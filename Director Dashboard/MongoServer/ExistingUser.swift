//
//  ExistingUser.swift
//  Director Dashboard
//
//  Created by ADJ on 07/01/2024.
//

import Foundation

struct ExistingUser: Hashable , Codable {
    var name = ""
    var username = ""
    var password = ""
}

class UserViewModel: ObservableObject {
    
    @Published var existing: [ExistingUser] = []
    
    func fetchExistingUser() {
        guard let url = URL(string: "http://localhost:1000/givens")
                
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
                let users = try JSONDecoder().decode([ExistingUser].self, from: data)
                DispatchQueue.main.async {
                    self?.existing = users
                }
            }
            catch{
                print("Error While Getting Data")
            }
        }
        task.resume()
    }
}

struct ExistingCourses: Hashable , Codable {
    var course = ""
    var code = ""
}

class CourseViewModel: ObservableObject {
    
    @Published var courses: [ExistingCourses] = []
    
    func fetchExistingCourse() {
        guard let url = URL(string: "http://localhost:1000/course")
                
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
                let courses = try JSONDecoder().decode([ExistingCourses].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            }
            catch{
                print("Error While Getting Data")
            }
        }
        task.resume()
    }
}

