//
//  RecipeAppNav.swift
//  RecipeApp
//
//  Created by moh on 28/12/2022.
//

import UIKit

class RecipeAppNav: UINavigationController {

    var user : User? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nextVC = self.viewControllers.first as? HomePageTableViewController else{return}
        
        nextVC.user = user;
        // Do any additional setup after loading the view.
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
