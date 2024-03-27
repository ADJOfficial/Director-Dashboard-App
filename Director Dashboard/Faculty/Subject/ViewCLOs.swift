//
//  ViewCLOs.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct ViewCLOs: View { // Design 100% Ok
    
    
    var f_id: Int
    var c_id: Int
    var c_title: String
    
    @State private var CLOName = ""
    @State private var searchText = ""
    @StateObject private var cloViewModel = CLOViewModel()
    
    var filteredCLO: [CLO] { // All Data Will Be Filter and show on Table
        if searchText.isEmpty {
            return cloViewModel.existing
        } else {
            return cloViewModel.existing.filter { topic in
                topic.clo_text.localizedCaseInsensitiveContains(searchText)
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
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                Text("CLOs")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Course")
                    .bold()
                    .padding(.horizontal)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Text("\(c_title)")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
//                Spacer()
                
                    Text("Desccription")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    TextField("Enter CLO Description" , text: $CLOName)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.gray.opacity(1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                
                
                Image(systemName: "bolt.fill")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color.green)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .trailing)
                    .onTapGesture {
//                            createQuestion()
                    }
                
                SearchBar(text: $searchText)
                    .padding()
                
                VStack {
                    ScrollView{
                        ForEach(filteredCLO.indices , id:\ .self) { index in
                            let cr = filteredCLO[index]
                            HStack{
                                Text(cr.clo_text)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                NavigationLink{
                                    //                                    EditTopics(f_id: f_id, c_id: c_id , c_title: c_title, topic: cr)
                                    //                                        .navigationBarBackButtonHidden(true)
                                }label: {
                                    Image(systemName: "square.and.pencil.circle")
                                        .font(.title)
                                        .foregroundColor(Color.orange)
                                        .frame(maxWidth: .infinity , alignment: .trailing)
                                }
                                Image(systemName: isCLOEnabled(index) ? "checkmark.circle.fill" : "nosign")
                                    .font(.title)
                                    .foregroundColor(isCLOEnabled(index) ? .green : .red)
                                    .onTapGesture {
                                        toggleCLOStatus(index)
                                    }
                            }
                            Divider()
                                .background(Color.white)
                            .padding(1)
                        }
                        if filteredCLO.isEmpty {
                            Text("No CLO Found For Course - \(c_title)")
                                .font(.headline)
                                .foregroundColor(.orange)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.green.opacity(0.5), lineWidth: 1)
                )
                .frame(height:400)
                .onAppear {
                    cloViewModel.getCLO(courseID: 3)
                }
            }
            .background(Image("fiii").resizable().ignoresSafeArea())
        }
    }
    func saveCLOs() {
        
    }
    
    func isCLOEnabled(_ index: Int) -> Bool {
        return filteredCLO[index].status == "Enable"
    }
    func toggleCLOStatus(_ index: Int) {
        let topic = filteredCLO[index]
        let newStatus = topic.status == "Enable" ? "Disable" : "Enable"
        
        guard let url = URL(string: "http://localhost:4000/enabledisableclo/\(topic.clo_id)") else {
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
                print("Error updating Topic status: \(error.localizedDescription)")
            } else if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Topic status updated successfully: \(responseString)")
                    cloViewModel.getCLO(courseID: c_id)
                }
            }
        }.resume()
    }
}

struct ViewCLOs_Previews: PreviewProvider {
    static var previews: some View {
        ViewCLOs(f_id: 0, c_id: 0, c_title: "")
    }
}
