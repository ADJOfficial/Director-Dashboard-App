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
    @State private var searchResults: [AllCourses] = []
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
                        .foregroundColor(.gray)
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
                                    CourseAssignedTo(courseID: cr.c_id, courseName: cr.c_title)
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
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 410, height: 700)
                .onAppear {
                    coursesViewModel.fetchExistingCourses()
                }
            }
            .background(Image("fc") .resizable().ignoresSafeArea())
        }
    }
}


struct Courer: Codable  ,Hashable {
    let f_id: Int
    let c_id: Int
    let c_code: String
    let c_title: String
    let f_name: String
//    var role: String
    
}

class CoViewModel: ObservableObject {
    @Published var Courseassignedto: [Courer] = []
    
    func fetchCoursesAssignedTo(courseID: Int) {
        guard let url = URL(string: "http://localhost:2000/CourseAssignedTo?c_id=\(courseID)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                            print("Response status code: \(httpResponse.statusCode)")
                        }
            
            do {
                let courses = try JSONDecoder().decode([Courer].self, from: data)
                DispatchQueue.main.async {
                    self.Courseassignedto = courses
                    print("Fetched \(courses.count) assigned courses for faculty ID: \(courseID)")
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    func deleteAssignedCourse(courseId: Int , facultyId: Int) {
        // Perform the deletion using an API call or database query
        deleteAssignedCourseFromServer(courseId: courseId , facultyId: facultyId) { success in
            if success {
                // Remove the deleted assigned course from the array
                DispatchQueue.main.async {
                    if let index = self.Courseassignedto.firstIndex(where: { $0.c_id == courseId && $0.f_id == facultyId }) {
                        self.Courseassignedto.remove(at: index)
                    }
                }
            } else {
                // Handle error
                print("Failed to delete assigned course")
            }
        }
    }

    private func deleteAssignedCourseFromServer(courseId: Int , facultyId: Int, completion: @escaping (Bool) -> Void) {
        // Make the API call or database query to delete the assigned course
        // You can use URLSession or Alamofire to make the HTTP request
        
        // Example using URLSession
        guard let url = URL(string: "http://localhost:2000/DeleteAssignedF/\(courseId)/\(facultyId)") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting assigned course:", error)
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
}

struct CourseAssignedTo: View {  // Design 100% ok
    
    @StateObject private var coViewModel = CoViewModel()
//    var facultyID: Int
    var courseID: Int
    var courseName: String
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView{
            VStack {
                Text("Assigned Courses")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(courseName)")
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
                            Text("\(courseName) have no Assigned Courses Yet !")
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
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 410, height: 500)
                .onAppear {
                    coViewModel.fetchCoursesAssignedTo(courseID: courseID)
                }
                
                NavigationLink{
                    CLOS()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Image(systemName: "plus.app.fill")
                        .bold()
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity , alignment: .trailing)
                }
                
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
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        VStack {
            Text("CLOS")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            HStack{
                Spacer()
                Text("Status: ")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .trailing)
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.yellow)
                Spacer()
            }
            .padding()
            Text("Programming Fundamental")
                .bold()
                .font(.title2)
                .padding(.horizontal)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            Text("Course Code  CS-323")
                .bold()
                .padding(.horizontal)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
           Spacer()
            
            VStack{
                Text("CLO-1")
                    .padding()
                Text("CLO-2")
                    .padding()
                Text("CLO-3")
                    .padding()
                Text("CLO-4")
                    .padding()
            }
            .bold()
            .font(.headline)
            .frame(maxWidth: .infinity , alignment: .leading)
            .foregroundColor(Color.white)
            
          Spacer()
            
            HStack{
                Spacer()
                Button("Approve"){
                    // Add Logic for Backend to Store New Data
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.teal)
                .cornerRadius(8)
                .padding(.all)
                Button("Disapprove"){
                    // Add Logic for Backend to Store New Data
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.teal)
                .cornerRadius(8)
                .padding(.all)
                Spacer()
            }
        }
        .background(Image("h").resizable().ignoresSafeArea())
    }
}

struct ViewCourses_Previews: PreviewProvider {
    static var previews: some View {
       ViewCourses()
    }
}
