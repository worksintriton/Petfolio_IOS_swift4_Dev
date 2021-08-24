//
//  mycouponlistTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 21/08/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class mycouponlistTableViewCell: UITableViewCell {

    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_sub_title: UILabel!
    @IBOutlet weak var label_ref: UILabel!
    @IBOutlet weak var image_img_data: UIImageView!
    @IBOutlet weak var label_expiry_date: UILabel!
    @IBOutlet weak var btn_copy_coupon: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
