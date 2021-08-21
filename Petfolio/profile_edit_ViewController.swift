//
//  profile_edit_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 31/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class profile_edit_ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textfield_firstname: UITextField!
    @IBOutlet weak var textfield_lastname: UITextField!
    @IBOutlet weak var textfield_email: UITextField!
    @IBOutlet weak var textfield_phoneno: UITextField!
    @IBOutlet weak var view_save: UIView!
    @IBOutlet weak var view_country: UIView!
    @IBOutlet weak var view_verifyemail: UIView!
    @IBOutlet weak var label_emailstatus: UILabel!
    @IBOutlet weak var view_details: UIView!
    @IBOutlet weak var view_firstname: UIView!
    @IBOutlet weak var view_lastname: UIView!
    @IBOutlet weak var view_email: UIView!
    @IBOutlet weak var view_phone: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.view_save.view_cornor()
        self.view_firstname.view_cornor()
        self.view_lastname.view_cornor()
        self.view_email.view_cornor()
        self.view_phone.view_cornor()
        self.view_verifyemail.view_cornor()
        self.view_country.view_cornor()
        
        self.textfield_email.delegate = self
        self.textfield_firstname.delegate = self
        self.textfield_lastname.delegate = self
        
        self.textfield_email.text = Servicefile.shared.user_email
        self.textfield_firstname.text = Servicefile.shared.first_name
        self.textfield_lastname.text = Servicefile.shared.last_name
        self.textfield_phoneno.text = Servicefile.shared.user_phone
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view_details.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_email.resignFirstResponder()
        self.textfield_firstname.resignFirstResponder()
        self.textfield_lastname.resignFirstResponder()
        return true
    }
    
    @IBAction func action_email_verify(_ sender: Any) {
        self.view.endEditing(true)
         let emailval = Servicefile.shared.checktextfield(textfield: self.textfield_email.text!)
        if self.isValidEmail(emailval) == false || emailval == "" {
            self.alert(Message: "Email ID is invalid")
        }else {
            Servicefile.shared.signupemail = emailval
            self.callemailotpsend()
        }
    }
    
    func callemailotpsend(){
           self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.verifyemail, method: .post, parameters:
               ["user_email": Servicefile.shared.signupemail], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                   switch (response.result) {
                   case .success:
                       let res = response.value as! NSDictionary
                       print("Email success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                           let Data = res["Data"] as! NSDictionary
                           let otp = Data["otp"] as? Int ?? 0
                        Servicefile.shared.otp = String(otp)
                           Servicefile.shared.email_status = true
                           Servicefile.shared.signupemail = self.textfield_email.text!
                        let vc = UIStoryboard.emailsignupViewController()
                           self.present(vc, animated: true, completion: nil)
                           self.stopAnimatingActivityIndicator()
                       }else{
                           self.stopAnimatingActivityIndicator()
                           print("status code service denied")
                           let Messages = res["Message"] as? String ?? ""
                           self.alert(Message: Messages)
                       }
                       break
                   case .failure(let Error):
                       self.stopAnimatingActivityIndicator()
                       print("Can't Connect to Server / TimeOut",Error)
                       break
                   }
               }
           } else {
               self.stopAnimatingActivityIndicator()
               self.alert(Message: "No Intenet Please check and try again ")
           }
       }
    
    @objc func textFieldDidChange(textField : UITextField){
        if self.textfield_email == textField {
            Servicefile.shared.email_status = false
            Servicefile.shared.email_status_label = "Verify email"
            self.label_emailstatus.text = Servicefile.shared.email_status_label
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_submit(_ sender: Any) {
        if self.textfield_firstname.text! == "" {
            self.alert(Message: "Please enter the First name")
        }else if self.textfield_lastname.text! == "" {
            self.alert(Message: "Please enter the Last name")
        } else {
             let emailval = Servicefile.shared.checktextfield(textfield: self.textfield_email.text!)
            if emailval != "" {
                if self.isValidEmail(emailval) == true  {
                    if Servicefile.shared.email_status == true {
                        self.callupdate()
                    }else{
                        self.callupdate()
                    }
                }else{
                    self.alert(Message: "Email ID is invalid")
                }
            }else{
                self.callupdate()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.label_emailstatus.text = Servicefile.shared.email_status_label
        if Servicefile.shared.email_status != false {
            Servicefile.shared.email_status_label = "Verified email"
        } else {
            Servicefile.shared.email_status_label = "Verify email"
        }
         self.label_emailstatus.text = Servicefile.shared.email_status_label
    }
    
    
    
    
    func callupdate(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.update_profile, method: .post, parameters:
            [  "user_id": Servicefile.shared.userid,
               "first_name": Servicefile.shared.checktextfield(textfield: self.textfield_firstname.text!),
               "last_name": Servicefile.shared.checktextfield(textfield: self.textfield_lastname.text!),
               "user_email": Servicefile.shared.checktextfield(textfield: self.textfield_email.text!),
               "user_email_verification": Servicefile.shared.email_status], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let user_details = res["Data"] as! NSDictionary
                        Servicefile.shared.first_name = user_details["first_name"] as? String ?? ""
                        Servicefile.shared.last_name = user_details["last_name"] as? String ?? ""
                        Servicefile.shared.user_email = user_details["user_email"] as? String ?? ""
                        Servicefile.shared.user_phone = user_details["user_phone"] as? String ?? ""
                        Servicefile.shared.user_type = String(user_details["user_type"] as? Int ?? 0)
                        Servicefile.shared.date_of_reg = user_details["date_of_reg"] as? String ?? ""
                        Servicefile.shared.otp = String(user_details["otp"] as? Int ?? 0)
                        Servicefile.shared.userid = user_details["_id"] as? String ?? ""
                        Servicefile.shared.email_status = user_details["user_email_verification"] as? Bool ?? false
                        Servicefile.shared.userimage = user_details["profile_img"] as? String ?? ""
                        
                        UserDefaults.standard.set(Servicefile.shared.userid, forKey: "userid")
                        UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                        UserDefaults.standard.set(Servicefile.shared.first_name, forKey: "first_name")
                        UserDefaults.standard.set(Servicefile.shared.last_name, forKey: "last_name")
                        UserDefaults.standard.set(Servicefile.shared.user_email, forKey: "user_email")
                        UserDefaults.standard.set(Servicefile.shared.user_phone, forKey: "user_phone")
                        UserDefaults.standard.set(Servicefile.shared.userimage, forKey: "user_image")
                        UserDefaults.standard.set(Servicefile.shared.email_status, forKey: "email_status")
                        let alert = UIAlertController(title: "", message: "Profile Updated sucessfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            if Servicefile.shared.user_type == "1" {
                                //        Servicefile.shared.tabbar_selectedindex = 2
                                        let tapbar = UIStoryboard.petloverDashboardViewController()
                                //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                                        self.present(tapbar, animated: true, completion: nil)
                            } else if Servicefile.shared.user_type == "4" {
                                let vc = UIStoryboard.DocdashboardViewController()
                                self.present(vc, animated: true, completion: nil)
                            } else if Servicefile.shared.user_type == "2" {
                                let vc = UIStoryboard.Sp_dash_ViewController()
                                self.present(vc, animated: true, completion: nil)
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                        self.stopAnimatingActivityIndicator()
                    }else{
                        self.stopAnimatingActivityIndicator()
                        print("status code service denied")
                    }
                    break
                case .failure(let Error):
                    self.stopAnimatingActivityIndicator()
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func moveTextField(textField: UITextField, up: Bool){
        let movementDistance:CGFloat = -230
        let movementDuration: Double = 0.3
        var movement:CGFloat = 0
        if up {
            movement = movementDistance
        } else {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.textfield_email == textField || self.textfield_lastname == textField  {
            self.moveTextField(textField: textField, up:true)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.textfield_email == textField || self.textfield_lastname == textField {
            self.moveTextField(textField: textField, up:false)
        }
    }
    
    
}
