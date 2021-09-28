//
//  pet_order_reject_ViewController.swift
//  Petfolio
//
//  Created by Admin on 23/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class pet_order_reject_ViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_rejectlist: UITableView!
    @IBOutlet weak var view_others: UIView!
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var product_title: UILabel!
    @IBOutlet weak var Label_product_amt: UILabel!
    
    @IBOutlet weak var Label_status: UILabel!
    @IBOutlet weak var view_status: UIView!
    @IBOutlet weak var textview_other_reason: UITextView!
    
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    var ret_reason = [""]
    var isselect = ["0"]
    var o_isselect = ["0"]
    var selval = ""
    var seltext = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
        self.ret_reason.removeAll()
        self.isselect.removeAll()
        self.o_isselect.removeAll()
        self.callrejectdetails()
        self.tbl_rejectlist.delegate = self
        self.tbl_rejectlist.dataSource = self
        self.textview_other_reason.delegate = self
        self.textview_other_reason.text = "Write here.."
        self.textview_other_reason.textColor = UIColor.lightGray
        self.view_others.isHidden = true
        self.product_title.text = Servicefile.shared.order_productdetail[Servicefile.shared.service_index].v_order_text
        self.image_product.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        self.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[Servicefile.shared.service_index].v_order_image)) { (image, error, cache, urls) in
            if (error != nil) {
                self.image_product.image = UIImage(named: imagelink.sample)
            } else {
                self.image_product.image = image
            }
        }
        self.image_product.contentMode = .scaleAspectFill
        self.Label_product_amt.text = "INR " +   String(Servicefile.shared.order_productdetail[Servicefile.shared.service_index].v_order_price)
        self.Label_status.text = "Delivered on : " +  String(Servicefile.shared.order_productdetail[Servicefile.shared.service_index].v_order_booked_on)
        
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Update status"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.view_sos.isHidden = true
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: false, b2: false, b3: false, b4: true, b5: false)
    // footer action
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ret_reason.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! selectionTableViewCell
        if self.isselect[indexPath.row] == "0" {
            cell.image_isselect.image = UIImage(named: "Radio")
            self.view_others.isHidden = true
        }else{
            cell.image_isselect.image = UIImage(named: "selectedRadio")
            
        }
        cell.selectionStyle = .none
        if self.selval == "Other" {
            self.view_others.isHidden = false
        }else{
            self.view_others.isHidden = true
        }
        cell.label_title.text = self.ret_reason[indexPath.row]
        cell.btn_isselect.tag = indexPath.row
        cell.btn_isselect.addTarget(self, action: #selector(action_isselect), for: .touchUpInside)
        return cell
    }
    
    @objc func action_isselect(sender: UIButton){
        let tag = sender.tag
        self.isselect = self.o_isselect
        self.isselect.remove(at: tag)
        self.isselect.insert("1", at: tag)
        self.selval = self.ret_reason[tag]
        self.tbl_rejectlist.reloadData()
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textview_other_reason == textView  {
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
        if self.textview_other_reason.text!.count > 149 {
            textview_other_reason.resignFirstResponder()
        }else{
            self.textview_other_reason.text = textView.text
        }
        if(text == "\n") {
            textview_other_reason.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func action_return(_ sender: Any) {
        if self.selval == "Other" {
            self.selval = self.textview_other_reason.text!
        }
        if self.selval.trimmingCharacters(in: .whitespaces).isEmpty {
            self.alert(Message: "Please enter the reason for returning the product")
        }else{
            print(self.selval)
            self.call_submit_return()
        }
    }
    
    @IBAction func action_bag(_ sender: Any) {
        
    }
    
    @IBAction func action_back(_ sender: Any) {
        
    }
    
    @IBAction func action_user(_ sender: Any) {
        
    }
    
    @IBAction func action_bell(_ sender: Any) {
        
    }
    
    @IBAction func action_home(_ sender: Any) {
        
    }
    
    @IBAction func action_shop(_ sender: Any) {
        
    }
    
    @IBAction func action_service(_ sender: Any) {
        
    }
    
    @IBAction func action_care(_ sender: Any) {
        
    }
    
    @IBAction func action_community(_ sender: Any) {
        
    }
    
    func callrejectdetails(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.vendor_cancel_status, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let cancellist = Data["return_status"] as! NSArray
                        self.isselect.removeAll()
                        for i in 0..<cancellist.count{
                            let dataval = cancellist[i] as! NSDictionary
                            let title = dataval["title"] as! String
                            self.ret_reason.append(title)
                            self.isselect.append("0")
                        }
                        if self.ret_reason.count > 0 {
                            self.isselect.remove(at: 0)
                            self.isselect.insert("1", at: 0)
                            self.selval = self.ret_reason[0]
                        }
                            
                         self.o_isselect = self.isselect
                        self.tbl_rejectlist.reloadData()
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
                }        }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func call_submit_return(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_return, method: .post, parameters: ["_id" : Servicefile.shared.orderid, "activity_id" : 5, "activity_title" : "Order Returned", "activity_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()), "order_status" : "Cancelled", "user_return_info" : self.selval, "user_return_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),"user_return_pic" : "http://pic.png"]
        , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
