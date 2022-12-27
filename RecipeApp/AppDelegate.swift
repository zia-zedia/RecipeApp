//
//  AppDelegate.swift
//  RecipeApp
//
//  Created by moh on 22/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        func giveId() -> String {
            return String(UUID().uuidString.split(separator: "-")[0])
        }
        /*
        var arr: [Category] = [Category(categoryId: giveId(), categoryName: "Mexican"),Category(categoryId: giveId(), categoryName: "American"),Category(categoryId: giveId(), categoryName: "Indian"),Category(categoryId: giveId(), categoryName: "Egyptian")]
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("categories").appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(arr)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
       */
        
        return true
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

