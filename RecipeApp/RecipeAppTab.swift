//
//  RecipeAppTab.swift
//  RecipeApp
//
//  Created by moh on 28/12/2022.
//

import UIKit

class RecipeAppTab: UITabBarController {
    
    var user : User? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let nextVC = self.viewControllers?[0] as? RecipeAppNav else{return}
        nextVC.user = user;
        
        guard let nextVC2 = self.viewControllers?[1] as? AddRecipe else{return}
        nextVC2.user = user;
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
