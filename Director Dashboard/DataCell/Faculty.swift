//
//  Faculty.swift
//  Director Dashboard
//
//  Created by ADJ on 08/01/2024.
//

import SwiftUI

struct Faculty: View {
    
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name")
                .padding()
            TextField("Name" , text: $name)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            Text("Username")
                .padding()
            TextField("Username" , text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            Text("Password")
                .padding()
            SecureField("Password" , text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Button("Create"){
                saveUser()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .padding()
            
            ScrollView{
                VStack {
                    HStack {
                        Text("Name")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                        Divider()
                        Text("Username")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                        Divider()
                        Text("Edit")
                            .font(.headline)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                    }
                    .padding()
                    
                    ForEach(userViewModel.existing , id:\ .self) { cr in
                        HStack{
                            Text(cr.name)
                                .padding(.horizontal)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            
                            Divider()
                            Text(cr.username)
                                .padding(.horizontal)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            
                            Divider()
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .padding(.horizontal)
                                .font(.title3)
                                .foregroundColor(Color.green)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .padding(1)
                    }
                }
            }
            .background(Color.gray.opacity(0.3)) // Add a background color for better visibility
            .cornerRadius(8)
            .frame(width: 360, height: 150)
            .padding()
            .onAppear {
                userViewModel.fetchExistingUser()
            }
        }
    }
    func saveUser() {
        guard let url = URL(string: "http://localhost:1000/addFaculties") else {
            return
        }

        let user = [
            "name": name,
            "username": username,
            "password": password
        ] as [String : Any]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: user) else {
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
                    print("Result from server:", result)
                } catch {
                    print("Error parsing JSON:", error)
                }
            } else if let error = error {
                print("Error making request:", error)
            }
        }.resume()
    }
}

struct Faculty_Previews: PreviewProvider {
    static var previews: some View {
        Faculty()
    }
}
