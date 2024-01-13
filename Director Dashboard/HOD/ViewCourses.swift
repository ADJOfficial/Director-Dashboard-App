//
//  ViewCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct ViewCourses: View {
    
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            VStack { // Add Backend logic and get courses and course-code from MongoDB
                Text("Course Details")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                TextField("Search Subject", text: $search)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .frame(width: 370)
                    .cornerRadius(8)
                Spacer()
                ScrollView{
                    HStack{
                        Text("Parallel & distributing Computing")
                            .font(.headline)
                        Text("CS-323")
                        NavigationLink{
                            AssignCourses()
                        }label: {
                            Image(systemName: "eye.fill")
                        }
                    }
                    .padding(.top)
                    .foregroundColor(Color.white)
                }
            }
            .background(Image("h"))
        }
    }
}

struct ViewCouses: PreviewProvider {
    static var previews: some View {
        ViewCourses()
    }
}
