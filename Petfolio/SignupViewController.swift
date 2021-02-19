//
//  SignupViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ViewFname: UIView!
    @IBOutlet weak var ViewLname: UIView!
    @IBOutlet weak var viewemail: UIView!
    @IBOutlet weak var Viewphone: UIView!
    @IBOutlet weak var Viewotp: UIView!
    @IBOutlet weak var ViewChangeUtype: UIView!
    @IBOutlet weak var viewcoun: UIView!
    
    @IBOutlet weak var usertypetitle: UILabel!
    @IBOutlet weak var textfield_fname: UITextField!
    @IBOutlet weak var textfield_lastname: UITextField!
    @IBOutlet weak var textfield_email: UITextField!
    @IBOutlet weak var textfield_phno: UITextField!
    @IBOutlet weak var view_verifyemail: UIView!
    @IBOutlet weak var label_emailstatus: UILabel!
    @IBOutlet weak var view_details: UIView!
    
    @IBOutlet weak var btn_email_verify: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.checkemailvalid = "signup"
        self.viewemail.layer.cornerRadius = 15.0
        self.ViewFname.layer.cornerRadius = 5.0
        self.ViewLname.layer.cornerRadius = 5.0
        self.viewemail.layer.cornerRadius = 5.0
        self.Viewphone.layer.cornerRadius = 5.0
        self.view_verifyemail.layer.cornerRadius = 5.0
        
        self.view_verifyemail.dropShadow()
        self.viewemail.dropShadow()
        self.ViewFname.dropShadow()
        self.ViewLname.dropShadow()
        self.viewemail.dropShadow()
        self.Viewphone.dropShadow()
        self.ViewChangeUtype.dropShadow()
        
        self.Viewotp.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.ViewChangeUtype.layer.cornerRadius = 15.0
        self.viewcoun.layer.cornerRadius = 5.0
        self.textfield_phno.delegate = self
        self.textfield_email.delegate = self
        self.textfield_fname.delegate = self
        self.textfield_lastname.delegate = self
        self.textfield_fname.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_lastname.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_email.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_phno.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view_details.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
                        Servicefile.shared.otp = String(otp as! Int)
                        Servicefile.shared.email_status = true
                        Servicefile.shared.signupemail = self.textfield_email.text!
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "emailsignupViewController") as! emailsignupViewController
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_phno.resignFirstResponder()
        self.textfield_email.resignFirstResponder()
        self.textfield_fname.resignFirstResponder()
        self.textfield_lastname.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        if self.textfield_phno == textField {
            if self.textfield_phno.text!.count > 9 {
                self.textfield_phno.resignFirstResponder()
            }else{
                self.textfield_phno.text = textField.text
            }
        } else if self.textfield_fname == textField {
            if self.textfield_fname.text!.count > 24 {
                self.textfield_fname.resignFirstResponder()
            }else{
                self.textfield_fname.text = textField.text
            }
        } else if self.textfield_lastname == textField {
            if self.textfield_lastname.text!.count > 24 {
                self.textfield_lastname.resignFirstResponder()
            }else{
                self.textfield_lastname.text = textField.text
            }
        }else if self.textfield_email == textField {
            Servicefile.shared.email_status = false
            Servicefile.shared.email_status_label = "verify email"
            self.label_emailstatus.text = Servicefile.shared.email_status_label
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Servicefile.shared.email_status == true {
            self.textfield_email.isUserInteractionEnabled = false
            self.btn_email_verify.isUserInteractionEnabled = false
        }
        self.usertypetitle.text = Servicefile.shared.usertypetitle
        self.label_emailstatus.text = Servicefile.shared.email_status_label
        print("user type and usertype value",Servicefile.shared.usertypetitle, Servicefile.shared.user_type_value)
    }
    
    
    @IBAction func changeUT(_ sender: Any) {
        
    }
    
    @IBAction func Action_Votp(_ sender: Any) {
        if self.textfield_fname.text! == "" {
            self.alert(Message: "Please enter the First name")
        } else if self.textfield_lastname.text! == "" {
            self.alert(Message: "Please enter the Last name")
        } else if self.textfield_phno.text! == "" {
            self.alert(Message: "Please enter the Phone number")
        } else {
            let emailval = Servicefile.shared.checktextfield(textfield: self.textfield_email.text!)
            if emailval != "" {
                if self.isValidEmail(emailval) == true  {
                    if Servicefile.shared.email_status == true {
                        self.callsignup()
                    }else{
                         self.callsignup()
                    }
                }else{
                    self.alert(Message: "Email ID is invalid")
                }
            }else{
                 self.callsignup()
            }
        }
    }
    
    func alert(Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func callsignup(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.signup, method: .post, parameters:
            ["first_name": Servicefile.shared.checktextfield(textfield: self.textfield_fname.text!),
             "last_name":  Servicefile.shared.checktextfield(textfield: self.textfield_lastname.text!),
             "user_email": Servicefile.shared.checktextfield(textfield: self.textfield_email.text!),
             "user_phone": Servicefile.shared.checktextfield(textfield: self.textfield_phno.text!),
             "user_type" : Servicefile.shared.user_type_value,
             "date_of_reg": Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()),
             "mobile_type" : "IOS",
             "user_email_verification": Servicefile.shared.email_status], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary 
                        let user_details = Data["user_details"] as! NSDictionary
                        Servicefile.shared.first_name = user_details["first_name"] as? String ?? ""
                        Servicefile.shared.last_name = user_details["last_name"] as? String ?? ""
                        Servicefile.shared.user_email = user_details["user_email"] as? String ?? ""
                        Servicefile.shared.user_phone = user_details["user_phone"] as? String ?? ""
                        Servicefile.shared.user_type = String(user_details["user_type"] as? Int ?? 0)
                        Servicefile.shared.date_of_reg = user_details["date_of_reg"] as? String ?? ""
                        Servicefile.shared.otp = String(user_details["otp"] as? Int ?? 0)
                        Servicefile.shared.userid  = user_details["_id"] as? String ?? ""
                        Servicefile.shared.email_status = user_details["user_email_verification"] as? Bool ?? false
                        if Servicefile.shared.userid != "" {
                            self.stopAnimatingActivityIndicator()
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignOTPViewController") as! SignOTPViewController
                            self.present(vc, animated: true, completion: nil)
                        }else{
                             self.stopAnimatingActivityIndicator()
                        }
                    } else {
                        self.stopAnimatingActivityIndicator()
                        let Messages = res["Message"] as? String ?? ""
                        self.alert(Message: Messages)
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
        if self.textfield_email == textField || self.textfield_phno == textField  {
            self.moveTextField(textField: textField, up:true)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.textfield_email == textField || self.textfield_phno == textField {
            self.moveTextField(textField: textField, up:false)
        }
    }
    
}
