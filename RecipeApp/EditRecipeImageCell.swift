//
//  EditRecipeImageCell.swift
//  RecipeApp
//
//  Created by moh on 29/12/2022.
//

import UIKit

class EditRecipeImageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
