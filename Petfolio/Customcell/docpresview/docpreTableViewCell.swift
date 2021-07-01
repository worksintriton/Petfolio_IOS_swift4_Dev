//
//  docpreTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 30/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class docpreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label_medi: UILabel!
    @IBOutlet weak var label_noofdays: UILabel!
    
    @IBOutlet weak var img_m: UIImageView!
    @IBOutlet weak var btn_m: UIButton!
    @IBOutlet weak var img_a: UIImageView!
    @IBOutlet weak var btn_a: UIButton!
    
    @IBOutlet weak var img_n: UIImageView!
    @IBOutlet weak var btn_n: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
