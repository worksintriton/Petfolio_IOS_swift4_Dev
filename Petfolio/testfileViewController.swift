//
//  testfileViewController.swift
//  Petfolio
//
//  Created by Admin on 27/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class testfileViewController: UIViewController {
    
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var testviewgray: UIView!
    @IBOutlet weak var view_circle: UIView!
    
    @IBOutlet weak var view_dash1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_circle.startAnimating()
        self.view_dash1.startAnimating()
        // Do any additional setup after loading the view.
    }
}

