//
//  PaperMaking.swift
//  Director Dashboard
//
//  Created by ADJ on 16/03/2024.
//

import SwiftUI

struct PaperMaking: View {
    
    let paperID: Int
    
    var q_id: Int
//    var q_text: String
//    var q_image : String
//    var q_difficulty: String
//    var q_marks: Int
//    var q_verification: String
//    var parent_topic_id: Int
    var p_id: Int
    var c_id: Int
    var c_code: String
    var c_title: String
    var f_id: Int
    var f_name: String
    
    var exam_date: String
    var degree: String
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
                        .padding(1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Date of Exam: \(exam_date)")
                        .padding(1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Degree Program: \(degree)")
                        .padding(1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Teacher Name: \(f_name)")
                        .padding(1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                }
                VStack{
                    Text("Course Code: \(c_code)")
                        .padding(1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Duration: \(duration)")
                        .padding(1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Total Marks: \(t_marks)")
                        .padding(1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                }
            }
            .padding()
//            .font(.headline)
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
//                        let assignedFaculty = questionViewModel.uploadedQuestions[index]
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
                                Text("Question \(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
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
                            Text("[ \(assignedFaculty.q_difficulty) ,\(assignedFaculty.q_marks)]")
                                .font(.title3)
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            HStack {
                                Button(action: {
                                    selectedButton = "Approved"
                                    updateQuestionStatus(questionId: assignedFaculty.q_id, q_verification: "Approved")
                                }) {
                                    Image(systemName: selectedButton == "Approved" ? "largecircle.fill.circle" : "circle")
                                        .foregroundColor(selectedButton == "Approved" ? .green : .gray)
                                    Text("Approved")
                                        .font(.title3)
                                        .foregroundColor(selectedButton == "Approved" ? .green : .gray)
                                }
                                .onTapGesture {
                                    selectedButton = selectedButton == "Approved" ? "" : "Approved"
                                }
                                
                                Button(action: {
                                    selectedButton = "Rejected"
                                    updateQuestionStatus(questionId: assignedFaculty.q_id, q_verification: "Rejected")
                                }) {
                                    Image(systemName: selectedButton == "Rejected" ? "largecircle.fill.circle" : "circle")
                                        .foregroundColor(selectedButton == "Rejected" ? .red : .gray)
                                    Text("Rejected")
                                        .font(.title3)
                                        .foregroundColor(selectedButton == "Rejected" ? .red : .gray)
                                }
                                .onTapGesture {
                                    selectedButton = selectedButton == "Rejected" ? "" : "Rejected"
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
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange.opacity(0.7), lineWidth: 1)
            )
            .onAppear {
                questionViewModel.getPaperQuestions(paperID: p_id)
            }
            Spacer()
            
            Button("View Topics"){
//                createFeedback()
            }
            .bold()
            .padding()
            .frame(width: 150)
            .foregroundColor(.black)
            .background(Color.cyan)
            .cornerRadius(8)
        }
        .background(Image("fw").resizable().ignoresSafeArea())
    }
    
    private func updateQuestionStatus(questionId: Int, q_verification: String) {
        var qVerificationValue: String
        if q_verification == "" {
            qVerificationValue = "Pending"
        } else {
            qVerificationValue = q_verification
        }
        
        let url = URL(string: "http://localhost:3000/updatequestionstatus/\(questionId)")!
        let parameters = ["q_verification": qVerificationValue]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating question status: \(error.localizedDescription)")
            } else if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Question status updated successfully: \(responseString)")
                    // Handle the response as needed
                }
            }
        }.resume()
    }
    func createFeedback() {
        guard let url = URL(string: "http://localhost:3000/addfeedback") else {
            return
        }

        let user = [
            "f_id": f_id,
            "c_id": c_id,
            "p_id": p_id,
            "q_id": q_id,
            "fb_details": fb_details
        ] as [String : Any]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: user) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print("Result from server:", result)
//                    facultiesViewModel.fetchExistingFaculties() // Refresh faculties after creating a new one
                    DispatchQueue.main.async {
                        fb_details = ""
                        
                    }
                } catch {
                    print("Error parsing JSON:", error)
                }
            } else if let error = error {
                print("Error making request:", error)
            }
        }.resume()
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
        PaperMaking(paperID: 2, q_id: 2, p_id: 1, c_id: 1, c_code: "String", c_title: "String", f_id: 1, f_name: "", exam_date: "", degree: "", duration: 1, t_marks: 1)
    }
}



//struct QuestionStatusView: View {
//    @State private var selectedButtons: [String] = []
//
//    var body: some View {
//        VStack {
//            ForEach(0..<selectedButtons.count, id: \.self) { index in
//                HStack {
//                    Button(action: {
//                        selectedButtons[index] = "Approved"
//                        updateQuestionStatus(questionId: assignedFaculty.q_id, q_verification: "Approved", index: index)
//                    }) {
//                        Image(systemName: selectedButtons[index] == "Approved" ? "largecircle.fill.circle" : "circle")
//                            .foregroundColor(selectedButtons[index] == "Approved" ? .green : .gray)
//                        Text("Approved")
//                            .font(.title3)
//                            .foregroundColor(selectedButtons[index] == "Approved" ? .green : .gray)
//                    }
//
//                    Button(action: {
//                        selectedButtons[index] = "Rejected"
//                        updateQuestionStatus(questionId: assignedFaculty.q_id, q_verification: "Rejected", index: index)
//                    }) {
//                        Image(systemName: selectedButtons[index] == "Rejected" ? "largecircle.fill.circle" : "circle")
//                            .foregroundColor(selectedButtons[index] == "Rejected" ? .red : .gray)
//                        Text("Rejected")
//                            .font(.title3)
//                            .foregroundColor(selectedButtons[index] == "Rejected" ? .red : .gray)
//                    }
//                }
//            }
//        }
//        .padding()
//        .onAppear {
//            // Fetch records from the backend and set the selectedButtons array
//            // Example:
//            // selectedButtons = ["", "", ""] // Assuming 3 records
//        }
//    }
//
//    private func updateQuestionStatus(questionId: Int, q_verification: String, index: Int) {
//        // Rest of the code remains the same
//    }
//}
