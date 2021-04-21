//
//  pet_dashboard_vets_CollectionViewCell.swift
//  Petfolio
//
//  Created by Admin on 21/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Cosmos

class pet_dashboard_vets_CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var view_vets: UIView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var image_vet: UIImageView!
    
    @IBOutlet weak var image_fav: UIImageView!
    @IBOutlet weak var view_pet_paw: UIView!
    
    @IBOutlet weak var label_DR: UILabel!
    @IBOutlet weak var label_clinic: UILabel!
    @IBOutlet weak var view_rating: CosmosView!
    
    
    
}
