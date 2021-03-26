//
//  isselectionTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 26/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class isselectionTableViewCell: UITableViewCell {

    @IBOutlet weak var image_isselect: UIImageView!
    @IBOutlet weak var label_val: UILabel!
    @IBOutlet weak var btn_isselect: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
