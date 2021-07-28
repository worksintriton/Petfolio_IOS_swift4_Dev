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
    
    
    @IBOutlet weak var view_belcount: UIView!
    @IBOutlet weak var label_belcount: UILabel!
    
    @IBOutlet weak var view_cartcount: UIView!
    @IBOutlet weak var label_cartcount: UILabel!
    
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
            self.checknoti()
            self.addSubview(view)
        }
    }
    
    func checknoti(){
        self.view_belcount.isHidden = true
        self.view_cartcount.isHidden = true
        self.view_belcount.layer.cornerRadius = self.view_belcount.frame.height / 2
        self.view_cartcount.layer.cornerRadius = self.view_cartcount.frame.height / 2
        if Servicefile.shared.notifi_count > 0 {
            self.view_belcount.isHidden = false
            self.label_belcount.text = String(Servicefile.shared.notifi_count)
        }
        if Servicefile.shared.cart_count > 0 {
            self.view_cartcount.isHidden = false
            self.label_cartcount.text = String(Servicefile.shared.cart_count)
        }
    }
}

