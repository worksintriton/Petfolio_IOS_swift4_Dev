//
//  sosTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 14/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class sosTableViewCell: UITableViewCell {

    @IBOutlet weak var label_contact: UILabel!
    @IBOutlet weak var label_phno: UILabel!
    @IBOutlet weak var view_sos: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
