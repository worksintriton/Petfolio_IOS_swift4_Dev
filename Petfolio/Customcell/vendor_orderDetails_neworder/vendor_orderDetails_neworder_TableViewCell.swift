//
//  vendor_orderDetails_neworder_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 22/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class vendor_orderDetails_neworder_TableViewCell: UITableViewCell {

    @IBOutlet weak var image_order: UIImageView!
    @IBOutlet weak var label_order_id: UILabel!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_AmtAndProdCount: UILabel!
    @IBOutlet weak var btn_trackorder: UIButton!
    @IBOutlet weak var image_ischeck_dispatch: UIImageView!
    @IBOutlet weak var label_dispatch: UILabel!
    @IBOutlet weak var btn_dispatch: UIButton!
    @IBOutlet weak var image_ischeck_reject: UIImageView!
    @IBOutlet weak var label_reject: UILabel!
    @IBOutlet weak var btn_reject: UIButton!
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