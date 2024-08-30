//
//  ContentView.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var current_tab: Tab = Tab.Competitions

    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            if status {
            
            VStack(spacing: 0, content: {
            
                    TabView(selection: $current_tab, content: {

                        CompetitionsView()
                            .tag(Tab.Competitions)

                        ParticipantsView()
                            .tag(Tab.Participants)
                        
                        SettingsView()
                            .tag(Tab.Settings)
                        
                    })
                    
                })
                    .ignoresSafeArea(.all, edges: .bottom)
                    .onAppear {
                        
                    }
                
                VStack {
                    
                    Spacer()
                    
                    TabBar(selectedTab: $current_tab)
                    
                }
                
            } else {
                
                R1()
            }
        }
    }
}

#Preview {
    ContentView()
}
