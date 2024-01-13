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
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                
                Text("Welcome Mr Nadeem")
                    .font(.title)
                    .position(x:150,y: 80)
                    .foregroundColor(Color.white)
                
                VStack{
                    NavigationLink{
                        Faculty()
                    } label: {
                        Text("Faculty")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        VerifiedPapers()
                    } label: {
                        Text("Papers")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.all)
                    
                    NavigationLink{
                        Printed()
                    } label: {
                        Text("Printed")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .bold()
                    .frame(width: 150)
                    .background(Color.yellow)
                    .cornerRadius(8)
                    .padding(.all)
                }
                .position(x:200)
            }
            .background(Image("fac"))
        }
    }
}
struct VerifiedPapers: View {
    var body: some View {
        VStack {
            Text("Verified Printed")
                .foregroundColor(Color.white)
        }
        .background(Image("fac"))
    }
}

struct Printed: View {
    var body: some View {
        VStack{
            Text("Printed")
                .foregroundColor(Color.white)
        }
        .background(Image("fac"))
    }
}


struct DataCellWelcome_Previews: PreviewProvider {
    static var previews: some View {
        DataCellWelcome()
    }
}
