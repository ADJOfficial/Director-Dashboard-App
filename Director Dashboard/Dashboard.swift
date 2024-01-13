//
//  SelectRole.swift
//  Director Dashboard
//
//  Created by ADJ on 11/01/2024.
//

import SwiftUI




struct Dashboard: View {

    @State private var animate = false
    
    var body: some View {
        NavigationView {
            ZStack{
                GeometryReader { geometry in
                    VStack{
                        Text("Director Dashboard")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)
                        Text("What's Your Role")
                            .foregroundColor(Color.white)
                            .font(.title2)
                            .bold()
                            .scaleEffect(animate ? 1 : 0)
                        //                        .position(x:geometry.size.width - 320 , y: geometry.size.width - 290)
                            .padding(.top ,50)
                            .padding(.leading ,-170)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 2)) {
                                    animate = true
                                }
                            }
                        VStack{
                            
                            NavigationLink{
                                DirectorLogin()
                            }label: {
                                Text("Director")
                                    .foregroundColor(.black)
                                    .padding()
                                    .bold()
                                    .frame(width: 150)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.all)
                                    .blur(radius: animate ? 0 : 10)
                            }
                            NavigationLink{
                                HODLogin()
                            }label: {
                                Text("HOD")
                                    .foregroundColor(.black)
                                    .padding()
                                    .bold()
                                    .frame(width: 150)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.all)
                                    .blur(radius: animate ? 0 : 10)
                            }
                            NavigationLink{
                                FacultyLogin()
                            }label: {
                                Text("Faculty")
                                    .foregroundColor(.black)
                                    .padding()
                                    .bold()
                                    .frame(width: 150)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.all)
                                    .blur(radius: animate ? 0 : 10)
                            }
                            NavigationLink{
                                DataCellLogin()
                            }label: {
                                Text("Data Cell")
                                    .foregroundColor(.black)
                                    .padding()
                                    .bold()
                                    .frame(width: 150)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.all)
                                    .blur(radius: animate ? 0 : 10)
                            }
                        }
                        .position(x:geometry.size.width - 190 , y: geometry.size.width - 180)
//                        .minimumScaleFactor(200)
                        Text("Welcome to the Director Dashboard! The Director Dashboard is a powerful tool that provides you with valuable insights and control over your organization's operations. With this dashboard, you can easily monitor key performance indicators, track project progress, and make informed decisions to drive your team's success.")
                        
                            .multilineTextAlignment(.center)
                            .fontWeight(.thin)
                        //                        .font(.title3 )
                        //                        .italic()
                            .font(.custom("HelveticaNeue-Bold", size: 20))
                            .foregroundColor(Color.gray)
                    }
                }
            }.background(Image("fa").resizable().ignoresSafeArea())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}


// Table Bar Controller
