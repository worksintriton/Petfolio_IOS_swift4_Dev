//
//  petowner_footerview.swift
//  Petfolio
//
//  Created by Admin on 08/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

@IBDesignable
class petowner_footerview: UIView {
    
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
    
    @IBOutlet weak var view_Fprocess_four : UIView!
    @IBOutlet weak var image_Fprocess_four : UIImageView!
    @IBOutlet weak var label_Fprocess_four : UILabel!
    @IBOutlet weak var btn_Fprocess_four : UIButton!
    
    @IBOutlet weak var view_Fprocess_five : UIView!
    @IBOutlet weak var image_Fprocess_five : UIImageView!
    @IBOutlet weak var label_Fprocess_five : UILabel!
    @IBOutlet weak var btn_Fprocess_five : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
   
    private func configureView() {
        if let view = self.loadNib(nibname: "petowner_footerview") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            self.addSubview(view)
        }
    }
    
    
    func setup(b1: Bool, b2: Bool, b3: Bool, b4: Bool, b5: Bool){
        if b3 {
            self.image_Fprocess_three.image = UIImage(named: imagelink.home_blue)
            self.label_Fprocess_three.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_three.image = UIImage(named: imagelink.Home_gray)
            self.label_Fprocess_three.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b1 {
            self.image_Fprocess_one.image = UIImage(named: imagelink.petcare_blue)
            self.label_Fprocess_one.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_one.image = UIImage(named: imagelink.petcare_gray)
            self.label_Fprocess_one.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b5 {
            self.image_Fprocess_five.image = UIImage(named: imagelink.pet_community_blue)
            self.label_Fprocess_five.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_five.image = UIImage(named: imagelink.pet_community_gray)
            self.label_Fprocess_five.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b2 {
            self.image_Fprocess_two.image = UIImage(named: imagelink.pet_service_blue)
            self.label_Fprocess_two.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_two.image = UIImage(named: imagelink.pet_service_gray)
            self.label_Fprocess_two.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b4 {
            self.image_Fprocess_four.image = UIImage(named: imagelink.shop_blue)
            self.label_Fprocess_four.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_blue)
        }else{
            self.image_Fprocess_four.image = UIImage(named: imagelink.shop_gray)
            self.label_Fprocess_four.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        
        self.label_Fprocess_one.text = "Pet Care" // 1
        self.label_Fprocess_two.text = "Pet Service" // 2
        self.label_Fprocess_three.text = "Home" // 3
        self.label_Fprocess_four.text = "Shop" // 4
        self.label_Fprocess_five.text = "Community" // 5
    }
}

extension UIView {
    func loadNib(nibname: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibname, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
   }
}
