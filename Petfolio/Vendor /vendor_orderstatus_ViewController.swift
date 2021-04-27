//
//  vendor_orderstatus_ViewController.swift
//  Petfolio
//
//  Created by Admin on 17/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class vendor_orderstatus_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var product_title: UILabel!
    @IBOutlet weak var label_product_amt: UILabel!
    
    @IBOutlet weak var Label_status: UILabel!
    @IBOutlet weak var dropDownIconImageView: UIImageView!
    @IBOutlet weak var view_drop: UIView!
    
    @IBOutlet weak var label_orderdate: UILabel!
    @IBOutlet weak var label_id: UILabel!
    @IBOutlet weak var label_paymentmethod: UILabel!
    @IBOutlet weak var label_ordertotal: UILabel!
    @IBOutlet weak var label_quality: UILabel!
    
    // booked
    @IBOutlet weak var view_booked: UIView!
    @IBOutlet weak var label_booked: UILabel!
    @IBOutlet weak var label_bookeddate: UILabel!
    @IBOutlet weak var view_pathline: UIView!
    @IBOutlet weak var image_booked_status: UIImageView!
    // booked
    
    // confirmation
    @IBOutlet weak var label_confirmation: UILabel!
    @IBOutlet weak var view_confirmation: UIView!
    @IBOutlet weak var label_confrim_date: UILabel!
    @IBOutlet weak var view_confrim_pathline: UIView!
    @IBOutlet weak var image_confrim_status: UIImageView!
    @IBOutlet weak var label_confrim_details: UILabel!
    // confirmation
 
     // vendor rejected
    @IBOutlet weak var lable_orderrejCancelstatus: UILabel!
    @IBOutlet weak var view_rejected: UIView!
     @IBOutlet weak var label_rejected_date: UILabel!
     @IBOutlet weak var view_rejected_pathline: UIView!
     @IBOutlet weak var image_rejected_status: UIImageView!
     @IBOutlet weak var label_rejected_details: UILabel!
     // vendor rejected
    
    
    
    // dispatched
    @IBOutlet weak var label_dispatch: UILabel!
    @IBOutlet weak var view_dispatched: UIView!
    @IBOutlet weak var label_dispatch_details: UILabel!
    @IBOutlet weak var label_dispatch_date: UILabel!
    @IBOutlet weak var view_dispatch_pathline: UIView!
    @IBOutlet weak var image_dispatched: UIImageView!
    
    // dispatched
    @IBOutlet weak var label_intransit: UILabel!
    @IBOutlet weak var view_intransit: UIView!
    @IBOutlet weak var label_transit_date: UILabel!
    @IBOutlet weak var image_transit: UIImageView!
    @IBOutlet weak var view_intransit_pathline: UIView!
    
    @IBOutlet weak var view_return_status: UIView!
    @IBOutlet weak var label_return_status_details: UILabel!
    @IBOutlet weak var label_return_status_date: UILabel!
    @IBOutlet weak var view_return_status_pathline: UIView!
    @IBOutlet weak var image_return_status: UIImageView!
    
    @IBOutlet weak var view_return: UIView!
    @IBOutlet weak var label_return: UILabel!
    @IBOutlet weak var image_return: UIImageView!
    @IBOutlet weak var view_return_pathline: UIView!
    @IBOutlet weak var tbl_status: UITableView!
    
    @IBOutlet weak var view_status_popup: UIView!
    @IBOutlet weak var textview_status_reason: UITextView!
    @IBOutlet weak var view_update: UIView!
    
    @IBOutlet weak var view_submit_reason: UIView!
    
    @IBOutlet weak var view_tbl_backview: UIView!
    
    
    var rejectOrcancel = false
    var _id = ""
    var billing_address = ""
    var billling_address_id = ""
    var coupon_code = ""
    var date_of_booking = ""
    var date_of_booking_display = ""
    var delivery_date = ""
    var delivery_date_display = ""
    var discount_price = 0
    var grand_total = 0
    var order_id = ""
    var order_status = ""
    var over_all_total = 0
    var payment_id = ""
    var prodcut_image = ""
    var prodouct_total = 0
    var product_name = ""
    var product_price = 0
    var product_quantity = 0
    var shipping_address = ""
    var shipping_address_id = ""
    var shipping_charge = 0
    var status = ""
    var user_cancell_date = ""
    var user_cancell_info = ""
    var vendor_accept_cancel = ""
    var vendor_cancell_date = ""
    var vendor_cancell_info = ""
    var vendor_complete_date = ""
    var vendor_complete_info = ""
    @IBOutlet weak var view_footer: UIView!
    
    @IBOutlet weak var view_status_alpha: UIView!
    var status_arr =  [""]
    var new_status_arr = ["Select Order Status", "Order Confirmation","Order Cancellation"]
    
    var copnfirm_status_arr = ["Select Order Status","Order Cancellation", "Order Dispatched"]
    
    var statusurl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_footer.view_cornor()
        self.view_drop.view_cornor()
        self.view_update.view_cornor()
        self.view_status_popup.view_cornor()
        self.textview_status_reason.layer.cornerRadius = 8.0
        self.textview_status_reason.delegate = self
        self.status_arr.removeAll()
        self.tbl_status.delegate = self
        self.tbl_status.dataSource = self
        self.tbl_status.isHidden = true
        self.view_status_alpha.isHidden = true
        self.view_intransit_pathline.isHidden = true
        self.view_return.isHidden = true
        self.view_return_status.isHidden = true
        self.view_return_status_pathline.isHidden = true
        self.view_status_popup.isHidden = true
        self.view_rejected.isHidden = true
        self.image_confrim_status.image = UIImage(named: "")
        self.image_dispatched.image = UIImage(named: "")
        self.image_transit.image = UIImage(named: "")
        self.image_return.image = UIImage(named: "")
        self.image_return_status.image = UIImage(named: "")
        self.view_status_popup.dropShadow()
        
        self.image_transit.layer.cornerRadius =  self.image_transit.frame.height / 2
        self.image_dispatched.layer.cornerRadius =  self.image_dispatched.frame.height / 2
        self.image_confrim_status.layer.cornerRadius =  self.image_confrim_status.frame.height / 2
        self.image_return.layer.cornerRadius =  self.image_return.frame.height / 2
        self.image_return_status.layer.cornerRadius =  self.image_return_status.frame.height / 2
        
        
        self.image_confrim_status.backgroundColor = UIColor.gray
        self.image_dispatched.backgroundColor = UIColor.gray
        self.image_transit.backgroundColor = UIColor.gray
        self.image_return.backgroundColor = UIColor.gray
        self.image_return_status.backgroundColor = UIColor.gray
        
        self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        self.view_confrim_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        self.view_dispatch_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        self.view_intransit_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        self.view_return_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
        self.callgetstatuslist()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidetbl))
        self.view_status_alpha.addGestureRecognizer(tap)
        self.label_confrim_date.text = ""
    }
    
    @objc func hidetbl() {
        self.tbl_status.isHidden = true
        self.view_status_alpha.isHidden = true
        self.view_status_popup.isHidden = true
        self.textview_status_reason.resignFirstResponder()
        self.Label_status.text = "Select Order Status"
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? vendor_myorder_ViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
       }
   
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.status_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.status_arr[indexPath.row]
        cell.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.applightgreen)
        cell.selectionStyle = .none
        cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.Label_status.text = self.status_arr[indexPath.row]
        self.tbl_status.isHidden = true
        self.view_status_alpha.isHidden = true
        if self.Label_status.text == "Order Dispatched" {
            self.view_status_alpha.isHidden = false
            self.view_status_popup.isHidden = false
            self.textview_status_reason.text = "Trackid....."
            self.textview_status_reason.textColor = UIColor.lightGray
        }else if self.Label_status.text == "Order Cancellation" {
            self.view_status_alpha.isHidden = false
            self.view_status_popup.isHidden = false
            self.textview_status_reason.text = "Reason....."
            self.textview_status_reason.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isbookstatus(status: Bool, bookval : String){
        self.view_booked.isHidden = false
        self.label_bookeddate.text = bookval
        print("isbooked status",status)
    }
    
    func isconfirmorder(status: Bool, bookval : String, details: String, other: Bool){
        self.view_confirmation.isHidden = false
        self.view_confrim_pathline.isHidden = false
        if bookval != "" {
            self.label_confrim_date.text = bookval
        }
        self.label_confrim_details.text = details
        print("confirm status",status)
    }
    
    func isrejectedorder(status: Bool, bookval : String, details: String){
        if status {
            self.view_rejected.isHidden = false
        }else{
            self.view_rejected.isHidden = true
        }
        self.label_rejected_details.text = details
        self.label_rejected_date.text = bookval
        self.view_confrim_pathline.isHidden = false
        self.view_rejected_pathline.isHidden = false
        self.view_pathline.isHidden = false
    }
//
//    func iscancelorder(status: Bool, bookval : String, details: String){
//        self.view_cancelled.isHidden = status
//        self.label_cancel_details.text = details
//        self.label_cancel_date.text = bookval
//        self.view_confrim_pathline.isHidden = false
//        self.view_rejected_pathline.isHidden = status
//        self.view_pathline.isHidden = false
//
//    }
    @IBAction func action_view_status_drop(_ sender: Any) {
        self.tbl_status.isHidden = false
        self.view_status_alpha.isHidden = false
    }
    
    func isdispatchorder(status: Bool, bookval : String, details: String){
        print("dispatched status",status)
        self.view_dispatched.isHidden = false
        self.label_dispatch_details.text = details
        self.label_dispatch_date.text = bookval
        self.label_transit_date.text = bookval
        self.view_dispatch_pathline.isHidden = false
        self.view_confrim_pathline.isHidden = false
        if status {
            self.view_dispatch_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_confrim_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            self.view_dispatch_pathline.backgroundColor = UIColor.gray
            self.view_confrim_pathline.backgroundColor = UIColor.gray
        }
    }
    
    func istransitorder(status: Bool, bookval : String){
        print("dispatched status",status)
        self.view_intransit.isHidden = false
        self.label_transit_date.text = bookval
    }
    
    @IBAction func action_check_status(_ sender: Any) {
        if self.Label_status.text == "Select Order Status"{
           self.alert(Message: "Please select the status type")
       }else {
           self.callupdatestatus()
       }
    }
    
    @IBAction func action_update_status(_ sender: Any) {
        self.view_status_alpha.isHidden = true
        self.view_status_popup.isHidden = true
        self.textview_status_reason.resignFirstResponder()
        let text = self.textview_status_reason.text!
        if text.trimmingCharacters(in: .whitespaces).isEmpty{
            self.alert(Message: "Please enter the status details")
            self.Label_status.text = "Select Order Status"
        }else if  text == "Reason....." || text == "Trackid....." {
            self.alert(Message: "Please enter the status details")
            self.Label_status.text = "Select Order Status"
        } else{
            self.callupdatestatus()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.textview_status_reason.text!.count > 149 {
            textview_status_reason.resignFirstResponder()
        }else{
            self.textview_status_reason.text = textView.text
        }
        if(text == "\n") {
            textview_status_reason.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textview_status_reason == textView  {
            if textView.text == "Reason....." || textView.text == "Trackid....." {
                textView.text = ""
                if textView.textColor == UIColor.lightGray {
                    textView.text = nil
                    textView.textColor = UIColor.black
                }
            }
        }
    }
    
    
    
    func callupdatestatus(){
        var params = [String:Any]()
        var url = ""
        if self.Label_status.text == "Order Confirmation" {
            url = Servicefile.vendor_update_status_accept
            params = ["_id" : Servicefile.shared.orderid,
                     "activity_id" : 1,
                     "activity_title" : "Order Accept",
                     "activity_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date())]
            Servicefile.shared.ordertype = "current"
        }else if self.Label_status.text == "Order Dispatched"{
            url = Servicefile.vendor_update_status_dispatch
            params = ["_id" : Servicefile.shared.orderid,
                     "activity_id" : 3,
                          "activity_title" : "Order Dispatch",
                          "activity_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                          "vendor_complete_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                          "vendor_complete_info" : self.textview_status_reason.text!,
                          "order_status" : "Complete"]
            Servicefile.shared.ordertype = "Complete"
        }else if self.Label_status.text == "Order Cancellation"{
            url = Servicefile.vendor_update_status_vendor_cancel
            params = ["_id" : Servicefile.shared.orderid,
                "activity_id" : 5,
                "activity_title" : "Vendor cancelled",
                "activity_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                "order_status" : "Cancelled",
                "vendor_cancell_info" : self.textview_status_reason.text!,
                "vendor_cancell_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date())]
            Servicefile.shared.ordertype = "cancelled"
        }
        
        
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(url, method: .post, parameters:
                                                                    params, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        //let Data = res["Data"] as! NSDictionary
                        self.callgetstatuslist()
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
    
    
    func callgetstatuslist(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        print("product id",Servicefile.shared.productid,"order id", Servicefile.shared.orderid)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_product_order_status_list, method: .post, parameters:
            ["order_id": Servicefile.shared.orderid,
                "product_order_id": Servicefile.shared.productid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        self._id = Data["_id"] as? String ?? ""
                        self.billing_address = Data["billing_address"] as? String ?? ""
                        self.billling_address_id = Data["billling_address_id"]  as? String ?? ""
                        self.coupon_code = Data["coupon_code"] as? String ?? ""
                        self.date_of_booking = Data["date_of_booking"] as? String ?? ""
                        self.date_of_booking_display = Data["date_of_booking_display"] as? String ?? ""
                        self.delivery_date = Data["delivery_date"] as? String ?? ""
                        self.delivery_date_display = Data["delivery_date_display"] as? String ?? ""
                        self.discount_price = Data["discount_price"] as? Int ?? 0
                        self.grand_total = Data["grand_total"] as? Int ?? 0
                        self.order_id = Data["order_id"] as? String ?? ""
                        self.order_status = Data["order_status"] as? String ?? ""
                        self.over_all_total = Data["over_all_total"] as? Int ?? 0
                        self.payment_id = Data["payment_id"] as? String ?? ""
                        self.prodcut_image = Data["product_image"] as? String ?? Servicefile.sample_img
                        self.prodouct_total = Data["product_total_price"] as? Int ?? 0
                        self.product_name = Data["product_name"] as? String ?? ""
                        self.product_price = Data["product_price"] as? Int ?? 0
                        self.label_product_amt.text = "₹ " +  String(self.prodouct_total)
                        self.product_quantity = Data["product_count"] as? Int ?? 0
                        self.shipping_address = Data["shipping_address"] as? String ?? ""
                        self.shipping_address_id = Data["shipping_address_id"] as? String ?? ""
                        self.shipping_charge = Data["shipping_charge"] as? Int ?? 0
                        self.status = Data["status"] as? String ?? ""
//                        self.user_cancell_date = Data["user_cancell_date"] as? String ?? ""
//                        self.user_cancell_info = Data["user_cancell_info"] as? String ?? ""
//                        self.vendor_accept_cancel = Data["vendor_accept_cancel"] as? String ?? ""
//                        self.vendor_cancell_date = Data["vendor_cancell_date"] as? String ?? ""
//                        self.vendor_cancell_info = Data["vendor_cancell_info"] as? String ?? ""
//                        self.vendor_complete_date = Data["vendor_complete_date"] as? String ?? ""
//                        self.vendor_complete_info = Data["vendor_complete_info"] as? String ?? ""
                        let prodcut_track_details = Data["prodcut_track_details"] as! NSArray
                        self.product_title.text = self.product_name
                        self.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: self.prodcut_image)) { (image, error, cache, urls) in
                            if (error != nil) {
                                self.image_product.image = UIImage(named: "sample")
                            } else {
                                self.image_product.image = image
                            }
                        }

                        self.label_orderdate.text = Servicefile.shared.date_of_booking
                        self.label_id.text = Servicefile.shared.order_id
                        self.label_paymentmethod.text = "Online"
                        self.label_ordertotal.text = "₹" + String(self.prodouct_total)
                        self.label_quality.text = String(self.product_quantity)
                        for i in 0..<prodcut_track_details.count{
                            let itdata = prodcut_track_details[i] as! NSDictionary
                            let Status = itdata["Status"] as! Bool
                            let date = itdata["date"] as! String
                            let id = itdata["id"] as! Int
                            let text = itdata["text"] as! String
                            let title = itdata["title"] as! String
                            if title == "Order Booked" {
                                self.isbookstatus(status: Status, bookval : date)
                                if Status {
                                self.status_arr = self.new_status_arr

                                }
                            }else if title == "Order Accept" {
                                self.isconfirmorder(status: Status, bookval : date, details: text, other: false)
                                if Status {
                                    self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.image_confrim_status.image = UIImage(named: "success")
                                    self.status_arr = self.copnfirm_status_arr

                                }
                            }else if title == "Order Dispatch" {
                                self.isdispatchorder(status: Status, bookval : date, details: text)
                                if Status {
                                self.image_dispatched.image = UIImage(named: "success")
                                self.image_transit.image = UIImage(named: "success")
                                self.view_dispatch_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.view_update.isHidden = true
                                    self.view_drop.isHidden = true
                                    self.view_tbl_backview.isHidden = true
                                }

                            }else if title == "Order Cancelled" {
                               // self.isrejectedorder(status: Status, bookval : date, details: self.vendor_cancell_info)
//                                if Status {
//                                    self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
//                                    self.image_confrim_status.image = UIImage(named: "047")
//                                    self.image_confrim_status.backgroundColor = .clear
//                                    self.view_update.isHidden = true
//                                    self.view_drop.isHidden = true
//                                    self.view_tbl_backview.isHidden = true
//                                }
                                if Status {
                                    self.isrejectedorder(status: Status, bookval : date, details: text)
                                    self.view_confrim_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.image_rejected_status.image = UIImage(named: "047")
                                    self.image_rejected_status.backgroundColor = .clear
                                    self.view_update.isHidden = true
                                    self.view_rejected.isHidden = false
                                    self.view_drop.isHidden = true
                                    self.view_tbl_backview.isHidden = true
                                    self.view_confrim_pathline.isHidden = false
                                    self.view_pathline.isHidden = false
                                }else{
                                    self.isrejectedorder(status: Status, bookval : date, details: text)
                                }

                            }else if title == "Vendor cancelled" {
                               
                                //self.isconfirmorder(status: Status, bookval : date, details: self.vendor_cancell_info, other: Status)
                                if self.rejectOrcancel {
                                    
                                }else {
                                if Status {
                                    self.isrejectedorder(status: Status, bookval : date, details: text)
                                    self.view_confrim_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.image_rejected_status.image = UIImage(named: "047")
                                    self.image_rejected_status.backgroundColor = .clear
                                    self.view_update.isHidden = true
                                    self.view_rejected.isHidden = false
                                    self.view_drop.isHidden = true
                                    self.view_tbl_backview.isHidden = true
                                    self.view_confrim_pathline.isHidden = false
                                    self.view_pathline.isHidden = false
                                }else{
                                    self.isrejectedorder(status: Status, bookval : date, details: text)
                                }
                                }
                            }else{
                                self.istransitorder(status: Status, bookval : date)
                                if Status {
                                    self.view_update.isHidden = true
                                    self.view_drop.isHidden = true
                                    self.view_tbl_backview.isHidden = true
                                }
                            }
                            Servicefile.shared.vendor_orderstatuss.append(vendor_orderstatus.init(In_Status: Status, In_date: date, In_id: id, In_title: title))
                        }
                        self.tbl_status.reloadData()
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
