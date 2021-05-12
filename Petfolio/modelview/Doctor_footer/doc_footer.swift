//
//  doc_footer.swift
//  Petfolio
//
//  Created by Admin on 11/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

@IBDesignable
class doc_footer: UIView {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var view_subview: UIView!
    
    @IBOutlet weak var view_Fprocess_one : UIView!
    @IBOutlet weak var image_Fprocess_one : UIImageView!
    @IBOutlet weak var label_Fprocess_one : UILabel!
    @IBOutlet weak var btn_Fprocess_one : UIButton!
    
    @IBOutlet weak var view_Fprocess_two : UIView!
    @IBOutlet weak var image_Fprocess_two : UIImageView!
    @IBOutlet weak var label_Fprocess_two : UILabel!
    @IBOutlet weak var btn_Fprocess_two : UIButton!
    
    @IBOutlet weak var view_Fprocess_three : UIView!
    @IBOutlet weak var image_Fprocess_three : UIImageView!
    @IBOutlet weak var label_Fprocess_three : UILabel!
    @IBOutlet weak var btn_Fprocess_three : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
   
    private func configureView() {
        if let view = self.loadNib(nibname: "doc_footer") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            self.addSubview(view)
        }
    }
    
    
    func setup(b1: Bool, b2: Bool, b3: Bool){
        if b3 {
            self.image_Fprocess_three.image = UIImage(named: imagelink.pet_community_blue)
            self.label_Fprocess_three.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_three.image = UIImage(named: imagelink.pet_community_gray)
            self.label_Fprocess_three.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b1 {
            self.image_Fprocess_one.image = UIImage(named: imagelink.home_blue)
            self.label_Fprocess_one.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_one.image = UIImage(named: imagelink.Home_gray)
            self.label_Fprocess_one.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
       
        if b2 {
            self.image_Fprocess_two.image = UIImage(named: imagelink.shop_blue)
            self.label_Fprocess_two.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_two.image = UIImage(named: imagelink.shop_gray)
            self.label_Fprocess_two.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        self.label_Fprocess_one.text = "Home" // 1
        self.label_Fprocess_two.text = "Shop" // 2
        self.label_Fprocess_three.text = "Community" // 3
    }

}
