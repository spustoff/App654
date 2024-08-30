//
//  CompetitionsView.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI

struct CompetitionsView: View {
    
    @StateObject var viewModel = CompetitionsViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("11")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .cornerRadius(35)
                    .overlay(
                        
                        VStack {
                            
                            Text("Competitions")
                                .foregroundColor(.white)
                                .font(.system(size: 34, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                            
                            Spacer()
                        }
                        
                )
                    .padding(.bottom)

                
                if viewModel.events.isEmpty {
                    
                    VStack(spacing: 20) {
                        
                        Image("kubok")
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .medium))
                        
                        Text("Add an event, click +")
                            .foregroundColor(.white.opacity(0.6))
                            .font(.system(size: 15, weight: .regular))
                        
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.events, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedEvent = index
                                    
                                    viewModel.currentEvName = viewModel.selectedEvent?.evName ?? ""
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image(systemName: index.evPhoto ?? "")
                                            .foregroundColor(Color("prim"))
                                            .font(.system(size: 34, weight: .regular))
                                            .frame(width: 100, height: 100)
                                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.05)))
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            
                                            Text(index.evName ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .medium))
                                            
                                            Text(index.evDescr ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 15, weight: .regular))
                                                                                    
                                            HStack {
                                                
                                                Image(systemName: "calendar")
                                                    .foregroundColor(Color("prim"))
                                                    .font(.system(size: 13, weight: .regular))
                                                
                                                Text((index.evDate ?? Date()).convertDate(format: "dd.MM.yy"))
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 13, weight: .regular))
                                                
                                                Image(systemName: "clock")
                                                    .foregroundColor(Color("prim"))
                                                    .font(.system(size: 13, weight: .regular))
                                                
                                                Text((index.evTime ?? Date()).convertDate(format: "HH:mm"))
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 13, weight: .regular))
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        VStack {
                                            
                                            Button(action: {
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDetail = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "arrow.up.right")
                                                    .foregroundColor(.white.opacity(0.3))
                                                    .padding()
                                                    .background(Circle().fill(.white.opacity(0.05)))
                                            })
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                                })
                            }
                        }
                    }
                }
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                     
                        Text("Add event")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(RoundedRectangle(cornerRadius: 20.0).fill(Color("prim")))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 50)
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchEvents()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddEvent(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            EventsDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    CompetitionsView()
}
