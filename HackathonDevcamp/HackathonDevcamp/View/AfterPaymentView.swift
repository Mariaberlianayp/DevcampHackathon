//
//  AfterPaymentView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct AfterPaymentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("afterPayment")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack{
                    NavigationLink(destination: TransactionDetailView()) {
                        Text("Belanja Lagi")
                            .font(.custom("OpenSauceOne-Bold", size: 16))
                            .frame(width: 360.0, height: 40.0)
                    }
                    .background(Color("Hijau1"))
                    .foregroundColor(.white)
                    .frame(width: 360.0, height: 40.0)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: TransactionDetailView()) {
                        Text("Cek Status Pembayaran")
                            .font(.custom("OpenSauceOne-Bold", size: 16))
                            .frame(width: 360.0, height: 40.0)
                    }
                    .background(.white)
                    .foregroundColor(Color("Hijau1"))
                    .frame(width: 360.0, height: 40.0)
                    .cornerRadius(10)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("Hijau1"), lineWidth: 1)
                        )
                }.padding(.top, -200.0)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AfterPaymentView()
}
