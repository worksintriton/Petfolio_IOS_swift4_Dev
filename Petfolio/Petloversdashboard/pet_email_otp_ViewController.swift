//
//  pet_email_otp_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 20/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_email_otp_ViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var Viewotp: UIView!
    @IBOutlet weak var Viewactionotp: UIView!
    @IBOutlet weak var textfield_otp: UITextField!
    @IBOutlet weak var view_main: UIView!
    
    @IBOutlet weak var resendbtn: UIButton!
    @IBOutlet weak var secondstext: UILabel!
    
     var counter = 120
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callotpresend()
        self.textfield_otp.delegate = self
        self.Viewotp.layer.cornerRadius = 5.0
        self.Viewactionotp.layer.cornerRadius = 10.0
        self.textfield_otp.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view_main.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func updateCounter() {
      self.secondstext.layer.cornerRadius = 10.0
         if counter > 0 {
             print("\(counter) seconds to the end of the world")
             counter -= 1
             let (h, m, s) = secondsToHoursMinutesSeconds (seconds: counter)
             let mm = String(format: "%02i",m)
             let ss = String(format: "%02i",s)
             print ("\(h) Hours, \(m) Minutes, \(s) Seconds")
             self.secondstext.text = "Resend"+" "+"\(mm):\(ss)"
             self.resendbtn.isHidden = true
             self.secondstext.textColor = Servicefile.shared.hexStringToUIColor(hex: "#c32126")
             } else {
             print("(0) seconds to the end of the world")
             self.secondstext.text = "Resend"+" OTP"
             self.resendbtn.isHidden = false
             self.secondstext.textColor = Servicefile.shared.hexStringToUIColor(hex: "#009674")
         }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
         return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
       }
       
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_otp.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(textField : UITextField){
          if self.textfield_otp.text!.count > 6 {
            let otptxt = self.textfield_otp.text!
            let trimmedString = otptxt.trimmingCharacters(in: .whitespaces)
            if trimmedString  == Servicefile.shared.otp {
                print("otp matches")
            }
               self.textfield_otp.resignFirstResponder()
           }else{
               self.textfield_otp.text = textField.text
           }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? SignupViewController {
                            DispatchQueue.main.async {
                             firstVC.viewWillAppear(true)
                            }
                        }
    }
    
    @IBAction func action_Submit(_ sender: Any) {
        print("user type",Servicefile.shared.user_type)
        if Servicefile.shared.otp != "0"{
            let otptxt = self.textfield_otp.text!
                              let trimmedString = otptxt.trimmingCharacters(in: .whitespaces)
                              if trimmedString  == Servicefile.shared.otp {
                               Servicefile.shared.email_status = true
                               Servicefile.shared.email_status_label = "Verified email"
                               self.dismiss(animated: true, completion: nil)
                              }else{
                                print("verification Not success")
                   }
        }
       
    }
    
    @IBAction func action_ResendOTP(_ sender: Any) {
        self.counter = 120
        self.textfield_otp.text = ""
        self.callotpresend()
    }
    
    
    func moveTextField(textField: UITextField, up: Bool){
         let movementDistance:CGFloat = -260
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
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
             self.moveTextField(textField: textField, up:true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, up:false)
    }
    
    func callotpresend(){
               self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.verifyemail, method: .post, parameters:
            [   "user_email": Servicefile.shared.signupemail], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                           let Data = res["Data"] as! NSDictionary
                                                           let otp = Data["otp"] as? Int ?? 0
                                                           Servicefile.shared.otp = String(otp as! Int)
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
               } else {
                   self.stopAnimatingActivityIndicator()
                   self.alert(Message: "No Intenet Please check and try again ")
               }
           }
    
    

    func alert(Message: String){
           let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
           self.present(alert, animated: true, completion: nil)
       }
}
