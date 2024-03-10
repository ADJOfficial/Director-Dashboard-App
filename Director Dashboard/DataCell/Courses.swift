//
//  Courses.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct Courses: View {   // Design 100% OK
    
    @State private var isEnable = false
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""
    @State private var search = ""
    @StateObject private var facultiesViewModel = FacultiesViewModel()
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView {
            VStack {
                Text("Create Course")
                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Course Code")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("Course Code" , text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Text("Course Title")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("Course Title" , text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Text("Credit Hours")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                SecureField("Credit Hours" , text: $password)
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
                    TextField("Search Course" , text: $search)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .frame(width: 300)
                    Spacer()
                }
                VStack {
                    ScrollView{
                        ForEach(facultiesViewModel.remaining , id:\ .self) { cr in
                            HStack{
                                Text(cr.f_name)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                Text(cr.username)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .center)
                                NavigationLink{
                                    EditCourse()
                                        .navigationBarBackButtonHidden(true)
                                }label: {
                                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                        .font(.title2)
                                        .foregroundColor(Color.orange)
                                }
                                Image(systemName: "nosign")
                                    .font(.title2)
                                    .foregroundColor(isEnable ? .green : .red)
                                    .onTapGesture {
                                        isEnable.toggle()
                                    }
                            }
                            Divider()
                                .background(Color.white)
                            .padding(1)
                        }
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 410 , height:250)
                .onAppear {
                    facultiesViewModel.fetchExistingFaculties()
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

struct EditCourse: View { // Design 100% OK
    
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""

    var body: some View { // Get All Data From Node MongoDB : Pending
        VStack {
            Text("Update Course")
                .padding()
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Spacer()
            Text("Course Code")
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Course Code" , text: $name)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
            Text("Course Title")
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Course Title" , text: $username)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
            Text("Credit Hours")
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            SecureField("Credit Hours" , text: $password)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
            Spacer()
                Button("Update"){
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
        .background(Image("fw"))
    }
    func update() {
        
    }
}

struct Courses_Previews: PreviewProvider {
    static var previews: some View {
        Courses()
    }
}
