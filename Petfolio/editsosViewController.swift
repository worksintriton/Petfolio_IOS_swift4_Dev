//
//  editsosViewController.swift
//  Petfolio
//
//  Created by Admin on 27/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class editsosViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var view_name: UIView!
    @IBOutlet weak var textfield_name: UITextField!
    @IBOutlet weak var view_phno: UIView!
    @IBOutlet weak var textfield_phno: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textfield_name.delegate = self
        self.textfield_phno.delegate = self
        self.textfield_name.text = Servicefile.shared.sosnumbers[Servicefile.shared.sosselect].title
        self.textfield_phno.text = Servicefile.shared.sosnumbers[Servicefile.shared.sosselect].number
        self.textfield_name.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_phno.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
   
        @objc func textFieldDidChange(textField : UITextField){
            if self.textfield_phno == textField {
                if self.textfield_phno.text!.count > 9 {
                    self.textfield_phno.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
                    self.textfield_phno.resignFirstResponder()
                }else{
                    self.textfield_phno.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
                }
            } else if self.textfield_name == textField {
                if self.textfield_name.text!.count > 24 {
                    self.textfield_name.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvedalphanumericsymbol, textcount: 25)
                    self.textfield_name.resignFirstResponder()
                }else{
                    self.textfield_name.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvedalphanumericsymbol, textcount: 25)
                }
            }
        }
    
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? SOSViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_update(_ sender: Any) {
        
        if self.textfield_name.text == "" {
            self.alert(Message: "please enter the name")
        }else if self.textfield_phno.text == "" {
            self.alert(Message: "please enter the Phone number")
        }else{
            self.callupdate()
        }
        
    }
    
    func callupdate(){
           self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sos_edit, method: .post, parameters:
        ["user_id": Servicefile.shared.userid,
         "id" : Int(Servicefile.shared.sosnumbers[Servicefile.shared.sosselect].id),
         "name" : self.textfield_name.text!,
         "phone" : self.textfield_phno.text!], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                               switch (response.result) {
                                               case .success:
                                                     let res = response.value as! NSDictionary
                                                     print("success data",res)
                                                     let Code  = res["Code"] as! Int
                                                     if Code == 200 {
                                                        let user_details = res["Data"] as! NSDictionary
                                                        self.dismiss(animated: true, completion: nil)
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
