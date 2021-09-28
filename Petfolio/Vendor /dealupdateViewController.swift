//
//  dealupdateViewController.swift
//  Petfolio
//
//  Created by Admin on 03/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class dealupdateViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var view_producttitle: UIView!
    @IBOutlet weak var view_product_price: UIView!
    @IBOutlet weak var view_productthreshold: UIView!
    @IBOutlet weak var view_description: UIView!
    
    @IBOutlet weak var view_update: UIView!
    
    
    @IBOutlet weak var textfield_product_title: UITextField!
    @IBOutlet weak var textfield_product_price: UITextField!
    @IBOutlet weak var textfield_product_threshold: UITextField!
    @IBOutlet weak var textview_description: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.textfield_product_title.delegate = self
        self.textfield_product_price.delegate = self
        self.textfield_product_threshold.delegate = self
        self.textview_description.delegate = self
        
        self.textfield_product_title.autocapitalizationType = .sentences
        self.textview_description.autocapitalizationType = .sentences
        
        self.textview_description.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        let data = Servicefile.shared.manageproductDic[Servicefile.shared.selectedindex] as! NSDictionary
        let product_desc = data["product_desc"] as? String ?? ""
        let product_price = data["product_price"] as? Int ?? 0
        let pet_threshold = data["pet_threshold"] as? String ?? ""
        let product_name = data["product_name"] as? String ?? ""
        self.textfield_product_price.addDoneButtonToKeyboard(myAction: #selector(self.textfield_product_price.resignFirstResponder))
        self.textfield_product_threshold.addDoneButtonToKeyboard(myAction: #selector(self.textfield_product_threshold.resignFirstResponder))
        self.textfield_product_title.text = product_name
        self.textfield_product_price.text = String(product_price)
        self.textfield_product_threshold.text = String(pet_threshold)
        self.textview_description.text = product_desc
        self.view_update.view_cornor()
        self.view_producttitle.view_cornor()
        self.view_productthreshold.view_cornor()
        self.view_product_price.view_cornor()
        self.view_description.view_cornor()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? vendor_manage_product_ViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
       }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textview_description == textView  {
            if textView.text == "Product description here..." {
                textView.text = ""
                if textView.textColor == UIColor.gray {
                    textView.text = nil
                    textView.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.textview_description.text!.count > 149 {
            self.textview_description.resignFirstResponder()
        }else{
            self.textview_description.text = textView.text
        }
        if(text == "\n") {
            self.textview_description.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func action_update(_ sender: Any) {
        
        if self.checkemptyfield(strv: textfield_product_title.text!) {
            self.alert(Message: "Please enter the Product title")
        }else if self.checkemptyfield(strv: textfield_product_price.text!) {
            self.alert(Message: "Please enter the Product price")
        }else if self.checkemptyfield(strv: textfield_product_threshold.text!) {
            self.alert(Message: "Please enter the Product threshold")
        }else if self.checkemptyfield(strv: textview_description.text!) {
            self.alert(Message: "Please enter the Product description")
        }else if self.textview_description.text == "Product description here..."{
            self.alert(Message: "Please enter the Product description")
        }else{
            self.callsubmit()
        }
    }
    
    func checkemptyfield(strv: String)-> Bool{
        let str = strv
        let trimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed == "" {
            return true
        }else{
            return false
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func callsubmit(){
        let data = Servicefile.shared.manageproductDic[Servicefile.shared.selectedindex] as! NSDictionary
        let product_id = data["product_id"] as? String ?? ""
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_edit_product, method: .post, parameters:["_id":product_id,"cost": Int(self.textfield_product_price.text!),"product_discription": self.textview_description.text!,"product_name": self.textfield_product_title.text!,"threshould": self.textfield_product_threshold.text!], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        //let Data = res["Data"] as! NSArray
                        let alert = UIAlertController(title: "", message: "Product details added successfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            self.dismiss(animated: true, completion: nil)
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
}

