//
//  DataCellWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct DataCellWelcome: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("DataCell")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                
                Text("Welcome Nadeem")
                    .font(.title)
                    .position(x:130,y: 80)
                
                VStack{
                    NavigationLink{
                        Faculty()
                    } label: {
                        Text("Faculty")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        VerifiedPapers()
                    } label: {
                        Text("Papers")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        Printed()
                    } label: {
                        Text("Printed")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.all)
                }
                .position(x:200)
            }
        }
    }
}
struct VerifiedPapers: View {

        var body: some View {
            VStack {
            }
        }
    }

struct Printed: View {
    var body: some View {
        Text("Printed")
    }
}


struct DataCellWelcome_Previews: PreviewProvider {
    static var previews: some View {
        DataCellWelcome()
    }
}
