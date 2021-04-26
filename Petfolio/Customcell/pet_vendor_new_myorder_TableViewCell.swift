//
//  pet_vendor_new_myorder_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 26/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class pet_vendor_new_myorder_TableViewCell: UITableViewCell {

    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_order: UIImageView!
    @IBOutlet weak var label_orderID: UILabel!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    @IBOutlet weak var label_prod_ord_datetime: UILabel!
    @IBOutlet weak var label_prod_date_title: UILabel!
    @IBOutlet weak var btn_order_details: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
