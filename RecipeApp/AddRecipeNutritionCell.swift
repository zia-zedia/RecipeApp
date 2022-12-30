//
//  AddRecipeNutritionCell.swift
//  RecipeApp
//
//  Created by moh on 29/12/2022.
//

import UIKit

class AddRecipeNutritionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBOutlet weak var carbInput: UITextField!
    @IBOutlet weak var proteinInput: UITextField!
    @IBOutlet weak var fatsInput: UITextField!
    @IBOutlet weak var caloriesInput: UITextField!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
