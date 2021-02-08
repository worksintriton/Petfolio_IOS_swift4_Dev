//
//  notification_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 08/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class notification_TableViewCell: UITableViewCell {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_noti: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
