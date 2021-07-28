//
//  product_fav_cell_CollectionViewCell.swift
//  Petfolio
//
//  Created by Admin on 15/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class product_fav_cell_CollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var label_prod_title: UILabel!
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var label_price: UILabel!
    @IBOutlet weak var label_orginalprice: UILabel!
    @IBOutlet weak var label_ratting: UILabel!
    @IBOutlet weak var label_likes: UILabel!
    @IBOutlet weak var image_fav: UIImageView!
    @IBOutlet weak var label_offer: UILabel!
    @IBOutlet weak var btn_menu: UIButton!
    @IBOutlet weak var btn_remove: UIButton!
    @IBOutlet weak var view_remove: UIView!
    @IBOutlet weak var view_menu: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
