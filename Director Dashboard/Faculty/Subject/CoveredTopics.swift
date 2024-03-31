//
//  CT.swift
//  Director Dashboard
//
//  Created by ADJ on 02/03/2024.
//

import SwiftUI


struct CoveredTopics: View {
    
    var c_id: Int
    var c_code: String
    var c_title: String
    var t_id: Int
    var t_name: String
    
    @State private var searchText = ""
    @State private var isChecked = false
    
    @State private var selectedTopic: Int?
    @State private var selectedSubTopic: Int?
    @StateObject private var topicViewModel = TopicViewModel()
    @StateObject private var subtopicViewModel = SubTopicViewModel()
    
    var filteredTopics: [Topic] { // All Data Will Be Filter and show on Table
        if searchText.isEmpty {
            return topicViewModel.existing
        } else {
            return topicViewModel.existing.filter { topic in
                topic.t_name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View { // Backend Functtionaliity Missing
        NavigationView{
            VStack{
                Text("Covered Topics")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Text("\(c_title)")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("\(c_code)")
                    .padding(.horizontal)
                    .font(.title3)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)
                
                VStack {
                    ScrollView{
                        ForEach(filteredTopics , id:\ .self) { cr in
                           DisclosureGroup {
                               ForEach(subtopicViewModel.existing.filter { $0.t_id == cr.t_id }, id: \.st_id) { subtopic in
                                   HStack{
                                       Image(systemName: "square")
                                           .font(.title2)
                                           .foregroundColor(Color.white)
                                           .padding(.horizontal)
                                           .frame(maxWidth: .infinity, alignment: .trailing)
                                       Text(subtopic.st_name)
                                           .foregroundColor(Color.white)
                                           .padding(.horizontal)
                                           .frame(maxWidth: .infinity, alignment: .leading)
                                   }
                               }
                                .padding(5)
                        }
                        label: {
                            HStack {
                                Text(cr.t_name)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                        }
                    }
                        if filteredTopics.isEmpty {
                            Text("No Topic Found For Course - \(c_title)")
                                .font(.headline)
                                .foregroundColor(.orange)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.green.opacity(0.5), lineWidth: 2)
                )
                .frame(height:600)
                .onAppear {
                    topicViewModel.getCourseTopic(courseID: c_id)
                }
                .onAppear {
                    subtopicViewModel.getTopicSubTopic(topicID: 1)
                }
                
//                Spacer()
            }
            .background(Image("fiii").resizable().ignoresSafeArea())
        }
    }
//    private func toggleCourseSelection(subtopicID: Int) {
//        if selectedSubTopic.contains(subtopicID) {
//            selectedSubTopic.remove(subtopicID)
//        } else {
//            selectedSubTopic.insert(subtopicID)
//        }
//    }
}


struct CoveredTopics_Previews: PreviewProvider {
    static var previews: some View {
        CoveredTopics(c_id: 1, c_code: "", c_title: "", t_id: 1, t_name: "")
    }
}
