//
//  order_curretn_TableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 28/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class order_curretn_TableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_order: UIImageView!
    @IBOutlet weak var label_orderID: UILabel!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    @IBOutlet weak var label_prod_ord_datetime: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
