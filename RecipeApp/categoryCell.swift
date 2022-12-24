//
//  categoryCell.swift
//  RecipeApp
//
//  Created by moh on 23/12/2022.
//

import UIKit

class categoryCell: UITableViewCell {

    
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet var categoryBackground: UIView!
    @IBOutlet var editBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
