//
//  DirectorWelcome.swift
//  Director Dashboard
//
//  Created by ADJ on 06/01/2024.
//

import SwiftUI

struct DirectorWelcome: View {
    var body: some View {
        VStack{
            Text("Director")
                .font(.largeTitle)
                .bold()
            Text("Welcome Dr ... ")
                .font(.title)
                .position(x:110,y: 70)
            
            VStack {
                
                NavigationLink {
                    UploadPapers()
                } label: {
                    Text("Upload Papers")
                }
                .foregroundColor(.white)
                .padding()
                .bold()
                .frame(width: 170)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.all)
                
                NavigationLink {
                    ApprovedPapers()
                } label: {
                    Text("Approved Papers")
                }
                .foregroundColor(.white)
                .padding()
                .bold()
                .frame(width: 170)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.all)
            }
            .position(x:200)
        }
    }
}

struct Comments: View {
    @State private var comment: String = ""
    var body: some View {
        VStack {
            Text("Comments")
                .font(.largeTitle)
                .bold()
            Text("Feedback")
                .font(.title)
                .bold()
                .position(x:90,y: 200)
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $comment)
                    .padding()
                    .frame(width: 370, height: 200)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .padding(.horizontal)
                    .position(x: 197)
                HStack {
                    Spacer()
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                        .position(x: 343 , y: 70)
                    
                }
                .padding(.trailing)
                .padding(.bottom)
            }
        }
    }
}

struct UploadPapers: View {
    var body: some View {
        Text("Show Uploaded Papers")
    }
}



struct ApprovedPapers: View {
    var body: some View {
        Text("Show Approved Papers")
    }
}
struct DirectorWelcome_Previews: PreviewProvider {
    static var previews: some View {
        Comments()
    }
}
