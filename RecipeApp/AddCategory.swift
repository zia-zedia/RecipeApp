//
//  AddCategory.swift
//  RecipeApp
//
//  Created by moh on 23/12/2022.
//

import UIKit

class AddCategory: UIViewController {
    var user:User? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBOutlet weak var categoryName: UITextField!
    @objc func imageTapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                    print("UIImageView tapped")
            }
    }
    func createCategoryFile(_ newId:String){
        guard let userId = self.user?.userId else{return}
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("Recipe_"+newId+"_"+userId).appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        let newEmptyRecipeList:[Recipe] = [];
        let encodedData = try? propertyListEncoder.encode(newEmptyRecipeList)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        guard let categoryNameStr = categoryName.text else{return}
        guard let userId = self.user?.userId else{return}
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("categories_"+userId).appendingPathExtension("plist")
        let propertyDecoder = PropertyListDecoder()
        guard let retrievedCategories = try? Data(contentsOf: archiveURL),
              var decodedCategories = try? propertyDecoder.decode(Array<Category>.self, from: retrievedCategories)else {
               return;
        }
        let newId = String(UUID().uuidString.split(separator: "-")[0])
        decodedCategories.append(Category(categoryId: newId, categoryName: categoryNameStr))
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(decodedCategories)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        _ = navigationController?.popViewController(animated: true)
        
        createCategoryFile(newId)
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
