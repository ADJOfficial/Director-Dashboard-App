//
//  VerifiedPapers.swift
//  Director Dashboard
//
//  Created by ADJ on 13/01/2024.
//

import SwiftUI

struct VerifiedPapers: View { // Design 100% OK
    
    @State private var search = ""
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView {
            VStack {
                Text("Approved Papers")
                    .bold()
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                TextField("Search Paper", text: $search)
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal)
                ScrollView{ // Get From Backend
                    HStack{
                        Spacer()
                        Text("Parallel & distributing Computing")
                            .font(.headline)
                        Spacer()
                        Text("CS-323")
                        Spacer()
                        NavigationLink{
                            PrintedPapers()
                                .navigationBarBackButtonHidden(true)
                        }label: {
                            Image(systemName: "printer.filled.and.paper")
                                .font(.title2)
                                .foregroundColor(Color.green)
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(Color.white)
                }
                Spacer()
            }
            .background(Image("h").resizable().ignoresSafeArea())
        }
    }
}

struct VerifiedPapers_Previews: PreviewProvider {
    static var previews: some View {
        VerifiedPapers()
    }
}
