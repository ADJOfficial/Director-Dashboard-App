//
//  FacultyDetails.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct FacultyDetails: View { // Designed 100% OK
    
    @StateObject private var courseViewModel = CourseViewModel()
    @State private var search = ""
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView {
            VStack {
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    Text("Teacher :")
                        .padding()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    TextField("Search Faculty", text: $search)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                VStack{
                    ScrollView{
                        ForEach(courseViewModel.courses , id:\ .self) { cr in
                            HStack{
                                Spacer()
                                Text(cr.course)
                                    .padding(.top)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                NavigationLink {
                                    EyeAssignedCousres()
                                        .navigationBarBackButtonHidden(true)
                                } label:{
                                    Image(systemName: "eye.fill")
                                        .font(.title3)
                                        .foregroundColor(Color.green)
                                }
                                Spacer()
                            }
                        }
                    }
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

struct EyeAssignedCousres: View {  // Design 100% ok
    
    @StateObject private var courseViewModel = CourseViewModel()
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView{
            VStack {
                Text("Assigned Courses")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Semester: Fall 2024")
                    .padding()
                    .foregroundColor(Color.white)
                Text("Sir Umer Farooq")
                    .bold()
                    .padding()
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)  
                Text("Assigned Courses")
                    .bold()
                    .underline()
                    .font(.title3)
                    .foregroundColor(Color.white)
                VStack{
                    ScrollView{
                        ForEach(courseViewModel.courses , id:\ .self) { cr in
                            HStack{
                                Spacer()
                                Text(cr.course)
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
                    .onAppear {
                        courseViewModel.fetchExistingCourse()
                    }
                }
                NavigationLink{
                    PlusAssignCourse()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Image(systemName: "plus.app.fill")
                        .bold()
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                }
            }
            .background(Image("h"))
        }
    }
}

struct PlusAssignCourse: View { // Design 100% ok
    
    @State private var SelectedOption = 0
    @State private var searchSubject = ""
    var options = ["Sir Zahid" , "Sir Abid Jameel" , "Sir Shahid Rasheed"]
   
    var body: some View { // Get All Data From Node MongoDB : Pending
       
        VStack {
            Text("Assign Course")
                .bold()
                .padding()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            Text("Semester: Fall 2024")
                .foregroundColor(Color.white)
            VStack{
                Picker("" , selection: $SelectedOption){
                    ForEach(0..<options.count) { index in
                        Text(options[index])
                    }
                }
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding(.horizontal)
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                Text("Sir Umer Farooq")
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Subject")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity,alignment: .leading)
                TextField("Search Subject", text: $searchSubject)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            ScrollView{
                HStack{
                    Spacer()
                    Image(systemName: "checkmark.square")
                    Spacer()
                    Text("Parallel & distributing Computing")
                    Spacer()
                }
                .padding(.top)
                .font(.title3)
                .foregroundColor(Color.white)
            }
            Button("Save Changes"){
                // Add Logic for Backend to Store New Data
            }
            .bold()
            .padding()
            .frame(width: 150)
            .foregroundColor(.black)
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
