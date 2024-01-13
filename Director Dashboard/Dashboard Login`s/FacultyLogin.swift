//
//  FacultyLogin.swift
//  Director Dashboard
//
//  Created by ADJ on 11/01/2024.
//

import SwiftUI

struct FacultyLogin: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var loginStatus = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack{
            Text("Faculty")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.white)
            Spacer()
            Text("Welcome")
                .font(.title2)
                .bold()
                .foregroundColor(Color.white)
                .padding(.leading,-170)
            Spacer()
            VStack(alignment: .leading){
                Text("Username")
                    .bold()
                    .font(.title3)
                    .padding(.leading)
                    .foregroundColor(Color.white)
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Text("Password")
                    .bold()
                    .font(.title3)
                    .padding(.leading)
                    .foregroundColor(Color.white)
                TextField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom,220)
            }
            Button("Login"){
                login()
            }
            .foregroundColor(Color.black)
            .padding()
            .frame(width: 150, height: 60)
            .background(Color.green)
            .cornerRadius(8)
        }
        .fullScreenCover(isPresented: $isLoggedIn){
            FacultyWelcome()
        }
        .background(Image("fa"))
    }
    
    func login() {
        guard let url = URL(string: "http://localhost:1000/fams") else {
            return
        }

        let user = ["username": username, "password": password]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    loginStatus = responseString
                    isLoggedIn = true // Update isLoggedIn based on the Response
                    print("Login successful")
                }
            }
            else{
                print("Invalid Credentials")
            }
        }.resume()
    }
}

struct FacultyLogin_Previews: PreviewProvider {
    static var previews: some View {
        FacultyLogin()
    }
}
