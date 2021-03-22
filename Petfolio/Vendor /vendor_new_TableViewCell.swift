//
//  vendor_new_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 16/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class vendor_new_TableViewCell: UITableViewCell {

    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_order: UIImageView!
    @IBOutlet weak var label_orderID: UILabel!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    @IBOutlet weak var label_prod_ord_datetime: UILabel!
    @IBOutlet weak var view_update_status: UIView!
    @IBOutlet weak var btn_update_status: UIButton!
    @IBOutlet weak var btn_order_details: UIButton!
    @IBOutlet weak var btn_track_order: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
