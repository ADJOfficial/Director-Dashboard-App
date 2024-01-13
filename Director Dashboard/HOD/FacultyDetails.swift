//
//  FacultyDetails.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct FacultyDetails: View {
    
    @StateObject private var courseViewModel = CourseViewModel()
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                //            Spacer()
                ScrollView{
                    Text("Teacher :")
                        .foregroundColor(Color.white)
                    
                    TextField("Username", text: $search)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .frame(width: 370)
                        .cornerRadius(8)
                    //                .padding(.bottom,590)
                    VStack{
                        ForEach(courseViewModel.courses , id:\ .self) { cr in
                            HStack{
                                Text(cr.course)
                                    .padding(.horizontal)
                                    .frame(width:290)
                                    .multilineTextAlignment(.leading)
                                
                                NavigationLink {
                                    EyeSub()
                                        
                                } label:{
                                    Image(systemName: "eye.fill")
                                        .padding(.horizontal)
                                        .font(.title3)
                                        .foregroundColor(Color.green)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                }
                            }
                            .padding(1)
                        }
                    }
                    .background(Color.white.opacity(0.8)) // Add a background color for better visibility
                    .cornerRadius(8)
                    //                .frame(width: 360, height: 200)
                    .padding()
                    .onAppear {
                        courseViewModel.fetchExistingCourse()
                    }
                }
            }
            .background(Image("h"))
        }
    }
}

struct EyeSub: View {
    
    @StateObject private var courseViewModel = CourseViewModel()
    @State private var search = ""
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Course")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.bottom)
                
                Text("Semester: Fall 2024")
                
                    .foregroundColor(Color.white)
                Text("Sir Umer Farooq")
                    .bold()
                    .padding(.top)
                    .font(.title2)
                    .foregroundColor(Color.white)
                
                ScrollView{
                    Text("Assigned Courses")
                        .bold()
                        .underline()
                        .font(.title3)
                        .foregroundColor(Color.white)
                    VStack{
                        ForEach(courseViewModel.courses , id:\ .self) { cr in
                            HStack{
                                Text(cr.course)
                                    .padding(.horizontal)
                                    .frame(width:290)
                                    .multilineTextAlignment(.leading)
                                
                                Image(systemName: "delete.right.fill")
                                    .padding(.horizontal)
                                    .font(.title3)
                                    .foregroundColor(Color.red)
                                //                                .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .padding(1)
                        }
                        
                    }
                    .background(Color.white.opacity(0.8)) // Add a background color for better visibility
                    .cornerRadius(8)
                    //                .frame(width: 360, height: 200)
                    .padding()
                    .onAppear {
                        courseViewModel.fetchExistingCourse()
                    }
                }
                NavigationLink{
                    AddCourse()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Image(systemName: "plus.app.fill")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                }
            }
            .background(Image("h"))
        }
    }
}

struct AddCourse: View {
    @State private var options = ""
    var body: some View {
        VStack {
            Text("Assign Course")
                .bold()
            //                .padding(.bottom,50)
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            Text("Drop Down For Teacher :")
                .foregroundColor(Color.white)
                .padding(.top)
            TextField("Username", text: $options)
                .padding()
                .background(Color.gray.opacity(0.8))
                .frame(width: 370)
                .cornerRadius(8)
            Text("Sir Umer Farooq")
                .bold()
                .padding(.top)
                .font(.title2)
                .foregroundColor(Color.white)
            Text("Subject")
                .foregroundColor(Color.white)
            
            TextField("Username", text: $options)
                .padding()
                .background(Color.gray.opacity(0.8))
                .frame(width: 370)
                .cornerRadius(8)
            Spacer()
            ScrollView{
                HStack{
                    Image(systemName: "checkmark.square")
                    Text("Parallel & distributing Computing")
                }
                .padding(.top)
                .font(.title3)
                .foregroundColor(Color.white)
            }
            Button("Save Changes"){
                
            }
            .foregroundColor(.black)
            .padding()
            .bold()
            .frame(width: 150)
            .background(Color.teal)
            .cornerRadius(8)
            .padding(.all)
            
        }
        .background(Image("h"))
    }
}

struct FacultyDetails_Previews: PreviewProvider {
    static var previews: some View {
        FacultyDetails()
    }
}
