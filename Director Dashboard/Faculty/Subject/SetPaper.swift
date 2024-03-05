//
//  SetPaper.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct SetPaper: View {
    
    @State private var isChecked = false
    @State private var semIsChecked = false
    @State private var examDate = ""
    @State private var duration = ""
    @State private var degree = ""
    @State private var totalMarks = ""
    @State private var totalQuestions = ""
    @State private var year = ""
    @State private var selectedSemRadioButton: String? = nil
    @State private var selectedTermRadioButton: String? = nil
    @State private var selectedValue = 0
    var option = ["2020" , "2021" , "2022" , "2023" , "2024"]
    
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Paper Setting")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Programming Fundamental")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Course Code  CS-323")
                    .padding(.horizontal)
                    .font(.title3)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)
               
                HStack {
                    Text("Status - Pending")
                        .font(.title3)
                        .frame(maxWidth: .infinity , alignment: .trailing)
                        .foregroundColor(Color.white)
                    Image(systemName: isChecked ? "circle.fill" : "circle")
//                        .padding()
                        .foregroundColor(isChecked ? .green : .white)
                        .onTapGesture {
                            isChecked.toggle()
                        }
                }
                
                Text("Set Paper")
                    .bold()
                    .padding()
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .center)
                    .foregroundColor(Color.white)
                
                VStack {
                    Text("Teacher :                     Shahid ")//DB name
                        .bold()
                        .padding(.all,1)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .font(.title3)
                        .foregroundColor(Color.white)
                    Text("Course Title :             Programming ")
                        .bold()
                        .padding(.all,1)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .font(.title3)
                        .foregroundColor(Color.white)
                    Text("Course Code :           CS-323")
                        .bold()
                        .padding(.all,1)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .font(.title3)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        Text("Date of Exam :")
                            .bold()
                            .padding(.all,1)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .font(.title3)
                            .foregroundColor(Color.white)
                        TextField("" , text: $examDate)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(8)
                            .frame(width: 180 , height: 20)
                            .padding(.horizontal)
                    }
                    HStack {
                        Text("Duration :")
                            .bold()
                            .padding(.all,1)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .font(.title3)
                            .foregroundColor(Color.white)
                        TextField("" , text: $duration)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(8)
                            .frame(width: 180 , height: 20)
                            .padding(.horizontal)
                    }
                    HStack {
                        Text("Degree :")
                            .bold()
                            .padding(.all,1)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .font(.title3)
                            .foregroundColor(Color.white)
                        TextField("" , text: $degree)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(8)
                            .frame(width: 180 , height: 20)
                            .padding(.horizontal)
                    }
                    VStack{
                        HStack{
                            Text("Total Marks :")
                                .bold()
                                .padding(.all,1)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .font(.title3)
                                .foregroundColor(Color.white)
                            TextField("" , text: $degree)
                                .background(Color.gray.opacity(0.8))
                                .cornerRadius(8)
                                .frame(width: 180 , height: 20)
                                .padding(.horizontal)
                        }
                        VStack{
                            Text("Semester :")
                                .bold()
                                .padding(.all,1)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .font(.title3)
                                .foregroundColor(Color.white)
                            HStack{
                                Spacer()
                                SemesterRadioButton(title: "Fall", isSelected: selectedSemRadioButton == "Fall") {
                                    selectedSemRadioButton = "Fall"
                                }
                                .foregroundColor(selectedSemRadioButton == "Fall" ? .green : .white)
                                Spacer()
                                SemesterRadioButton(title: "Spring", isSelected: selectedSemRadioButton == "Spring") {
                                    selectedSemRadioButton = "Spring"
                                }
                                .foregroundColor(selectedSemRadioButton == "Spring" ? .green : .white)
                                Spacer()
                                SemesterRadioButton(title: "Summer", isSelected: selectedSemRadioButton == "Summer") {
                                    selectedSemRadioButton = "Summer"
                                }
                                .foregroundColor(selectedSemRadioButton == "Summer" ? .green : .white)
                                Spacer()
                            }
                        }
                        VStack{
                            Text("Term :")
                                .bold()
                                .padding(.all,1)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .font(.title3)
                                .foregroundColor(Color.white)
                            HStack{
                                Spacer()
                                SemesterRadioButton(title: "Mid", isSelected: selectedTermRadioButton == "Mid") {
                                    selectedTermRadioButton = "Mid"
                                }
                                .foregroundColor(selectedTermRadioButton == "Mid" ? .green : .white)
                                Spacer()
                                SemesterRadioButton(title: "Final", isSelected: selectedTermRadioButton == "Final") {
                                    selectedTermRadioButton = "Final"
                                }
                                .foregroundColor(selectedTermRadioButton == "Final" ? .green : .white)
                                Spacer()
                            }
                        }
                        HStack{
                            Text("Questions :")
                                .bold()
                                .padding(.all,1)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .font(.title3)
                                .foregroundColor(Color.white)
                            TextField("" , text: $totalQuestions)
                                .background(Color.gray.opacity(0.8))
                                .cornerRadius(8)
                                .frame(width: 180 , height: 20)
                                .padding(.horizontal)
                        }
                        HStack{
                            Text("Year :")
                                .bold()
                                .padding(.all,1)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .font(.title3)
                                .foregroundColor(Color.white)
                            Picker("" ,selection: $selectedValue){
                                ForEach(0..<option.count){ index in
                                    Text(option[index])
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(Color.green)
                            
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                NavigationLink{
                    StartMakingPaper()
//                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Continue")
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.green)
                .cornerRadius(8)
                .padding(.all)

//                Spacer()
                
            }
            .background(Image("fiii").resizable().ignoresSafeArea())
        }
    }
}

