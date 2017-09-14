//
//  AppDelegate.swift
//  Homeowner
//
//  Created by Mimi Chenyao on 9/12/17.
//  Copyright © 2017 Mimi Chenyao. All rights reserved.
//

import UIKit

@UIApplicationMain

/// Delegate for entire app
/// Only interested in application lifecyle callbacks

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let itemStore = ItemStore()

    /// Called when application first enters active state
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let imageStore = ImageStore()
        
        // Access the ItemsViewController and set its item store
        let navController = window!.rootViewController as! UINavigationController
        let itemsController = navController.topViewController as! ItemsViewController
        itemsController.itemStore = itemStore
        itemsController.imageStore = imageStore
        
        return true
    }

    /// Called when app is in inactive state
    // Ex: Temporarily interrupted by a notification, alert, lock screen button pushed
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    /// Called when user presses Home button/switches to another app
    // Saves state to file "items.archive" in app's sandbox
    func applicationDidEnterBackground(_ application: UIApplication) {
        let success = itemStore.saveChanges()
        
        if (success) {
            print("Saved all of the Items")
        } else {
            print("Could not sae any of the items")
        }
    }

    /// Called when app is "thawed" from suspended state
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    /// Called when application first enters active state
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    /// Called when OS is about to terminate app completely
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

