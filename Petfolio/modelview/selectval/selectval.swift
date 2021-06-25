//
//  selectval.swift
//  Petfolio
//
//  Created by Admin on 18/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import iOSDropDown

@IBDesignable
class selectval: UIView {

    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var view_btn_side: UIView!
    @IBOutlet weak var image_side_view: UIImageView!
    @IBOutlet weak var textfield_value: UITextField!
    @IBOutlet weak var textfield_dropdown: DropDown!
    @IBOutlet weak var btn_get_data: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
   
    private func configureView() {
        if let view = self.loadNib(nibname: "selectval") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            view_main.view_cornor()
            view_main.dropShadow()
            view_main.layer.borderWidth = 0.1
            view_main.layer.borderColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray).cgColor
            view_btn_side.view_cornor()
            view_btn_side.dropShadow()
            view_btn_side.isHidden = true
            btn_get_data.isHidden = true
            textfield_dropdown.isHidden = true
            self.addSubview(view)
        }
    }

}
