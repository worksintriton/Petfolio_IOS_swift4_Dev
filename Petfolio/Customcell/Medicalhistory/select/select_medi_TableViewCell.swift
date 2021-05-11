//
//  select_medi_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 11/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class select_medi_TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var image_data: UIImageView!
    @IBOutlet weak var label_doc: UILabel!
    @IBOutlet weak var label_pet: UILabel!
    @IBOutlet weak var label_dateandtime: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
