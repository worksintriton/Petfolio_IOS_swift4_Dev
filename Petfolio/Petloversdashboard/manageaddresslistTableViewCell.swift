//
//  manageaddresslistTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 09/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class manageaddresslistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_default: UIView!
    @IBOutlet weak var label_locationTitle: UILabel!
    @IBOutlet weak var label_username: UILabel!
    @IBOutlet weak var label_address: UILabel!
    @IBOutlet weak var view_option: UIView!
    @IBOutlet weak var btn_isshowOption: UIButton!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var img_default: UIImageView!
    @IBOutlet weak var view_main: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
