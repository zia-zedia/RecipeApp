//
//  UserLogin.swift
//  RecipeApp
//
//  Created by moh on 27/12/2022.
//

import UIKit

class UserLogin: UIViewController {
    var user:User? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserLogin" {
            
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentDirectory.appendingPathComponent("users").appendingPathExtension("plist")
            let propertyDecoder = PropertyListDecoder()
            guard let retrievedUsers = try? Data(contentsOf: archiveURL),
                  let decodedUsers = try? propertyDecoder.decode(Array<User>.self, from: retrievedUsers)else {
                   return;
            }
            var userNameFound = false;
            for decodedUser in decodedUsers{
                if(decodedUser.userName == userNameInput.text){
                    userNameFound = true;
                    if(decodedUser.userPassword == passwordInput.text){
                        self.user = decodedUser;
                    }else{
                        let alert = UIAlertController(title: "Error", message: "Wrong Password", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return;
                    }
                        
                    
                }
            }
            if(!userNameFound){
                let alert = UIAlertController(title: "Error", message: "User not Found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return;
            }
            if let destinationVC = segue.destination as? HomePageTableViewController {
                
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
