//
//  mangeproduct_withoutvalTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 24/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class mangeproduct_withoutvalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var image_ischeck: UIImageView!
    @IBOutlet weak var btn_ischeck: UIButton!
    @IBOutlet weak var btn_side_menu: UIButton!
    @IBOutlet weak var btn_hide: UIButton!
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_amt: UILabel!
    @IBOutlet weak var label_deal_status: UILabel!
    @IBOutlet weak var view_menu: UIView!
    @IBOutlet weak var view_edit: UIView!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_clear_deals: UIButton!
    @IBOutlet weak var view_clear_deals: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
