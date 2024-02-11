//
//  Faculty.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct Faculty: View {   // Design 100% OK
    
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""
    @State private var search = ""
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView {
            VStack {
                Text("Create Faculty")
                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Name")
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("Name" , text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Text("Username")
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("Username" , text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Text("Password")
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                SecureField("Password" , text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                VStack{
                    Spacer()
                    Button("Create"){
                        saveUser()
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    Spacer()
                    TextField("Search Teacher" , text: $search)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 300)
                    Spacer()
                }
                VStack {
                    HStack {
                        Text("Name")
                            .bold()
                            .font(.title2)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("Username")
                            .bold()
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity , alignment: .leading)
                        Text("")
                            .font(.headline)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                    }
                    .padding(1)
                    ScrollView{
                        ForEach(userViewModel.existing , id:\ .self) { cr in
                            HStack{
                                Text(cr.name)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Text(cr.username)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .trailing)
                                NavigationLink{
                                    EditFaculty()
                                        .navigationBarBackButtonHidden(true)
                                }label: {
                                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                        .font(.title2)
                                        .foregroundColor(Color.green)
                                        .frame(maxWidth: .infinity , alignment: .trailing)
                                }
                                Image(systemName: "delete.right.fill")
                                    .font(.title3)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.red)
                            }
                            .padding(1)
                        }
                    }
                }
//                .background(Color.gray)
                .onAppear {
                    userViewModel.fetchExistingUser()
                }
                Spacer()
            }
            .background(Image("fac"))
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


struct EditFaculty: View { // Design 100% OK
    
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""

    var body: some View { // Get All Data From Node MongoDB : Pending
        VStack {
            Text("Update Faculty")
                .padding()
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            Text("Name")
                .padding(.horizontal)
                .font(.headline)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Name" , text: $name)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
            Text("Username")
                .padding(.horizontal)
                .font(.headline)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Username" , text: $username)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
            Text("Password")
                .padding(.horizontal)
                .font(.headline)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            SecureField("Password" , text: $password)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
            Spacer()
                Button("Create"){
                    update()
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.yellow)
                .cornerRadius(8)
                .padding(.all)
        }
        .background(Image("fac"))
    }
    func update() {
        
    }
}
struct Faculty_Previews: PreviewProvider {
    static var previews: some View {
        Faculty()
    }
}
