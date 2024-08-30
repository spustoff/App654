//
//  PartDetail.swift
//  App654
//
//  Created by IGOR on 02/07/2024.
//

import SwiftUI

struct PartDetail: View {

    @StateObject var viewModel: ParticipantsViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12) {
                        
                        HStack {
                            
                            Image(viewModel.selectedParticipant?.parPhoto ?? "")
                                .resizable()
                                .frame(width: 60, height: 60)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text(viewModel.selectedParticipant?.parName ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .medium))
                                
                                Text(viewModel.selectedParticipant?.parEx ?? "")
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
                                        
                                        Text("Age")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12, weight: .regular))
                                        
                                        Spacer()

                                    }
                                    
                                    Text(viewModel.selectedParticipant?.parAge ?? "")
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
                                        
                                        Text("Experience")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12, weight: .regular))
                                        
                                        Spacer()

                                    }
                                    
                                    Text(viewModel.selectedParticipant?.parEx ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .medium))
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.05)))
                            
                        }
                        
                        Text(viewModel.selectedParticipant?.parNote ?? "")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                    
                    VStack {
                        
                        Text("Application status")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        
                        HStack {
                            
                            ForEach(viewModel.statuses, id: \.self) { index in
                            
                                Text(index)
                                    .foregroundColor(.white)
                                    .font(.system(size: 11, weight: .medium))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(RoundedRectangle(cornerRadius: 20).fill((viewModel.selectedParticipant?.parStatus ?? "") == index ? Color("prim") : Color.white.opacity(0.05)))
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))

                }
            }
            .padding()
        }
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
                        
                        CoreDataStack.shared.deleteParticipant(withParName: viewModel.selectedParticipant?.parName ?? "", completion: {
                            
                            viewModel.fetchParticipants()
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
    PartDetail(viewModel: ParticipantsViewModel())
}
