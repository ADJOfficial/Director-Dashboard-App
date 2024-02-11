//
//  SetCLOs.swift
//  Director Dashboard
//
//  Created by ADJ on 14/01/2024.
//

import SwiftUI

struct SetCLOs: View { // Design 100% OK
    
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""
    @State private var selectedOptions = 0
    var options = ["CS", "WT" , "SNA" , "SE" , "Isl" , "SRE"]
    
    var body: some View { // Get All Data From Node MongoDB : Pending 
        
        NavigationView {
            VStack {
                Text("Create CLOs")
//                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                Spacer()
                Text("Course")
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity , alignment: .leading)
                Picker("" , selection: $selectedOptions){
                    ForEach(0..<options.count) { index in
                        Text(options[index])
                    }
                }
                .accentColor(.green)
                .pickerStyle(.segmented)
//                .background(Color.green)
                .environment(\.colorScheme, .dark)
                .frame(maxWidth: .infinity , alignment: .center)
                .padding(.horizontal)
                .cornerRadius(8)
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
                    Button("Create"){
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

struct SetCLOs_Previews: PreviewProvider {
    static var previews: some View {
        SetCLOs()
    }
}
