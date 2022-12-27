//
//  EditCategory.swift
//  RecipeApp
//
//  Created by moh on 23/12/2022.
//

import UIKit

class EditCategory: UIViewController {

    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var categoryInput: UITextField!
    var cat:Category? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryInput.text = cat?.categoryName;
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true;
    }
    @IBAction func saveChanges(_ sender: Any) {
        guard let categoryNameStr = categoryInput.text else{return}
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("categories").appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedCategories = try? Data(contentsOf: archiveURL),
              var decodedCategories = try? propertyDecoder.decode(Array<Category>.self, from: retrievedCategories)else {
               return;
        }
        for a in 0...decodedCategories.count-1{
            if(decodedCategories[a].categoryId == cat?.categoryId){
                decodedCategories[a].categoryName = categoryNameStr
            }
        }
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedCategories)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteRecipe(_ sender: Any) {
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("categories").appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedCategories = try? Data(contentsOf: archiveURL),
              var decodedCategories = try? propertyDecoder.decode(Array<Category>.self, from: retrievedCategories)else {
               return;
        }
        decodedCategories = decodedCategories.filter{
            $0.categoryId != cat?.categoryId
        }
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedCategories)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        _ = navigationController?.popViewController(animated: true)
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
