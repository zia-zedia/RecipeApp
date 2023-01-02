//
//  EditSettings.swift
//  RecipeApp
//
//  Created by moh on 02/01/2023.
//

import UIKit

class EditSettings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.changeTitle()
    }
    
    @IBOutlet weak var nutritionSettingBtn: UIButton!
    func changeTitle(){
        let sortMode = UserDefaults.standard.string(forKey:"sortMode")
        if(sortMode == "cal"){
            nutritionSettingBtn.setTitle("Calories", for: .normal)
        }else if(sortMode == "fat"){
            nutritionSettingBtn.setTitle("Fats", for: .normal)
        }else if(sortMode == "pro"){
            nutritionSettingBtn.setTitle("Protein", for: .normal)
        }else if(sortMode == "carb"){
            nutritionSettingBtn.setTitle("Carbohydrates", for: .normal)
        }
    }
    @IBAction func changeNutrition(_ sender: Any) {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.addAction(
            .init(title: "Calories", style: .default) { _ in
                UserDefaults.standard.set("cal", forKey: "sortMode")
                self.changeTitle()
            }
        )
        alert.addAction(
            .init(title: "Carbohydrates", style: .default) { _ in
                UserDefaults.standard.set("carb", forKey: "sortMode")
                self.changeTitle()
            }
        )
        alert.addAction(
            .init(title: "Protein", style: .default) { _ in
                UserDefaults.standard.set("pro", forKey: "sortMode")
                self.changeTitle()
            }
        )
        alert.addAction(
            .init(title: "Fats", style: .default) { _ in
                UserDefaults.standard.set("fat", forKey: "sortMode")
                self.changeTitle()
            }
        )
        
        present(alert, animated: true)
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
