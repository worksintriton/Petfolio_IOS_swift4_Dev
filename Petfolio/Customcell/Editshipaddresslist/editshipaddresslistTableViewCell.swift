//
//  editshipaddresslistTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 03/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class editshipaddresslistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var image_isselect: UIImageView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_mobileno: UILabel!
    @IBOutlet weak var label_addressline1: UILabel!
    @IBOutlet weak var label_addressline2: UILabel!
    @IBOutlet weak var label_addressline3: UILabel!
    
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var btn_isselect: UIButton!
    
    @IBOutlet weak var label_add_type: UILabel!
    @IBOutlet weak var view_add_type: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

