//
//  eduTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 21/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class eduTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label_educa: UILabel!
    
    @IBOutlet weak var label_yoc: UILabel!
    @IBOutlet weak var BTN_close: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
