//
//  CheckoutView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct CheckoutView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("Checkout")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack{
                    HStack{
                        NavigationLink(destination:CartView())
                        {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding(.leading, 15.0)
                    Spacer()
                }.padding(.top, 60.0)
                VStack{
                    Spacer()
                    NavigationLink(destination: ChoosePaymentView()) {
                        
                        Text("Pilih Pembayaran")
                            .font(.custom("OpenSauceOne-Bold", size: 16))
                            .frame(width: 360.0, height: 40.0)
                    }
                    .background(Color("Hijau1"))
                    .foregroundColor(.white)
                    .frame(width: 360.0, height: 40.0)
                    .cornerRadius(10)
                }.padding(.bottom, 55.0)
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    CheckoutView()
}
