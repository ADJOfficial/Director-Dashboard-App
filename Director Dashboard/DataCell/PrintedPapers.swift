//
//  UploadedPapers.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct PrintedPapers: View {
    
    @State private var search = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Printed Papers")
                    .bold()
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                TextField("Search Paper", text: $search)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                VStack{
                    ScrollView{ // Get From Backend
                        HStack{
                            Spacer()
                            Text("Parallel & distributing Computing")
                                .foregroundColor(Color.white)
                                .font(.headline)
                            Spacer()
                            Text("Printed")
                                .foregroundColor(Color.green)
                                .font(.headline)
                            Spacer()
                        }
                        Divider()
                            .background(Color.white)
                        .padding(1)
                    }
                    .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(width: 410 , height:700)
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
