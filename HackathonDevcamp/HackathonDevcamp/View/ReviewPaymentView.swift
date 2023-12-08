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
