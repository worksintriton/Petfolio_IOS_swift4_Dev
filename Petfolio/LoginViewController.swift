//
//  LoginViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var View_log: UIView!
    @IBOutlet weak var usercred: UITextField!
    @IBOutlet weak var ViewOTPBTN: UIView!
    @IBOutlet weak var View_usercred: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.View_log.layer.cornerRadius = 10.0
        self.ViewOTPBTN.layer.cornerRadius = 10.0
        self.View_usercred.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Action_OTP(_ sender: Any) {
        
    }
    
    
    @IBAction func Action_Signup(_ sender: Any) {
        
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
