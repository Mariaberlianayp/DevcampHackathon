//
//  ChoosePaymentView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct ChoosePaymentView: View {
    @State private var isToggleGoPayOn: Bool = true
    @State private var isToggleGoPayCoinsOn: Bool = false
    @State private var isToggleGoSplitOn: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var payment: String = "gopay"
    var body: some View {
        NavigationView{
            ZStack{
                Image("SelectPayment")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack{
                    HStack{
                        NavigationLink(destination:CheckoutView())
                        {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding(.leading, 20.0)
                    Spacer()
                }.padding(.top, 47.0)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: SplitBillView()) {
                            HStack{
                                Image(systemName: "checkmark.shield")
                                    .padding(.leading, -5.0)
                                Text("Bayar")
                                    .font(.custom("OpenSauceOne-Bold", size: 16))
                            }.frame(width: 105.0, height: 40.0)
                        }
                        .background(Color("Hijau1"))
                        .foregroundColor(.white)
                        .frame(width: 105.0, height: 40.0)
                        .cornerRadius(10)
                    }
                }
                .padding(.bottom, 42.0)
                .padding(.trailing, 15.0)
                
                VStack{
                    Toggle("", isOn: $isToggleGoPayOn)
                        .padding()
                    Toggle("", isOn: $isToggleGoPayCoinsOn)
                        .padding()
                    Toggle("", isOn: $isToggleGoSplitOn)
                        .padding()
                    Spacer()
                    
                }.padding(.top, 70.0)
                    .onReceive(timer) { _ in
                        if(isToggleGoSplitOn){
                            
                            isToggleGoPayOn = false
                            isToggleGoPayCoinsOn = false
                        }
                        else if(isToggleGoPayCoinsOn){
                            isToggleGoPayOn = false
                            isToggleGoSplitOn = false
                        }
                        else if(isToggleGoPayOn){
                            isToggleGoPayCoinsOn = false
                            isToggleGoSplitOn = false
                        }
                        
                    }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChoosePaymentView()
}
