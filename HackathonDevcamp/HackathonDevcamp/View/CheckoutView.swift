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
            }
        }
        
    }
}

#Preview {
    CheckoutView()
}
