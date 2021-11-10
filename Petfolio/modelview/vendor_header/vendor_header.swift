//
//  vendor_header.swift
//  Petfolio
//
//  Created by Admin on 20/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

@IBDesignable

class vendor_header: UIView {

    
    
    @IBOutlet weak var image_sidemenu: UIImageView!
    @IBOutlet weak var btn_sidemenu: UIButton!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var btn_profile: UIButton!
    @IBOutlet weak var image_profile: UIImageView!
    @IBOutlet weak var view_profile: UIView!
    @IBOutlet weak var view_btn_process: UIView!
    @IBOutlet weak var btn_button2: UIButton!
    @IBOutlet weak var image_button2: UIImageView!
    @IBOutlet weak var view_belcount: UIView!
    @IBOutlet weak var label_belcount: UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
   
    private func configureView() {
        if let view = self.loadNib(nibname: "vendor_header") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            self.image_sidemenu.image = UIImage(named: imagelink.sidemenu)
            self.view_belcount.isHidden = true
            self.addSubview(view)
        }
    }
    
    func checknoti(){
        self.view_belcount.isHidden = true
        self.label_belcount.text = ""
        self.view_belcount.layer.cornerRadius = self.view_belcount.frame.height / 2
        if Servicefile.shared.notifi_count > 0 {
            self.view_belcount.isHidden = false
            self.label_belcount.text = String(Servicefile.shared.notifi_count)
        }
        
    }
}

