//
//  AssignRole.swift
//  Director Dashboard
//
//  Created by ADJ on 20/01/2024.
//

import SwiftUI

struct AssignRole: View {
    
    @State private var isDropdownOpen = false
    @State private var selectedCourse: AllCourses?
    @StateObject private var coursesViewModel = CoursesViewModel()
    @StateObject private var coViewModel = CoViewModel()
    @State private var selectedFaculty: Courer?
    
    var body: some View {
        VStack{
            Text("Assign Role")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Text("Course")
                .bold()
                .padding()
                .padding(.horizontal)
                .font(.title)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity ,alignment: .leading)
            
            //            Spacer()
            
            HStack {
                Button(action: {
                    isDropdownOpen.toggle()
                }) {
                    Text(selectedCourse?.c_title ?? "Select a course >")
                        .padding()
                        .background(Color.teal.opacity(0.9))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .padding()
                
                if isDropdownOpen {
                    ScrollView {
                        VStack {
                            ForEach(coursesViewModel.existing, id: \.self) { course in
                                Button(action: {
                                    selectedCourse = course
                                    isDropdownOpen.toggle()
                                    fetchAssignedFaculty()
                                }) {
                                    Text(course.c_title)
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
                coursesViewModel.fetchExistingCourses()
            }
            Spacer()
            if let selectedCourse = selectedCourse {
                if coViewModel.Courseassignedto.isEmpty {
                    Text("No faculty assigned to \(selectedCourse.c_title)")
                        .foregroundColor(Color.white)
                        .padding()
                } else {
                    ScrollView{
                        ForEach(coViewModel.Courseassignedto, id: \.self) { assignedFaculty in
                            Button(action: {
                                updateFacultyRole(selectedFaculty: assignedFaculty)
                            }) {
                                HStack {
                                    Text(assignedFaculty.f_name)
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Image(systemName: selectedFaculty?.f_id == assignedFaculty.f_id ? "largecircle.fill.circle" : "circle")
                                        .font(.title3)
                                        .foregroundColor(Color.green)
                                }
                            }
                            .padding()
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.orange.opacity(0.5), lineWidth: 1)
                    )
                    .frame(width: 400,height: 250)
                }
            } else {
                Text("No course selected")
                    .foregroundColor(Color.white)
                    .padding()
            }
            Spacer()
            Button("Save"){
                
            }
            .bold()
            .padding()
            .frame(width: 100)
            .foregroundColor(.black)
            .background(Color.teal)
            .cornerRadius(8)
            .padding(.bottom)
        }
        .background(Image("fc").resizable().ignoresSafeArea())
    }
    func fetchAssignedFaculty() {
        coViewModel.Courseassignedto.removeAll()
        if let courseID = selectedCourse?.c_id {
            coViewModel.fetchCoursesAssignedTo(courseID: courseID)
        }
    }
    
    func updateFacultyRole(selectedFaculty: Courer?) {
        guard let selectedCourseID = selectedCourse?.c_id, let selectedFacultyID = selectedFaculty?.f_id else {
            return
        }
        
        let url = URL(string: "http://localhost:2000/updatefacultyrole")!
        
        // Create the request body
        let requestBody: [String: Any] = [
            "c_id": selectedCourseID,
            "f_id": selectedFacultyID
        ]
        
        // Convert the request body to JSON data
        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Parse the response data
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let responseDict = json as? [String: Any], let message = responseDict["message"] as? String {
                    print(message)
                    DispatchQueue.main.async {
                        self.selectedFaculty = selectedFaculty
                    }
                }
            } catch {
                print("Error parsing response: \(error)")
            }
        }.resume()
    }
}

struct AssignRole_Previews: PreviewProvider {
    static var previews: some View {
        AssignRole()
    }
}
