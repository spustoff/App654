//
//  EventsDetail.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI

struct EventsDetail: View {
    
    @StateObject var viewModel: CompetitionsViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12) {
                        
                        HStack {
                            
                            Image(systemName: viewModel.selectedEvent?.evPhoto ?? "")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 34, weight: .regular))
                                .frame(width: 100, height: 100)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.05)))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(viewModel.selectedEvent?.evName ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .medium))
                                
                                Text(viewModel.selectedEvent?.evDescr ?? "")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                
                            }
                            
                            Spacer()
                            
                            VStack {
                                
                                Button(action: {
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDelete = true
                                    }
                                    
                                }, label: {
                                    
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .font(.system(size: 14, weight: .regular))
                                        .padding()
                                        .background(Circle().fill(.white.opacity(0.05)))
                                })
                                
                            }
                            
                        }
                        
                        HStack {
                            
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    
                                    HStack {
                                        
                                        Text("Date")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "calendar")
                                            .foregroundColor(Color("prim"))
                                            .font(.system(size: 12, weight: .regular))
                                    }
                                    
                                    Text((viewModel.selectedEvent?.evDate ?? Date()).convertDate(format: "dd.MM.yy"))
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .medium))
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.05)))
                            
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    
                                    HStack {
                                        
                                        Text("Date")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "clock")
                                            .foregroundColor(Color("prim"))
                                            .font(.system(size: 12, weight: .regular))
                                    }
                                    
                                    Text((viewModel.selectedEvent?.evTime ?? Date()).convertDate(format: "HH:mm"))
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .medium))
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.05)))
                            
                        }
                        
                        Text(viewModel.selectedEvent?.evDescr ?? "")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                    
                    VStack {
                        
                        Text("Participants")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        
                        LazyVStack {
                            
                            ForEach(viewModel.participants, id: \.self) { index in
                            
                                HStack {
                                    
                                    Image(systemName: "person")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text(index.partName ?? "")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Spacer()

                                }
                                .padding(7)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                            }
                        }
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPart = true
                            }
                            
                        }, label: {
                            
                            HStack {
                               
                                Image(systemName: "plus")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 13, weight: .regular))
                                
                                Text("Add a participant")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 13, weight: .medium))
                                
                            }
                            .padding(7)
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color("prim")))
                            .padding(1)
                            
                        })
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchEParts()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddPart ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddPart = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPart = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Enter participant name")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Participant name")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.partName.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.partName)
                            .foregroundColor(Color.black)
                            .font(.system(size: 14, weight: .semibold))
                        
                    })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    
                    HStack {
                        
                        Button(action: {
                            
                            viewModel.partEvent = viewModel.selectedEvent?.evName ?? ""
                            
                            viewModel.addPart()
                            
                            viewModel.partName = ""
                            
                            viewModel.fetchEParts()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPart = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                        .opacity(viewModel.partName.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.partName.isEmpty ? true : false)
                        
                        Button(action: {
                            
                            viewModel.partName = ""
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPart = false
                            }
                            
                        }, label: {
                            
                            Text("Close")
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                    }
                    .padding(.top, 25)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg3")))
                .padding()
                .offset(y: viewModel.isAddPart ? 0 : UIScreen.main.bounds.height)
            }
        )
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteEvent(withEvName: viewModel.selectedEvent?.evName ?? "", completion: {
                            
                            viewModel.fetchEvents()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            viewModel.isDetail = false

                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    EventsDetail(viewModel: CompetitionsViewModel())
}
