//
//  order_complete_TableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 28/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class order_complete_TableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_order: UIImageView!
    @IBOutlet weak var label_orderID: UILabel!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    @IBOutlet weak var label_prod_ord_datetime: UILabel!
    @IBOutlet weak var btn_addreview: UIButton!
    @IBOutlet weak var view_addreview: UIView!
    
    @IBOutlet weak var btn_order_details: UIButton!
    @IBOutlet weak var btn_track_order: UIButton!
    @IBOutlet weak var btn_return_order: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
