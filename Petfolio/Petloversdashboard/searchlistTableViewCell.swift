//
//  searchlistTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 14/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import SNShadowSDK

class searchlistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img_doc: UIImageView!
    @IBOutlet weak var label_docname: UILabel!
    @IBOutlet weak var label_docSubsci: UILabel!
    @IBOutlet weak var label_placeanddis: UILabel!
    @IBOutlet weak var label_likes: UILabel!
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var btn_book: UIButton!
    @IBOutlet weak var view_book: UIView!
    @IBOutlet weak var view_img_doc: SNShadowView!
    @IBOutlet weak var label_distance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
