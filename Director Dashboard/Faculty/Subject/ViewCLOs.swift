//
//  ViewCLOs.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct ViewCLOs: View { // Design 100% Ok
    
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""

    
    var body: some View { // Get All Data From Node MongoDB : Pending
        
        NavigationView {
            VStack {
                Text("CLOs")
//                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Programming Fundamental")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title)
                    .foregroundColor(Color.white)
                Text("Course Code  CS-323")
                    .bold()
                    .padding(.horizontal)
                    .font(.title3)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                VStack{
                    Text("CLO-1")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    TextField("Create CLO-1" , text: $name)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    Text("CLO-2")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    TextField("Create CLO-2" , text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    Text("CLO-3")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    SecureField("Create CLO-3" , text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    Text("CLO-4")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity , alignment: .leading)
                    SecureField("Create CLO-4" , text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                    Spacer()
                    Button("Save Changes"){
                        saveCLOs()
                    }
                    .bold()
                    .padding()
                    .frame(width: 150)
                    .foregroundColor(.black)
                    .background(Color.green)
                    .cornerRadius(8)
                    Spacer()
                
            }
            .background(Image("fa").resizable().ignoresSafeArea())
        }
    }
    func saveCLOs() {
        
    }
}

struct ViewCLOs_Previews: PreviewProvider {
    static var previews: some View {
        ViewCLOs()
    }
}
