//
//  HODWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct HODWelcome: View { // Design 100% OK
    
//    let username: String
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView{
            VStack {
                Text("HOD Dashboard")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Welcome : ")
                    .bold()
                    .padding()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Spacer()
                VStack{
//                    Spacer()
                    NavigationLink{
                        ViewCourses()
                            
                    } label: {
                        Text("View Courses")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.teal)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        FacultyDetails()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Faculty Details")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.teal)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        AssignCourse()
                    } label: {
                        Text("Assign Course")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.teal)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        GridView()
                    } label: {
                        Text("Grid View")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.teal)
                    .cornerRadius(8)
                    .padding(.all)
                }
                Spacer()
            }
            .background(Image("h").resizable().ignoresSafeArea())
        }
    }
}

struct HODWelcome_Previews: PreviewProvider {
    static var previews: some View {
        HODWelcome()
    }
}
