//
//  healthissueCollectionViewCell.swift
//  Petfolio
//
//  Created by Admin on 24/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import SNShadowSDK

class healthissueCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var view_shadow: SNShadowView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_data: UIImageView!
    @IBOutlet weak var view_image: UIView!
    @IBOutlet weak var label_title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
