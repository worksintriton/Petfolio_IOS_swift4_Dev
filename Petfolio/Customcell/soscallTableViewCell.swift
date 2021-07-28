//
//  soscallTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 27/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class soscallTableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_phone: UILabel!
    @IBOutlet weak var btn_menu: UIButton!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var view_edit: UIView!
    @IBOutlet weak var view_menu: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
