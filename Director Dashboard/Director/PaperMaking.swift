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
    var clo_text: String
    var t_name: String
    
    var exam_date: String
    var degree: String
    var duration: Int
    var t_marks: Int
    
    @State private var isAccepted = false // For Accept All CheckMark
    @State private var showApprovedPaperButton = false
    @State private var showAlert = false
    
    @State private var q_text = ""
    @State private var fb_details = ""
    @State private var selectedButton: String?
    @StateObject private var questionViewModel = QuestionViewModel()
    
    var body: some View {
        NavigationView {
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
                    Button(action: {
                        isAccepted.toggle()
                        if isAccepted {
                            selectedButton = "Approved"
                            updateAllQuestionStatus(q_verification: "Approved")
                        } else {
                            selectedButton = nil
                            updateAllQuestionStatus(q_verification: "")
                            selectedButton = ""
                        }
                        updateApprovedPaperButtonVisibility()
                    }) {
                        Image(systemName: isAccepted ? "checkmark.square.fill" : "square")
                            .font(.title2)
                            .foregroundColor(Color.green)
                            .padding(.horizontal)
                    }
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
                                Text("[ \(assignedFaculty.q_difficulty) ,\(assignedFaculty.q_marks)]") //  , \(assignedFaculty.clo_text)
                                    .font(.title3)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                                HStack {
                                    Button(action: {
                                        selectedButton = "Approved"
                                        updateQuestionStatus(questionId: assignedFaculty.q_id, q_verification: "Approved")
                                        updateApprovedPaperButtonVisibility()
                                    }) {
                                        Image(systemName: selectedButton == "Approved" ? "largecircle.fill.circle" : "circle")
                                            .foregroundColor(selectedButton == "Approved" ? .green : .gray)
                                        Text("Approved")
                                            .font(.title3)
                                            .foregroundColor(selectedButton == "Approved" ? .green : .gray)
                                    }
                                    .onTapGesture {
                                        selectedButton = selectedButton == "Approved" ? "" : "Approved"
                                        updateApprovedPaperButtonVisibility()
                                    }
                                    
                                    Button(action: {
                                        selectedButton = "Rejected"
                                        updateQuestionStatus(questionId: assignedFaculty.q_id, q_verification: "Rejected")
                                        updateApprovedPaperButtonVisibility()
                                    }) {
                                        Image(systemName: selectedButton == "Rejected" ? "largecircle.fill.circle" : "circle")
                                            .foregroundColor(selectedButton == "Rejected" ? .red : .gray)
                                        Text("Rejected")
                                            .font(.title3)
                                            .foregroundColor(selectedButton == "Rejected" ? .red : .gray)
                                    }
                                    .onTapGesture {
                                        selectedButton = selectedButton == "Rejected" ? "" : "Rejected"
                                        updateApprovedPaperButtonVisibility()
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
                HStack{
                    Spacer()
                    NavigationLink {
                        PaperTopic(t_name: t_name , c_title: c_title , c_code: c_code)
                    }label: {
                        Text("View Topics")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.cyan)
                    .cornerRadius(8)
                    Spacer()
                    Button("Approved") {
                        updateApprovedPaperButtonVisibility()
                        updatePaperStatus()
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.green)
                    .cornerRadius(8)
                    .opacity(showApprovedPaperButton ? 1 : 0)
                    Spacer()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Paper Status Updated"), message: Text("The paper status has been set to Approved."), dismissButton: .default(Text("OK")))
                }
            }
            .background(Image("fw").resizable().ignoresSafeArea())
        }
    }
    
    func updateAllQuestionStatus(q_verification: String) {
        for index in 0..<questionViewModel.uploadedQuestions.count {
            let questionId = questionViewModel.uploadedQuestions[index].q_id
            updateQuestionStatus(questionId: questionId, q_verification: q_verification)
        }
    }
    
    private func updateQuestionStatus(questionId: Int, q_verification: String) {
        var qVerificationValue: String
           if q_verification.isEmpty {
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
    private func updateApprovedPaperButtonVisibility() {
        let allApproved = questionViewModel.uploadedQuestions.allSatisfy { assignedFaculty in
            selectedButton == "Approved" || selectedButton == nil
        }
        let anyRejected = questionViewModel.uploadedQuestions.contains { assignedFaculty in
            selectedButton == "Rejected"
        }
        
        showApprovedPaperButton = allApproved && !anyRejected
    }
    func updatePaperStatus() {
            guard let url = URL(string: "http://localhost:3000/updatepaperstatus/\(p_id)") else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else {
                    print("Error updating paper status")
                    return
                }

                if response.statusCode == 200 {
                    print("Paper status updated to Approved")
                    self.showAlert = true
                } else {
                    print("Paper status was not updated")
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




struct PaperTopic: View { // For Radio Button
    
    var t_name : String
    var c_title: String
    var c_code: String
    
    var body: some View {
        
        VStack {
            Text("Paper Topic")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            
            Text(c_title)
                .bold()
                .font(.title2)
                .padding(.horizontal)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            Text(c_code)
                .font(.title3)
                .padding(.horizontal)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            Spacer()
            VStack{
                ScrollView {
                    HStack{
                        Text(t_name)
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity , alignment: .center)
                    }
                    Divider()
                        .background(Color.white)
                        .padding(1)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange.opacity(0.7), lineWidth: 1)
            )
            .frame(height:600)
        }
        .background(Image("fw").resizable().ignoresSafeArea())
    }
}

struct AdditionalQuestions: View { // For Radio Button
    
//    var t_name : String
    
    var body: some View {
        
        VStack {
            Text("Additional Questions")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            VStack{
                ScrollView {
                    HStack{
                        Text("")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity , alignment: .center)
                    }
                    Divider()
                        .background(Color.white)
                        .padding(1)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange.opacity(0.7), lineWidth: 1)
            )
            .frame(height:700)
        }
        .background(Image("fw").resizable().ignoresSafeArea())
    }
}

struct PaperTopic_Previews: PreviewProvider {
    static var previews: some View {
        PaperMaking(paperID: 1, q_id: 1, p_id: 1, c_id: 1, c_code: "", c_title: "", f_id: 1, f_name: "", clo_text: "", t_name: "", exam_date: "", degree: "", duration: 1, t_marks: 1)
    }
}
