//
//  SignOTPViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class SignOTPViewController: UIViewController {

    
    @IBOutlet weak var Viewotp: UIView!
    @IBOutlet weak var Viewactionotp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.Viewotp.layer.cornerRadius = 5.0
        self.Viewactionotp.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
