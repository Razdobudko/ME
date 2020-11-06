//
//  UserNotificationManager.swift
//  ME
//
//  Created by Veranika Razdabudzka on 11/4/20.
//

import Foundation
import UserNotifications

class UserNotificationManager: NSObject {
    
    static var shared = UserNotificationManager()
    
    let center = UNUserNotificationCenter.current()
    
    func configureNotitication() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("OK")
            }else {
                print("error")
            }
        }
        center.delegate = self
    }
    
    func localNotification(title: String, body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.year,.month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifier = "Local identifier"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}

extension UserNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.badge, .banner])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
