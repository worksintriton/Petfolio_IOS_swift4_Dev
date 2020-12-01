//
//  docdashTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 01/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class docdashTableViewCell: UITableViewCell {

    
    @IBOutlet weak var View_mainview: UIView!
    @IBOutlet weak var img_petimg: UIImageView!
    @IBOutlet weak var label_petname: UILabel!
    @IBOutlet weak var label_pettype: UILabel!
    @IBOutlet weak var label_servicename: UILabel!
    @IBOutlet weak var label_servicecost: UILabel!
    @IBOutlet weak var view_completebtn: UIView!
    @IBOutlet weak var btn_complete: UIButton!
    @IBOutlet weak var view_cancnel: UIView!
    @IBOutlet weak var btn_cancel: UIButton!
    @IBOutlet weak var label_completedon: UILabel!
    @IBOutlet weak var labe_comMissed: UILabel!
    @IBOutlet weak var view_commissed: UIView!
    @IBOutlet weak var label_amount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
