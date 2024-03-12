//
//  Faculty.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct Faculty: View {   // Design 100% OK

    @State private var f_name = ""
    @State private var username = ""
    @State private var password = ""
    @State private var searchText = ""
    @State private var searchResults: [faculties] = []
    @StateObject private var facultiesViewModel = FacultiesViewModel()

    var filteredFaculties: [faculties] { // All Data Will Be Filter and show on Table
            if searchText.isEmpty {
                return facultiesViewModel.remaining
            } else {
                return facultiesViewModel.remaining.filter { faculty in
                    faculty.f_name.localizedCaseInsensitiveContains(searchText) ||
                    faculty.username.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

    struct SearchBar: View { // Search Bar avaible outside of table to search record
        @Binding var text: String

        var body: some View {
            HStack {
                TextField("Search", text: $text)
                    .padding()
                    .frame(width: 247 , height: 40)
                    .background(Color.gray.opacity(1))
                    .cornerRadius(8) // Set the corner radius to round the corners
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .opacity(text.isEmpty ? 0 : 1)
            }
        }
    }
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView {
            VStack {
                Text("Create Faculty")
                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Text("Name")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("Name" , text: $f_name)
                    .padding()
                    .background(Color.gray.opacity(1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Text("Username")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                TextField("Username" , text: $username)
                    .padding()
                    .background(Color.gray.opacity(1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                Text("Password")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                SecureField("Password" , text: $password)
                    .padding()
                    .background(Color.gray.opacity(1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                VStack{
                    Spacer()
                    Button("Create"){
                        createFaculty()
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    Spacer()
                    SearchBar(text: $searchText)
                    Spacer()
                }

                VStack{
                    ScrollView {
                        ForEach(filteredFaculties.indices, id: \.self) { index in
                            let cr = filteredFaculties[index]
                            HStack{
                                Text(cr.f_name)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Text(cr.username)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .center)
                                
                                NavigationLink(destination: EditFaculty(faculty: cr)) {
                                    Image(systemName: "square.and.pencil.circle")
                                        .bold()
                                        .font(.title)
                                        .foregroundColor(Color.orange)
                                }
                                Image(systemName: isFacultyEnabled(index) ? "checkmark.circle.fill" : "nosign")
                                    .font(.title2)
                                    .foregroundColor(isFacultyEnabled(index) ? .green : .red)
                                    .onTapGesture {
                                        toggleFacultyStatus(index)
                                    }
                            }
                            Divider()
                                .background(Color.white)
                                .padding(1)
                        }
                        if filteredFaculties.isEmpty {
                            Text("No Data Found")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding()
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
            .background(Image("fw"))
        }
    }
//    func performSearch(_ searchText: String) {
//            guard !searchText.isEmpty else {
//                searchResults = []
//                return
//            }
//            
//            guard let url = URL(string: "http://localhost:8000/faculty/search?q=\(searchText)") else {
//                return
//            }
//
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    print("Error searching faculty: \(error.localizedDescription)")
//                } else if let data = data {
//                    do {
//                        let searchResults = try JSONDecoder().decode([faculties].self, from: data)
//                        DispatchQueue.main.async {
//                            self.searchResults = searchResults
//                        }
//                    } catch {
//                        print("Error decoding search results: \(error.localizedDescription)")
//                    }
//                }
//            }.resume()
//        }
    func isFacultyEnabled(_ index: Int) -> Bool {
        return filteredFaculties[index].status == "enable"
    }
    func toggleFacultyStatus(_ index: Int) {
        let faculty = filteredFaculties[index]
        let newStatus = faculty.status == "enable" ? "disable" : "enable"
        
        guard let url = URL(string: "http://localhost:8000/EDfaculty/\(faculty.f_id)") else {
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(["status": newStatus]) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating faculty status: \(error.localizedDescription)")
            } else if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Faculty status updated successfully: \(responseString)")
                    facultiesViewModel.fetchExistingFaculties()
                }
            }
        }.resume()
    }
    func createFaculty() {
        guard let url = URL(string: "http://localhost:8000/addfaculty") else {
            return
        }

        let user = [
            "f_name": f_name,
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
                    facultiesViewModel.fetchExistingFaculties() // Refresh faculties after creating a new one
                    DispatchQueue.main.async {
                        f_name = ""
                        username = ""
                        password = ""
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


struct EditFaculty: View { // Design 100% OK
    var faculty: faculties
    @State private var f_name = ""
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
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Name" , text: $f_name)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
                .onAppear {
                    f_name = faculty.f_name
                }
            Text("Username")
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Username" , text: $username)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
                .onAppear {
                    username = faculty.username
                }
            Text("Password")
                .bold()
                .padding(.horizontal)
                .font(.title2)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity , alignment: .leading)
            TextField("Password" , text: $password)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
                .onAppear {
                    password = faculty.password
                }
            Spacer()
            Button("Update"){
                updateFaculty()
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
    func updateFaculty() {
        guard let url = URL(string: "http://localhost:8000/faculty/\(faculty.f_id)") else {
            return
        }

        let updatedFaculty = faculties(f_id: faculty.f_id, f_name: f_name, username: username , password: password ,status: faculty.status)

        guard let encodedData = try? JSONEncoder().encode(updatedFaculty) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error while updating faculty: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let response = try? JSONDecoder().decode(faculties.self, from: data) {
                print("Faculty updated successfully: \(response)")

                // Perform any necessary UI updates or navigation after successful update
            } else {
                print("Error while decoding updated faculty data")
            }
        }
        task.resume()
    }
}
struct Faculty_Previews: PreviewProvider {
    static var previews: some View {
        Faculty()
    }
}
