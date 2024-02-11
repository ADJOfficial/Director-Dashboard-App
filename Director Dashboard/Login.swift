//
//  ContentView.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var loginMessage = ""
    @State private var isLoggedIn = false
    @State private var name = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                TextField("Username", text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                NavigationLink(destination: WelcomeView(name: $name), isActive: $isLoggedIn) {
                    EmptyView()
                }

                Button(action: {
                    loginUser()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                Text(loginMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            .padding()
            .navigationTitle("Login")
        }
    }

    func loginUser() {
        guard let url = URL(string: "http://localhost:1000/fams") else { return }

        let body: [String: String] = ["username": username, "password": password]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    loginMessage = "Error: \(error?.localizedDescription ?? "Unknown error")"
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode(String.self, from: data) {
                    DispatchQueue.main.async {
                        loginMessage = decodedResponse
                        if decodedResponse.hasPrefix("Login successful") {
                            isLoggedIn = true
                            name = String(decodedResponse.split(separator: ",").last ?? "")
                        }
                    }
                } else {
                    loginMessage = "Invalid response from server"
                }
            }.resume()
        } catch {
            loginMessage = "Error: \(error.localizedDescription)"
        }
    }
}
import SwiftUI

struct WelcomeView: View {
    @Binding var name: String

    var body: some View {
        VStack {
            Text("Welcome, \(name)")
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle("Welcome")
    }
}


//struct Login: View {
//
//    @State private var username = ""
//    @State private var password = ""
//    @State private var loginStatus = ""
//    @State private var isLoggedIn = false
//    var body: some View {
//        NavigationView{
//            VStack{
//                Text("iOS Fam")
//                    .font(.largeTitle)
//                    .bold()
//                Spacer()
//                TextField("Enter Username" , text: $username)
//                    .padding()
//                    .background(Color.gray.opacity(0.3))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//                SecureField("Enter Password" , text: $password)
//                    .padding()
//                    .background(Color.gray.opacity(0.3))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//                Spacer()
//                Button("Login"){
//                    login()
//                }
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .cornerRadius(8)
//                .padding(.all)
//
//                NavigationLink(destination: Faculty() , isActive: $isLoggedIn){
//                    EmptyView()
//                }
//
//                Text(loginStatus)
//                    .padding()
//                    .foregroundColor(Color.red)
//
//                NavigationLink {
//                    SignUp()
//                        .navigationBarBackButtonHidden(true)
//                } label: {
//                    HStack{
//                        Text("Don't have an account?")
//                        Text("Sign Up")
//                            .fontWeight(.bold)
//                    }
//                    .font(.system(size: 14))
//                }
//            }
//            .background(Color.yellow)
//        }
//    }
//
//    func login() {
//        guard let url = URL(string: "http://localhost:1000/fams") else {
//            return
//        }
//
//        let user = ["username": username, "password": password]
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "Unknown error")
//                return
//            }
//
//            if let responseString = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
//                    loginStatus = responseString
//                    isLoggedIn = responseString == "Login successful" // Update isLoggedIn based on the Response
//                    print("Login successful")
//                }
//            }
//            else{
//                print("Invalid Credentials")
//            }
//        }.resume()
//    }
//}


//enum UserRole {
//    case director
//    case hod
//    case faculty
//    case datacell
//
//}
//
//struct ContentView: View {
//    @State private var isLoggedIn = false
//    @State private var userRole: UserRole?
//
//    var body: some View {
//        NavigationView {
//            if isLoggedIn {
//                switch userRole {
//                case .director:
//                    DirectorWelcome()
//                case .hod:
//                    HODWelcome()
//                case .faculty:
//                    FacultyWelcome()
//                case .datacell:
//                    DataCellWelcome()
//                default:
//                    Text("Invalid User Role")
//                }
//            } else {
//                Login(isLoggedIn: $isLoggedIn, userRole: $userRole)
//            }
//        }
//    }
//}
//
//struct Login: View {
//
//    @State private var username = ""
//    @State private var password = ""
//    @Binding var isLoggedIn: Bool
//    @Binding var userRole: UserRole?
//    var body: some View {
//        NavigationView{
//            VStack{
//                Text("Director Dashboard")
//                    .font(.largeTitle)
//                    .bold()
//                    .padding(.top,-0.5)
//                Spacer()
//                TextField("Enter Username" , text: $username)
//                    .padding()
//                    .background(Color.gray.opacity(0.3))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//                SecureField("Enter Password" , text: $password)
//                    .padding()
//                    .background(Color.gray.opacity(0.3))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//                Spacer()
//                Button("Login"){
//                    login()
//                }
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .cornerRadius(8)
//                .padding(.all)
//
//                NavigationLink {
//                    SignUp()
//                        .navigationBarBackButtonHidden(true)
//                } label: {
//                    HStack{
//                        Text("Don't have an account?")
//                        Text("Sign Up")
//                            .fontWeight(.bold)
//                    }
//                    .font(.system(size: 14))
//                }
//            }
//        }
//    }
//
//    func login() {
//        guard let url = URL(string: "http://localhost:1000/fams") else {
//            return
//        }
//
//        let user = ["username": username, "password": password]
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "Unknown error")
//                return
//            }
//
//            if let responseString = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
//                    if username == "D" && password == "" {
//                        isLoggedIn = true
//                        userRole = .director
//                    }
//                    else if username == "H" && password == "" {
//                        isLoggedIn = true
//                        userRole = .hod
//                    }
//                    else if username == "F" && password == "" {
//                        isLoggedIn = true
//                        userRole = .faculty
//                    }  else if username == "Da" && password == "" {
//                        isLoggedIn = true
//                        userRole = .datacell
//                    } else {
//                        isLoggedIn = false
//                        userRole = nil
//                    }
//                    print("Login Successful")
//                }
//            }
//            else{
//                print("Invalid Credentials")
//            }
//        }.resume()
//    }
//}
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
