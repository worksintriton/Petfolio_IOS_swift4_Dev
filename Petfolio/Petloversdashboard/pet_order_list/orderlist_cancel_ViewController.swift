//
//  orderlist_cancel_ViewController.swift
//  Petfolio
//
//  Created by Admin on 19/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class orderlist_cancel_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var tbl_cancellist: UITableView!
    @IBOutlet weak var label_cancelval: UILabel!
    @IBOutlet weak var view_cancel: UIView!
    @IBOutlet weak var view_cancel_order: UIView!
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    @IBOutlet weak var view_others: UIView!
    @IBOutlet weak var textview_others: UITextView!
    
    var cancellistval = [""]
    var selval = "Select the reason"
    var showlist = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
        self.view_cancel_order.view_cornor()
        self.view_cancel.view_cornor()
        self.tbl_cancellist.dropShadow()
        self.tbl_cancellist.isHidden = true
        self.tbl_cancellist.delegate = self
        self.tbl_cancellist.dataSource = self
        self.cancellistval.removeAll()
        self.callcanceldetails()
        self.label_cancelval.text = self.selval
        self.view_others.isHidden = true
        self.textview_others.delegate = self
        self.textview_others.text = "Write here..."
        self.textview_others.textColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.appTextcolor)
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Cancel order"
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.textview_others == textView  {
            if textView.text == "Write here..." {
                textView.text = ""
                if textView.textColor == UIColor.gray {
                    textView.text = ""
                    textView.textColor = UIColor.black
                }
            }
            if self.textview_others.text!.count > 49 {
                self.textview_others.resignFirstResponder()
            }else{
                self.textview_others.text = textView.text
            }
        }
        
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.cancellistval.removeAll()
        if let firstVC = presentingViewController as? pet_vendor_orderdetails_ViewController {
            DispatchQueue.main.async {
                firstVC.viewWillAppear(true)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cancellistval.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.cancellistval[indexPath.row]
        cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tbl_cancellist.isHidden = true
        self.selval = self.cancellistval[indexPath.row]
        self.label_cancelval.text = self.cancellistval[indexPath.row]
        if self.selval != "Other"{
            self.view_others.isHidden = true
        } else {
            self.view_others.isHidden = false
        }
    }
    
    
    @IBAction func action_cancel_order(_ sender: Any) {
        if self.selval != "Select the reason" {
            if self.label_cancelval.text != "Other" {
                self.call_submit_cancel_new()
            }else{
                print(self.textview_others.text)
                if self.textview_others.text != "Write here..."{
                    self.selval = self.textview_others.text!
                    self.call_submit_cancel_new()
                }else{
                    self.selval = ""
                    self.call_submit_cancel_new()
                }
            }
            print("cancel data",Servicefile.shared.iscancelselect)
        }else{
            self.alert(Message: "Please select the reason for cancellation")
        }
    }
    
    @IBAction func action_showlist(_ sender: Any) {
        if showlist {
            self.tbl_cancellist.isHidden = false
        } else {
            self.tbl_cancellist.isHidden = true
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func call_submit_cancel_new(){
        var params = [String:Any]()
        var url = ""
        if Servicefile.shared.iscancelmulti { // calls multi cancel api and params
             params = ["order_id": Servicefile.shared.orderid,
                        "product_id": Servicefile.shared.iscancelselect,
                        "reject_reason":self.selval,
                          "date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date())]
             url = Servicefile.pet_vendor_cancel_overall
        }else{
            if Servicefile.shared.iscancelselect.count > 0 || Servicefile.shared.iscancelselect.count == 1 {  // calls single cancel api and params
                params = ["order_id": Servicefile.shared.orderid,
                          "reject_reason":self.selval,
                             "product_id": Servicefile.shared.iscancelselect[0],
                             "date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date())]
                url = Servicefile.pet_vendor_cancel_single
            }
        }
        
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(url, method: .post, parameters: params
        , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
            switch (response.result) {
            case .success:
                let res = response.value as! NSDictionary
                print("success data",res)
                let Code  = res["Code"] as! Int
                if Code == 200 {
                    let vc = UIStoryboard.App_couponViewController()
                    self.present(vc, animated: true, completion: nil)
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
    
    func call_submit_cancel(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_cancel, method: .post, parameters: ["_id" : Servicefile.shared.orderid, "activity_id" : 4, "activity_title" : "Order Cancelled", "activity_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()), "order_status" : "Cancelled", "user_cancell_info" : self.selval, "user_cancell_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date())]
        , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
            switch (response.result) {
            case .success:
                let res = response.value as! NSDictionary
                print("success data",res)
                let Code  = res["Code"] as! Int
                if Code == 200 {
                    let vc = UIStoryboard.App_couponViewController()
                    self.present(vc, animated: true, completion: nil)
                    //self.dismiss(animated: true, completion: nil)
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
    
    func callcanceldetails(){
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
                        let cancellist = Data["cancel_status"] as! NSArray
                        for i in 0..<cancellist.count{
                            let dataval = cancellist[i] as! NSDictionary
                            let title = dataval["title"] as! String
                            self.cancellistval.append(title)
                            
                        }
                        self.tbl_cancellist.reloadData()
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
    
    
    
}
