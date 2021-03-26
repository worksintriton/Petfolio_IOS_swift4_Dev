//
//  manageproduct_withval_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 24/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class manageproduct_withval_TableViewCell: UITableViewCell {

    @IBOutlet weak var image_ischeck: UIImageView!
    @IBOutlet weak var btn_ischeck: UIButton!
    @IBOutlet weak var btn_side_menu: UIButton!
    @IBOutlet weak var btn_hide: UIButton!
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_amt: UILabel!
    @IBOutlet weak var label_pettype: UILabel!
    @IBOutlet weak var label_age: UILabel!
    @IBOutlet weak var label_breed: UILabel!
    @IBOutlet weak var label_threshold: UILabel!
    @IBOutlet weak var label_deal_status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
