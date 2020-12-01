//
//  Mycal_edit_availdayTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 24/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class Mycal_edit_availdayTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img_check: UIImageView!
    @IBOutlet weak var label_weekday: UILabel!
    @IBOutlet weak var view_edit: UIView!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_availcheck: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
