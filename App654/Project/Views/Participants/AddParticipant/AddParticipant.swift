//
//  AddParticipant.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI

struct AddParticipant: View {

    @StateObject var viewModel: ParticipantsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Text("Adding participant")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))

                HStack {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            router.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 17, weight: .medium))
                            
                            Text("Back")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))
                        }
                    })
                    
                    Spacer()
                }
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentPhoto.isEmpty {
                                
                                Image(systemName: "camera.fill")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 26))
                                    .frame(width: 100, height: 100)
                                    .background(Circle().fill(Color("bg2")))
                                
                                
                            } else {
                                
                                Image(viewModel.currentPhoto)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                            }
                            
                        })
                        .padding()
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.parName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.parName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Specialization")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.parSpec.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.parSpec)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        
                        HStack {
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Age")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.parAge.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.parAge)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Experience")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.parEx.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.parEx)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        
                    }
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Note")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.parNote.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.parNote)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        .padding(.bottom)
                        
                        Text("Select status")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            ForEach(viewModel.statuses, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentStatus = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                        .foregroundColor(.white)
                                        .font(.system(size: 11, weight: .medium))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(RoundedRectangle(cornerRadius: 20).fill(viewModel.currentStatus == index ? Color("prim") : Color("bg2")))
                                })
                            }
                        }
                    }
                }
                
                Button(action: {
                    
                    viewModel.parPhoto = viewModel.currentPhoto
                    viewModel.parStatus = viewModel.currentStatus
                    
                    viewModel.addParticipant()
                    
                    viewModel.currentPhoto = ""
                    viewModel.currentStatus = ""
                    viewModel.parName = ""
                    viewModel.parEx = ""
                    viewModel.parSpec = ""
                    viewModel.parAge = ""
                    viewModel.parNote = ""
                    
                    viewModel.fetchParticipants()

                    withAnimation(.spring()) {
                        
                        router.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color("prim")))
                })
                .opacity(viewModel.parName.isEmpty || viewModel.parSpec.isEmpty || viewModel.parAge.isEmpty || viewModel.parEx.isEmpty || viewModel.parNote.isEmpty || viewModel.currentStatus.isEmpty ? 0.5 : 1)
                .disabled(viewModel.parName.isEmpty || viewModel.parSpec.isEmpty || viewModel.parAge.isEmpty || viewModel.parEx.isEmpty || viewModel.parNote.isEmpty || viewModel.currentStatus.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddParticipant(viewModel: ParticipantsViewModel())
}
