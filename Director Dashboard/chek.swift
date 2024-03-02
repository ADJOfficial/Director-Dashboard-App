import SwiftUI

struct Teacher: Identifiable {
    let id: Int
    let name: String
    var role: String
}

class FacultyViewModel: ObservableObject {
    @Published var faculties: [Teacher] = []
    
    init() {
        // Populate the initial list of faculties
        faculties = [
            Teacher(id: 1, name: "Faculty 1", role: "Junior"),
            Teacher(id: 2, name: "Faculty 2", role: "Junior"),
            Teacher(id: 3, name: "Faculty 3", role: "Junior")
            // Add more faculties as needed
        ]
    }
    
    func updateFacultyRole(facultyId: Int) {
        // Update the role of the selected faculty and all other faculties
        for index in faculties.indices {
            if faculties[index].id == facultyId {
                faculties[index].role = "Senior"
            } else {
                faculties[index].role = "Junior"
            }
        }
        
        // Make a POST request to your Express API to update the faculty role
        let url = URL(string: "http://localhost:1000/updatestatus")!
        let parameters: [String: Any] = ["f_id": facultyId]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                // Handle the error if needed
            } else if let data = data {
                // Process the response data if needed
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
            }
        }.resume()
    }
}

//struct check: View {
//    @StateObject private var facultyViewModel = FacultyViewModel()
//    
//    var body: some View {
//        VStack {
//            ForEach(facultyViewModel.faculties) { faculty in
//                RadioButton(
//                    id: faculty.id,
//                    text: faculty.name,
//                    isSelected: faculty.role == "Senior",
//                    action: facultyViewModel.updateFacultyRole
//                )
//            }
//        }
//        .padding()
//    }
//}
//
//struct RadioButton: View {
//    let id: Int
//    let text: String
//    let isSelected: Bool
//    let action: (Int) -> Void
//    
//    var body: some View {
//        Button(action: {
//            action(id)
//        }) {
//            HStack {
//                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
//                Text(text)
//            }
//            .foregroundColor(isSelected ? .blue : .primary)
//        }
//        .padding()
//    }
//}

//struct Radio_Previews: PreviewProvider {
//    static var previews: some View {
//      check()
//    }
//}
