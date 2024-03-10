//
//  FacultyRecords.swift
//  Director Dashboard
//
//  Created by ADJ on 07/03/2024.

import Foundation

// To Get All Existing Faculties Members

struct faculties: Hashable , Decodable  ,Encodable {
        
        var f_id: Int // To detect ID of That date to be get/edit
        var f_name: String
        var username: String
        var password: String
        var status: String
}

class FacultiesViewModel: ObservableObject {
    
    @Published var remaining: [faculties] = []
    @Published var f_id: [Int] = [] // To get ID
    
    func fetchExistingFaculties() {
        guard let url = URL(string: "http://localhost:8000/allfaculty")
                
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
                let faculty = try JSONDecoder().decode([faculties].self, from: data)
                DispatchQueue.main.async {
                    self?.remaining = faculty
                }
            }
            catch{
                print("Error While Getting Data")
            }
        }
        task.resume()
    }
}


//// To Create New Faculty Members
//
//
