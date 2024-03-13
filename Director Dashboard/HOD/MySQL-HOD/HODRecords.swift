////
////  HODRecords.swift
////  Director Dashboard
////
////  Created by ADJ on 12/03/2024.
////
//
//import Foundation
//
//struct AssignedCourse: Hashable, Codable {
//    var f_id: Int
//    var c_code: String
//    var c_title: String
//}
//
//class AssignedCourseViewModel: ObservableObject {
//    @Published var assignedCourse: [AssignedCourse] = []
//    
//    func fetchFacultyAssignCourse() { // it fetches all Papers whether Printed or Print
//        
//        guard let url = URL(string: "http://localhost:2000/FacultyAssignedCourse") else {
//            print("Invalid URL")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                print("No data returned")
//                return
//            }
//            
//            do {
//                let facultyAssignedCourses = try JSONDecoder().decode([AssignedCourse].self, from: data)
//                DispatchQueue.main.async {
//                    self?.assignedCourse = facultyAssignedCourses
//                    print("Fetched \(facultyAssignedCourses.count) AssignedCourse")
//                }
//            } catch {
//                print("Error decoding data: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//    
//    func fetchAssignedCourses(for userId: String) {
//        guard let url = URL(string: "http://localhost:2000/FacultyAssignedCourse?userId=\(userId)") else {
//            print("Invalid URL")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let data = data else {
//                print("No data returned")
//                return
//            }
//            
//            do {
//                let courses = try JSONDecoder().decode([AssignedCourse].self, from: data)
//                DispatchQueue.main.async {
//                    self?.assignedCourse = courses
//                    print("Fetched \(courses.count) AssignedCourse for userId: \(userId)")
//                }
//            } catch {
//                print("Error decoding data: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//}
//
////struct AssignedCourse: Hashable, Codable {
////
////
////    var f_id: Int
////    var c_code: String
////    var c_title: String
////}
////
////class AssignedCourseViewModel: ObservableObject {
////    @Published var assignedCourse: [AssignedCourse] = []
////
////    func fetchFacultyAssignCourse() { // it fetches all Papers whether Printed or Print
////
////        guard let url = URL(string: "http://localhost:2000/FacultyAssignedCourse") else {
////            print("Invalid URL")
////            return
////        }
////
////        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
////            if let error = error {
////                print("Error fetching data: \(error.localizedDescription)")
////                return
////            }
////
////            guard let data = data else {
////                print("No data returned")
////                return
////            }
////
////            do {
////                let facultyAssignedCourses = try JSONDecoder().decode([AssignedCourse].self, from: data)
////                DispatchQueue.main.async {
////                    self?.assignedCourse = facultyAssignedCourses
////                    print("Fetched \(facultyAssignedCourses.count) AssignedCourse")
////                }
////            } catch {
////                print("Error decoding data: \(error.localizedDescription)")
////            }
////        }
////        task.resume()
////    }
////    func fetchAssignedCourses(for userId: String) {
////        guard let url = URL(string: "http://localhost:2000/FacultyAssignedCourse?userId=\(userId)") else {
////            print("Invalid URL")
////            return
////        }
////
////        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
////            if let error = error {
////                print("Error fetching data: \(error.localizedDescription)")
////                return
////            }
////
////            guard let data = data else {
////                print("No data returned")
////                return
////            }
////
////            do {
////                let courses = try JSONDecoder().decode([AssignedCourse].self, from: data)
////                DispatchQueue.main.async {
////                    // Handle the fetched courses here
////                }
////            } catch {
////                print("Error decoding data: \(error.localizedDescription)")
////            }
////        }
////        task.resume()
////    }
////}
