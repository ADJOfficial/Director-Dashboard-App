//
//  UploadedPapers.swift
//  Director Dashboard
//
//  Created by ADJ on 16/03/2024.
//

import SwiftUI

struct GetUploadedPaper: Hashable , Decodable  ,Encodable {
        // To detect ID of That date to be get/edit
//    var p_id: Int
    let p_name: String
    let c_code: String
//    var duration: Int
//    var degree: String
//    var t_marks: Int
//    var term : String
//    var year: Int
//    var exam_date: String
//    var semester: String
//    var status: String
//    var c_id: Int
    
}

class UploadedPaperViewModel: ObservableObject {
    
    @Published var uploaded: [GetUploadedPaper] = []
//    @Published var c_id: [Int] = [] // To get ID
    
    func fetchExistingPapers() {
        guard let url = URL(string: "http://localhost:3000/getuploadedpapers")
                
        else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data , error == nil
                    
            else {
                return
            }
            
            // Convert to JSON
            
            do{
                let faculty = try JSONDecoder().decode([GetUploadedPaper].self, from: data)
                DispatchQueue.main.async {
                    self?.uploaded = faculty
                    print("Fetched \(faculty.count) Faculties")
                }
            }
            catch{
                print("Error While Getting Data", error.localizedDescription)
            }
        }
        task.resume()
    }
}



struct UploadedPapers: View {
    
    
    @State private var searchText = ""
    @State private var searchResults: [GetUploadedPaper] = []
    @StateObject private var uploadedPaperViewModel = UploadedPaperViewModel()
    @StateObject private var coursesViewModel = CoursesViewModel()
    
    var filteredPapers: [GetUploadedPaper] { // All Data Will Be Filter and show on Table
        if searchText.isEmpty {
            return uploadedPaperViewModel.uploaded
        } else {
            return uploadedPaperViewModel.uploaded.filter { faculty in
                faculty.p_name.localizedCaseInsensitiveContains(searchText) ||
                faculty.c_code.localizedCaseInsensitiveContains(searchText)
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
//                        .padding(.horizontal)
                }
                .opacity(text.isEmpty ? 0 : 1)
            }
        }
    }
    var body: some View { // Get All Data From Node MongoDB : Pending
        NavigationView {
            VStack {
                Text("Create Faculty")
//                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)

                Spacer()
                SearchBar(text: $searchText)
                    .padding()
                
                VStack{
                    ScrollView {
                        ForEach(filteredPapers.indices, id: \.self) { index in
                            let cr = filteredPapers[index]
                            HStack{
                                Text(cr.p_name)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Text(cr.c_code)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .center)
                                NavigationLink{
                                    EyeViewPaperHeader()
                                        .navigationBarBackButtonHidden(true)
                                }label: {
                                    Image(systemName: "eye.fill")
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(Color.orange)
                                }
                            }
                            Divider()
                                .background(Color.white)
                                .padding(1)
                        }
                        if filteredPapers.isEmpty {
                            Text("No Uploaded Papers Found")
                                .font(.headline)
                                .foregroundColor(.orange)
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
                .frame(width: 410 , height:700)
                .onAppear {
                    uploadedPaperViewModel.fetchExistingPapers()
                    print("Filtered Papers Count:", filteredPapers.count)
                }
                
                Spacer()
            }
            .background(Image("fw").resizable().ignoresSafeArea())
        }
    }
}

struct EyeViewPaperHeader: View {
    
//    var courseID: Int
//    var paperID: Int
    
    var body: some View{
        VStack{
            Text("Make Paper")
                .font(.title)
                .foregroundColor(Color.orange)
            Spacer()
        }
//        .background(Image("fw").resizable().ignoresSafeArea())
    }
}

struct UploadedPapers_Previews: PreviewProvider {
    static var previews: some View {
        UploadedPapers()
    }
}
