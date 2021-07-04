//
//  paymentpageViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Razorpay

class paymentpageViewController: UIViewController  {
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
           
    }
    
}
