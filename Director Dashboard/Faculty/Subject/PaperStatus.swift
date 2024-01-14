//
//  PaperStatus.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct PaperStatus: View { // Design 100% Ok
    @State private var search = ""
    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView {
            VStack {
                Text("Paper Status")
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
                    HStack{
                        Spacer()
                        Text("Courses")
                            .bold()
                            .padding()
                            .font(.title2)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("Status")
                            .bold()
                            .font(.title2)
                            .frame(maxWidth: .infinity , alignment: .trailing)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    ScrollView{ // Get From Backend
                        HStack{
                            Spacer()
                            Text("Parallel & distributing Computing")
                                .bold()
                                .font(.headline)
                                .frame(maxWidth: .infinity , alignment: .center)
                                .foregroundColor(Color.white)
                            Spacer()
                            Text("Pending")
                                .bold()
                                .font(.headline)
                                .frame(maxWidth: .infinity , alignment: .trailing)
                                .padding(.horizontal)
                                .foregroundColor(Color.red)
                            Spacer()
                        }
                        .foregroundColor(Color.white)
                    }
                }
            }
            .background(Image("fa").resizable().ignoresSafeArea())
        }
    }
}

struct PaperStatus_Previews: PreviewProvider {
    static var previews: some View {
        PaperStatus()
    }
}
