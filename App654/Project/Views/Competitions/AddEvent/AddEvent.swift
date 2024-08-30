//
//  AddEvent.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI

struct AddEvent: View {

    @StateObject var viewModel: CompetitionsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Text("Adding an event")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .regular))

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
                        
                        Text("Icon")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            ForEach(viewModel.icons, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentIcon = index
                                    
                                }, label: {
                                    
                                    Image(systemName: index)
                                        .foregroundColor(.white)
                                        .font(.system(size: 11, weight: .medium))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                                        .background(RoundedRectangle(cornerRadius: 10).stroke(viewModel.currentIcon == index ? Color("prim") : Color("bg2"), lineWidth: 2))
                                    .padding(1)
                                })
                            }
                        }

                        ZStack(alignment: .leading, content: {
                            
                            Text("Event name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.evName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.evName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))

                        ZStack(alignment: .leading, content: {
                            
                            Text("Short description")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.evDescr.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.evDescr)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Note")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.evNote.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.evNote)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg2")))
                        .padding(.bottom)
                        
                        HStack {
                            
                            Text("Date and time")
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()

                            DatePicker("", selection: $viewModel.evDate, displayedComponents: .date)
                                .labelsHidden()
                                                        
                            DatePicker("", selection: $viewModel.evTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.graphical)
                                .labelsHidden()
                        }
                    }
                }
                
                Button(action: {
                    
                    viewModel.evPhoto = viewModel.currentIcon
                    
                    viewModel.addEvent()
                    
                    viewModel.evName = ""
                    viewModel.evDescr = ""
                    viewModel.evNote = ""
                    viewModel.currentIcon = ""
                    
                    viewModel.fetchEvents()

                    withAnimation(.spring()) {
                        
                        router.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    
                    Text("Add")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                })
                .opacity(viewModel.evName.isEmpty || viewModel.evDescr.isEmpty || viewModel.evNote.isEmpty || viewModel.currentIcon.isEmpty ? 0.5 : 1)
                .disabled(viewModel.evName.isEmpty || viewModel.evDescr.isEmpty || viewModel.evNote.isEmpty || viewModel.currentIcon.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddEvent(viewModel: CompetitionsViewModel())
}
