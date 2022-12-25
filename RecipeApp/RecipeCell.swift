//
//  RecipeCell.swift
//  RecipeApp
//
//  Created by moh on 24/12/2022.
//

import UIKit

class RecipeCell: UITableViewCell {


    @IBOutlet weak var shadowBackground: UIView!
    @IBOutlet weak var nutritionInfo: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
