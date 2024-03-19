//
//  UploadedPapers.swift
//  Director Dashboard
//
//  Created by ADJ on 16/03/2024.
//

import SwiftUI

struct UploadedPapers: View {
    
    
    @State private var searchText = ""
    @State private var searchResults: [GetUploadedPaper] = []
    @StateObject private var uploadedPaperViewModel = UploadedPaperViewModel()
//    @StateObject private var coursesViewModel = CoursesViewModel()
    
    var filteredPapers: [GetUploadedPaper] { // All Data Will Be Filter and show on Table
        if searchText.isEmpty {
            return uploadedPaperViewModel.uploaded
        } else {
            return uploadedPaperViewModel.uploaded.filter { faculty in
                faculty.c_title.localizedCaseInsensitiveContains(searchText) ||
                faculty.c_code.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    struct SearchBar: View { // Search Bar avaible outside of table to search record
        @Binding var text: String
        
        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .padding()
                    .frame(width: 247 , height: 40)
                    .background(Color.gray.opacity(1))
                    .cornerRadius(8) // Set the corner radius to round the corners
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
//                        .padding(.horizontal)
                }
                .opacity(text.isEmpty ? 0 : 1)
            }
        }
    }
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView {
            VStack {
                Text("Uploaded Papers")
//                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)

                Spacer()
                SearchBar(text: $searchText)
                    .padding()
                
                VStack{
                    ScrollView {
                        ForEach(filteredPapers.indices, id: \.self) { index in
                            let cr = filteredPapers[index]
                            HStack{
                                Text(cr.c_title)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Text(cr.c_code)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .center)
                                NavigationLink{
                                    EyeViewPaperHeader(p_id: cr.p_id, f_id: cr.f_id, f_name: cr.f_name, c_id: cr.c_id, c_title: cr.c_title, c_code: cr.c_code, exam_date: cr.exam_date, duration: cr.duration, degree: cr.degree, term: cr.term, year: cr.year, t_marks: cr.t_marks, q_id: cr.q_id ,clo_text: cr.clo_text, t_name: cr.t_name )
                                        .navigationBarBackButtonHidden(false)
                                }label: {
                                    Image(systemName: "eye.fill")
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(Color.orange)
                                }
                            }
                            Divider()
                                .background(Color.white)
                                .padding(1)
                        }
                        if filteredPapers.isEmpty {
                            Text("No Uploaded Papers Found")
                                .font(.headline)
                                .foregroundColor(.orange)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 410 , height:700)
                .onAppear {
                    uploadedPaperViewModel.fetchExistingPapers()
                    print("Filtered Papers Count:", filteredPapers.count)
                }
                
                Spacer()
            }
            .background(Image("fw").resizable().ignoresSafeArea())
        }
    }
}

struct EyeViewPaperHeader: View { // Design 100% Ok

    var p_id:Int
    var f_id: Int
    var f_name: String
    var c_id: Int
    var c_title: String
    var c_code: String
    var exam_date: String
    var duration: Int
    var degree: String
    var term: String
    var year: Int
    var t_marks: Int
    var q_id: Int
    var clo_text: String
    var t_name: String
//    var q_text: String
//    var q_marks: Int
//    var q_difficulty: String
//    var status: String
    
    var body: some View { // Get All Data From Node MongoDB : Pending
    
        NavigationView {
            VStack{
                Text("Paper Information")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(c_title)")
                    .bold()
                    .font(.title2)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Text("\(c_code)")
                    .bold()
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                NavigationLink {
                    Comments(f_id: f_id, c_id: c_id, p_id: p_id, q_id: q_id)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image(systemName: "text.bubble.fill")
                        .font(.largeTitle)
                        .padding(.horizontal)
                        .foregroundColor(Color.green)
                        .frame(maxWidth: .infinity , alignment: .trailing)
                }
                Spacer()
                VStack(){
                    HStack{
                        Text("Teacher :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(f_name)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Course Title :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(c_title)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Course Code :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(c_code)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Date of Exam :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(exam_date)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Duration :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(duration)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Degree :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(degree)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Term :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(term)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Year :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(year)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Total Marks :")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(t_marks)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    HStack{
                        Text("Questions ")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("\(q_id)")
                            .padding(1)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                }
                .bold()
                .font(.title3)
                .padding(.horizontal)
                .frame(maxWidth: .infinity , alignment: .leading)
                Spacer()
                NavigationLink {
                    PaperMaking(paperID: p_id, q_id: q_id, p_id: p_id, c_id: c_id, c_code: c_code, c_title: c_title, f_id: f_id, f_name: f_name, clo_text: clo_text, t_name: t_name, exam_date: exam_date, degree: degree, duration: duration, t_marks: t_marks)
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Text("View Paper")
                }
                .foregroundColor(.black)
                .padding()
                .background(Color.cyan)
                .cornerRadius(8)
                Spacer()
            }
            .background(Image("fw").resizable().ignoresSafeArea())
        }
    }
}

struct Comments: View { // Design 100% Ok
    
    var f_id: Int
    var c_id: Int
    var p_id: Int
    var q_id: Int
    @State private var fb_details: String = ""
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        VStack {
            Text("Comments")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            Text("Feedback")
                .bold()
                .font(.title)
                .foregroundColor(Color.white)
                .padding(.horizontal)
                .frame(maxWidth: .infinity , alignment: .leading)
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $fb_details)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(height: 400)
                HStack {
                    Spacer()
                    Button(action: {
                        createFeedback()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .padding()
                            .font(.largeTitle)
                            .foregroundColor(Color.green)
                    }
                }
            }
            .padding()
            Spacer()
        }
        .background(Image("fw").resizable().ignoresSafeArea())
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


struct UploadedPapers_Previews: PreviewProvider {
    static var previews: some View {
        UploadedPapers()
    }
}
