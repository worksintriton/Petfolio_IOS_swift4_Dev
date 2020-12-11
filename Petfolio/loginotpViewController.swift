//
//  loginotpViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 17/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class loginotpViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var Viewotp: UIView!
    @IBOutlet weak var Viewactionotp: UIView!
    @IBOutlet weak var textfield_otp: UITextField!
    
    @IBOutlet weak var resendbtn: UIButton!
    @IBOutlet weak var secondstext: UILabel!
    
     var counter = 120
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textfield_otp.delegate = self
        self.Viewotp.layer.cornerRadius = 5.0
        self.Viewactionotp.layer.cornerRadius = 10.0
         self.textfield_otp.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
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
    
    @IBAction func action_Submit(_ sender: Any) {
        let otptxt = self.textfield_otp.text!
                   let trimmedString = otptxt.trimmingCharacters(in: .whitespaces)
                   if trimmedString  == Servicefile.shared.otp {
                    UserDefaults.standard.set(Servicefile.shared.userid, forKey: "userid")
                    UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                    Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                    UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                    Servicefile.shared.usertype = UserDefaults.standard.string(forKey: "usertype")!
                    self.callFCM()
                   }else{
                     print("verification Not success")
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
             self.moveTextField(textField: textField, up:true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, up:false)
    }
    
    func callotpresend(){
               self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.resend, method: .post, parameters:
            [   "user_phone": Servicefile.shared.user_phone], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                           let Data = res["Data"] as! NSDictionary
                                                           let user_details = Data["User_Details"] as! NSDictionary
                                                            Servicefile.shared.first_name = user_details["first_name"] as! String
                                                            Servicefile.shared.last_name = user_details["last_name"] as! String
                                                            Servicefile.shared.user_email = user_details["user_email"] as! String
                                                            Servicefile.shared.user_phone = user_details["user_phone"] as! String
                                                            Servicefile.shared.user_type = String(user_details["user_type"] as! Int)
                                                           Servicefile.shared.date_of_reg = user_details["date_of_reg"] as! String
                                                           Servicefile.shared.otp = String(user_details["otp"] as! Int)
                                                           let userid = user_details["_id"] as! String
                                                           UserDefaults.standard.set(userid, forKey: "userid")
                                                           
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
    
    func callFCM(){
           self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.tokenupdate, method: .post, parameters:
        [ "user_id": Servicefile.shared.userid,
          "fb_token" : Servicefile.shared.FCMtoken ], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                               switch (response.result) {
                                               case .success:
                                                     let res = response.value as! NSDictionary
                                                     print("success data",res)
                                                     let Code  = res["Code"] as! Int
                                                     if Code == 200 {
                                                       if Servicefile.shared.usertype == "1" {
                                                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
                                                                                      self.present(vc, animated: true, completion: nil)
                                                       }else{
                                                           let vc = self.storyboard?.instantiateViewController(withIdentifier: "DocdashboardViewController") as! DocdashboardViewController
                                                                                      self.present(vc, animated: true, completion: nil)
                                                       }
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

    func alert(Message: String){
           let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
           self.present(alert, animated: true, completion: nil)
       }
}
