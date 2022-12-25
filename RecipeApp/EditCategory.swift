//
//  EditCategory.swift
//  RecipeApp
//
//  Created by moh on 23/12/2022.
//

import UIKit

class EditCategory: UIViewController {

    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var categoryInput: UITextField!
    var categoryName : String = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryInput.text = categoryName;
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBAction func saveChanges(_ sender: Any) {
        
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
