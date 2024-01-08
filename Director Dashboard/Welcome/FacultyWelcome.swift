//
//  FacultyWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Faculty")
                    .font(.largeTitle)
                    .bold()
                Text("Welcome Mr ... ")
                    .font(.title)
                    .bold()
                    .position(x:120,y:100)
                VStack{
                    NavigationLink {
                        ViewYourCourses()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Courses")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink {
                        CLOs()
                    } label: {
                        Text("CLOs")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink {
                        Topic()
                    } label: {
                        Text("Topics")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                }
                .position(x:195,y: 10)
            }
            .background(Color.yellow)
        }
    }
}

struct CLOs: View {
    var body: some View {
        Text("CLOs")
    }
}


struct Topic: View {
    var body: some View {
        Text("Topics")
    }
}


struct ViewYourCourses: View {
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Faculty Dashboard")
                    .font(.largeTitle)
                    .bold()
                Text("Welcome ")
                    .position(x:80,y:100)
                    .bold()
                    .font(.title)
                NavigationLink {
                    Mail()
                } label: {
                    Image(systemName: "mail.fill")
                        .foregroundColor(.black)
                }
                .font(.largeTitle)
                .position(x:350,y:-130)
                Text("Subjects")
                    .position(x:60,y:-90)
                    .bold()
                
                
                HStack{
                    
                    Spacer()
                    
                    NavigationLink {
                        PF()
                            .navigationBarBackButtonHidden(false)
                    } label: {
                        Text("Programming Fundamental")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    Spacer()
                    
                    NavigationLink {
                        Web()
                            .navigationBarBackButtonHidden(false)
                    } label: {
                        Text("Web Technology")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    Spacer()
                }
                .position(x: 195,y: -150)
                
                HStack{
                    
                    Spacer()
                    
                    NavigationLink {
                        SE()
                            .navigationBarBackButtonHidden(false)
                    } label: {
                        Text("Software Engennring")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    Spacer()
                    
                    NavigationLink {
                        OR()
                            .navigationBarBackButtonHidden(false)
                    } label: {
                        Text("Operation Research")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    Spacer()
                }
                .position(x: 195,y: -180)
                
                Spacer()
            }.background(Color.yellow)
        }
    }
}



struct PF: View {
    var body: some View {
        Text("Subject : Programming Fundamental")
    }
}
struct Web: View {
    var body: some View {
        Text("Subject : Web Technology")
    }
}
struct SE: View {
    var body: some View {
        Text("Subject : Software English")
    }
}
struct OR: View {
    var body: some View {
        Text("Subject : Operation Research")
    }
}
 // To Get Notification on New Screen
struct Notification: Hashable , Codable {
    var subject: String
    var Comment: String
}

struct Mail: View {
    @StateObject var viewModel = ViewModel()
    @State private var isFetchingData = false
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.notif , id:\ .self) { no in
                    VStack(alignment: .leading){
                        Text(no.subject)
                            .bold()
                        Text(no.Comment)
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle("Notification")
        .onAppear {
            viewModel.fetchApiData()
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
