//
//  paymentdetails_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 18/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class paymentdetails_TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var label_payment_id: UILabel!
    
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_amount: UILabel!
    @IBOutlet weak var label_date: UILabel!
    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var view_image: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
