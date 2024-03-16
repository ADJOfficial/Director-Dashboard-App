//
//  PaperMaking.swift
//  Director Dashboard
//
//  Created by ADJ on 16/03/2024.
//

import SwiftUI

struct PaperMaking: View {
    
    var c_title : String
    var exam_date: String
    var degree: String
    var f_name: String
    var c_code: String
    var duration: Int
    var t_marks: Int
    @State private var q_text = ""
    @State private var fb_details = ""
    @State private var selectedButton: String?
    @StateObject private var questionViewModel = QuestionViewModel()
    
    var body: some View {
        VStack{
            Text("Paper")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            HStack{
                Image(systemName: "mail.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.green)
                Text("Barani Institute of Information Technology\n         PMAS Arid Agriculture University\n                     Rawalpindi Pakistan\n        Fall 2024: Mid Term Examination")
                    .foregroundColor(Color.white)
                Image(systemName: "mail.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.green)
            }
            HStack{
                VStack{
                    Text("Course Title: \(c_title)")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Date of Exam: \(exam_date)")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Degree Program: \(degree)")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Teacher Name: \(f_name)")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                }
                VStack{
                    Text("Course Code: \(c_code)")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Duration: \(duration)")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Total Marks: \(t_marks)")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                }
            }
            .padding()
//            .frame(width: 420)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange.opacity(0.7), lineWidth: 1)
                )
            HStack{
                Text("Accept All")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .trailing)
                Image(systemName: "checkmark.square.fill")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
            }
            VStack{
                ScrollView{
                    ForEach(questionViewModel.uploadedQuestions ,  id: \.self) { assignedFaculty in
                        VStack {
                            if let index = questionViewModel.uploadedQuestions.firstIndex(of: assignedFaculty) {
                                let binding = Binding<String>(
                                    get: {
                                        questionViewModel.uploadedQuestions[index].q_text
                                    },
                                    set: { newValue in
                                        questionViewModel.uploadedQuestions[index].q_text = newValue
                                    }
                                )
                                TextField("", text: binding)
                                    .padding()
                                    .font(.headline)
                                    .background(Color.gray.opacity(0.8))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                                    .onAppear {
                                        q_text = assignedFaculty.q_text
                                    }
                            }
                            Text("[ \(assignedFaculty.q_difficulty) ]")
//                                .bold()
                                .font(.title3)
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            HStack {
                                Button(action: {
                                    selectedButton = "Accept"
                                }) {
                                    Image(systemName: selectedButton == "Accept" ? "largecircle.fill.circle" : "circle")
                                        .foregroundColor(selectedButton == "Accept" ? .green : .gray)
                                    Text("Accept")
                                        .font(.title3)
                                        .foregroundColor(selectedButton == "Accept" ? .green : .gray)
                                }
                                Button(action: {
                                    //                                updateFacultyRole(selectedFaculty: assignedFaculty)
                                    selectedButton = "Reject"
                                }) {
                                    Image(systemName: selectedButton == "Reject" ? "largecircle.fill.circle" : "circle")
                                        .foregroundColor(selectedButton == "Reject" ? .red : .gray)
                                    Text("Reject")
                                        .font(.title3)
                                        .foregroundColor(selectedButton == "Reject" ? .red : .gray)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity , alignment: .trailing)
                            HStack{
                                TextField("Type Comment" , text: $fb_details)
                                    .padding()
                                    .font(.headline)
                                    .background(Color.gray.opacity(0.8))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                                Button(action: {
                                    createFeedback()
                                }, label: {
                                    Image(systemName: "paperplane.fill")
                                        .font(.title)
                                        .padding(.horizontal)
                                        .foregroundColor(Color.green)
                                })
                            }
                        }
                        Divider()
                            .background(Color.white)
                            .padding()
//                            .background(Color.white)
                    }
                }
//                .padding(1)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange.opacity(0.7), lineWidth: 1)
            )
            .onAppear {
                questionViewModel.fetchExistingQuestions()
            }
            Spacer()
            
            Button("View Topics"){
//                savePaper()
            }
            .bold()
            .padding()
            .frame(width: 150)
            .foregroundColor(.black)
            .background(Color.cyan)
            .cornerRadius(8)
        }
        .background(Image("fw").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
    }
    
    func createFeedback() {
    }
}

struct AcceptRejectRadioButton: View { // For Radio Button
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(title)
            }
        }
    }
}

struct PaperMaking_Previews: PreviewProvider {
    static var previews: some View {
        PaperMaking(c_title: "", exam_date: "", degree: "", f_name: "", c_code: "", duration: 1, t_marks: 1)
    }
}