struct SemesterRadioButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(title)
            }
        }
    }
}


struct StartMakingPaper: View {
    
    @State private var question = ""
    @State private var selectedone = 0
    var options = ["EASY" , "HARD" , "MEDIUM"]
    var topicoptions = ["LOOP" , "ARRAY" , "INTEGERS"]
    
    var body: some View {
        VStack{
            Text("Paper")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            HStack{
                Image(systemName: "mail.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.green)
                Text("Barani Institute of Information Technology\n         PMAS Arid Agriculture University\n                     Rawalpindi Pakistan\n        Fall 2024: Mid Term Examination")
                    .foregroundColor(Color.white)
                Image(systemName: "mail.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.green)
            }
            HStack{
                VStack{
                    Text("Course Title: PF")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Date of Exam: 9/12/2024")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Degree Program: BSCS/IT")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Teacher Name: Shahid Abid")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                }
                VStack{
                    Text("Course Code: CS-323")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Duration: 11:00-12:30")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    Text("Total Marks: 100")
                        .bold()
                        .padding(.all,1)
                        .frame(maxWidth: .infinity , alignment: .leading)
                }
            }
            .padding()
            .frame(width: 420)
            .foregroundColor(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 2)
            )
            Spacer()
            VStack{
                TextField("Type Question" , text: $question)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                HStack{
                    Spacer()
                    Text("Difficulty :")
                        .frame(maxWidth: .infinity , alignment: .trailing)
                        .font(.title3)
                        .foregroundColor(Color.white)
                    Picker("" , selection: $selectedone) {
                        ForEach(0..<options.count) {index in
                            Text(options[index])
                        }
                    }
                    .accentColor(Color.green)
                    Spacer()
                    Text("Topic :")
                        .frame(maxWidth: .infinity , alignment: .trailing)
                        .font(.title3)
                        .foregroundColor(Color.white)
                   
                    Picker("" , selection: $selectedone) {
                        ForEach(0..<topicoptions.count) {index in
                            Text(topicoptions[index])
                        }
                    }
                    .accentColor(Color.green)
                    Spacer()
                }
                HStack{
                    Spacer()
                    Image(systemName: "photo.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                    Spacer()
                    Text("Marks :")
                        .font(.title3)
                        .foregroundColor(Color.white)
                    TextField("Marks", text: $question)
                        .frame(width: 50, height: 40)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                    Spacer()
                    Image(systemName: "bolt.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color.green)
                    Spacer()
                }
            }
            Spacer()
            
            Button("Save"){
                savePaper()
            }
            .bold()
            .padding()
            .frame(width: 150)
            .foregroundColor(.black)
            .background(Color.green)
            .cornerRadius(8)
        }
        .background(Image("fiii").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
    }
    
    func savePaper() {
        
    }
}

struct SetPaper_Previews: PreviewProvider {
    static var previews: some View {
        StartMakingPaper()
    }
}
