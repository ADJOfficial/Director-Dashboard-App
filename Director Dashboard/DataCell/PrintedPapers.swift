//
//  UploadedPapers.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct PrintedPapers: View {
    
    @State private var searchPaper = ""
    @StateObject private var paperViewModel = PaperViewModel()
    
    var filteredPapers: [Paper] { // All Data Will Be Filter and show on Table
            if searchPaper.isEmpty {
                return paperViewModel.existingPapers
            } else {
                return paperViewModel.existingPapers.filter { faculty in
                    faculty.p_name.localizedCaseInsensitiveContains(searchPaper)
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
                }
                .opacity(text.isEmpty ? 0 : 1)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Printed Papers")
                    .bold()
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                SearchBar(text: $searchPaper)
                Spacer()
                VStack{
                    ScrollView {
                        ForEach(filteredPapers.indices, id: \.self) { index in
                            let cr = filteredPapers[index]
                            HStack{
                                Text(cr.p_name)
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                Text(cr.status)
                                    .font(.headline)
                                    .foregroundColor(Color.green)
                                    .frame(maxWidth: .infinity , alignment: .trailing)
                               
                            }
                            Divider()
                                .background(Color.white)
                                .padding(1)
                        }
                        if filteredPapers.isEmpty {
                            Text("No Printed Paper Found")
                                .font(.headline)
                                .foregroundColor(.yellow)
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
                    paperViewModel.fetchPrintedPapers()
                }
                Spacer()
            }
            .background(Image("fw").resizable().ignoresSafeArea())
        }
    }
}
struct PrintedPapers_Previews: PreviewProvider {
    static var previews: some View {
        PrintedPapers()
    }
}
