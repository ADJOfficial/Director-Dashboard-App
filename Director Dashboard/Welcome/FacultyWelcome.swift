//
//  FacultyWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct FacultyWelcome: View { // Design 100% OK
    
    let username: String
    
    var body: some View { // Get All Data From Node MongoDB : Pending
       
        NavigationView {
            VStack {
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Welcome \(username)")
                    .bold()
                    .padding()
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                Spacer()
                VStack{
                    NavigationLink {
                        ViewYourCourses()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Courses")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.green.opacity(0.7))
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink {
                        SetCLOs()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("CLOs")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.green.opacity(0.7))
                    .cornerRadius(8)
                    .padding(.all)
                    NavigationLink {
                        Topics()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Topics")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.green.opacity(0.7))
                    .cornerRadius(8)
                    .padding(.all)
                }
                Spacer()
                
                NavigationLink{
                    FacultyLogin()
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
            .background(Image("fiii").resizable().ignoresSafeArea())
        }
    }
}

struct FacultyWelcome_Previews: PreviewProvider {
    static var previews: some View {
        FacultyWelcome(username: "")
    }
}
