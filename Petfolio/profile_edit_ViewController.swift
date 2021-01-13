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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textfield_email.delegate = self
        self.textfield_firstname.delegate = self
        self.textfield_lastname.delegate = self
        
        self.textfield_email.text = Servicefile.shared.user_email
        self.textfield_firstname.text = Servicefile.shared.first_name
        self.textfield_lastname.text = Servicefile.shared.last_name
        self.textfield_phoneno.text = Servicefile.shared.user_phone
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_back(_ sender: Any) {
        
    }
    
    @IBAction func action_submit(_ sender: Any) {
         if self.textfield_firstname.text! == "" {
                     self.alert(Message: "Please enter the First name")
                }else if self.textfield_lastname.text! == "" {
                      self.alert(Message: "Please enter the Last name")
                }else {
                    if self.textfield_email.text != ""{
                        if self.isValidEmail(self.textfield_email.text!) != false {
        //                     self.alert(Message: "Email ID is valid")
                            self.callupdate()
                        }else{
                             self.alert(Message: "Email ID is invalid")
                        }
                    }else{
        //                self.alert(Message: "Email ID is empty and submiting the process")
                        self.callupdate()
                    }
                     
                }
    }
    
    func alert(Message: String){
         let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              }))
         self.present(alert, animated: true, completion: nil)
     }
    
    
    func callupdate(){
               self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.update_profile, method: .post, parameters:
               [  "user_id": Servicefile.shared.userid,
                  "first_name": self.textfield_firstname.text!,
                 "last_name": self.textfield_lastname.text!,
                 "user_email": self.textfield_email.text!], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                           let user_details = res["Data"] as! NSDictionary
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
                                                           UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                                                           Servicefile.shared.usertype = UserDefaults.standard.string(forKey: "usertype")!
                                                            self.alert(Message: "Profile Updated sucessfully")
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