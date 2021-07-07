//
//  petowner_header.swift
//  Petfolio
//
//  Created by Admin on 19/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

@IBDesignable
class petowner_header: UIView {
    
    
    @IBOutlet weak var image_sidemenu: UIImageView!
    @IBOutlet weak var btn_sidemenu: UIButton!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var image_drop_down: UIImageView!
    @IBOutlet weak var btn_profile: UIButton!
    @IBOutlet weak var image_profile: UIImageView!
    @IBOutlet weak var view_profile: UIView!
    @IBOutlet weak var btn_location: UIButton!
    @IBOutlet weak var view_location: UIView!
    @IBOutlet weak var view_btn_process: UIView!
    @IBOutlet weak var btn_button2: UIButton!
    @IBOutlet weak var image_button2: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
   
    private func configureView() {
        if let view = self.loadNib(nibname: "petowner_header") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            self.image_sidemenu.image = UIImage(named: imagelink.sidemenu)
            self.image_drop_down.image = UIImage(named: imagelink.Drop_down)
            //self.view_profile.layer.cornerRadius = self.view_profile.frame.height / 2
            self.view_location.layer.cornerRadius = self.view_location.frame.height / 2
            self.addSubview(view)
        }
    }
}

