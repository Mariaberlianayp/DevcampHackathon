//
//  ReviewPaymentView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 09/12/23.
//

import SwiftUI

struct ReviewPaymentView: View {
    var body: some View {
            NavigationView{
                ZStack{
                    Image("ReviewPayment")
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
                        NavigationLink(destination:PinInputView())
                        {
                            Image("ButtonReviewPayment")
                        }
                    }
                }
            }.navigationBarBackButtonHidden(true)
            
        
    }
}

#Preview {
    ReviewPaymentView()
}
