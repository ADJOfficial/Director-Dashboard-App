import SwiftUI
////
////  updatecheck.swift
////  Director Dashboard
////
////  Created by ADJ on 07/03/2024.
////
//
//import SwiftUI
//
//import SwiftUI
//
//struct editFaculty: Codable {
//    let id: Int
//    let fName: String
//    let username: String
//    let password: String
//}
//
//struct UpdateFacultyView: View {
//    @State private var facultyId: Int?
//    @State private var fName = ""
//    @State private var username = ""
//    @State private var password = ""
//    @State private var errorMessage = ""
//
//    var body: some View {
//        VStack {
//            if let facultyId = facultyId {
//                Text("Faculty ID: \(facultyId)")
//                    .font(.headline)
//                    .padding()
//            }
//
//            TextField("First Name", text: $fName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            TextField("Username", text: $username)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            SecureField("Password", text: $password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Text(errorMessage)
//                .foregroundColor(.red)
//                .padding()
//
//            Button(action: updateFaculty) {
//                Text("Update Faculty")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//        .onAppear {
//            // Simulate fetching faculty record from API
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                let faculty = editFaculty(id: 123, fName: "John", username: "john123", password: "password")
//                facultyId = faculty.id
//                fName = faculty.fName
//                username = faculty.username
//                password = faculty.password
//            }
//        }
//    }
//
//    func updateFaculty() {
//        guard let facultyId = facultyId else {
//            errorMessage = "Invalid faculty ID"
//            return
//        }
//
//        let faculty = editFaculty(id: facultyId, fName: fName, username: username, password: password)
//
//        guard let jsonData = try? JSONEncoder().encode(faculty) else {
//            errorMessage = "Error encoding faculty data"
//            return
//        }
//
//        guard let url = URL(string: "http://your-api-url/faculty/\(facultyId)") else {
//            errorMessage = "Invalid URL"
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.httpBody = jsonData
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, let response = response as? HTTPURLResponse else {
//                errorMessage = "Error updating faculty"
//                return
//            }
//
//            if response.statusCode == 200 {
//                errorMessage = "Faculty record updated successfully"
//            } else if response.statusCode == 404 {
//                errorMessage = "Faculty record not found"
//            } else {
//                errorMessage = "Error updating faculty"
//            }
//        }.resume()
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        UpdateFacultyView()
//    }
//}
//
//struct Conten_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}








// Orignal One .....


//
//  Faculty.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

//import SwiftUI
//
//struct Faculty: View {   // Design 100% OK
//    
//    @State private var isEnable = false
//    @State private var f_name = ""
//    @State private var username = ""
//    @State private var password = ""
//    @State private var search = ""
//    @StateObject var facultiesViewModel = FacultiesViewModel()
//    
//    var body: some View { // Get All Data From Node MongoDB : Pending
//        NavigationView {
//            VStack {
//                Text("Create Faculty")
//                    .padding()
//                    .bold()
//                    .font(.largeTitle)
//                    .foregroundColor(Color.white)
//                Text("Name")
//                    .bold()
//                    .padding(.horizontal)
//                    .font(.title2)
//                    .foregroundColor(Color.white)
//                    .frame(maxWidth: .infinity , alignment: .leading)
//                TextField("Name" , text: $f_name)
//                    .padding()
//                    .background(Color.gray.opacity(0.8))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//                Text("Username")
//                    .bold()
//                    .padding(.horizontal)
//                    .font(.title2)
//                    .foregroundColor(Color.white)
//                    .frame(maxWidth: .infinity , alignment: .leading)
//                TextField("Username" , text: $username)
//                    .padding()
//                    .background(Color.gray.opacity(0.8))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//                Text("Password")
//                    .bold()
//                    .padding(.horizontal)
//                    .font(.title2)
//                    .foregroundColor(Color.white)
//                    .frame(maxWidth: .infinity , alignment: .leading)
//                SecureField("Password" , text: $password)
//                    .padding()
//                    .background(Color.gray.opacity(0.8))
//                    .cornerRadius(8)
//                    .padding(.horizontal)
//                VStack{
//                    Spacer()
//                    Button("Create"){
//                        createFaculty()
//                    }
//                    .bold()
//                    .padding()
//                    .frame(width: 150)
//                    .foregroundColor(.black)
//                    .background(Color.yellow)
//                    .cornerRadius(8)
//                    Spacer()
//                    TextField("Search Teacher" , text: $search)
//                        .padding()
//                        .background(Color.gray.opacity(0.8))
//                        .cornerRadius(8)
//                        .frame(width: 300)
//                    Spacer()
//                }
//                VStack {
//                    ScrollView{
//                        ForEach(facultiesViewModel.remaining , id:\ .self) { cr in
//                            HStack{
//                                Text(cr.f_name)
//                                    .font(.headline)
//                                    .padding(.horizontal)
//                                    .foregroundColor(Color.white)
//                                Text(cr.username)
//                                    .font(.headline)
//                                    .padding(.horizontal)
//                                    .foregroundColor(Color.white)
//                                    .frame(maxWidth: .infinity , alignment: .center)
//                                NavigationLink{
//                                    EditFaculty()
//                                        .navigationBarBackButtonHidden(true)
//                                }label: {
//                                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
//                                        .font(.title2)
//                                        .foregroundColor(Color.orange)
//                                }
//                                Image(systemName: "nosign")
//                                    .font(.title2)
//                                    .foregroundColor(isEnable ? .green : .red)
//                                    .onTapGesture {
//                                        isEnable.toggle()
//                                    }
//                            }
//                            Divider()
//                                .background(Color.white)
//                            .padding(1)
//                        }
//                    }
//                    .padding()
//                }
//                .background(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.gray, lineWidth: 2)
//                )
//                .frame(width: 410 , height:250)
//                .onAppear {
//                    facultiesViewModel.fetchExistingFaculties()
//                }
//                Spacer()
//            }
//            .background(Image("fw"))
//        }
//    }
//    func createFaculty() {
//        guard let url = URL(string: "http://localhost:8000/addfaculty") else {
//            return
//        }
//
//        let user = [
//            "f_name": f_name,
//            "username": username,
//            "password": password
//        ] as [String : Any]
//
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: user) else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let result = try JSONSerialization.jsonObject(with: data)
//                    print("Result from server:", result)
//                } catch {
//                    print("Error parsing JSON:", error)
//                }
//            } else if let error = error {
//                print("Error making request:", error)
//            }
//        }.resume()
//    }
//}
//
//
//
//struct upFaculty: Codable {
//    let f_name: String
//    let username: String
//    let password: String
//}
//
//struct EditFaculty: View { // Design 100% OK
//    
//    @State private var f_name = ""
//    @State private var username = ""
//    @State private var password = ""
//
//    var body: some View { // Get All Data From Node MongoDB : Pending
//        VStack {
//            Text("Update Faculty")
//                .padding()
//                .bold()
//                .font(.largeTitle)
//                .foregroundColor(Color.white)
//            Spacer()
//            Text("Name")
//                .bold()
//                .padding(.horizontal)
//                .font(.title2)
//                .foregroundColor(Color.white)
//                .frame(maxWidth: .infinity , alignment: .leading)
//            TextField("Name" , text: $f_name)
//                .padding()
//                .background(Color.gray.opacity(0.8))
//                .cornerRadius(8)
//                .padding(.horizontal)
//            Text("Username")
//                .bold()
//                .padding(.horizontal)
//                .font(.title2)
//                .foregroundColor(Color.white)
//                .frame(maxWidth: .infinity , alignment: .leading)
//            TextField("Username" , text: $username)
//                .padding()
//                .background(Color.gray.opacity(0.8))
//                .cornerRadius(8)
//                .padding(.horizontal)
//            Text("Password")
//                .bold()
//                .padding(.horizontal)
//                .font(.title2)
//                .foregroundColor(Color.white)
//                .frame(maxWidth: .infinity , alignment: .leading)
//            SecureField("Password" , text: $password)
//                .padding()
//                .background(Color.gray.opacity(0.8))
//                .cornerRadius(8)
//                .padding(.horizontal)
//            Spacer()
//                Button("Update"){
//                    updateFaculty()
//                }
//                .bold()
//                .padding()
//                .frame(width: 150)
//                .foregroundColor(.black)
//                .background(Color.yellow)
//                .cornerRadius(8)
//                .padding(.all)
//        }
//        .background(Image("fw"))
//    }
//    func updateFaculty() {
//        
//    }
//}
//struct Faculty_Previews: PreviewProvider {
//    static var previews: some View {
//        Faculty()
//    }
//}


