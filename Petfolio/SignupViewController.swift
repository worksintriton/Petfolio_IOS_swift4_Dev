//
//  SignupViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var ViewFname: UIView!
    @IBOutlet weak var ViewLname: UIView!
    @IBOutlet weak var viewemail: UIView!
    @IBOutlet weak var Viewphone: UIView!
    @IBOutlet weak var Viewotp: UIView!
    @IBOutlet weak var ViewChangeUtype: UIView!
    @IBOutlet weak var viewcoun: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ViewFname.layer.cornerRadius = 5.0
         self.ViewLname.layer.cornerRadius = 5.0
         self.viewemail.layer.cornerRadius = 5.0
         self.Viewphone.layer.cornerRadius = 5.0
        self.Viewotp.layer.cornerRadius = 5.0
         self.ViewChangeUtype.layer.cornerRadius = 5.0
        self.viewcoun.layer.cornerRadius = 5.0
        
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func changeUT(_ sender: Any) {
        
    }
    
    @IBAction func Action_Votp(_ sender: Any) {
        
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
