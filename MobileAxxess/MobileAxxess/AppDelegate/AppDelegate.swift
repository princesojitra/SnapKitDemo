//
//  AppDelegate.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 01/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // set window of the application
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initliaze core data persistantstore
        CoreDataContext.loadStores()
        
        // change navigation bar color
        UINavigationBar.appearance().tintColor = AppColor.Color_NavyBlue
        UINavigationBar.appearance().barTintColor = AppColor.Color_NavyBlue
    
        // change navigation item title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        // set rortview controller
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: SwiftArticlesVC())
        
        return true
    }
    
}


