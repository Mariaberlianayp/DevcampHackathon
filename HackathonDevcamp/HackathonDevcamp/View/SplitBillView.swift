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
    let data: UserData?
}

struct UserData: Codable {
    let name: String
    let phone: String
    // Add other properties as needed
}

struct SplitBillView: View {
    @State private var nomorUser: String = ""
    @State private var namaUser: String = ""
    @State private var isEditing: Bool = false
    @State private var friends: [(name: String, phoneNumber: String)] = []
    
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
                        
                    }.padding(.vertical, 20.0)
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
            }
            .padding()
        }.navigationBarBackButtonHidden(true)
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
