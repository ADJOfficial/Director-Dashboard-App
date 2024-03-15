//
//  AssignCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct AssignCourse: View { // Design 100% ok
    
    @StateObject private var facultiesViewModel = FacultiesViewModel()
    @StateObject private var coursesViewModel = CoursesViewModel()
    var facultyID: Int
    var courseID: Int
    var facultyName: String
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCourses: Set<Int> = []
    @State private var isDropdownOpen = false
    @State private var selectedCourse: faculties?

    
    
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
                        .foregroundColor(.gray)
//                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .opacity(text.isEmpty ? 0 : 1)
            }
        }
    }
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        VStack {
            Text("Assign Course")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            HStack {
                Button(action: {
                    isDropdownOpen.toggle()
                }) {
                    Text(selectedCourse?.f_name ?? "Select Teacher >")
                        .padding()
                        .background(Color.teal.opacity(0.9))
//                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .padding()
                
                if isDropdownOpen {
                    ScrollView {
                        VStack {
                            ForEach(facultiesViewModel.remaining, id: \.self) { course in
                                Button(action: {
                                    selectedCourse = course
                                    isDropdownOpen.toggle()
                                }) {
                                    Text(course.f_name)
                                        .foregroundColor(Color.white)
                                }
                                Divider()
                                    .background(Color.white)
                                    .padding(1)
                            }
                            
                        }
                        .padding()
                        .frame(width: 200)
                    }
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(20)
                    .frame(height: 150)
                    
                    
                }
            }
            .onAppear {
                facultiesViewModel.fetchExistingFaculties()
            }
            Text("\(selectedCourse?.f_name ?? "")")
                .padding()
                .foregroundColor(Color.white)
            Spacer()
            VStack{
                Text("Assign Course")
                    .bold()
                    .padding()
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                SearchBar(text: $searchText)
                    .padding(1)
//                Spacer()
                VStack{
                    ScrollView {
                        ForEach(filteredCourses, id: \.self) { cr in
                            HStack {
                                Text(cr.c_title)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Image(systemName: selectedCourses.contains(cr.c_id) ? "checkmark.square.fill" : "square")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
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
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                )
                .frame(width: 410, height: 430)
                .onAppear {
                    coursesViewModel.fetchExistingCourses()
                }
//                Spacer()
            }
            
        }
        .navigationBarItems(leading: backButton)
        .background(Image("fc").resizable().ignoresSafeArea())
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
    private func toggleCourseSelection(courseID: Int) {
           if selectedCourses.contains(courseID) {
               selectedCourses.remove(courseID)
           } else {
               selectedCourses.insert(courseID)
           }
       }
    private func assignSelectedCourses() {
        // Iterate over the selected courses
        for courseID in selectedCourses {
            // Make the API call to assign the course to the faculty
            assignCourseToFaculty(courseID: courseID,facultyID: facultyID)
        }

        // Dismiss the view after saving
//        presentationMode.wrappedValue.dismiss()
    }

//    private func assignCourseToFaculty(courseID: Int, facultyID: Int) {
//        // Prepare the request URL
//        let url = URL(string: "http://localhost:2000/assigncoursetofaculty")!
//
//        // Prepare the request body
//        let parameters: [String: Any] = [
//            "courseID": courseID,
//            "facultyID": facultyID
//        ]
//
//        // Create the request
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//
//        // Send the request
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//                // Handle the error as needed
//            } else if let data = data {
//                // Parse the response data if needed
//                // Handle the response as needed
//            }
//        }.resume()
//    }
    private func assignCourseToFaculty(courseID: Int, facultyID: Int) {
        let url = URL(string: "http://localhost:2000/assigncoursetofaculty")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "courseID": courseID,
            "facultyID": facultyID
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let message = responseJSON["message"] as? String {
                // Login successful
//                isLoggedIn = true
                print(message)
            } else {
                // Invalid credentials
//                showAlert = true
            }
        }.resume()
    }
}
struct AssignCourse_Previews: PreviewProvider {
    static var previews: some View {
        AssignCourse(facultyID: 1, courseID: 1, facultyName: "")
    }
}
