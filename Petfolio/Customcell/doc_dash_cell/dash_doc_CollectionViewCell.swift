//
//  dash_doc_CollectionViewCell.swift
//  Petfolio
//
//  Created by Admin on 14/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Cosmos

class dash_doc_CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view_vets: UIView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_vet: UIImageView!
    
    @IBOutlet weak var image_fav: UIImageView!
    @IBOutlet weak var view_pet_paw: UIView!
    
    @IBOutlet weak var label_DR: UILabel!
    @IBOutlet weak var label_clinic: UILabel!
    @IBOutlet weak var view_rating: CosmosView!
    @IBOutlet weak var view_bottom_curve: UIView!
    @IBOutlet weak var image_paw: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
