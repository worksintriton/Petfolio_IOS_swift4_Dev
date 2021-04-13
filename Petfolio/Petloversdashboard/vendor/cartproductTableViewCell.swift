//  cartproductTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 10/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class cartproductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var img_product: UIImageView!
    @IBOutlet weak var label_product_title: UILabel!
    @IBOutlet weak var label_product_amt: UILabel!
    @IBOutlet weak var label_final_amt: UILabel!
    @IBOutlet weak var label_offer: UILabel!
    @IBOutlet weak var btn_decrement: UIButton!
    @IBOutlet weak var btn_increament: UIButton!
    @IBOutlet weak var label_product_cart_count: UILabel!
    @IBOutlet weak var view_inc: UIView!
    @IBOutlet weak var view_dec: UIView!
    @IBOutlet weak var btn_delete: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
