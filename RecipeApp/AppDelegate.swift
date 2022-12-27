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
        
        if !signedUp(){
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            var archiveURL = documentsDirectory.appendingPathComponent("categories").appendingPathExtension("plist")
            let propertyListEncoder = PropertyListEncoder()

            var categoryArr: [Category] = [Category(categoryId: giveId(), categoryName: "Mexican"),Category(categoryId: giveId(), categoryName: "American"),Category(categoryId: giveId(), categoryName: "Pakistani"),Category(categoryId: giveId(), categoryName: "French")]
            
            let encodedCategoryData = try? propertyListEncoder.encode(categoryArr)
            try? encodedCategoryData?.write(to: archiveURL, options: .noFileProtection)
            
            archiveURL = documentsDirectory.appendingPathComponent("users").appendingPathExtension("plist")
            
            var userArr: [User] = [User(userId: giveId(), userName: "admin", userPassword: "admin", userBio: "Admin", userImage: "user.png"),User(userId: giveId(), userName: "hamood", userPassword: "123", userBio: "hamood #EZ", userImage: "user.png")];
            
            let encodedUserData = try? propertyListEncoder.encode(userArr)
            try? encodedUserData?.write(to: archiveURL, options: .noFileProtection)
        }
        
        /*
        var arr: [Category] = [Category(categoryId: giveId(), categoryName: "Mexican"),Category(categoryId: giveId(), categoryName: "American"),Category(categoryId: giveId(), categoryName: "Indian"),Category(categoryId: giveId(), categoryName: "Egyptian")]
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("categories").appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(arr)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
       */
        /*var arr: [User] = [User(userId: giveId(), userName: "admin", userPassword: "admin", userBio: "Admin", userImage: "user.png"),User(userId: giveId(), userName: "hamood", userPassword: "123", userBio: "hamood #EZ", userImage: "user.png")];
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("users").appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(arr)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        */
        return true
    }
    
    func signedUp()->Bool{
            let defaults = UserDefaults.standard
            
            if defaults.bool(forKey: "signedUp"){
                return true
            }else{
                return false
            }
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

