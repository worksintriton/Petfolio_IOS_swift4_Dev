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
import IQKeyboardManagerSwift

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    // old AIzaSyCX3487yLNeuS5v3mtf4J95ervrmSo7MRc
    // old AIzaSyBq6YK_r9XNtKCycLN0cS3kGdzAYdTcFqQ up to 2021
    // old AIzaSyAlvAK3lZepIaApTDbDZUNfO0dBmuP6h4A
let googleApiKey = "AIzaSyDap8qav1flUsql0VWUYkjgB0noN0o_U1Y"
var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //UIApplication.shared.statusBarView?.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        IQKeyboardManager.shared.enable = true
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
        if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { requests in
                    for request in requests {
                        Servicefile.shared.setNotification(userInfo: request.request.content.userInfo as NSDictionary)
                    }
                })
            }
            return true
        }
          
        // MARK: UISceneSession Lifecycle
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
          print("Firebase registration token: \(fcmToken)")
            Servicefile.shared.FCMtoken = fcmToken
          let dataDict:[String: String] = ["token": fcmToken]
          NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
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
    
    

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
                // Servicefile.shared.setNotification(userInfo: userInfo as NSDictionary)
                print("data from the notification",userInfo)
                let data = userInfo as NSDictionary
                let usertype = data["usertype"] as? String ?? "0"
                let appintments = data["appintments"] as? String ?? ""
                let orders = data["orders"] as? String ?? ""
                if  UserDefaults.standard.string(forKey: "usertype") != nil {
                    if  UserDefaults.standard.string(forKey: "usertype") != "" {
                        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
                        Servicefile.shared.first_name = UserDefaults.standard.string(forKey: "first_name")!
                        Servicefile.shared.last_name = UserDefaults.standard.string(forKey: "last_name")!
                        Servicefile.shared.user_email = UserDefaults.standard.string(forKey: "user_email")!
                        Servicefile.shared.user_phone = UserDefaults.standard.string(forKey: "user_phone")!
                        Servicefile.shared.userimage = UserDefaults.standard.string(forKey: "user_image")!
                        if UserDefaults.standard.string(forKey: "my_ref_code") != nil {
                            if  UserDefaults.standard.string(forKey: "my_ref_code") != "" {
                            Servicefile.shared.my_ref_code = UserDefaults.standard.string(forKey: "my_ref_code")!
                            }else{
                                Servicefile.shared.my_ref_code = ""
                            }
                        }else{
                            Servicefile.shared.my_ref_code = ""
                        }
                        print("user type ",Servicefile.shared.user_type,"user id",Servicefile.shared.userid)
                        if Servicefile.shared.user_type == "1" && usertype == "1"{
                            if appintments != "" {
                                Servicefile.shared.appointtype = appintments
                                print("i am in appointment page pet lover",appintments)
                                let vc = UIStoryboard.Pet_applist_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else if orders != "" {
                                print("i am in order page ")
                                let vc = UIStoryboard.Petlover_myorder_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else {
                                let tapbar = UIStoryboard.petloverDashboardViewController()
                                let navigationController = UINavigationController.init(rootViewController: tapbar)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }
                            
                        } else if Servicefile.shared.user_type == "4" && usertype == "4" {
                            if appintments != "" {
                                print("i am in appointment page doctor",appintments)
                                let vc = UIStoryboard.DocdashboardViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else if orders != "" {
                                print("i am in order page ",usertype)
                                let vc = UIStoryboard.doc_myorderdetails_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else {
                                let vc = UIStoryboard.DocdashboardViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }
                        } else if Servicefile.shared.user_type == "2" && usertype == "2" {
                            if appintments != "" {
                                print("i am in appointment page Service provider",appintments)
                                let vc = UIStoryboard.Sp_dash_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else if orders != "" {
                                print("i am in order page ",usertype)
                                let vc = UIStoryboard.sp_myorder_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else {
                                let vc = UIStoryboard.Sp_dash_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }
                        } else if Servicefile.shared.user_type == "3" && usertype == "3"{
                            if appintments != "" {
                                print("i am in appointment page Vendor",appintments)
                                let vc = UIStoryboard.vendor_myorder_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else if orders != "" {
                                print("i am in order page ",usertype)
                                let vc = UIStoryboard.vendor_myorder_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else {
                                let vc = UIStoryboard.vendor_myorder_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }
                        } else {
//                            let vc = UIStoryboard.LoginViewController()
//                            let navigationController = UINavigationController.init(rootViewController: vc)
//                            self.window?.rootViewController = navigationController
//                            self.window?.makeKeyAndVisible()
                        }
                    }else{
                        let vc = UIStoryboard.LoginViewController()
                        let navigationController = UINavigationController.init(rootViewController: vc)
                        self.window?.rootViewController = navigationController
                        self.window?.makeKeyAndVisible()
                    }
                }
            }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let state = UIApplication.shared.applicationState
        if state == .active {
            print("user active",state)
        }else if state == .inactive {
            print("user inactive",state)
        }else if state == .background {
            print("user background",state)
        }else{
            print("user state",state)
        }
        
        print("data from the notification",userInfo)
        if state == .inactive {
                Servicefile.shared.setNotification(userInfo: userInfo as NSDictionary)
            print("data from the notification",userInfo)
            let data = userInfo as NSDictionary
            let usertype = data["usertype"] as? String ?? "0"
            let appintments = data["appintments"] as? String ?? ""
            let orders = data["orders"] as? String ?? ""
            if  UserDefaults.standard.string(forKey: "usertype") != nil {
                if  UserDefaults.standard.string(forKey: "usertype") != "" {
                    Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                    Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
                    Servicefile.shared.first_name = UserDefaults.standard.string(forKey: "first_name")!
                    Servicefile.shared.last_name = UserDefaults.standard.string(forKey: "last_name")!
                    Servicefile.shared.user_email = UserDefaults.standard.string(forKey: "user_email")!
                    Servicefile.shared.user_phone = UserDefaults.standard.string(forKey: "user_phone")!
                    Servicefile.shared.userimage = UserDefaults.standard.string(forKey: "user_image")!
                    if UserDefaults.standard.string(forKey: "my_ref_code") != nil {
                        if  UserDefaults.standard.string(forKey: "my_ref_code") != "" {
                        Servicefile.shared.my_ref_code = UserDefaults.standard.string(forKey: "my_ref_code")!
                        }else{
                            Servicefile.shared.my_ref_code = ""
                        }
                    }else{
                        Servicefile.shared.my_ref_code = ""
                    }
                    print("user type ",Servicefile.shared.user_type,"user id",Servicefile.shared.userid)
                    if Servicefile.shared.user_type == "1" && usertype == "1"{
                        if appintments != "" {
                            print("i am in appointment page ",appintments)
                            if appintments != "Walkin" {
                                Servicefile.shared.appointtype = appintments
                                let vc = UIStoryboard.Pet_applist_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else{
                                Servicefile.shared.appointtype = "New"
                                let vc = UIStoryboard.pet_app_walkin_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }
                        }else if orders != "" {
                            print("i am in order page ")
                            Servicefile.shared.ordertype = orders
                            let vc = UIStoryboard.Petlover_myorder_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }else {
                            let tapbar = UIStoryboard.petloverDashboardViewController()
                            let navigationController = UINavigationController.init(rootViewController: tapbar)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }
                        
                    } else if Servicefile.shared.user_type == "4" && usertype == "4" {
                        if appintments != "" {
                            print("i am in appointment page ",usertype)
                            
                            if appintments != "Walkin" {
                                Servicefile.shared.appointtype = appintments
                                let vc = UIStoryboard.DocdashboardViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }else{
                                Servicefile.shared.appointtype = "New"
                                let vc = UIStoryboard.doc_app_walkin_ViewController()
                                let navigationController = UINavigationController.init(rootViewController: vc)
                                self.window?.rootViewController = navigationController
                                self.window?.makeKeyAndVisible()
                            }
                        }else if orders != "" {
                            print("i am in order page ",usertype)
                            Servicefile.shared.ordertype = orders
                            let vc = UIStoryboard.doc_myorderdetails_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }else {
                            let vc = UIStoryboard.DocdashboardViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }
                    } else if Servicefile.shared.user_type == "2" && usertype == "2" {
                        if appintments != "" {
                            Servicefile.shared.appointtype = appintments
                            print("i am in appointment page ",usertype)
                            let vc = UIStoryboard.Sp_dash_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }else if orders != "" {
                            print("i am in order page ",usertype)
                            Servicefile.shared.ordertype = orders
                            let vc = UIStoryboard.sp_myorder_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }else {
                            let vc = UIStoryboard.Sp_dash_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }
                    } else if Servicefile.shared.user_type == "3" && usertype == "3"{
                        if appintments != "" {
                            print("i am in appointment page ",usertype)
                            let vc = UIStoryboard.vendor_myorder_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }else if orders != "" {
                            print("i am in order page ",usertype)
                            Servicefile.shared.ordertype = orders
                            let vc = UIStoryboard.vendor_myorder_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }else {
                            let vc = UIStoryboard.vendor_myorder_ViewController()
                            let navigationController = UINavigationController.init(rootViewController: vc)
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                        }
                    } else {
//                            let vc = UIStoryboard.LoginViewController()
//                            let navigationController = UINavigationController.init(rootViewController: vc)
//                            self.window?.rootViewController = navigationController
//                            self.window?.makeKeyAndVisible()
                    }
                }else{
                    let vc = UIStoryboard.LoginViewController()
                    let navigationController = UINavigationController.init(rootViewController: vc)
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                }
            }
        }else{
            
        }
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

extension UIApplication {
//    var statusBarView: UIView? {
//        return value(forKey: "statusBar") as? UIView
//    }
    //UIApplication.shared.statusBarView?.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
    var statusBarView: UIView? {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
            return nil
        }
}

