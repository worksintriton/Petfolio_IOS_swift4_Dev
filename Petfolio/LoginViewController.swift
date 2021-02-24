//
//  LoginViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var View_log: UIView!
    @IBOutlet weak var usercred: UITextField!
    @IBOutlet weak var ViewOTPBTN: UIView!
    @IBOutlet weak var View_usercred: UIView!
    @IBOutlet weak var view_details: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.checkemailvalid = "login"
        Servicefile.shared.email_status = false
        Servicefile.shared.email_status_label = "Verify email"
        self.View_log.view_cornor()
        self.ViewOTPBTN.view_cornor()
        self.View_usercred.view_cornor()
        self.ViewOTPBTN.dropShadow()
        self.View_usercred.dropShadow()
        self.usercred.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.usercred.delegate = self
        // Do any additional setup after loading the view.
     let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view_details.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
                     }

                     @objc func dismissKeyboard() {
                         view.endEditing(true)
                     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usercred.resignFirstResponder()
        return true
    }
    
    
    @objc func textFieldDidChange(textField : UITextField){
        if self.usercred == textField {
            if self.usercred.text!.count > 9 {
                  self.usercred.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
                self.usercred.resignFirstResponder()
            }else{
                 self.usercred.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
            }
        }
    }
    
    @IBAction func Action_OTP(_ sender: Any) {
        if self.usercred.text! == "" {
            self.alert(Message: "Please enter the Phone number")
        }else{
            Servicefile.shared.user_phone = self.usercred.text!
            self.callLogin()
        }
    }
    
    
    @IBAction func Action_Signup(_ sender: Any) {
        
        
    }
    
    func alert(Message: String){
           let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func callLogin(){
               self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.login, method: .post, parameters:
            ["user_phone": Servicefile.shared.user_phone], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                                                            Servicefile.shared.userid = user_details["_id"] as? String ?? ""
                                                            Servicefile.shared.userimage = user_details["profile_img"] as? String ?? ""
                                                            Servicefile.shared.email_status = user_details["user_email_verification"] as? Bool ?? false
                                                            
                                                           print("userid",Servicefile.shared.userid)
                                                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginotpViewController") as! loginotpViewController
                                                                                                                 self.present(vc, animated: true, completion: nil)
                                                            self.stopAnimatingActivityIndicator()
                                                         }else{
                                                           self.stopAnimatingActivityIndicator()
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
               }else{
                   self.stopAnimatingActivityIndicator()
                   self.alert(Message: "No Intenet Please check and try again ")
               }
           }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
       
//       func moveTextField(textField: UITextField, up: Bool){
//           let movementDistance:CGFloat = -230
//           let movementDuration: Double = 0.3
//           var movement:CGFloat = 0
//           if up {
//               movement = movementDistance
//           } else {
//               movement = -movementDistance
//           }
//           UIView.beginAnimations("animateTextField", context: nil)
//           UIView.setAnimationBeginsFromCurrentState(true)
//           UIView.setAnimationDuration(movementDuration)
//           self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
//           UIView.commitAnimations()
//       }
//
//       func textFieldDidBeginEditing(_ textField: UITextField) {
//                self.moveTextField(textField: textField, up:true)
//       }
//
//       func textFieldDidEndEditing(_ textField: UITextField) {
//        self.moveTextField(textField: textField, up:false)
//
//       }
}

extension UIImage {
        public func Image_cornor(radius: CGFloat? = nil) -> UIImage? {
            let maxRadius = min(size.width, size.height) / 2
            let cornerRadius: CGFloat
            if let radius = radius, radius > 0 && radius <= maxRadius {
                cornerRadius = radius
            } else {
                cornerRadius = maxRadius
            }
            
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            draw(in: rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            image?.sd_roundedCornerImage(withRadius: 8.0, corners: .allCorners , borderWidth: 0.2, borderColor: .lightGray)
            return image
        }
    
   
}

extension UIView {
  func dropShadow() {
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.3
    layer.shadowOffset = CGSize.zero
    layer.shadowRadius = 1.5
  }
    func submit_cornor(){
        layer.cornerRadius = 8.0
    }
    
    func view_cornor(){
        layer.cornerRadius = 8.0
    }
    
    func removeshadow(){
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 0
    }
}
