//
//  service_TableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 07/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class service_TableViewCell: UITableViewCell {

    
    @IBOutlet weak var img_sp: UIImageView!
    @IBOutlet weak var label_place: UILabel!
    @IBOutlet weak var label_distance: UILabel!
    
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var label_like: UILabel!
    @IBOutlet weak var label_sp_name: UILabel!
    @IBOutlet weak var label_price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
