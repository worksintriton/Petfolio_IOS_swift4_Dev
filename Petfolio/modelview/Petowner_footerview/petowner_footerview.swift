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
    @IBOutlet weak var img_s3: UIImageView!
    @IBOutlet weak var img_s3I: UIImageView!
    
    @IBOutlet weak var view_Fprocess_four : UIView!
    @IBOutlet weak var image_Fprocess_four : UIImageView!
    @IBOutlet weak var label_Fprocess_four : UILabel!
    @IBOutlet weak var btn_Fprocess_four : UIButton!
    
    @IBOutlet weak var view_Fprocess_five : UIView!
    @IBOutlet weak var image_Fprocess_five : UIImageView!
    @IBOutlet weak var label_Fprocess_five : UILabel!
    @IBOutlet weak var btn_Fprocess_five : UIButton!
    @IBOutlet weak var image_footer: UIImageView!
    
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
        self.image_Fprocess_three.image = UIImage(named: imagelink.Home_gray)
        self.label_Fprocess_three.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        self.image_footer.image = UIImage(named: imagelink.footnav3)
        self.label_Fprocess_three.isHidden = true
        self.img_s3.isHidden = false
        self.img_s3I.isHidden = false
        self.img_s3I.image = UIImage(named: imagelink.Home_gray)
        self.image_Fprocess_three.isHidden = true
        self.image_Fprocess_two.isHidden = false
        self.image_Fprocess_one.isHidden = false
        self.image_Fprocess_five.isHidden = false
        self.image_Fprocess_four.isHidden = false
        self.label_Fprocess_three.text = "" // 3
        self.label_Fprocess_one.text = "Pet Care"
        self.label_Fprocess_five.text = "Community"
        self.label_Fprocess_two.text = "Pet Service"
        self.label_Fprocess_four.text = "Shop"
        self.label_Fprocess_one.isHidden = false
        self.label_Fprocess_two.isHidden = false
        self.label_Fprocess_four.isHidden = false
        self.label_Fprocess_five.isHidden = false
        self.image_Fprocess_one.image = UIImage(named: imagelink.petcare_gray)!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image_Fprocess_five.image = UIImage(named: imagelink.pet_community_gray)!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image_Fprocess_two.image = UIImage(named: imagelink.pet_service_gray)!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image_Fprocess_four.image = UIImage(named: imagelink.shop_gray)!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image_Fprocess_one.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgrey)
        self.image_Fprocess_five.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgrey)
        self.image_Fprocess_two.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgrey)
        self.image_Fprocess_four.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgrey)
        if b3 {
            self.image_Fprocess_three.image = UIImage(named: imagelink.Home_gray)
        }else{
            self.image_Fprocess_three.image = UIImage(named: imagelink.Home_gray)
        }
        if b1 {
            self.image_Fprocess_one.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.label_Fprocess_one.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            self.image_Fprocess_one.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.black)
            self.label_Fprocess_one.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b5 {
            self.image_Fprocess_five.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.label_Fprocess_five.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            self.image_Fprocess_five.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.black)
            self.label_Fprocess_five.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b2 {
            self.image_Fprocess_two.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.label_Fprocess_two.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            self.image_Fprocess_two.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.black)
            self.label_Fprocess_two.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        if b4 {
            self.image_Fprocess_four.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.label_Fprocess_four.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            self.image_Fprocess_four.tintColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.black)
            self.label_Fprocess_four.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.footer_gray)
        }
        
        
    }
}

extension UIView {
    func loadNib(nibname: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibname, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
   }
}
