//
//  NotificationView.swift
//  HackathonDevcamp
//
//  Created by Maria Berliana on 08/12/23.
//
import SwiftUI
import UserNotifications

struct NotificationView: View {
    @State private var showPinView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: NotificationDetailView(), isActive: $showPinView) {
                    EmptyView()
                }
                .hidden()
                
                Button(action: {
                    // Handle tap gesture on the button
                    showPinView.toggle()
                    scheduleNotification()
                }) {
                    HStack {
                        Image(systemName: "checkmark.shield")
                            .padding(.leading, -5.0)
                        Text("Bayar")
                            .font(.custom("OpenSauceOne-Bold", size: 16))
                    }
                    .frame(width: 105.0, height: 40.0)
                    .background(Color("Hijau1"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else if granted {
                let content = UNMutableNotificationContent()
                content.title = "Bayar Sekarang!"
                content.body = "Transaction split bill menunggu pembayaran, Teman mu menunggu!"
                if let imageUrl = Bundle.main.url(forResource: "toped", withExtension: "png") {
                                do {
                                    let attachment = try UNNotificationAttachment(identifier: "image", url: imageUrl, options: nil)
                                    content.attachments = [attachment]
                                } catch {
                                    print("Error attaching image to notification: \(error.localizedDescription)")
                                }
                            }

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                center.add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled successfully")
                    }
                }
            }
        }
    }
    
}

struct NotificationDetailView: View {
    var body: some View {
        ReviewPaymentView()
    }
}


#Preview {
    NotificationView()
}
