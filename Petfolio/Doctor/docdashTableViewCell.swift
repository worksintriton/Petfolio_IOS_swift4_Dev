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
    @IBOutlet weak var image_emergnecy: UIImageView!
    @IBOutlet weak var view_pres: UIView!
    @IBOutlet weak var btn_pres: UIButton!
    @IBOutlet weak var view_addview: UIView!
    @IBOutlet weak var btn_addreview: UIButton!
    @IBOutlet weak var view_online: UIView!
    @IBOutlet weak var btn_online: UIButton!
    @IBOutlet weak var label_status: UILabel!
    @IBOutlet weak var label_status_val: UILabel!
    @IBOutlet weak var label_type_pet: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
