//
//  ViewCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct ViewCourses: View {    // Design 100% OK
    
    @State private var c_code = ""
    @State private var c_title = ""
    @State private var searchText = ""
    @StateObject private var coursesViewModel = CoursesViewModel()
    
    @State private var selectedCourseName: String? = nil
    
    var filteredCourses: [AllCourses] { // All Data Will Be Filter and show on Table
        if searchText.isEmpty {
            return coursesViewModel.existing
        } else {
            return coursesViewModel.existing.filter { faculty in
                faculty.c_code.localizedCaseInsensitiveContains(searchText) ||
                faculty.c_title.localizedCaseInsensitiveContains(searchText)
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
                        .font(.title3)
                        .foregroundColor(Color.red.opacity(0.9))
                }
                .opacity(text.isEmpty ? 0 : 1)
            }
        }
    }
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView {
            VStack {
                Text("Course")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                //                Spacer()
                SearchBar(text: $searchText)
                    .padding()
                //                Spacer()
                VStack{
                    ScrollView {
                        ForEach(filteredCourses, id: \.self) { cr in
//                            let cr = filteredCourses[index]
                            HStack {
                                Text(cr.c_title)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                NavigationLink{
                                    CourseAssignedTo(c_id: cr.c_id, c_title: cr.c_title, c_code: cr.c_code)
                                        .navigationBarBackButtonHidden(true)
                                } label: {Image(systemName: "eye.fill")
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(Color.orange)
                                }
                            }
                            Divider()
                                .background(Color.white)
                                .padding(1)
                        }
                        if filteredCourses.isEmpty {
                            Text("No Data Found")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue.opacity(0.6), lineWidth: 2)
                )
                .frame(height: 700)
                .onAppear {
                    coursesViewModel.fetchExistingCourses()
                }
            }
            .background(Image("fc") .resizable().ignoresSafeArea())
        }
    }
}



struct CourseAssignedTo: View {  // Design 100% ok
    
    @StateObject private var coViewModel = CoViewModel()
//    var facultyID: Int
    var c_id: Int
    var c_title: String
    var c_code: String
//    var clo: CLO
//    var status: String
//    var approved: String
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView{
            VStack {
                Text("Assigned Courses")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(c_title)")
                    .bold()
                    .padding()
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .center)
                    .foregroundColor(Color.white)
                Text("Assigned Courses")
                    .underline()
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                VStack{
                    ScrollView{
                        ForEach(coViewModel.Courseassignedto, id: \.self) { cr in
                            HStack{
                                Text(cr.f_name)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Image(systemName: "trash.fill")
                                    .font(.title3)
                                    .foregroundColor(Color.red)
                                    .onTapGesture {
                                        deleteAssignedCourse(courseId: cr.c_id,facultyId: cr.f_id)
                                    }
                            }
                            Divider()
                                .background(Color.white)
                                .padding(1)
                        }
                        if coViewModel.Courseassignedto.isEmpty {
                            Text("\(c_title) have no Assigned Courses Yet !")
                            //                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.yellow)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue.opacity(0.6), lineWidth: 2)
                )
                .frame(height: 500)
                .onAppear {
                    coViewModel.fetchCoursesAssignedTo(courseID: c_id)
                }
                
                NavigationLink {
                    CLOS(c_id: c_id, c_title: c_title, c_code: c_code)
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Text("View CLOs")
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.blue.opacity(0.9))
                .cornerRadius(8)
                
            }
            .navigationBarItems(leading: backButton)
            .background(Image("fc").resizable().ignoresSafeArea())
        }
    }
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
                .imageScale(.large)
        }
    }
    private func deleteAssignedCourse( courseId: Int,facultyId: Int) {
        coViewModel.deleteAssignedCourse(courseId: courseId , facultyId: facultyId)
    }
}
struct CLOS: View { // Design 100% OK
    
    var c_id: Int
    var c_title: String
    var c_code: String
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedButton: String?
    
    @State private var searchText = ""
    @StateObject private var cloViewModel = CLOViewModel()
    
    @State private var showAlert = false
    
    var filteredClo: [CLO] { // All Data Will Be Filter and show on Table
        if searchText.isEmpty {
            return cloViewModel.existing
        } else {
            return cloViewModel.existing.filter { topic in
                topic.clo_text.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var statusText: String {
        if cloViewModel.existing.contains(where: { $0.status == "Pending" }) {
            return "Pending"
        } else if cloViewModel.existing.contains(where: { $0.status == "Approved" }) {
            return "Approved"
        } else {
            return "Rejected"
        }
    }
    var statusColor: Color {
        switch statusText {
        case "Pending":
            return Color.yellow
        case "Approved":
            return Color.green
        case "Rejected":
            return Color.red
        default:
            return Color.gray
        }
    }
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        VStack {
            Text("CLOS")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            HStack{
                Spacer()
                Text("Status - \(statusText)")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .trailing)
                Image(systemName: "circle.fill")
                    .foregroundColor(statusColor)
                Spacer()
            }
            .padding()
            Text("\(c_title)")
                .bold()
                .font(.title2)
                .padding(.horizontal)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            Text("\(c_code)")
                .bold()
                .padding(.horizontal)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
           Spacer()
            
            VStack {
                ScrollView{
                    ForEach(filteredClo.indices , id:\ .self) { index in
                        let cr = filteredClo[index]
                        VStack{
                            Text(cr.clo_code)
                                .padding(1)
                                .font(.headline)
                                .foregroundColor(Color.orange)
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Text(cr.clo_text)
                                .padding(.horizontal)
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity , alignment: .leading)
                            HStack {
                                Button(action: {
                                    selectedButton = "Approved"
                                    updateQuestionStatus(cloId: cr.clo_id, cloStatus: "Approved")
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
                                    updateQuestionStatus(cloId: cr.clo_id, cloStatus: "Rejected")
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
                        }
                        Divider()
                            .background(Color.white)
                        .padding(1)
                    }
                    if filteredClo.isEmpty {
                        Text("No CLO Found For Course - \(c_title)")
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
                    .stroke(Color.blue.opacity(0.6), lineWidth: 2)
            )
            .frame(height:450)
            .onAppear {
                cloViewModel.getCourseCLO(courseID: c_id)
            }
        }
        .navigationBarItems(leading: backButton)
        .background(Image("fc").resizable().ignoresSafeArea())
    }
    private func updateQuestionStatus(cloId: Int, cloStatus: String) {
        var statusValue: String
           if cloStatus.isEmpty {
               statusValue = "Pending"
           } else {
               statusValue = cloStatus
           }
        
        let url = URL(string: "http://localhost:4000/updateclostatus/\(cloId)")!
        let parameters = ["q_verification": statusValue]
        
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
                    print("CLO status updated successfully: \(responseString)")
                    // Handle the response as needed
                }
            }
        }.resume()
    }
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
                .imageScale(.large)
        }
    }
}

struct ViewCourses_Previews: PreviewProvider {
    static var previews: some View {
       ViewCourses()
//        CLOS(c_id: 2, c_title: "", c_code: "", status: "")
    }
}
