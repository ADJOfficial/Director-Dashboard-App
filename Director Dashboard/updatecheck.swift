//import SwiftUI
//
//import SwiftUI
//
//struct Coure: Codable  ,Hashable {
//    let c_code: String
//    let c_title: String
//    let f_name: String
//}
//
//class CouViewModel: ObservableObject {
//    @Published var assignedCourses: [Coure] = []
//    
//    func fetchAssignedCourses(facultyID: Int) {
//        guard let url = URL(string: "http://localhost:2000/FacultyAssignedCourse?f_id=\(facultyID)") else {
//            print("Invalid URL")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
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
//                let courses = try JSONDecoder().decode([Coure].self, from: data)
//                DispatchQueue.main.async {
//                    self.assignedCourses = courses
//                    print("Fetched \(courses.count) assigned courses for faculty ID: \(facultyID)")
//                }
//            } catch {
//                print("Error decoding data: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
//}
//
////struct FacultyListView: View {
////    let facul: [faculties]
////
////    var body: some View {
////        ForEach(facul, id: \.self) { faculty in
////            NavigationLink(destination: EyeAssignedCourses(facultyID: faculty.f_id)) {
////                Text(faculty.f_name)
////            }
////        }
////    }
////}
//
//struct FacultyListView: View {
//    @StateObject private var facultyViewModel = FacultiesViewModel()
//    
//    var body: some View {
//        NavigationView{
//            VStack{
//                ForEach(facultyViewModel.remaining, id: \.self) { faculty in
//                    NavigationLink(destination: EyeAssignedCourses(facultyID: faculty.f_id)) {
//                        Image(systemName: "eye.fill")
//                            .bold()
//                            .font(.title3)
//                            .foregroundColor(Color.orange)
//                        
//                    }
//                    Text(faculty.f_name)
//                }
//            }
//            .onAppear {
//                facultyViewModel.fetchExistingFaculties()
//            }
//        }
//    }
//}
//
//struct EyeAssignedCourses: View {
//    @StateObject private var couViewModel = CouViewModel()
//    var facultyID: Int
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Assigned Courses")
//                    .bold()
//                    .font(.largeTitle)
//                    .foregroundColor(Color.white)
//                Spacer()
//                Text("")
//                    .bold()
//                    .padding()
//                    .font(.title2)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .foregroundColor(Color.white)
//                Text("Assigned Courses")
//                    .bold()
//                    .underline()
//                    .font(.title3)
//                    .foregroundColor(Color.white)
//                VStack {
//                    ScrollView {
//                        ForEach(couViewModel.assignedCourses, id: \.self) { course in
//                            HStack {
//                                Spacer()
//                                Text(course.c_code)
//                                    .padding(.top)
//                                    .font(.headline)
//                                    .foregroundColor(Color.white)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                Text(course.c_title)
//                                    .padding(.top)
//                                    .font(.headline)
//                                    .foregroundColor(Color.white)
//                                    .frame(maxWidth: .infinity, alignment: .leading)
//                                Spacer()
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                .background(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.gray, lineWidth: 2)
//                )
//                .frame(width: 410, height: 400)
//                .onAppear {
//                    couViewModel.fetchAssignedCourses(facultyID: facultyID)
//                }
//                NavigationLink(destination: PlusAssignCourse()) {
//                    Image(systemName: "plus.app.fill")
//                        .bold()
//                        .padding()
//                        .font(.largeTitle)
//                        .foregroundColor(Color.green)
//                }
//            }
//            .background(Image("fc").resizable().ignoresSafeArea())
//        }
//    }
//}
//
//
//struct E_Previews: PreviewProvider {
//    static var previews: some View {
//        FacultyListView()
//    }
//}
