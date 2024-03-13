//
//  FacultyDetails.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct FacultyDetails: View { // Designed 100% OK
    
    @State private var f_name = ""
    @State private var searchText = ""
    @State private var searchResults: [faculties] = []
    @StateObject private var facultiesViewModel = FacultiesViewModel()
    
//    @State private var selectedFacultyName: String? = nil
    
    var filteredFaculties: [faculties] { // All Data Will Be Filter and show on Table
        if searchText.isEmpty {
            return facultiesViewModel.remaining
        } else {
            return facultiesViewModel.remaining.filter { faculty in
                faculty.f_name.localizedCaseInsensitiveContains(searchText) ||
                faculty.username.localizedCaseInsensitiveContains(searchText)
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
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                //                Spacer()
                SearchBar(text: $searchText)
                    .padding()
                //                Spacer()
                VStack{
                    ScrollView {
                        ForEach(filteredFaculties, id: \.self) { cr in
//                            let cr = filteredFaculties[index]
                            HStack{
                                Text(cr.f_name)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                
                                NavigationLink(destination: EyeAssignedCousres(facultyID: cr.f_id, facultyName: cr.f_name)) {
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
                        if filteredFaculties.isEmpty {
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
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 410 , height:700)
                .onAppear {
                    facultiesViewModel.fetchExistingFaculties()
                }
                Spacer()
            }
            .background(Image("fc") .resizable().ignoresSafeArea())
        }
    }
}

struct Coure: Codable  ,Hashable {
    let f_id: Int
    let c_id: Int
    let c_code: String
    let c_title: String
    let f_name: String
}

class CouViewModel: ObservableObject {
    @Published var assignedCourses: [Coure] = []
    
    func fetchAssignedCourses(facultyID: Int) {
        guard let url = URL(string: "http://localhost:2000/FacultyAssignedCourse?f_id=\(facultyID)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Coure].self, from: data)
                DispatchQueue.main.async {
                    self.assignedCourses = courses
                    print("Fetched \(courses.count) assigned courses for faculty ID: \(facultyID)")
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    func deleteAssignedCourse(facultyId: Int, courseId: Int) {
        // Perform the deletion using an API call or database query
        deleteAssignedCourseFromServer(facultyId: facultyId, courseId: courseId) { success in
            if success {
                // Remove the deleted assigned course from the array
                DispatchQueue.main.async {
                    if let index = self.assignedCourses.firstIndex(where: { $0.f_id == facultyId && $0.c_id == courseId }) {
                        self.assignedCourses.remove(at: index)
                    }
                }
            } else {
                // Handle error
                print("Failed to delete assigned course")
            }
        }
    }

    private func deleteAssignedCourseFromServer(facultyId: Int, courseId: Int, completion: @escaping (Bool) -> Void) {
        // Make the API call or database query to delete the assigned course
        // You can use URLSession or Alamofire to make the HTTP request
        
        // Example using URLSession
        guard let url = URL(string: "http://localhost:2000/assigncourse/\(facultyId)/\(courseId)") else {
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

struct EyeAssignedCousres: View {  // Design 100% ok
    
    @StateObject private var couViewModel = CouViewModel()
    var facultyID: Int
    var facultyName: String
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView{
            VStack {
                Text("Assigned Courses")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(facultyName)")
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
                        ForEach(couViewModel.assignedCourses, id: \.self) { cr in
                            HStack{
                                Text(cr.c_title)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Text(cr.c_code)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .center)
                                Image(systemName: "trash.fill")
                                    .font(.title3)
                                    .foregroundColor(Color.red)
                                    .onTapGesture {
                                        deleteAssignedCourse(facultyId: cr.f_id, courseId: cr.c_id)
                                    }
                            }
                            Divider()
                                .background(Color.white)
                                .padding(1)
                        }
                        if couViewModel.assignedCourses.isEmpty {
                            Text("\(facultyName) have no Assigned Courses Yet !")
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
                    couViewModel.fetchAssignedCourses(facultyID: facultyID)
                }
                NavigationLink{
//                    PlusAssignCourse()
//                        .navigationBarBackButtonHidden(true)
                }label: {
                    Image(systemName: "plus.app.fill")
                        .bold()
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity , alignment: .trailing)
                }
//                Spacer()
            }
            .background(Image("fc").resizable().ignoresSafeArea())
        }
    }
    private func deleteAssignedCourse(facultyId: Int, courseId: Int) {
            couViewModel.deleteAssignedCourse(facultyId: facultyId, courseId: courseId)
        }
}


struct PlusAssignCourse: View { // Design 100% ok
    
    @StateObject private var couViewModel = CouViewModel()
    var facultyID: Int
    var facultyName: String
    @State private var searchText = ""
   
    struct SearchBar: View { // Search Bar avaible outside of table to search record
        
        @Binding var text: String
        
        var body: some View {
            HStack {
//                Spacer()
                TextField("Search", text: $text)
                    .padding()
                    .frame(width: 247 , height: 40)
                    .background(Color.gray.opacity(1))
                    .cornerRadius(8) // Set the corner radius to round the corners
                    .padding(.horizontal)

                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .opacity(text.isEmpty ? 0 : 1)
                Spacer()
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
                Text("\(facultyName)")
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Subject")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                SearchBar(text: $searchText)
            VStack{
//                ScrollView{
//                    ForEach(couViewModel.assignedCourses, id: \.self) { cr in
//                        HStack{
//                            Text(cr.c_title)
//                                .font(.headline)
//                                .foregroundColor(Color.white)
//                                .frame(maxWidth: .infinity , alignment: .leading)
//                            Text(cr.c_code)
//                                .font(.headline)
//                                .foregroundColor(Color.white)
//                                .frame(maxWidth: .infinity , alignment: .center)
//                            Image(systemName: "trash.fill")
//                                .font(.title3)
//                                .foregroundColor(Color.red)
//                                .onTapGesture {
//                                    deleteAssignedCourse(facultyId: cr.f_id, courseId: cr.c_id)
//                                }
//                        }
//                        Divider()
//                            .background(Color.white)
//                            .padding(1)
//                    }
//                    if couViewModel.assignedCourses.isEmpty {
//                        Text("\(facultyName) have no Assigned Courses Yet !")
////                                .font(.headline)
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(.yellow)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                    }
//                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .frame(width: 410, height: 500)
            .onAppear {
                couViewModel.fetchAssignedCourses(facultyID: facultyID)
            }

            Spacer()
            
            Button("Save"){
                // Add Logic for Backend to Store New Data
            }
            .bold()
            .padding()
            .frame(width: 150)
            .foregroundColor(.black)
            .background(Color.teal)
            .cornerRadius(8)
            
        }
        .background(Image("fc").resizable().ignoresSafeArea())
    }
}

struct FacultyDetails_Previews: PreviewProvider {
    static var previews: some View {
        PlusAssignCourse(facultyID: 1, facultyName: "String")
    }
}
