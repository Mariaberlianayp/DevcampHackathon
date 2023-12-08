//
//  TransactionDetailView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct TransactionDetailView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("TransactionDetail")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack{
                    NavigationLink(destination: MenungguPembayaranView()) {
                        Image("MenungguPembayaranButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }.padding(.top, -285.0)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TransactionDetailView()
}
