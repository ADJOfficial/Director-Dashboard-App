//
//  AssignRole.swift
//  Director Dashboard
//
//  Created by ADJ on 20/01/2024.
//

import SwiftUI

struct AssignRole: View {
    
    @State private var selectedd = 0
    var options = ["CS" , "PF" , "AI"]
    @State private var selectedr = 0
    let teachers = ["Dr Qamar Mehmood" , "Dr Shahid Jameel" , "Dr Zeeshan Muzafar"]
    var body: some View {
        VStack{
            Text("Assign Role")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Text("Course")
                .bold()
                .padding()
                .padding(.horizontal)
                .font(.title)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity ,alignment: .leading)
            Picker("" , selection: $selectedd){
                ForEach(0..<options.count){ index in
                    Text(options[index])
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.3))
            .cornerRadius(8)
            .padding(.horizontal)
           
            Spacer()
            
            VStack{
                Text("SENIOR TEACHER")
                    .font(.title)
                    .foregroundColor(Color.white)
                ForEach(teachers.indices) { index in
                    Button(action: {
                        selectedr = index
                    }) {
                        HStack {
                            Text(teachers[index])
                                .padding()
                                .font(.title2)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.horizontal)
                                .foregroundColor(.white)
//                            Spacer()
                            Image(systemName: selectedr == index ? "largecircle.fill.circle" : "circle")
                                .resizable()
                                .font(.title2)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.green)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            Spacer()
            Button("Save"){
                
            }
            .bold()
            .padding()
            .frame(width: 100)
            .foregroundColor(.black)
            .background(Color.teal)
            .cornerRadius(8)
            .padding(.bottom)
        }
        .background(Image("fc").resizable().ignoresSafeArea())
    }
}

struct AssignRole_Previews: PreviewProvider {
    static var previews: some View {
        AssignRole()
    }
}
