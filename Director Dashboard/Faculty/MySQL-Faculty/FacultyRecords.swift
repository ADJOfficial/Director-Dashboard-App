//////
//////  FacultyRecords.swift
//////  Director Dashboard
//////
//////  Created by ADJ on 13/03/2024.
//////
////
import Foundation

struct feedback: Hashable , Decodable  ,Encodable {

        var fb_details: String
}

class FeedBackViewModel: ObservableObject {

    @Published var fb: [feedback] = []
    //    @Published var f_id: [Int] = [] // To get ID

    func fetchExistingFeedback() {
        guard let url = URL(string: "http://localhost:4000/getfeedback")

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
                let fbs = try JSONDecoder().decode([feedback].self, from: data)
                DispatchQueue.main.async {
                    self?.fb = fbs
                    print("Fetched \(fbs.count) Faculties")
                }
            }
            catch{
                print("Error While Getting Data")
            }
        }
        task.resume()
    }
//    func markAsRead(_ feedback: feedback) {
//        if let index = fb.firstIndex(of: feedback) {
//            fb[index].isRead = true
//        }
//    }
}
