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
            view.layer.cornerRadius = 15
            view.layer.masksToBounds = true
            self.addSubview(view)
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
