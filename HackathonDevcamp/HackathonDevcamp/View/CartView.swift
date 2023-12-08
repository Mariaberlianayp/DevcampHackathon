//
//  CartView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("Cart")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: CartView()) {
                            
                            Text("Beli(1)")
                                .font(.custom("OpenSauceOne-Bold", size: 16))
                                .frame(width: 105.0, height: 40.0)
                        }
                        .background(.green)
                        .foregroundColor(.white)
                        .frame(width: 105.0, height: 40.0)
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom, 42.0)
                .padding(.trailing, 15.0)
                
            }
            
        }
    }
}
#Preview {
    CartView()
}
