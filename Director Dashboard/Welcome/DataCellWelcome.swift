//
//  DataCellWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct DataCellWelcome: View { // Design 100% Ok
    
    var body: some View { // Get All Data From Node MongoDB : Pending
    
        NavigationView{
            VStack{
                Text("DataCell")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Welcome Mr Nadeem")
                    .bold()
                    .padding()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Spacer()
                VStack{
                    NavigationLink{
                        Faculty()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Faculty")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        Courses()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Course")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        VerifiedPapers()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Papers")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        PrintedPapers()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Printed")
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.all)
                }
                Spacer()
            }
            .background(Image("fac"))
        }
    }
}

struct DataCellWelcome_Previews: PreviewProvider {
    static var previews: some View {
        DataCellWelcome()
    }
}
