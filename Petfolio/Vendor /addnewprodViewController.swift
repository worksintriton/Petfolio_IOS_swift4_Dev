//
//  addnewprodViewController.swift
//  Petfolio
//
//  Created by Admin on 23/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class addnewprodViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var view_producttitle: UIView!
    @IBOutlet weak var view_product_price: UIView!
    @IBOutlet weak var view_productthreshold: UIView!
    @IBOutlet weak var view_description: UIView!
    
    @IBOutlet weak var view_update: UIView!
    @IBOutlet weak var image_data: UIImageView!
    
    @IBOutlet weak var view_header: petowner_otherpage_header!
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var textfield_product_title: UITextField!
    @IBOutlet weak var textfield_product_price: UITextField!
    @IBOutlet weak var textfield_product_threshold: UITextField!
    @IBOutlet weak var textview_description: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inital_setup()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.textfield_product_title.delegate = self
        self.textfield_product_price.delegate = self
        self.textfield_product_threshold.delegate = self
        self.textview_description.delegate = self
        
        self.textfield_product_title.autocapitalizationType = .sentences
        self.textview_description.autocapitalizationType = .sentences
        
        self.textview_description.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        let data = Servicefile.shared.addproddic[Servicefile.shared.vselectedindex] as! NSDictionary
        let product_desc = data["product_discription"] as? String ?? ""
        let product_name = data["product_title"] as? String ?? ""
        let product_img = data["product_img"] as? String ?? ""
        self.image_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        self.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: product_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    self.image_data.image = UIImage(named: imagelink.sample)
                } else {
                    self.image_data.image = image
                }
        }
        self.textfield_product_price.addDoneButtonToKeyboard(myAction: #selector(self.textfield_product_price.resignFirstResponder))
        self.textfield_product_threshold.addDoneButtonToKeyboard(myAction: #selector(self.textfield_product_threshold.resignFirstResponder))
        self.textfield_product_title.text = product_name
        self.textfield_product_title.isUserInteractionEnabled = false
        self.textview_description.isUserInteractionEnabled = true
        self.textview_description.isEditable = false
        self.textview_description.text = product_desc
        self.textfield_product_price.text = ""
        self.textfield_product_threshold.text = ""
        self.textview_description.text = product_desc
        self.view_update.view_cornor()
        self.view_producttitle.view_cornor()
        self.view_productthreshold.view_cornor()
        self.view_product_price.view_cornor()
        self.view_description.view_cornor()
        
    }
    func inital_setup(){
        // header action
            self.view_header.label_header_title.text = "Add product"
            self.view_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
            self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_header.btn_profile.addTarget(self, action: #selector(self.vendorprofile), for: .touchUpInside)
        self.view_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
            self.view_header.view_sos.isHidden = true
            self.view_header.view_bag.isHidden = true
        // header action
        self.view_footer.setup(b1: false, b2: true, b3: false)
        self.view_footer.label_Fprocess_one.text = "Add Products"
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.vendorproduct), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.vendordash), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? AddproductViewController {
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
        let data = Servicefile.shared.addproddic[Servicefile.shared.vselectedindex] as! NSDictionary
        let product_id = data["_id"] as? String ?? ""
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_product_create, method: .post,
                                                                 parameters:["_id":product_id,
                                                                             "cost": Int(self.textfield_product_price.text!),
                                                                             "product_discription": self.textview_description.text!,
                                                                             "product_name": self.textfield_product_title.text!,
                                                                             "threshould": self.textfield_product_threshold.text!,
                                                                             "vendor_id" : Servicefile.shared.vendorid,
                                                                             "date_and_time" : Servicefile.shared.ddmmhhmmastringformat(date: Date()),
                                                                             "mobile_type" : "IOS"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        //let Data = res["Data"] as! NSArray
                        let alert = UIAlertController(title: "Product Updated", message: "", preferredStyle: .alert)
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
}

