//
//  ViewYourCourses.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct ViewYourCourses: View { // Design 100% OK
    
    
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView {
            VStack{
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
//                Text("Welcome ")
//                    .bold()
//                    .font(.title)
//                    .foregroundColor(Color.white)
                NavigationLink {
                    Mail()
                } label: {
                    Image(systemName: "mail.fill")
                        .foregroundColor(.blue)
                }
                .padding()
                .font(.largeTitle)
                .frame(maxWidth: .infinity , alignment: .trailing)
                .padding(.horizontal)
                Spacer()
                Text("Subjects ")
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                VStack{
                    HStack{
                        Spacer()
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Programming Fundamental")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                        
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Web Technology")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                    }
                    HStack{
                        
                        Spacer()
                        
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Software Engennring")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                        
                        NavigationLink {
                            Subject()
//                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Operation Research")
                        }
                        .foregroundColor(.black)
                        .padding()
                        .bold()
                        .frame(width: 150)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.all)
                        
                        Spacer()
                    }
                }
                Spacer()
            }
            .background(Image("fa").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea())
        }
    }
}

struct Notification: Hashable , Codable { // Design 100% OK
    var subject: String
    var Comment: String
}

struct Mail: View { // Get All Data From Node MongoDB : Done
    
    @StateObject var viewModel = ViewModel()
    @State private var isFetchingData = false
    
    var body: some View {
        VStack{
            Text("Notifications")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            ScrollView {
                VStack {
                    ForEach(viewModel.notif, id: \.self) { no in
                        VStack{
                            Text(no.subject)
                                .bold()
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.horizontal)
                            Text(no.Comment)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.horizontal)
                                .frame(height: 20)
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                viewModel.fetchApiData()
            }
        }
        .background(Image("fa").resizable().ignoresSafeArea())
    }
}

struct Subject: View {
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Subject")
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
                Spacer()
                VStack{
                    NavigationLink{
                        CoveredTopics()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("View Topics")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                    
                    NavigationLink{
                        ViewCLOs()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("View CLOs")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                    
                    NavigationLink{
                        SetPaper()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Set Paper")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                    
                    NavigationLink{
                        PaperStatus()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Paper Status")
                            .underline()
                    }
                    .bold()
                    .padding()
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.all)
                }
                Spacer()
            }
            .background(Image("fa").resizable().ignoresSafeArea())
        }
    }
}

struct ViewYourCourses_Previews: PreviewProvider {
    static var previews: some View {
        Subject()
    }
}
