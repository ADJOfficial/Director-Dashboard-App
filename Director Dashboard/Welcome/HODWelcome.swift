//
//  HODWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct HODWelcome: View {
    
    var body: some View {
        VStack {
            Text("HOD Dashboard")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            Text("Welcome")
                .font(.title)
                .position(x:80,y: 80)
            
            VStack{
                NavigationLink{
                    ViewCourses()
                } label: {
                    Text("View Courses")
                }
                .foregroundColor(.white)
                .padding()
                .bold()
                .frame(width: 150)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.all)
                
                NavigationLink{
                    FacultyDetails()
                } label: {
                    Text("Faculty Details")
                }
                .foregroundColor(.white)
                .padding()
                .bold()
                .frame(width: 150)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.all)
                
                NavigationLink{
                    AssignCourses()
                } label: {
                    Text("Assign Course")
                }
                .foregroundColor(.white)
                .padding()
                .bold()
                .frame(width: 150)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.all)
            }
            .position(x: 200)
        }
    }
}

struct ViewCourses: View {
    var body: some View {
        VStack {
            Text("")
        }
    }
}

struct FacultyDetails: View {
    var body: some View {
        VStack {
            Text("")
        }
    }
}

struct AssignCourses: View {
    var body: some View {
        VStack {
            Text("")
        }
    }
}
struct HODWelcome_Previews: PreviewProvider {
    static var previews: some View {
        HODWelcome()
    }
}
