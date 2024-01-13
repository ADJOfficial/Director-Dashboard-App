//
//  HODWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct HODWelcome: View {
    
    var body: some View {
        NavigationView{
            VStack {
                Text("HOD Dashboard")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)

                Text("Welcome Dr Munir")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundColor(Color.white)
               
                VStack{
                    Spacer()
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
                        AssignCourses()
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
                    
                    Spacer()
                }
            }
            .background(Image("h").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
        }
    }
}

struct HODWelcome_Previews: PreviewProvider {
    static var previews: some View {
        HODWelcome()
    }
}
