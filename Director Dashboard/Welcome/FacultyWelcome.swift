//
//  FacultyWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct FacultyWelcome: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Welcome Mr ... ")
                    .bold()
                    .font(.title)
                    .position(x:120,y:100)
                    .foregroundColor(Color.white)
                VStack{
                    NavigationLink {
                        ViewYourCourses()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Courses")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink {
                        CLOs()
                    } label: {
                        Text("CLOs")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink {
                        Topic()
                    } label: {
                        Text("Topics")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.all)
                }
                .position(x:195,y: 10)
            }
            .background(Image("fa"))
        }
    }
}

struct CLOs: View {
    var body: some View {
        VStack{
            Text("CLOs")
                .foregroundColor(Color.white)
        }
        .background(Image("fa"))
    }
}


struct Topic: View {
    var body: some View {
        VStack{
            Text("Topics")
                .foregroundColor(Color.white)
        }
        .background(Image("fa"))
    }
}


struct ViewYourCourses: View {
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Faculty")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Welcome ")
                    .position(x:80,y:100)
                    .bold()
                    .font(.title)
                    .foregroundColor(Color.white)
                NavigationLink {
                    Mail()
                } label: {
                    Image(systemName: "mail.fill")
                        .foregroundColor(.blue)
                }
                .font(.largeTitle)
                .position(x:350,y:-130)
                Text("Subjects")
                    .position(x:60,y:-90)
                    .bold()
                    .foregroundColor(Color.white)
                HStack{
                    Spacer()
                    NavigationLink {
                        PF()
                            .navigationBarBackButtonHidden(false)
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
                        Web()
                            .navigationBarBackButtonHidden(false)
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
                .position(x: 195,y: -150)
                
                HStack{
                    
                    Spacer()
                    
                    NavigationLink {
                        SE()
                            .navigationBarBackButtonHidden(false)
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
                        OR()
                            .navigationBarBackButtonHidden(false)
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
                .position(x: 195,y: -180)
                
                Spacer()
            }
            .background(Image("fa"))
        }
    }
}



struct PF: View {
    var body: some View {
        VStack {
            Text("Subject : Programming Fundamental")
                .foregroundColor(Color.white)
        }
        .background(Image("fa"))
    }
}
struct Web: View {
    var body: some View {
        VStack {
            Text("Subject : Web Technology")
                .foregroundColor(Color.white)
        }
        .background(Image("fa"))
    }
}
struct SE: View {
    var body: some View {
        VStack {
            Text("Subject : Software English")
                .foregroundColor(Color.white)
        }
        .background(Image("fa"))
    }
}
struct OR: View {
    var body: some View {
        VStack {
            Text("Subject : Operation Research")
                .foregroundColor(Color.white)
        }
        .background(Image("fa"))
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
        ScrollView {
            Text("Notifications")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            VStack {
                ForEach(viewModel.notif, id: \.self) { no in
                    VStack(alignment: .leading) {
                        Text(no.subject)
                            .foregroundColor(Color.white)
                            .bold()
                        Text(no.Comment)
                            .foregroundColor(Color.white)
                    }
                    .padding(20)
                    
                }
            }
        }
        .background(
            Image("fa")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            viewModel.fetchApiData()
        }
    }
}
struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        FacultyWelcome()
    }
}
