//
//  DirectorWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct DirectorWelcome: View { // Design 100% Ok
    
//    let username: String
    
    var body: some View { // Get All Data From Node MongoDB : Pending
    
        NavigationView{
            VStack{
                Text("Director")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Welcome")
                    .bold()
                    .padding()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.all)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Spacer()
                VStack {   
                    NavigationLink {
                        UploadPapers()
                    } label: {
                        Text("Upload Papers")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 170)
                    .background(Color.cyan)
                    .cornerRadius(8)
                    .padding(.all)
                    NavigationLink {
                        ApprovedPapers()
                    } label: {
                        Text("Approved Papers")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 170)
                    .background(Color.cyan)
                    .cornerRadius(8)
                    .padding(.all)
                }
                Spacer()
            }
            .background(Image("fe").resizable().ignoresSafeArea())
        }
    }
}

struct Comments: View { // Design 100% Ok
    
    @State private var comment: String = ""
    
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
                TextEditor(text: $comment)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(height: 400)
                HStack {
                    Spacer()
                    Image(systemName: "paperplane.fill")
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                }
            }
            .padding()
            Spacer()
        }
        .background(Image("fii").resizable().ignoresSafeArea())
    }
}

struct UploadPapers: View {
    
    @StateObject private var courseViewModel = CourseViewModel()
    @State private var search = ""
    @State private var course = ""
    @State private var code = ""

    var body: some View {
        NavigationView {
            VStack{
                Text("Uploaded Papers")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                TextField("Search By Subject...",text: $search)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text("Courses")
                            .bold()
                            .font(.title2)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Spacer()
                        Text("Code")
                            .bold()
                            .font(.title2)
                            .frame(maxWidth: .infinity , alignment: .center)
                        Spacer()
                    }
                    .padding()
                    ScrollView {
                        ForEach(courseViewModel.courses , id:\ .self) { cr in
                            HStack{
                                Spacer()
                                Text(cr.course)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Spacer()
                                Text(cr.code)
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity , alignment: .trailing)
                                Spacer()
                                NavigationLink {
                                    Eye()
                                        .navigationBarBackButtonHidden(true)
                                } label:{
                                    Image(systemName: "eye.fill")
                                        .padding(.horizontal)
                                        .font(.title3)
                                        .foregroundColor(Color.orange)
                                }
                            }
                            .padding(1)
                        }
                    }
                }
                .frame(height: 400)
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .onAppear {
                    courseViewModel.fetchExistingCourse()
                }
            }
            .background(Image("fii").resizable().ignoresSafeArea())
        }
    }
}



struct ApprovedPapers: View {
    @StateObject private var courseViewModel = CourseViewModel()
    @State private var search = ""
    @State private var course = ""
    @State private var code = ""
    
    var body: some View {
        VStack{
            Text("Approved Papers")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            TextField("Search By Title or Code",text: $search)
//                .padding()
//                .border(Color.black)
//                .cornerRadius(8)
//                .padding(.horizontal)
//                .frame(width: 400, height: 40)
//                .position(x: 196, y: 120)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
               
            VStack {
                HStack {
                    Text("Courses")
                        .font(.title2)
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(width: 150)
                    Divider()
                        .background(Color.black)
                    Text("Code")
                        .font(.title2)
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(width: 130)
                    
                    Divider()
                        .background(Color.black)
                    Text("")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                }
                .padding(1)
                ScrollView {
                    ForEach(courseViewModel.courses , id:\ .self) { cr in
                        HStack{
                            Text(cr.course)
                                .padding(.horizontal)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(width: 150)
                            Divider()
                                .background(Color.black)
                            Text(cr.code)
                                .padding(.horizontal)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(width: 130)
                            Divider()
                                .background(Color.black)
                            Image(systemName: "checkmark")
                                .padding(.horizontal)
                                .font(.title3)
                                .foregroundColor(Color.green)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .padding(1)
                    }
                }
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .frame(width: 360, height: 200)
            .padding()
            .onAppear {
                courseViewModel.fetchExistingCourse()
            }
        }
        .background(Image("fii").resizable().ignoresSafeArea())
    }
}

struct Eye: View { // Design 100% Ok
    
    var body: some View { // Get All Data From Node MongoDB : Pending
    
        NavigationView {
            VStack{
                Text("Paper Information")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Communication Skills")
                    .bold()
                    .font(.title2)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Text("Code: CS-502")
                    .bold()
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                NavigationLink {
                    Comments()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Image(systemName: "text.bubble.fill")
                        .font(.largeTitle)
                        .padding(.horizontal)
                        .foregroundColor(Color.green)
                        .frame(maxWidth: .infinity , alignment: .trailing)
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("Teacher ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Course Title ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Course Code ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Date of Exam ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Duration ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Degree ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Term ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Year ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Total Marks ")
                        .padding(5)
                        .foregroundColor(Color.white)
                    Text("Questions ")
                        .padding(5)
                        .foregroundColor(Color.white)
                }
                .bold()
                .font(.title3)
                .padding(.horizontal)
                .frame(maxWidth: .infinity , alignment: .leading)
                Spacer()
                NavigationLink {
                    MakePaper()
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
            .background(Image("fii").resizable().ignoresSafeArea())
        }
    }
}

struct MakePaper: View {
    
    var body: some View {
        VStack{
            Text("Paper")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.white)
            
            Image(systemName: "mail.fill")
                .font(.largeTitle)
                .foregroundColor(Color.green)
                .position(x:40,y: 50)
            Text("Barani Institute of Information Technology\n         PMAS Arid Agriculture University\n                     Rawalpindi Pakistan\n        Fall 2024: Mid Term Examination")
                .foregroundColor(Color.white)
                .position(x:215,y: -160)
            Image(systemName: "mail.fill")
                .font(.largeTitle)
                .foregroundColor(Color.green)
                .position(x:390,y: -330)
            VStack(alignment: .leading){
                Text("Course Title:")
                    .position(x:43,y:-488)
                    .bold()
                Text("Date of Exam:")
                    .position(x:48,y:-500)
                    .bold()
                Text("Degree Program:")
                    .position(x:60,y:-515)
                    .bold()
                Text("Teacher Name:")
                    .position(x:52,y:-530)
                    .bold()
            }
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 410, height: 200)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
                    .position(x:204,y: -390)
            )
            .padding(.horizontal)
            
            VStack {
                
            }
        }
        .background(Image("ft").resizable().ignoresSafeArea())
    }
}
struct DirectorWelcome_Previews: PreviewProvider {
    static var previews: some View {
        MakePaper()
    }
}
