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
                        ForEach(filteredCourses.indices, id: \.self) { index in
                            let cr = filteredCourses[index]
                            HStack {
                                Text(cr.c_title)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                NavigationLink(destination: CourseAssigned(courseName: cr.c_title), tag: cr.c_title,selection: $selectedCourseName) {
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

struct CourseAssigned: View { // Design 100% OK
    
    let courseName: String
//    let courseCode: String
//    @State private var selectedOptions = 0
    @StateObject private var courseViewModel = CoursesViewModel()
    var options = ["Sir Naveed Ashraf" , "Sir Abid Jameel" , "Ma'am Zoya" , "Sir Zeeshan"]
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView{
            VStack {
                Text("Course Assigned")
                    .bold()
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(courseName)")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
//                Text("Course Code  CS-323")
//                    .bold()
//                    .padding(.horizontal)
//                    .font(.headline)
//                    .frame(maxWidth: .infinity , alignment: .leading)
//                    .foregroundColor(Color.white)

                    Text("Assigned To")
                        .bold()
                        .padding()
                        .underline()
                        .font(.title3)
                        .foregroundColor(Color.white)

                VStack{
                    ScrollView{
                        ForEach(courseViewModel.existing , id:\ .self) { cr in
                            HStack{
                                Spacer()
                                Text(cr.c_code)
                                    .padding(.top)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Text(cr.c_title)
                                    .padding(.top)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Image(systemName: "delete.right.fill")
                                    .font(.title3)
                                    .foregroundColor(Color.red)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 410, height: 400)
                .onAppear {
                    courseViewModel.fetchExistingCourses()
                }
                Spacer()
                NavigationLink{
                    CLOS()
                        .navigationBarBackButtonHidden()
                }label: {
                    Text("CLOS")
                }
                .foregroundColor(.black)
                .padding()
                .bold()
                .frame(width: 100)
                .background(Color.teal)
                .cornerRadius(8)
                .padding(.all)
                
                Spacer()
            }
            .background(Image("fc").resizable().ignoresSafeArea())
        }
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
