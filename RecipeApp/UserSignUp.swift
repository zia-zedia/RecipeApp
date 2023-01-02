//
//  UserSignUp.swift
//  RecipeApp
//
//  Created by moh on 27/12/2022.
//

import UIKit

class UserSignUp: UIViewController {
    

    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func makeCategoryContent(_ user:User, _ categoryId:String){
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var archiveURL = documentDirectory.appendingPathComponent("Recipe_"+categoryId).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedRecipes = try? Data(contentsOf: archiveURL),
              let decodedRecipes = try? propertyDecoder.decode(Array<Recipe>.self, from: retrievedRecipes)else {
               return;
        }
        
        archiveURL = documentDirectory.appendingPathComponent("Recipe_"+categoryId+"_"+user.userId).appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedRecipes)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        _ = navigationController?.popViewController(animated: true)
    }
    
    func makeCategories(_ user:User){
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var archiveURL = documentDirectory.appendingPathComponent("categories").appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedCategories = try? Data(contentsOf: archiveURL),
              let decodedCategories = try? propertyDecoder.decode(Array<Category>.self, from: retrievedCategories)else {
               return;
        }
        for cat in decodedCategories{
            makeCategoryContent(user,cat.categoryId)
        }
        archiveURL = documentDirectory.appendingPathComponent("categories_"+user.userId).appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedCategories)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        _ = navigationController?.popViewController(animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserSignUp" {
            guard let userNameStr = userNameInput.text else{return}
            guard let passwordStr = passwordInput.text else{return}
            if(userNameStr.count <= 3){
                let alert = UIAlertController(title: "Error", message: "Username Too Short", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return;
            }
            
            if(passwordStr.count < 8){
                let alert = UIAlertController(title: "Error", message: "Password must be at least 8 characters long", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return;
            }
            
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentDirectory.appendingPathComponent("users").appendingPathExtension("plist")
            let propertyDecoder = PropertyListDecoder()
            guard let retrievedUsers = try? Data(contentsOf: archiveURL),
                  var decodedUsers = try? propertyDecoder.decode(Array<User>.self, from: retrievedUsers)else {
                   return;
            }
            
            let newId = String(UUID().uuidString.split(separator: "-")[0])
            let user:User = User(userId: newId, userName: userNameStr, userPassword: passwordStr, userBio: "", userImage: "user.png")
            decodedUsers.append(user)
            
            let propertyListEncoder = PropertyListEncoder()
            let encodedData = try? propertyListEncoder.encode(decodedUsers)
            try? encodedData?.write(to: archiveURL, options: .noFileProtection)
            
            makeCategories(user)
            UserDefaults.standard.set(true, forKey: "signedUp")
            if let destinationVC = segue.destination as? RecipeAppTab {
                
                destinationVC.user = user
                
            }
            
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
