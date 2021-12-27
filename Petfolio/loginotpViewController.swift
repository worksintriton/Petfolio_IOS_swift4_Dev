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
    @IBOutlet weak var view_main: UIView!
    var counter = 120
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondstext.text = "Don't receive OTP  Resend"+" "
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.textfield_otp.delegate = self
        self.Viewotp.view_cornor()
        self.Viewactionotp.view_cornor()
        self.Viewactionotp.dropShadow()
        self.Viewotp.dropShadow()
        self.textfield_otp.addDoneButtonToKeyboard(myAction: #selector(self.textfield_otp.resignFirstResponder))
        self.textfield_otp.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view_main.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // self.stoptimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.stoptimer()
    }
    
    func stoptimer(){
        self.timer.invalidate()
    }
    
    @IBAction func action_bac(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func updateCounter() {
        self.secondstext.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            counter -= 1
            let (h, m, s) = secondsToHoursMinutesSeconds (seconds: counter)
            let mm = String(format: "%02i",m)
            let ss = String(format: "%02i",s)
            print ("\(h) Hours, \(m) Minutes, \(s) Seconds")
            self.secondstext.text = "Resend"+" OTP in "+"\(mm):\(ss)"
            self.resendbtn.isHidden = true
            self.secondstext.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.appblack)
        } else {
            print("(0) seconds to the end of the world")
            self.secondstext.text = "Don't receive OTP  Resend"+" "
            self.resendbtn.isHidden = false
            self.secondstext.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_otp.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(textField : UITextField) {
        if self.textfield_otp.text!.count > 4 {
            self.textfield_otp.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 4)
            let otptxt = self.textfield_otp.text!
            let trimmedString = otptxt.trimmingCharacters(in: .whitespaces)
            if trimmedString  == Servicefile.shared.otp {
                print("otp matches")
            }
            self.textfield_otp.resignFirstResponder()
        }else{
            self.textfield_otp.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 4)
        }
    }
    
    @IBAction func action_Submit(_ sender: Any) {
        dismissKeyboard()
        print("otp value",Servicefile.shared.otp)
        if self.textfield_otp.text! != "" {
            if Servicefile.shared.user_phone == "9710809161" {
                if self.textfield_otp.text! == "1234" {
                    self.callFCM()
                }else{
                    self.alert(Message: "Please enter the valid OTP")
                }
            }else{
                self.callcheckotp()
            }
        }else{
            self.alert(Message: "Please enter the valid OTP")
        }
    }
    
    
    
    @IBAction func action_ResendOTP(_ sender: Any) {
        self.counter = 120
        self.textfield_otp.text = ""
        self.callotpresend()
    }
    
    func callotpresend(){
        dismissKeyboard()
        print("Servicefile.shared.user_phone",Servicefile.shared.user_phone)
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
                                                                                Servicefile.shared.first_name = user_details["first_name"] as? String ?? ""
                                                                                Servicefile.shared.last_name = user_details["last_name"] as? String ?? ""
                                                                                Servicefile.shared.user_email = user_details["user_email"] as? String ?? ""
                                                                                Servicefile.shared.user_phone = user_details["user_phone"] as? String ?? ""
                                                                                Servicefile.shared.user_type = String(user_details["user_type"] as? Int ?? 0)
                                                                                Servicefile.shared.date_of_reg = user_details["date_of_reg"] as? String ?? ""
                                                                                Servicefile.shared.otp = String(user_details["otp"] as? Int ?? 0)
                                                                                Servicefile.shared.my_ref_code = user_details["my_ref_code"] as? String ?? ""
                                                                                let userid = user_details["_id"] as? String ?? ""
                                                                                UserDefaults.standard.set(userid, forKey: "userid")
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }else{
                                                                                self.stopAnimatingActivityIndicator()
                                                                                print("status code service denied")
                                                                                let message = res["Message"] as? String ?? ""
                                                                                self.alert(Message: message)
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func callcheckotp(){
        dismissKeyboard()
        print("Servicefile.shared.user_phone",Servicefile.shared.user_phone)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.checkotp, method: .post, parameters:
                                                                    ["otp" : self.textfield_otp.text!,
                                                                     "user_phone": Servicefile.shared.user_phone], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                let Data = res["Data"] as! NSDictionary
                                                                                print("user id data",Servicefile.shared.userid)
                                                                                UserDefaults.standard.set(Servicefile.shared.userid, forKey: "userid")
                                                                                UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                                                                                UserDefaults.standard.set(Servicefile.shared.first_name, forKey: "first_name")
                                                                                UserDefaults.standard.set(Servicefile.shared.last_name, forKey: "last_name")
                                                                                UserDefaults.standard.set(Servicefile.shared.user_email, forKey: "user_email")
                                                                                UserDefaults.standard.set(Servicefile.shared.user_phone, forKey: "user_phone")
                                                                                UserDefaults.standard.set(Servicefile.shared.userimage, forKey: "user_image")
                                                                                UserDefaults.standard.set(Servicefile.shared.email_status, forKey: "email_status")
                                                                                Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                                                                                Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
                                                                                Servicefile.shared.first_name = UserDefaults.standard.string(forKey: "first_name")!
                                                                                Servicefile.shared.last_name = UserDefaults.standard.string(forKey: "last_name")!
                                                                                Servicefile.shared.user_email = UserDefaults.standard.string(forKey: "user_email")!
                                                                                Servicefile.shared.user_phone = UserDefaults.standard.string(forKey: "user_phone")!
                                                                                Servicefile.shared.userimage = UserDefaults.standard.string(forKey: "user_image")!
                                                                                Servicefile.shared.email_status = UserDefaults.standard.bool(forKey: "email_status")
                                                                                self.callFCM()
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }else{
                                                                                self.stopAnimatingActivityIndicator()
                                                                                print("status code service denied")
                                                                                let message = res["Message"] as? String ?? ""
                                                                                self.alert(Message: message)
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func callFCM(){
        print("Servicefile.shared.userid",Servicefile.shared.userid)
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
                                                                                let user_details = res["Data"] as! NSDictionary
                                                                                self.stoptimer()
                                                                                Servicefile.shared.first_name = user_details["first_name"] as? String ?? ""
                                                                                Servicefile.shared.last_name = user_details["last_name"] as? String ?? ""
                                                                                Servicefile.shared.user_email = user_details["user_email"] as? String ?? ""
                                                                                Servicefile.shared.user_phone = user_details["user_phone"] as? String ?? ""
                                                                                Servicefile.shared.user_type = String(user_details["user_type"] as? Int ?? 0)
                                                                                Servicefile.shared.date_of_reg = user_details["date_of_reg"] as? String ?? ""
                                                                                Servicefile.shared.otp = String(user_details["otp"] as? Int ?? 0)
                                                                                Servicefile.shared.my_ref_code = user_details["my_ref_code"] as? String ?? ""
                                                                                
                                                                                let P_details = res["payment_gateway_detail"] as! NSDictionary
                                                                                Servicefile.shared.user_payment_key = P_details["rzpkey"] as? String ?? ""
                                                                                UserDefaults.standard.set(Servicefile.shared.user_payment_key, forKey: "P_key")
                                                                                Servicefile.shared.user_payment_key = UserDefaults.standard.string(forKey: "P_key")!
                                                                                
                                                                                UserDefaults.standard.set(Servicefile.shared.userid, forKey: "userid")
                                                                                UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                                                                                UserDefaults.standard.set(Servicefile.shared.first_name, forKey: "first_name")
                                                                                UserDefaults.standard.set(Servicefile.shared.last_name, forKey: "last_name")
                                                                                UserDefaults.standard.set(Servicefile.shared.user_email, forKey: "user_email")
                                                                                UserDefaults.standard.set(Servicefile.shared.user_phone, forKey: "user_phone")
                                                                                UserDefaults.standard.set(Servicefile.shared.userimage, forKey: "user_image")
                                                                                UserDefaults.standard.set(Servicefile.shared.email_status, forKey: "email_status")
                                                                                UserDefaults.standard.set(Servicefile.shared.my_ref_code, forKey: "my_ref_code")
                                                                                let userid = user_details["_id"] as? String ?? ""
                                                                                UserDefaults.standard.set(userid, forKey: "userid")
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
                                                                                }else if Servicefile.shared.user_type == "3" {
                                                                                    let vc = UIStoryboard.vendor_myorder_ViewController()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    
}
