//
//  genderview.swift
//  Petfolio
//
//  Created by Admin on 19/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit


@IBDesignable
class genderview: UIView {

    
    @IBOutlet weak var view_M: UIView!
    @IBOutlet weak var label_M: UILabel!
    
    @IBOutlet weak var view_F: UIView!
    @IBOutlet weak var label_F: UILabel!
    
    @IBOutlet weak var view_O: UIView!
    @IBOutlet weak var label_O: UILabel!
    
    
    @IBOutlet weak var btn_m: UIButton!
    @IBOutlet weak var btn_f: UIButton!
    @IBOutlet weak var btn_o: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
   
    private func configureView() {
        if let view = self.loadNib(nibname: "genderview") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            view_M.layer.cornerRadius = view_M.frame.height / 2
            view_F.layer.cornerRadius = view_F.frame.height / 2
            view_O.layer.cornerRadius = view_O.frame.height / 2
            
            view_M.layer.borderWidth = 1.0
            view_F.layer.borderWidth = 1.0
            view_O.layer.borderWidth = 1.0
            
            maleselect()
            self.addSubview(view)
        }
    }
    
    func maleselect(){
        label_M.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        label_F.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        label_O.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        
        view_M.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen).cgColor
        view_F.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray).cgColor
        view_O.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray).cgColor
    }
    
    func femaleselect(){
        label_F.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        label_M.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        label_O.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        
        view_F.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen).cgColor
        view_M.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray).cgColor
        view_O.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray).cgColor
    }
    
    func othersselect(){
        label_F.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        label_M.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        label_O.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        
        view_F.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray).cgColor
        view_M.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray).cgColor
        view_O.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen).cgColor
    }

}
