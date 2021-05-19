//
//  header_title.swift
//  Petfolio
//
//  Created by Admin on 19/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
@IBDesignable
class header_title: UIView {

    
    @IBOutlet weak var image_back: UIImageView!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var label_title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        if let view = self.loadNib(nibname: "header_title") {
            view.frame = self.bounds
            view.layer.masksToBounds = true
            self.image_back.image = UIImage(named: imagelink.image_back)
            self.addSubview(view)
        }
    }

}
