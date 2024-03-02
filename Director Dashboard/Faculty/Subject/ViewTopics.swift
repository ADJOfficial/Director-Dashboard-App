//
//  ViewTopics.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct ViewTopics: View { // Design 100% Ok
    
    @State private var course = ""
    @State private var addTopic = ""
    @State private var Topic = ""
    @State private var clos = ""
    @State private var searchTopic = ""
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView{
            VStack{
                Text("Add Topics")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Course")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Text("Programming Fundamental")
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity , alignment: .center)
                    .foregroundColor(Color.white)
                .accentColor(.green)
                .pickerStyle(.menu)
                Text("Topic")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("Username" , text: $Topic)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Spacer()
                VStack{
                    Text("CLOs")
                        .bold()
                        .padding()
//                        .padding(.horizontal)
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .center)
                    HStack {
                        Text("CLO:1")
                        Image(systemName: "square")
                        Text("CLO:2")
                        Image(systemName: "checkmark.square")
                            .foregroundColor(.green)
                        
                        Spacer()
                        
                        Text("CLO:3")
                        Image(systemName: "square")
                        Text("CLO:4")
                        Image(systemName: "checkmark.square")
                            .foregroundColor(.green)
                    }
                    TextField("Search Teacher" , text: $searchTopic)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 300)
                }
                .padding(.horizontal)
                .font(.headline)
                .foregroundColor(Color.white)
                VStack {
                    ScrollView{
                        ForEach(userViewModel.existing , id:\ .self) { cr in
                            HStack{
                                Text(cr.name)
                                    .font(.headline)
//                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                NavigationLink{
                                    EditSubTopics()
                                        .navigationBarBackButtonHidden(true)
                                }label: {
                                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                        .font(.title2)
                                        .foregroundColor(Color.green)
                                        .frame(maxWidth: .infinity , alignment: .trailing)
                                }
                                    Image(systemName: "trash.fill")
                                        .font(.title3)
//                                        .padding(.horizontal)
                                        .foregroundColor(Color.red)
                                NavigationLink{
                                    AddSubTopics()
                                }label: {
                                    Image(systemName: "plus.rectangle.fill.on.rectangle.fill")
                                        .font(.title3)
                                        .foregroundColor(Color.orange)
                                }
                            }
                            Divider()
                                .background(Color.white)
                            .padding(1)
                        }
                    }
                    .padding()
                }
                .border(.gray , width: 2)
                .cornerRadius(5)
                .frame(width: 410 , height:150)
                .onAppear {
                    userViewModel.fetchExistingUser()
                }
                Button("Create"){
                    saveTopic()
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.green)
                .cornerRadius(8)
                .padding(.all)
            }
            .background(Image("fa").resizable().ignoresSafeArea())
        }
    }
    func saveTopic() {
        
    }
}
        

struct EditTopics: View { // Design 100% Ok
    
    @State private var editTopic = ""
    @StateObject var userViewModel = UserViewModel()
    
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        VStack{
            Text("Edit Topic")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)

            VStack{
                Spacer()
                Text("Course")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Programming Fundamental")
                    .padding()
                    .frame(maxWidth: .infinity , alignment: .center)
                    .font(.title3)
                    .foregroundColor(Color.white)
                Text("Topic")
                    .bold()
                    .padding()
                    .font(.title2)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)
                TextField("Edit Topic Name" , text:$editTopic)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .frame(width: 400)
                Text("CLOs")
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                HStack {
                    Spacer()
                    Text("CLO:1")
                    Image(systemName: "square")
                    Text("CLO:2")
                    Image(systemName: "checkmark.square")
                        .foregroundColor(.green)
                    Text("CLO:3")
                    Image(systemName: "square")
                    Text("CLO:4")
                    Image(systemName: "checkmark.square")
                        .foregroundColor(.green)
                    Spacer()
                }
                .padding()
                .font(.title3)
                .foregroundColor(.white)
                Spacer()
            }
            Button("Update"){
                updateTopic()
            }
            .bold()
            .padding()
            .frame(width: 150)
            .foregroundColor(.black)
            .background(Color.green)
            .cornerRadius(8)
            .padding(.all)
            Spacer()
        }
        .background(Image("fa").resizable().ignoresSafeArea())
    }
    func updateTopic() {
        
    }
}

struct AddSubTopics: View { // Design 100% Ok
    
    @State private var Topic = ""
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        VStack{
            Text("Add Sub Topics")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            Text("Course")
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            Text("Programming Fundamental")
                .padding()
                .frame(maxWidth: .infinity , alignment: .center)
                .font(.title3)
                .foregroundColor(Color.white)
            Text("Topic")
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Username" , text: $Topic)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
            VStack{
                Text("Sub Topic")
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("SubTopic Name" , text: $Topic)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            Spacer()
            
            VStack {
                ScrollView{
                    ForEach(userViewModel.existing , id:\ .self) { cr in
                        HStack{
                            Text(cr.name)
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity , alignment: .leading)
                            NavigationLink{
                                EditSubTopics()
                                    .navigationBarBackButtonHidden(true)
                            }label: {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                    .font(.title2)
                                    .foregroundColor(Color.green)
                                    .frame(maxWidth: .infinity , alignment: .trailing)
                            }
                            Image(systemName: "trash.fill")
                                .font(.title3)
                                .foregroundColor(Color.red)
                        }
                        Divider()
                            .background(Color.white)
                    }
                }
                .padding()
            }
            .border(Color.gray ,width: 3)
            .cornerRadius(5)
            .frame(height:200)
            .onAppear {
                userViewModel.fetchExistingUser()
            }
            Button("Create"){
                saveSubTopic()
            }
            .bold()
            .padding()
            .frame(width: 150)
            .foregroundColor(.black)
            .background(Color.green)
            .cornerRadius(8)
            .padding(.all)
        }
        .background(Image("fa").resizable().ignoresSafeArea())
    }
    
    func saveSubTopic() {
        
    }
}
struct EditSubTopics: View { // Design 100% Ok
    
    @State private var course = ""
    @State private var Topic = ""
    @State private var clos = ""
    @State private var searchTopic = ""
    @StateObject var userViewModel = UserViewModel()
    
    
    var body: some View { // Get All Data From Node MongoDB : Pending
       
        NavigationView{
            VStack{
                Text("Edit Sub Topic")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                            Spacer()
                VStack{
                    Text("Course")
                        .bold()
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .font(.title2)
                        .foregroundColor(Color.white)
                    Text("Programming Fundamental")
                        .padding()
                        .frame(maxWidth: .infinity , alignment: .center)
                        .font(.title3)
                        .foregroundColor(Color.white)
                    //                Spacer()
                    Text("Topic")
                        .bold()
                        .padding()
                        .font(.title2)
                        .frame(maxWidth: .infinity , alignment: .leading)
                        .foregroundColor(Color.white)
                    Text("Basic Structure of Programming")
//                        .bold()
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity , alignment: .center)
                        .font(.title3)
                        .foregroundColor(Color.white)
//                    Spacer()
                    
                    Text("Sub Topic")
                        .bold()
                        .padding()
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    TextField("SubTopic Name" , text: $course)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                Spacer()
                Button("Update"){
                    updateTopic()
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.green)
                .cornerRadius(8)
                .padding(.all)
            }
            .background(Image("fa").resizable().ignoresSafeArea())
        }
    }
    func updateTopic() {
        
    }
}

struct ViewTopics_Previews: PreviewProvider {
    static var previews: some View {
        ViewTopics()
    }
}
