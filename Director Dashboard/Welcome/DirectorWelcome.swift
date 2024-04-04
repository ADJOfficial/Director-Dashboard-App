//
//  DirectorWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct DirectorWelcome: View { // Design 100% Ok
    
    let username: String
    
    var body: some View { // Get All Data From Node MongoDB : Pending
    
        NavigationView{
            VStack{
                Text("Director")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Welcome \(username)")
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Spacer()
                VStack {   
                    NavigationLink {
                        UploadedPapers()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Upload Papers")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 170)
                    .background(Color.brown.opacity(0.7))
                    .cornerRadius(8)
                    .padding(.all)
                    NavigationLink {
                        AdditionalQuestions()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Approved Papers")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 170)
                    .background(Color.brown.opacity(0.7))
                    .cornerRadius(8)
                    .padding(.all)
                }
                Spacer()
                
                NavigationLink{
                    DirectorLogin()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Logout ? ")
                }
                .bold()
                .padding()
                .padding(.horizontal)
                .foregroundColor(.teal)
                .frame(maxWidth: .infinity , alignment: .trailing)
            }
            .background(Image("ft").resizable().ignoresSafeArea())
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
        .navigationBarItems(leading: backButton)
        .background(Image("ft").resizable().ignoresSafeArea())
    }
    @Environment(\.presentationMode) var presentationMode
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
struct DirectorWelcome_Previews: PreviewProvider {
    static var previews: some View {
        DirectorWelcome(username: "")
    }
}
