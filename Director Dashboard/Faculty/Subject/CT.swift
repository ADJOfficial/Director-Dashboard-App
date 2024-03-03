//
//  CT.swift
//  Director Dashboard
//
//  Created by ADJ on 02/03/2024.
//

import SwiftUI

struct CoveredTopics: View { // Design 100% complete
    
    @State private var isChecked = false
    let mainItems = ["First item", "Second item", "Third item"]
    let subItems = ["Subitem ", "Subitem ", "Subitem "]
    
    @State private var expandedItems: Set<Int> = []
    @State private var selectedMainItems: Set<Int> = []
    @State private var selectedSubItems: [Set<Int>] = Array(repeating: [], count: 3)
    @State private var selectedRadioButton: String? = nil
    
    var body: some View { // Backend Functtionaliity Missing
        NavigationView{
            VStack{
                Text("Covered Topics")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
               
                Spacer()
                
                Text("Programming Fundamental")
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("Course Code  CS-323")
                    .padding(.horizontal)
                    .font(.title3)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .foregroundColor(Color.white)
               
                Spacer()
                
                HStack {
                    Spacer()
                    RadioButton(title: "Covered", isSelected: selectedRadioButton == "Covered") {
                        selectedRadioButton = "Covered"
                    }
                    .foregroundColor(selectedRadioButton == "Covered" ? .green : .white)
                    Spacer()
                    RadioButton(title: "Common", isSelected: selectedRadioButton == "Common") {
                        selectedRadioButton = "Common"
                    }
                    .foregroundColor(selectedRadioButton == "Common" ? .green : .white)
                    Spacer()
                }
                
                Text("Topics - ")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity , alignment: .leading)
                    .font(.title2)
                    .foregroundColor(Color.white)
                ScrollView{
                    VStack {
                        
                        
                        ForEach(0..<mainItems.count) { mainIndex in
                            DisclosureGroup(
                                isExpanded: Binding(
                                    get: {
                                        expandedItems.contains(mainIndex)
                                    },
                                    set: { isExpanded in
                                        if isExpanded {
                                            expandedItems.insert(mainIndex)
                                        } else {
                                            expandedItems.remove(mainIndex)
                                        }
                                    }
                                ),
                                content: {
                                    ForEach(0..<subItems.count) { subIndex in
                                        HStack {
                                            Image(systemName: selectedSubItems[mainIndex].contains(subIndex) ? "checkmark.square.fill" : "square")
                                                .foregroundColor(selectedSubItems[mainIndex].contains(subIndex) ? .green : .white)
                                            
                                                .onTapGesture {
                                                    if selectedSubItems[mainIndex].contains(subIndex) {
                                                        selectedSubItems[mainIndex].remove(subIndex)
                                                    } else {
                                                        selectedSubItems[mainIndex].insert(subIndex)
                                                    }
                                                }
                                            Text("\(mainIndex + 1).\(subIndex + 1) \(subItems[subIndex])")
                                                .foregroundColor(Color.white)
                                                .padding(.all,3)
                                        }
                                    }
                                },
                                label: {
                                    HStack {
                                        Image(systemName: selectedMainItems.contains(mainIndex) ? "checkmark.square.fill" : "square")
                                            .foregroundColor(Color.white)
                                            .frame(width: 20) // Adjust the width as needed
                                            .onTapGesture {
                                                if selectedMainItems.contains(mainIndex) {
                                                    selectedMainItems.remove(mainIndex)
                                                } else {
                                                    selectedMainItems.insert(mainIndex)
                                                }
                                            }
                                        Text("\(mainIndex + 1). \(mainItems[mainIndex])")
                                            .foregroundColor(Color.white)
                                            .padding(.leading)
                                    }
                                }
                            )
                        }
                    }
                }
                .padding()
                .padding(.horizontal)
                .frame(width: 400 , height: 350)
                .cornerRadius(15)
               
                Spacer()
                
                NavigationLink {
                    SetPaper()
                    //                    .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Paper Setting")
                }
                .bold()
                .padding()
                .frame(width: 150)
                .foregroundColor(.black)
                .background(Color.green)
                .cornerRadius(8)
                .padding(.all)
                
//                Spacer()
                
            }
            .background(Image("fa").resizable().ignoresSafeArea())
        }
    }
}

struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(title)
            }
        }
    }
}

struct CoveredTopics_Previews: PreviewProvider {
    static var previews: some View {
        CoveredTopics()
    }
}
