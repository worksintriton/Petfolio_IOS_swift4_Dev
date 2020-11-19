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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usertypetitle.text = Servicefile.shared.usertype
        self.ViewFname.layer.cornerRadius = 5.0
         self.ViewLname.layer.cornerRadius = 5.0
         self.viewemail.layer.cornerRadius = 5.0
         self.Viewphone.layer.cornerRadius = 5.0
        self.Viewotp.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
         self.ViewChangeUtype.layer.cornerRadius = 15.0
        self.viewcoun.layer.cornerRadius = 5.0
        self.textfield_phno.delegate = self
        self.textfield_email.delegate = self
        self.textfield_fname.delegate = self
        self.textfield_lastname.delegate = self
        // Do any additional setup after loading the view.
        self.textfield_fname.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_lastname.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_email.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_phno.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
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
            if self.textfield_fname.text!.count > 14 {
                self.alert(Message: "only 15 char allowed")
                self.textfield_fname.resignFirstResponder()
            }else{
                self.textfield_fname.text = textField.text
            }
        } else if self.textfield_lastname == textField {
            if self.textfield_lastname.text!.count > 14 {
                self.alert(Message: "oly 15 char allowed")
                self.textfield_lastname.resignFirstResponder()
            }else{
                self.textfield_lastname.text = textField.text
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
               return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }
    
    override func viewWillAppear(_ animated: Bool) {
        self.usertypetitle.text = Servicefile.shared.usertype
    }
    
   
    @IBAction func changeUT(_ sender: Any) {
        
    }
    
    @IBAction func Action_Votp(_ sender: Any) {
        if self.textfield_fname.text! == "" {
             self.alert(Message: "Please enter the First name")
        }else if self.textfield_lastname.text! == "" {
              self.alert(Message: "Please enter the Last name")
        }else if self.textfield_phno.text! == ""{
             self.alert(Message: "Please enter the Phone number")
        }else {
            if self.textfield_email.text != ""{
                if isValidEmail(self.textfield_email.text!) != false {
//                     self.alert(Message: "Email ID is valid")
                    self.callsignup()
                }else{
                     self.alert(Message: "Email ID is invalid")
                }
            }else{
//                self.alert(Message: "Email ID is empty and submiting the process")
                self.callsignup()
            }
             
        }
    }
    
    func alert(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
             }))
        self.present(alert, animated: true, completion: nil)
    }
   
    
    
    func callsignup(){
            self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.signup, method: .post, parameters:
            [ "first_name": self.textfield_fname.text!,
            "last_name": self.textfield_lastname.text!,
            "user_email": self.textfield_email.text!,
            "user_phone": self.textfield_phno.text!,
            "user_type" : Servicefile.shared.user_type_value,
            "date_of_reg": Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                        let Data = res["Data"] as! NSDictionary
                                                        let user_details = Data["user_details"] as! NSDictionary
                                                         Servicefile.shared.first_name = user_details["first_name"] as! String
                                                         Servicefile.shared.last_name = user_details["last_name"] as! String
                                                         Servicefile.shared.user_email = user_details["user_email"] as! String
                                                         Servicefile.shared.user_phone = user_details["user_phone"] as! String
                                                         Servicefile.shared.user_type = String(user_details["user_type"] as! Int)
                                                        Servicefile.shared.date_of_reg = user_details["date_of_reg"] as! String
                                                        Servicefile.shared.otp = String(user_details["otp"] as! Int)
                                                        let userid = user_details["_id"] as! String
                                                        UserDefaults.standard.set(userid, forKey: "userid")
                                                         Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                                                        print("user id",Servicefile.shared.userid)
                                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignOTPViewController") as! SignOTPViewController
                                                                                                              self.present(vc, animated: true, completion: nil)
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
        let movementDistance:CGFloat = -280
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
        if self.textfield_email == textField || self.textfield_phno == textField {
             self.moveTextField(textField: textField, up:true)
        }
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.textfield_email == textField || self.textfield_phno == textField {
        self.moveTextField(textField: textField, up:false)
        }
    }

}
