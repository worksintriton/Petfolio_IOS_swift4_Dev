//
//  petowner_otherpage_header.swift
//  Petfolio
//
//  Created by Admin on 28/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

@IBDesignable
class petowner_otherpage_header: UIView {

    @IBOutlet weak var image_back: UIImageView!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var label_header_title: UILabel!
    @IBOutlet weak var image_sos: UIImageView!
    @IBOutlet weak var btn_sos: UIButton!
    @IBOutlet weak var btn_bel: UIButton!
    @IBOutlet weak var image_bel: UIImageView!
    @IBOutlet weak var btn_bag: UIButton!
    @IBOutlet weak var image_bag: UIImageView!
    @IBOutlet weak var image_profile: UIImageView!
    @IBOutlet weak var btn_profile: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
   
    private func configureView() {
        if let view = self.loadNib(nibname: "petowner_otherpage_header") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            self.image_sos.image = UIImage(named: imagelink.image_sos)
            self.image_bel.image = UIImage(named: imagelink.image_bel)
            self.image_bag.image = UIImage(named: imagelink.image_bag)
            self.image_profile.image = UIImage(named: imagelink.image_profile)
            self.image_back.image = UIImage(named: imagelink.image_back)
            self.addSubview(view)
        }
    }
}
