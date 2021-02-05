//
//  service_select_TableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 05/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class service_select_TableViewCell: UITableViewCell {

    @IBOutlet weak var imag_check: UIImageView!
    @IBOutlet weak var label_service: UILabel!
    @IBOutlet weak var btn_drop: UIButton!
    @IBOutlet weak var label_time: UILabel!
    @IBOutlet weak var view_time: UIView!
    @IBOutlet weak var view_amt: UIView!
    @IBOutlet weak var label_amt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
