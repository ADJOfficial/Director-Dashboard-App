//
//  AssignCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct AssignCourse: View { // Design 100% ok
    
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
                Text("---------------")
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
            Button("Save"){
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
        .background(Image("h").resizable().ignoresSafeArea())
    }
}

struct AssignCourse_Previews: PreviewProvider {
    static var previews: some View {
        AssignCourse()
    }
}
