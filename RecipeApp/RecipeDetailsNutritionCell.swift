//
//  RecipeDetailsNutritionCell.swift
//  RecipeApp
//
//  Created by moh on 26/12/2022.
//

import UIKit

class RecipeDetailsNutritionCell: UITableViewCell {

    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var carb: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var calories: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
