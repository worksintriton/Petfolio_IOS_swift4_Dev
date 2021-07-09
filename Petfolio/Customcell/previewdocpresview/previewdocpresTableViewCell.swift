//
//  previewdocpresTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 08/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class previewdocpresTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var labe_count: UILabel!
    @IBOutlet weak var label_consuption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
