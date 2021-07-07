//
//  animateloader.swift
//  Petfolio
//
//  Created by Admin on 04/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

    @IBDesignable
    class animateloader: UIView {

        
        @IBOutlet weak var view1: UIView!
        @IBOutlet weak var view11: UIView!
        @IBOutlet weak var view12: UIView!
        @IBOutlet weak var view13: UIView!
        @IBOutlet weak var view14: UIView!
        @IBOutlet weak var view15: UIView!
        
        
         @IBOutlet weak var view2: UIView!
         @IBOutlet weak var view21: UIView!
         @IBOutlet weak var view22: UIView!
         @IBOutlet weak var view23: UIView!
         @IBOutlet weak var view24: UIView!
         @IBOutlet weak var view25: UIView!
         
         
        
        
         @IBOutlet weak var view3: UIView!
         @IBOutlet weak var view31: UIView!
         @IBOutlet weak var view32: UIView!
         @IBOutlet weak var view33: UIView!
         @IBOutlet weak var view34: UIView!
         @IBOutlet weak var view35: UIView!
         
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.configureView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.configureView()
        }
       
        private func configureView() {
            if let view = self.loadNib(nibname: "animateloader") {
                view.frame = self.bounds
                view.layer.masksToBounds = true
                self.view1.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view11.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view12.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view13.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view14.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view15.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view2.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view21.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view22.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view23.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view24.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view25.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view3.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view31.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view32.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view33.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view34.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                self.view35.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
                
                self.view1.startShimmeringViewAnimation()
                self.view11.startShimmeringViewAnimation()
                self.view12.startShimmeringViewAnimation()
                self.view13.startShimmeringViewAnimation()
                self.view14.startShimmeringViewAnimation()
                self.view15.startShimmeringViewAnimation()
                self.view2.startShimmeringViewAnimation()
                self.view21.startShimmeringViewAnimation()
                self.view22.startShimmeringViewAnimation()
                self.view23.startShimmeringViewAnimation()
                self.view24.startShimmeringViewAnimation()
                self.view25.startShimmeringViewAnimation()
                self.view3.startShimmeringViewAnimation()
                self.view31.startShimmeringViewAnimation()
                self.view32.startShimmeringViewAnimation()
                self.view33.startShimmeringViewAnimation()
                self.view34.startShimmeringViewAnimation()
                self.view35.startShimmeringViewAnimation()
                
                self.addSubview(view)
            }
        }
        
      

    }
