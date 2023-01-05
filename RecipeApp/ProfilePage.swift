//
//  ProfilePage.swift
//  RecipeApp
//
//  Created by moh on 02/01/2023.
//

import UIKit

class ProfilePage: UIViewController, UITextViewDelegate {
    var user:User? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        username.text = user!.userName
        bioInput.text = user!.userBio
        bioInput.delegate = self;


    }
    func textViewDidChange(_ textView: UITextView) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("users").appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedUsers = try? Data(contentsOf: archiveURL),
              var decodedUsers = try? propertyDecoder.decode(Array<User>.self, from: retrievedUsers)else {
               return;
        }
        for a in 0...decodedUsers.count-1{
            if decodedUsers[a].userId == user?.userId{
                decodedUsers[a].userBio = bioInput.text!;
            }
        }
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedUsers)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
   
    }
    
    @IBOutlet weak var bioInput: UITextView!
    
    @IBOutlet weak var username: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
