//
//  DirectorLogin.swift
//  Director Dashboard
//
//  Created by ADJ on 11/01/2024.
//

import SwiftUI

struct DirectorLogin: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showAlert = false
    @State private var showPassword: Bool = false

    var body: some View {
        VStack{
            Text("Director")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.white)
            Spacer()
            VStack(alignment: .leading){
                Text("Username")
                    .bold()
                    .font(.title3)
                    .padding(.leading)
                    .foregroundColor(Color.white)
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(1))
                    .cornerRadius(8)
                    .padding(.horizontal)

                Text("Password")
                    .bold()
                    .font(.title3)
                    .padding(.leading)
                    .foregroundColor(Color.white)
                VStack {
                    if showPassword {
                        TextField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    } else {
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(1))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .padding()
                            .font(.title3)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                            .foregroundColor(.gray)
                    }
                }
            }
            Spacer()
            Button("Login"){
                login()
            }
            .foregroundColor(Color.black)
            .padding()
            .frame(width: 150, height: 60)
            .background(Color.brown.opacity(0.7))
            .cornerRadius(8)
            
//            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid credentials"), message: Text("Please enter valid username and password"), dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(isPresented: $isLoggedIn){
           DirectorWelcome(username: username)
        }
        .background(Image("ft").resizable().ignoresSafeArea())
    }

    func login() {
        let url = URL(string: "http://localhost:8000/LoginAllMembers")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let message = responseJSON["message"] as? String {
                // Login successful
                isLoggedIn = true
                print(message)
            } else {
                // Invalid credentials
                showAlert = true
            }
        }.resume()
    }
}

struct DirectorLogin_Previews: PreviewProvider {
    static var previews: some View {
        DirectorLogin()
    }
}
