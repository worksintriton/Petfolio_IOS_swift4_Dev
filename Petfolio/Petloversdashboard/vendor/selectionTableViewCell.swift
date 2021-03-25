//
//  selectionTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 23/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class selectionTableViewCell: UITableViewCell {

    @IBOutlet weak var image_isselect: UIImageView!
    @IBOutlet weak var label_title: UILabel!
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
