//
//  SplitBillView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = ""},
                    label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.gray)
                    }
                )
            }
        }
    }
}

struct PlusButton: View {
    
    var body: some View {
        VStack{
            Text("")
        }
    }
}
struct APIResponse: Codable {
    let data: FriendsData?
}

struct FriendsData: Codable {
    let name: String
    let phone: String
    // Add other properties as needed
}

struct SplitBillView: View {
    @State private var nomorUser: String = ""
    @State private var namaUser: String = ""
    @State private var totalBarang: Int = 592700
    @State private var biayaPerOrang: Int = 592700
    @State private var isEditing: Bool = false
    @State private var isError: Bool = false
    @State private var friends: [(name: String, phoneNumber: String)] = []
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading) {
                    HStack{
                        NavigationLink(destination:ChoosePaymentView())
                        {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(Color("Dark1"))
                        }
                        Text("Tambahkan Teman")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Dark2"))
                            .font(.system(size: 20))
                        
                    }.padding(.bottom, 20.0)
                    ZStack{
                        
                        TextField("", text: $nomorUser, onEditingChanged: { editing in
                            withAnimation {
                                isEditing = editing
                            }
                        })
                        .modifier(TextFieldClearButton(text: $nomorUser))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isEditing ? Color("Hijau1") : .gray, lineWidth: 2)
                        )
                        
                        HStack{
                            Text("Nomor Teman")
                                .font(.system(size: 14))
                                .multilineTextAlignment(.leading)
                                .frame(width: 110.0, height: 30.0)
                                .background(Color.white)
                                .foregroundColor(isEditing ? Color("Hijau1") : .gray)
                                .padding()
                                .offset(y: isEditing ? -26 : 0)
                                .onTapGesture {
                                    withAnimation {
                                        isEditing = true
                                    }
                                }
                            Spacer()
                        }
                        
                        
                        
                    }
                }
                HStack {
                    Button(action: {
                        fetchUserData()
                        
                    }) {
                        Text("Tambah Teman")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Hijau1"))
                    }
                }
                
                VStack(alignment: .leading){
                    Text("List")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                }.padding(.leading, -180.0)
                ForEach(friends, id: \.phoneNumber) { friend in
                    HStack{
                        Text(friend.name)
                            .padding(.leading, 30.0)
                            .foregroundColor(Color("Dark1"))
                        Text("-")
                        Text(friend.phoneNumber)
                            .foregroundColor(Color("Dark1"))
                        
                        Spacer()
                        Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .padding(.trailing, 30.0)
                    }
                    .frame(width: 365.0, height: 60.0)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Hijau1"), lineWidth: 2)
                    )
                }
                
                Spacer()
                VStack{
                    VStack(alignment: .leading){
                        Text("Ringkasan Patungan")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }.padding(.leading, -180.0)
                    HStack{
                        Text("Total Pembelian")
                        Spacer()
                        Text("Rp. \(totalBarang)")
                    }
                    HStack{
                        Text("Biaya per orang")
                        Spacer()
                        Text("Rp. \(biayaPerOrang)")
                    }
                }.padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                    .frame(width: 500.0, height: 100.0)
                )
                HStack{
                    VStack{
                        Text("Total Tagihan")
                            .fontWeight(.semibold)
                        Text("Rp. \(biayaPerOrang)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.leading, 20.0)
                        
                    }.padding(.leading, -18.0)
                    Spacer()
                    NavigationLink(destination: PinInputView()) {
                        HStack{
                            Image(systemName: "checkmark.shield")
                                .padding(.leading, -5.0)
                            Text("Bayar")
                                .font(.custom("OpenSauceOne-Bold", size: 16))
                        }.frame(width: 105.0, height: 40.0)
                    }
                    .background(Color("Hijau1"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                }
                .padding(.top, 20.0)
            }
            .padding()
            
        }.navigationBarBackButtonHidden(true)
            .onReceive(timer) { _ in
                biayaPerOrang = totalBarang/(friends.count+1)
            }
        
    }
    func fetchUserData() {
        guard let url = URL(string: "http://localhost:8080/api/user/\(nomorUser)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                
                if let userData = apiResponse.data {
                    DispatchQueue.main.async {
                        let newFriend = (name: userData.name, phoneNumber: userData.phone)
                        friends.append(newFriend)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

#Preview {
    SplitBillView()
}
