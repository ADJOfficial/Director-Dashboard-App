//
//  SignUp.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct SignUp: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var phone = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            Text("iOS Fam")
                .font(.largeTitle)
                .bold()

            Spacer()

            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("Email Address", text: $email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("First Name", text: $name)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .padding(.horizontal)

            TextField("Phone", text: $phone)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .padding(.horizontal)

            Spacer()

            Button("Create Account") {
                create()
            }
            .padding()
            NavigationLink {
                Login()
                    .navigationBarBackButtonHidden(true)
            } label: {
                HStack{

                    Text("Back to Login?")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
        .padding()
        .background(Color.yellow)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Account Created"),
                message: Text("Your account has been created successfully."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func create() {
        guard let url = URL(string: "http://localhost:1000/createFam") else {
            return
        }

        let fam = [
            "username": username,
            "email": email,
            "password": password,
            "name": name,
            "phone": phone
        ] as [String : Any]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: fam) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data)
                    print("Result from server:", response)
                    let res = response as! HTTPURLResponse
                    res.statusCode
                    DispatchQueue.main.async {
                        if let success = result as? Bool, success {
                            self.showAlert = true
                        }
                    }
                } catch {
                    print("Error parsing JSON:", error)
                }
            } else if let error = error {
                print("Error making request:", error)
            }
        }.resume()
    }
}



struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
