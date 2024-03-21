//
//  ViewYourCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct ViewYourCourses: View { // Design 100% OK
    
    var f_id: Int
    var c_id: Int
    var c_code: String
    var c_title: String
    var f_name: String
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView {
            VStack{
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                NavigationLink {
//                    ma
                } label: {
                    Image(systemName: "mail.fill")
                        .foregroundColor(Color.blue.opacity(0.7))
                }
                .padding()
                .font(.largeTitle)
                .frame(maxWidth: .infinity , alignment: .trailing)
                .padding(.horizontal)
                Spacer()
                Text("Subjects ")
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Programming Fundamental")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                        
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Web Technology")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                    }
                    HStack{
                        
                        Spacer()
                        
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Software Engennring")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                        
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Operation Research")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                    }
                }
                Spacer()
            }
            .background(Image("fiii").resizable().ignoresSafeArea())
        }
    }
}

struct Feedback: Hashable, Decodable, Encodable {
    var fb_details: String
    var c_title: String
    var c_code: String
    var f_name: String
    var q_id: Int
    var p_id: Int
//    var isNew: Bool
}

class FeedbackViewModel: ObservableObject {
    @Published var feedback: [Feedback] = []
//    @Published var selectedMessage: Feedback?
    func fetchExistingFeedback() {
        guard let url = URL(string: "http://localhost:4000/getfeedback")
                
        else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data , error == nil
                    
            else {
                return
            }
            
            // Convert to JSON
            
            do{
                let faculty = try JSONDecoder().decode([Feedback].self, from: data)
                DispatchQueue.main.async {
                    self?.feedback = faculty
                    print("Fetched \(faculty.count) Faculties")
                }
            }
            catch{
                print("Error While Getting Data")
            }
        }
        task.resume()
    }
}

struct Mail: View {
    
    var fb_details: String
    var c_title: String
    var c_code: String
    var f_name: String
    var q_id: Int
    var p_id: Int
    @StateObject var feedbackViewModel = FeedbackViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Notifications")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                VStack {
                    ScrollView {
                        ForEach(feedbackViewModel.feedback.indices, id: \.self) { index in
                            let msg = feedbackViewModel.feedback[index]
                            VStack {
                                HStack{
                                    Text(msg.c_title)
//                                        .font(.headline)
                                        .foregroundColor(Color.yellow)
                                        .padding(.horizontal)
                                    Text(msg.c_code)
//                                        .font(.headline)
                                        .foregroundColor(Color.yellow)
                                        .padding(.horizontal)
                                }
                                .padding(5)
                                    Text(msg.fb_details)
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding(.horizontal)
                            }
                            Divider()
                                .background(Color.white)
                                .padding(2)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.orange.opacity(0.5), lineWidth: 1)
                )
                .frame(height: 770)
                .onAppear {
                    feedbackViewModel.fetchExistingFeedback()
                }
            }
            .background(Image("fiii").resizable().ignoresSafeArea().aspectRatio(contentMode: .fill))
        }
    }
}

struct MessageDetails: View {
    var message: String
    
    var body: some View {
        Text(message)
            .font(.headline)
            .padding()
    }
}


//struct Mail: View {
//    var fb_details: String
//    @StateObject var feedbackViewModel = FeedBackViewModel()
//    @State private var selectedMessage: String?
//
//    var body: some View {
//        NavigationView {
//            VStack{
//                Text("Notifications")
//                    .bold()
//                    .font(.largeTitle)
//                    .foregroundColor(Color.white)
//                Spacer()
//                VStack{
//                    ScrollView {
//                        ForEach(feedbackViewModel.fb, id: \.self) { msg in
//                            Button(action: {
//                                selectedMessage = msg.fb_details
//                            }) {
//                                HStack {
//                                    Text(msg.fb_details)
//                                        .font(.headline)
//                                        .foregroundColor(Color.white)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                }
//                            }
//                            Divider()
//                                .background(Color.white)
//                                .padding(1)
//                        }
//                    }
//                    Spacer()
//                }
//                .padding()
//                .background(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.orange.opacity(0.5), lineWidth: 2)
//                )
//                .frame(width: 420, height: 770)
//                .onAppear {
//                    feedbackViewModel.fetchExistingFeedback()
//                }
//            }
//            .background(Image("fiii").resizable().ignoresSafeArea().aspectRatio(contentMode: .fill))
//            .background(
//                NavigationLink(
//                    destination: MessageDetails(message: selectedMessage ?? ""),
//                    isActive: Binding<Bool>(
//                        get: { selectedMessage != nil },
//                        set: { _ in
//                            selectedMessage = nil
//                        }
//                    )
//                ) {
//                    EmptyView()
//                }
//            )
//        }
//    }
//}
//
//struct MessageDetails: View {
//    var message: String
//
//    var body: some View {
//        Text(message)
//            .font(.headline)
//            .padding()
//    }
//}

// For FYP

//struct Mail: View { // Get All Data From Node MongoDB : Done
//
//    var fb_details: String
//    @StateObject var feedbackViewModel = FeedBackViewModel()
//
//    var body: some View {
//        VStack{
//            Text("Notifications")
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color.white)
//            Spacer()
//            VStack{
//                ScrollView {
//                    ForEach(feedbackViewModel.fb, id: \.self) { msg in
//                        HStack {
//                            Text(msg.fb_details)
//                                .font(.headline)
//                                .foregroundColor(Color.white)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                        }
//                        Divider()
//                            .background(Color.white)
//                            .padding(1)
//                    }
//                }
//                Spacer()
//            }
//            .padding()
//            .background(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color.orange.opacity(0.5), lineWidth: 2)
//            )
//            .frame(width: 420, height: 770)
//            .onAppear {
//                feedbackViewModel.fetchExistingFeedback()
//            }
//        }
//        .background(Image("fiii").resizable().ignoresSafeArea().aspectRatio(contentMode: .fill))
//    }
//}

struct Subject: View {
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Subject")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Programming Fundamental")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Course Code  CS-323")
                    .padding(.horizontal)
                    .font(.title3)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                VStack{
                    NavigationLink{
                        CoveredTopics()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("View Topics")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                    
                    NavigationLink{
                        ViewCLOs()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("View CLOs")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                    
                    NavigationLink{
                        SetPaper()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Set Paper")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                    
                    NavigationLink{
                        PaperStatus()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Paper Status")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                }
                Spacer()
            }
            .background(Image("fiii").resizable().ignoresSafeArea())
        }
    }
}

struct ViewYourCourses_Previews: PreviewProvider {
    static var previews: some View {
//        Mail(fb_details: "", c_title: "", c_code: "", f_name: "", q_id: 1, p_id: 1)
        ViewYourCourses(f_id: 1, c_id: 1, c_code: "", c_title: "", f_name: "")
    }
}
