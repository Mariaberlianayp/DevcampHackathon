//
//  MenungguPembayaranView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct MenungguPembayaranView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("MenungguPembayaran")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack{
                    HStack{
                        NavigationLink(destination:TransactionDetailView())
                        {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding(.leading, 15.0)
                    Spacer()
                }.padding(.top, 60.0)
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MenungguPembayaranView()
}
