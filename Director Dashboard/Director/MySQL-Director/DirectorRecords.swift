//
//  MySQL-Director.swift
//  Director Dashboard
//
//  Created by ADJ on 16/03/2024.
//

import Foundation


//struct GetUploadedPaper: Hashable , Decodable  ,Encodable {
//        // To detect ID of That date to be get/edit
//    var p_id: Int
//    var p_name: String
//    var duration: Int
//    var degree: String
//    var t_marks: Int
//    var term : String
//    var year: Int
//    var exam_date: String
//    var semester: String
//    var status: String
//    var c_id: Int
//    
//}
//
//class UploadedPaperViewModel: ObservableObject {
//    
//    @Published var uploaded: [GetUploadedPaper] = []
////    @Published var f_id: [Int] = [] // To get ID
//    
//    func fetchExistingPapers() {
//        guard let url = URL(string: "http://localhost:3000/getuploadedpapers")
//                
//        else{
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            
//            guard let data = data , error == nil
//                    
//            else {
//                return
//            }
//            
//            // Convert to JSON
//            
//            do{
//                let faculty = try JSONDecoder().decode([GetUploadedPaper].self, from: data)
//                DispatchQueue.main.async {
//                    self?.uploaded = faculty
//                    print("Fetched \(faculty.count) Faculties")
//                }
//            }
//            catch{
//                print("Error While Getting Data")
//            }
//        }
//        task.resume()
//    }
//}
