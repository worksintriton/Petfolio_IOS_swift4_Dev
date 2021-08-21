//
//  App_couponTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 20/08/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class App_couponTableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_sub_title: UILabel!
    @IBOutlet weak var label_ref: UILabel!
    @IBOutlet weak var image_img_data: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
