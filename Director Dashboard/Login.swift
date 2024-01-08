//
//  ContentView.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct Login: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var loginStatus = ""
    @State private var isLoggedIn = false
    var body: some View {
        NavigationView{
            VStack{
                Text("iOS Fam")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                TextField("Enter Username" , text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal)
                SecureField("Enter Password" , text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Spacer()
                Button("Login"){
                    login()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.all)
                
                NavigationLink(destination: Welcome() , isActive: $isLoggedIn){
                    EmptyView()
                }
                
                Text(loginStatus)
                    .padding()
                    .foregroundColor(Color.red)
                
                NavigationLink {
                    SignUp()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            .background(Color.yellow)
        }
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
                    isLoggedIn = responseString == "Login successful" // Update isLoggedIn based on the Response
                    print("Login successful")
                }
            }
            else{
                print("Invalid Credentials")
            }
        }.resume()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
