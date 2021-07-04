//
//  pet_vendor_shippingaddressViewController.swift
//  Petfolio
//
//  Created by Admin on 03/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_vendor_shippingaddressViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    // view
    
    @IBOutlet weak var view_firstname: UIView!
    @IBOutlet weak var view_lastname: UIView!
    @IBOutlet weak var view_placedoornodetails: UIView!
    @IBOutlet weak var view_street: UIView!
    @IBOutlet weak var view_landmark: UIView!
    @IBOutlet weak var view_alertnatemobileno: UIView!
    @IBOutlet weak var view_mobileno: UIView!
    @IBOutlet weak var view_state: UIView!
    @IBOutlet weak var view_city: UIView!
    @IBOutlet weak var view_pincode: UIView!
    @IBOutlet weak var view_create_address: UIView!
    // view
    
    // Textfield
    @IBOutlet weak var textfield_firstname: UITextField!
    @IBOutlet weak var textfield_landmark: UITextField!
    @IBOutlet weak var textfield_street: UITextField!
    @IBOutlet weak var textview_placedoornodetails: UITextView!
    @IBOutlet weak var textfield_lastname: UITextField!
    @IBOutlet weak var textfield_pincode: UITextField!
    @IBOutlet weak var textfield_city: UITextField!
    @IBOutlet weak var textfield_state: UITextField!
    @IBOutlet weak var textfield_mobileno: UITextField!
    @IBOutlet weak var textfield_alternatemobileno: UITextField!
    
    // Textfield
    
    @IBOutlet weak var image_ishome: UIImageView!
    @IBOutlet weak var image_isothers: UIImageView!
    
    var ishome = true
    var isoffice = false
    var addresstype = "Home" //"Office"
    var appid = ""
    var address_status = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.calldelegate()
        
        self.call_cornor_view()
       
        self.textfield_pincode.addDoneButtonToKeyboard(myAction:  #selector(self.textfield_pincode.resignFirstResponder))
        self.textfield_mobileno.addDoneButtonToKeyboard(myAction:  #selector(self.textfield_pincode.resignFirstResponder))
        self.textfield_alternatemobileno.addDoneButtonToKeyboard(myAction:  #selector(self.textfield_pincode.resignFirstResponder))
        self.textfield_mobileno.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.textfield_alternatemobileno.addTarget(self, action: #selector(textFieldDidChangealtermobileno), for: UIControl.Event.editingChanged)
        self.textfield_pincode.addTarget(self, action: #selector(textFieldpincodeDidChange), for: UIControl.Event.editingChanged)
        self.check_status()
    }
    
    func check_status(){
        if Servicefile.shared.shipaddresslist_isedit {
            self.getdetails()
        }else{
            self.clearall()
        }
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        if self.textfield_mobileno == textField {
            if self.textfield_mobileno.text!.count > 9 {
                self.textfield_mobileno.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
                self.textfield_mobileno.resignFirstResponder()
            }else{
                self.textfield_mobileno.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
            }
        }
    }
    @objc func textFieldpincodeDidChange(textField : UITextField){
        if self.textfield_pincode == textField {
            if self.textfield_pincode.text!.count > 5 {
                self.textfield_pincode.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 6)
                self.textfield_pincode.resignFirstResponder()
            }else{
                self.textfield_pincode.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 6)
            }
        }
    }
    
    func checkishome(){
        if ishome && isoffice == false {
            self.addresstype = "Home" //"Office"
            self.image_ishome.setimage(name: imagelink.selectedRadio)
            self.image_isothers.setimage(name: imagelink.Radio)
        }else{
            self.addresstype = "Office" // "Home"
            self.image_ishome.setimage(name: imagelink.Radio)
            self.image_isothers.setimage(name: imagelink.selectedRadio)
        }
    }
    
    @objc func textFieldDidChangealtermobileno(textField : UITextField){
        if self.textfield_alternatemobileno == textField {
            if self.textfield_alternatemobileno.text!.count > 9 {
                self.textfield_alternatemobileno.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
                self.textfield_alternatemobileno.resignFirstResponder()
            }else{
                self.textfield_alternatemobileno.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 10)
            }
        }
    }
    
    func getdetails(){
        let details = Servicefile.shared.shipaddresslist[Servicefile.shared.shipaddresslist_index] as! NSDictionary
        self.appid = details["_id"] as? String ?? ""
        self.textview_placedoornodetails.textColor = UIColor.black
        self.textfield_firstname.text = details["user_first_name"] as? String ?? ""
        self.textfield_landmark.text = details["user_landmark"] as? String ?? ""
        self.textfield_street.text = details["user_stree"] as? String ?? ""
        self.textfield_lastname.text = details["user_last_name"] as? String ?? ""
        self.textfield_pincode.text = details["user_picocode"] as? String ?? ""
        self.textfield_city.text = details["user_city"] as? String ?? ""
        self.textfield_state.text = details["user_state"] as? String ?? ""
        self.textfield_mobileno.text = details["user_mobile"] as? String ?? ""
        self.textfield_alternatemobileno.text = details["user_alter_mobile"] as? String ?? ""
        self.textview_placedoornodetails.text = details["user_flat_no"] as? String ?? ""
        self.addresstype = details["user_address_type"] as? String ?? ""
        self.address_status = details["user_address_stauts"] as? String ?? ""
        if self.addresstype == "Home"{
            self.ishome = true
            self.isoffice = false
        }else{
            self.ishome = false
            self.isoffice = true
        }
        self.checkishome()
    }
    
    func clearall(){
        self.textview_placedoornodetails.text = "Write here.."
        self.textview_placedoornodetails.textColor = UIColor.lightGray
        self.textfield_firstname.text = ""
        self.textfield_landmark.text = ""
        self.textfield_street.text = ""
        self.textfield_lastname.text = ""
        self.textfield_pincode.text = ""
        self.textfield_city.text = ""
        self.textfield_state.text = ""
        self.textfield_mobileno.text = ""
        self.textfield_alternatemobileno.text = ""
        self.ishome = true
        self.isoffice = false
        self.checkishome()
    }
    
    func calldelegate(){
        self.textview_placedoornodetails.text = "Write here.."
        self.textview_placedoornodetails.textColor = UIColor.lightGray
        self.textfield_firstname.delegate = self
        self.textfield_landmark.delegate = self
        self.textfield_street.delegate = self
        self.textview_placedoornodetails.delegate = self
        self.textfield_lastname.delegate = self
        self.textfield_pincode.delegate = self
        self.textfield_city.delegate = self
        self.textfield_state.delegate = self
        self.textfield_mobileno.delegate = self
        self.textfield_alternatemobileno.delegate = self
    }
    
    func call_cornor_view(){
        self.view_firstname.view_cornor()
        self.view_lastname.view_cornor()
        self.view_placedoornodetails.view_cornor()
        self.view_street.view_cornor()
        self.view_landmark.view_cornor()
        self.view_pincode.view_cornor()
        self.view_city.view_cornor()
        self.view_state.view_cornor()
        self.view_mobileno.view_cornor()
        self.view_alertnatemobileno.view_cornor()
        self.view_create_address.view_cornor()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textview_placedoornodetails == textView  {
            if textView.text == "Write here.." {
                textView.text = ""
                if textView.textColor == UIColor.lightGray {
                    textView.text = nil
                    textView.textColor = UIColor.black
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.textview_placedoornodetails.text!.count > 49 {
            self.textview_placedoornodetails.resignFirstResponder()
        }else{
            self.textview_placedoornodetails.text = textView.text
        }
        if(text == "\n") {
            self.textview_placedoornodetails.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func action_ishome(_ sender: Any) {
        self.ishome = true
        self.isoffice = false
        self.checkishome()
    }
    
    @IBAction func action_isothers(_ sender: Any) {
        self.ishome = false
        self.isoffice = true
        self.checkishome()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_clearallfields(_ sender: Any) {
        self.clearall()
    }
    
    @IBAction func action_cancel_ship_address(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func action_create_ship_address(_ sender: Any) {
        let firstname = self.textfield_firstname.text!
        let lastname = self.textfield_lastname.text!
        let doorno = self.textview_placedoornodetails.text!
        let street = self.textfield_street.text!
        // let landmark = self.textfield_landmark.text!
        let pincode = self.textfield_pincode.text!
        let city = self.textfield_city.text!
        let State = self.textfield_state.text!
        let mobile = self.textfield_mobileno.text!
        let alertmobileno = self.textfield_alternatemobileno.text!
        if firstname.trim() == "" {
            self.alert(Message: "Please enter the first name ")
        }else if lastname.trim() == "" {
            self.alert(Message: "Please enter the last name ")
        }else if doorno.trim() == "" {
            self.alert(Message: "Please enter the Door no")
        }else if street.trim() == "" {
            self.alert(Message: "Please enter the street")
        }else if pincode.trim() == "" {
            self.alert(Message: "Please enter the pincode")
        }else if city.trim() == "" {
            self.alert(Message: "Please enter the city")
        }else if State.trim() == "" {
            self.alert(Message: "Please enter the state")
        }else if mobile.trim() == "" {
            self.alert(Message: "Please enter the mobile")
        }else if mobile.count < 10 {
            self.alert(Message: "Please enter the valid mobile")
        }else if alertmobileno.count < 10 {
            self.alert(Message: "Please enter the valid mobile")
        }else if alertmobileno.trim() == "" {
            self.alert(Message: "Please enter the alternate mobile no")
        }else{
            if Servicefile.shared.shipaddresslist_isedit {
                self.call_edit_shipping_address()
            }else{
                self.call_create_shipping_address()
            }
        }
    }
    
    func call_create_shipping_address(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_shiping_address_submit, method: .post, parameters:
                                                                    ["user_id":Servicefile.shared.userid,
                                                                     "user_first_name" : self.textfield_firstname.text!,
                                                                     "user_last_name" : self.textfield_lastname.text!,
                                                                     "user_flat_no" : self.textview_placedoornodetails.text!,
                                                                     "user_stree" : self.textfield_street.text!,
                                                                     "user_landmark" :  self.textfield_landmark.text!,
                                                                     "user_picocode" : self.textfield_pincode.text!,
                                                                     "user_state" : self.textfield_state.text!,
                                                                     "user_mobile" : self.textfield_mobileno.text!,
                                                                     "user_alter_mobile" : self.textfield_alternatemobileno.text!,
                                                                     "user_address_stauts" : "",
                                                                     "user_address_type" : self.addresstype,
                                                                     "user_display_date" : Servicefile.shared.ddMMyyyystringformat(date: Date()),
                                                                     "user_city" : self.textfield_city.text!], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                self.dismiss(animated: true, completion: nil)
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }else{
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }
                                                                            break
                                                                        case .failure(let _):
                                                                            self.stopAnimatingActivityIndicator()
                                                                            
                                                                            break
                                                                        }
                                                                     }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
        
    }
    
    func call_edit_shipping_address(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_update_shiping_address_list, method: .post, parameters:
                                                                    ["_id": self.appid,
                                                                    "user_id":Servicefile.shared.userid,
                                                                     "user_first_name" : self.textfield_firstname.text!,
                                                                     "user_last_name" : self.textfield_lastname.text!,
                                                                     "user_flat_no" : self.textview_placedoornodetails.text!,
                                                                     "user_stree" : self.textfield_street.text!,
                                                                     "user_landmark" :  self.textfield_landmark.text!,
                                                                     "user_picocode" : self.textfield_pincode.text!,
                                                                     "user_state" : self.textfield_state.text!,
                                                                     "user_mobile" : self.textfield_mobileno.text!,
                                                                     "user_alter_mobile" : self.textfield_alternatemobileno.text!,
                                                                     "user_address_stauts" : self.address_status,
                                                                     "user_address_type" : self.addresstype,
                                                                     "user_display_date" : Servicefile.shared.ddMMyyyystringformat(date: Date()),
                                                                     "user_city" : self.textfield_city.text!], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                self.dismiss(animated: true, completion: nil)
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }else{
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }
                                                                            break
                                                                        case .failure(let _):
                                                                            self.stopAnimatingActivityIndicator()
                                                                            
                                                                            break
                                                                        }
                                                                     }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
        
    }
    
}

extension String {
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}

extension UIImageView {
    func setimage(name: String){
        image = UIImage(named: name)
    }
}
