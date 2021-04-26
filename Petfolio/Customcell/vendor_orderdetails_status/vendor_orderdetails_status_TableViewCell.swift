//
//  vendor_orderdetails_status_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 22/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class vendor_orderdetails_status_TableViewCell: UITableViewCell {

    
    @IBOutlet weak var image_order: UIImageView!
    @IBOutlet weak var label_order_id: UILabel!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_AmtAndProdCount: UILabel!
    @IBOutlet weak var btn_trackorder: UIButton!
    @IBOutlet weak var label_order_status: UILabel!
    @IBOutlet weak var label_orderdatetitle: UILabel!
    @IBOutlet weak var label_order_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
