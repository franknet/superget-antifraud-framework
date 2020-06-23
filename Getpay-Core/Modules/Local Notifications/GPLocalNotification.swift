//
//  GPLOcalPushNotification.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 18/06/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation
import UserNotifications

// MARK: - Protocol
/// Define the content to be show in a `GPLocalNotification`.
/// - If you want to show images, we must implement the attachments.
/// - If we want custom action in notification, we must implement a custom
/// category to notification and handle it inside AppDelegate
public protocol LocalNotificationModel {
    
    var title: String { get }
    var subtitle: String { get }
    var body: String { get }
    
    /// When in doubt use `UNNotificationSound.default`
    var sound: UNNotificationSound { get }
    
    /// When in doubt, sample usage in discussion.
    ///```
    ///UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    ///```
    var trigger: UNTimeIntervalNotificationTrigger { get }
    
}

// MARK: - Class
public class GPLocalNotification: NSObject {
        
    // MARK: - Initializers
    private override init() {}
    
    // MARK: - Public Methods
    /// Fire the local app notification
    public static func fireNotification(withModel model: LocalNotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = model.title
        content.subtitle = model.subtitle
        content.body = model.body
        content.sound = model.sound
        // random identifier
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: model.trigger
        )

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    // MARK: - Public Static Methods
    /// Used to register app for local notifications
    public static func registerForLocalNotifications(withDelegate delegate: UNUserNotificationCenterDelegate) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                debugPrint("Local notifications set!")
                UNUserNotificationCenter.current().delegate = delegate
            } else if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}
