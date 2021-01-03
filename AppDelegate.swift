//
//  AppDelegate.swift
//  SqueakyClean
//
//  Created by Preksha on 7/20/20.
//  Copyright © 2020 Preksha Munot. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation
import UserNotifications
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    var locationManager: CLLocationManager!
    var notificationCenter: UNUserNotificationCenter!
    var usersettings: UserSettings?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
        if status{
            UserDefaults.standard.set(true, forKey: "status")
        }
        GMSPlacesClient.provideAPIKey("AIzaSyBudvy8V1_F930V2URmUeBJUA1B9Nslq8g")
        
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        
        self.notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Permission not granted")
            }
        }
        
        if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
            print("Permission granted!")
        }
        return true
    }
    
    func handleEvent(forRegion region: CLRegion!) {
        // customize your notification content
        self.usersettings?.userIsHome = true
        let content = UNMutableNotificationContent()
        content.title = "Wash your hands!"
        content.body = "Welcome back home! Don't forget to wash your hands!"
        content.sound = UNNotificationSound.default
        
        // when the notification will be triggered
        let timeInSeconds: TimeInterval = 3
        // the actual trigger object
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: timeInSeconds,
            repeats: false
        )
        
        // notification unique identifier, for this example, same as the region to avoid duplicate notifications
        let identifier = region.identifier
        
        // the notification request object
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        // trying to add the notification request to notification center
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(identifier)")
            }
        })
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            // Do what you want if this information
            self.handleEvent(forRegion: region)
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // when app is onpen and in foregroud
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // get the notification identifier to respond accordingly
        let identifier = response.notification.request.identifier
        
        // do what you need to do
        print(identifier)
        // ...
    }
}
