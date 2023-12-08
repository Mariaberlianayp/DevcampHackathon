//
//  SplitBillView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.black)
                            .onTapGesture {
                                PlusButton()
                            }
                        Text("|")
                            .padding(.horizontal, 1.0)
                            .foregroundColor(.gray)
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.gray)
                    }
                )
            }
        }
    }
}

struct PlusButton: View {
    
    var body: some View {
        VStack{
            Text("")
        }
    }
}

struct SplitBillView: View {
    @State private var nomorUser: String = ""
    @State private var isEditing: Bool = false
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                HStack{
                    NavigationLink(destination:ChoosePaymentView())
                    {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color("Dark1"))
                    }
                    Text("Tambahkan Teman")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Dark2"))
                    
                }.padding(.vertical, 20.0)
                ZStack{
                    
                    TextField("", text: $nomorUser, onEditingChanged: { editing in
                        withAnimation {
                            isEditing = editing
                        }
                    })
                    .modifier(TextFieldClearButton(text: $nomorUser))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isEditing ? Color("Hijau1") : .gray, lineWidth: 2)
                    )
                    
                    HStack{
                        Text("Nomor Teman")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .frame(width: 110.0, height: 30.0)
                            .background(Color.white)
                            .foregroundColor(isEditing ? Color("Hijau1") : .gray)
                            .padding()
                            .offset(y: isEditing ? -26 : 0)
                            .onTapGesture {
                                withAnimation {
                                    isEditing = true
                                }
                            }
                        Spacer()
                    }
                    
                    
                    
                }
                

            }
            .padding()
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SplitBillView()
}
