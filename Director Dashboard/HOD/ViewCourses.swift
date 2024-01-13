//
//  ViewCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct ViewCourses: View {    // Design 100% OK
    
    @State private var search = ""
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView {
            VStack {
                Text("Course Details")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                TextField("Search Subject", text: $search)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Spacer()
                ScrollView{ // Get From Backend
                    HStack{
                        Spacer()
                        Text("Parallel & distributing Computing")
                            .font(.headline)
                        Spacer()
                        Text("CS-323")
                        Spacer()
                        NavigationLink{
                            CourseAssigned()
                                .navigationBarBackButtonHidden(true)
                        }label: {
                            Image(systemName: "eye.fill")
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(Color.white)
                }
            }
            .background(Image("h").resizable().ignoresSafeArea())
        }
    }
}

struct CourseAssigned: View { // Design 100% OK
    
    @State private var selectedOptions = 0
    @StateObject private var courseViewModel = CourseViewModel()
    var options = ["Sir Naveed Ashraf" , "Sir Abid Jameel" , "Ma'am Zoya" , "Sir Zeeshan"]
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView{
            VStack {
                Text("Course Assigned")
                    .bold()
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Parallel & Distributing Computing")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Course Code  CS-323")
                    .bold()
                    .padding(.horizontal)
                    .font(.headline)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)
                
                    Text("Assigned To")
                        .bold()
                        .padding()
                        .underline()
                        .font(.title3)
                        .foregroundColor(Color.white)
                
                VStack{
                    ScrollView{
                        ForEach(courseViewModel.courses , id:\ .self) { cr in
                            HStack{
                                Spacer()
                                Text(cr.course) // Teacher Names From DB
                                    .padding(.top)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Image(systemName: "delete.right.fill") // Add logic To Delete
                                    .font(.title3)
                                    .foregroundColor(Color.red)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .onAppear {
                        courseViewModel.fetchExistingCourse()
                    }
                }
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
            }
            .background(Image("h").resizable().ignoresSafeArea())
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

struct ViewCouses: PreviewProvider {
    static var previews: some View {
        ViewCourses()
    }
}
