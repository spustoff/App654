//
//  TabBar.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 8, content: {
                        
                        Image(index.rawValue)
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == index ? Color("bg2") : .white)
                            .frame(width: 25, height: 25)
                            .padding()
                            .background(Circle().fill(selectedTab == index ? Color("prim") : Color("bg2")))
                            .background(Circle().stroke(selectedTab == index ? Color.white.opacity(0) : Color.white.opacity(0.2)))

                        
                    })
                    .frame(maxWidth: .infinity)
                })
            }
        }
        .frame(width: 200)
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 50).fill(Color("bg2")))
    }
}

enum Tab: String, CaseIterable {
    
    case Competitions = "Competitions"
    
    case Participants = "Participants"
                
    case Settings = "Settings"
    
}
