//
//  Doc_pres_labelTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 04/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class Doc_pres_labelTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label_medi: UILabel!
    @IBOutlet weak var label_noofdays: UILabel!
    @IBOutlet weak var label_consp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
