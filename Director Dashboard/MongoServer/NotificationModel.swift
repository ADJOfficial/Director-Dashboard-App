//
//  NotificationModel.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import Foundation


//class ViewModel: ObservableObject {
//    
//    @Published var notif: [Notification] = []
//    
//    func fetchApiData() {
//        guard let url = URL(string: "http://localhost:1000/notifications")
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
//                let cars = try JSONDecoder().decode([Notification].self, from: data)
//                DispatchQueue.main.async {
//                    self?.notif = cars
//                }
//            }
//            catch{
//                print("Error While Getting Data")
//            }
//        }
//        task.resume()
//    }
//}
