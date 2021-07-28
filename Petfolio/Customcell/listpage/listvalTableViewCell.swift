//
//  listvalTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 16/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class listvalTableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_data: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_sub_title: UILabel!
    @IBOutlet weak var label_km: UILabel!
    @IBOutlet weak var label_rate: UILabel!
    @IBOutlet weak var label_amt: UILabel!
    @IBOutlet weak var label_details: UILabel!
    @IBOutlet weak var label_loc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
