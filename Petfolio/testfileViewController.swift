//
//  testfileViewController.swift
//  Petfolio
//
//  Created by Admin on 27/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import iOSDropDown

class testfileViewController: UIViewController {
    
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var testviewgray: UIView!
    @IBOutlet weak var view_circle: UIView!
    
    @IBOutlet weak var dropdown: DropDown!
    @IBOutlet weak var view_dash1: UIView!
    let d2 = ["b1","b1","b1"]
    let d1 = ["a1","a1","a1"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_circle.startAnimating()
        self.view_dash1.startAnimating()
        self.dropdown.optionArray = ["data1","data1","data1","data1"]
        self.dropdown.didSelect{(selectedText , index ,id) in
        let data = "Selected String: \(selectedText) \n index: \(index)"
            print(data)
            }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func b1(_ sender: Any) {
        self.dropdown.optionArray = self.d1
        self.dropdown.didSelect{(selectedText , index ,id) in
        let data = "Selected String: \(selectedText) \n index: \(index)"
            print(data)
            }
    }
    @IBAction func d2(_ sender: Any) {
        self.dropdown.optionArray = self.d2
        self.dropdown.didSelect{(selectedText , index ,id) in
        let data = "Selected String: \(selectedText) \n index: \(index)"
            print(data)
            }
    }
}

