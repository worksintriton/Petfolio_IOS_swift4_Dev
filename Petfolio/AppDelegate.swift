//
//  AppDelegate.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
let googleApiKey = "AIzaSyCX3487yLNeuS5v3mtf4J95ervrmSo7MRc"
var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       GMSServices.provideAPIKey(googleApiKey)
            FirebaseApp.configure()
            do {
                       try Network.reachability = Reachability(hostname: "www.google.com")
                   }
                   catch {
                       switch error as? Network.Error {
                       case let .failedToCreateWith(hostname)?:
                           print("Network error:\nFailed to create reachability object With host named:", hostname)
                       case let .failedToInitializeWith(address)?:
                           print("Network error:\nFailed to initialize reachability object With address:", address)
                       case .failedToSetCallout?:
                           print("Network error:\nFailed to set callout")
                       case .failedToSetDispatchQueue?:
                           print("Network error:\nFailed to set DispatchQueue")
                       case .none:
                           print(error)
                         print("Network error:\nFailed to set DispatchQueue")
                       }
                   }
            if #available(iOS 10.0, *) {
              // For iOS 10 display notification (sent via APNS)
              UNUserNotificationCenter.current().delegate = self

              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            } else {
              let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
            }

            application.registerForRemoteNotifications()
            Messaging.messaging().delegate = self
           
            return true
        }
        // MARK: UISceneSession Lifecycle
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
          print("Firebase registration token: \(fcmToken)")

          let dataDict:[String: String] = ["token": fcmToken]
          NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
          // TODO: If necessary send token to application server.
          // Note: This callback is fired at each app startup and whenever a new token is generated.
        }
        
        @available(iOS 13.0, *)
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }

        @available(iOS 13.0, *)
        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
            // Called when the user discards a scene session.
            // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
            // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        }

        func application(application: UIApplication,
                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
            Messaging.messaging().apnsToken = deviceToken as Data
        }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Petfolio")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

