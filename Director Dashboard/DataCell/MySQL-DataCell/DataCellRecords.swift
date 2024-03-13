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
                    print("Fetched \(faculty.count) Faculties")
                }
            }
            catch{
                print("Error While Getting Data")
            }
        }
        task.resume()
    }
}


// To Get All Existing Faculties Members


struct AllCourses: Hashable , Decodable  ,Encodable {

        var c_id: Int // To detect ID of That date to be get/edit
        var c_code: String
        var c_title: String
        var cr_hours: Int
        var status: String
}

class CoursesViewModel: ObservableObject {

    @Published var existing: [AllCourses] = []

    func fetchExistingCourses() {
        guard let url = URL(string: "http://localhost:8000/allcourse") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let courses = try JSONDecoder().decode([AllCourses].self, from: data)
                DispatchQueue.main.async {
                    self?.existing = courses
                    print("Fetched \(courses.count) courses")
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


// To Get All Existing Papers 


struct Paper: Hashable, Codable {
    var p_id: Int
    var p_name: String
    var status: String
    // Add any other properties you need
}

class PaperViewModel: ObservableObject {
    @Published var existingPapers: [Paper] = []
    
    func fetchExistingPapers() { // it fetches all Papers whether Printed or Print
        
        guard let url = URL(string: "http://localhost:8000/GetApprovedPapers") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let papers = try JSONDecoder().decode([Paper].self, from: data)
                DispatchQueue.main.async {
                    self?.existingPapers = papers
                    print("Fetched \(papers.count) papers")
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    func fetchPrintedPapers() { // it fetches Only Printed Papers
        
        guard let url = URL(string: "http://localhost:8000/showPrintedPapers") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let papers = try JSONDecoder().decode([Paper].self, from: data)
                DispatchQueue.main.async {
                    self?.existingPapers = papers
                    print("Fetched \(papers.count) papers")
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


