import SwiftUI
struct PinInputView: View {
    @State private var pin: String = ""
    @State private var isEditing: Bool = false

    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack{
                    NavigationLink(destination:ChoosePaymentView())
                    {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color("Dark1"))
                    }
                    Text("Verifikasi Pembayaran")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Dark2"))
                        .font(.system(size: 20))
                    
                }.padding(.bottom, 20.0)
                Text("Enter your 6-digit PIN:")
                    .foregroundColor(.gray)
                    .padding()
                
                HStack(spacing: 10) {
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 50)
                            .frame(width: 50, height: 50)
                            .foregroundColor(index < pin.count ? Color("Hijau1") : .gray)
                            .overlay(
                                Text(index < pin.count ? "•" : "")
                                    .foregroundColor(.white)
                                    .font(.title)
                            )
                            .onTapGesture {
                                isEditing = true
                            }
                    }
                }
                .padding()
                
                if isEditing {
                    CustomNumericKeyboard(pin: $pin)
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                }
                
                // Use NavigationLink to navigate to the next page when pin has 6 digits
                NavigationLink(destination: AfterPaymentView(), isActive: .constant(pin.count == 6)) {
                    EmptyView()
                }
                .hidden()
                Spacer()
            }
            .padding()
        }.navigationBarBackButtonHidden(true)
    }
}

struct CustomNumericKeyboard: View {
    @Binding var pin: String
    
    let buttonLayout = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [-2,0, -1] // -1 represents the delete (x) button
    ]
    
    var body: some View {
        VStack{
            Spacer()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                ForEach(buttonLayout, id: \.self) { row in
                    ForEach(row, id: \.self) { number in
                        Button(action: {
                            if number == -1 {
                                if pin.count > 0 {
                                    pin.removeLast()
                                }
                            }else if(number == -2){
                                
                            }else {
                                if pin.count < 6 {
                                    pin += "\(number)"
                                }
                            }
                        }) {
                            Text(number == -1 ? "x" : (number == -2 ? "" : "\(number)"))
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color("Dark2"), lineWidth: 0))
                                .foregroundColor(Color("Dark2"))
                        }
                    }
                }
            }
            .padding()
        }
    }
}



#Preview {
    PinInputView()
}
