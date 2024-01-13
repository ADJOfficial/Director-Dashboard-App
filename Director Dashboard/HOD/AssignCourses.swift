//
//  AssignCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct AssignCourses: View {
    
    @StateObject private var courseViewModel = CourseViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Assigned Course")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.bottom)
                Text("Programming Fundamental")
                    .bold()
                    .padding(.top)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Course Code  CS-323")
                    .bold()
                    .font(.headline)
                    .foregroundColor(Color.white)
                
                ScrollView{
                    Text("Assigned To")
                        .bold()
                        .underline()
                        .font(.title3)
                        .foregroundColor(Color.white)
                    VStack{
                        ForEach(courseViewModel.courses , id:\ .self) { cr in
                            HStack{
                                Text(cr.course) // Teacher Names From DB
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
                    CLOS()
                }label: {
                    Text("CLOS")
                }
                .foregroundColor(.black)
                .padding()
                .bold()
                .frame(width: 100)
                .background(Color.teal)
                .cornerRadius(8)
                .padding(.all)
            }
            .background(Image("h"))
        }
    }
}
struct CLOS: View {
    var body: some View { // Get all Data From API using MongoDB
        VStack {
            Text("CLOS")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)

            Text("Status .. Pending ")
                .padding(.top)
                .padding(.leading,100)
                .foregroundColor(Color.white)
            Text("Programming Fundamental")
                .bold()
                .padding(.top)
                .padding(.trailing,80)
                .font(.title2)
                .foregroundColor(Color.white)
            Text("Course Code  CS-323")
                .bold()
                .padding(.trailing,185)
                .font(.headline)
                .foregroundColor(Color.white)
           Spacer()
            VStack{
                Text("CLO-1")
                    .padding()
                Text("CLO-2")
                    .padding()
                Text("CLO-3")
                    .padding()
                Text("CLO-4")
                    .padding()
            }
            .bold()
            .padding(.trailing,285)
            .font(.headline)
            .foregroundColor(Color.white)
            
            Spacer()
        }
        .background(Image("h"))
    }
}

struct AssignCourses_Previews: PreviewProvider {
    static var previews: some View {
        AssignCourses()
    }
}
