//
//  FacultyWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct FacultyWelcome: View { // Design 100% OK
    
    var body: some View { // Get All Data From Node MongoDB : Pending
       
        NavigationView {
            VStack {
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Welcome  -------- ")
                    .bold()
                    .padding()
                    .font(.title)
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
                    .background(Color.green)
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
                    .background(Color.green)
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
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.all)
                }
                Spacer()
            }
            .background(Image("fa").resizable().ignoresSafeArea())
        }
    }
}

struct FacultyWelcome_Previews: PreviewProvider {
    static var previews: some View {
        FacultyWelcome()
    }
}
