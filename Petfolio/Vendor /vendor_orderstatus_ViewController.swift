//
//  vendor_orderstatus_ViewController.swift
//  Petfolio
//
//  Created by Admin on 17/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class vendor_orderstatus_ViewController: UIViewController {
    
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var product_title: UILabel!
    
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
    @IBOutlet weak var label_bookeddate: UILabel!
    @IBOutlet weak var view_pathline: UIView!
    @IBOutlet weak var image_booked_status: UIImageView!
    // booked
    // confirmation
    @IBOutlet weak var view_confirmation: UIView!
    @IBOutlet weak var label_confrim_date: UILabel!
    @IBOutlet weak var view_confrim_pathline: UIView!
    @IBOutlet weak var image_confrim_status: UIImageView!
    // confirmation
    // Rejection
    @IBOutlet weak var view_rejected: UIView!
    @IBOutlet weak var view_rejected_pathline: UIView!
    @IBOutlet weak var label_rejected_details: UILabel!
    @IBOutlet weak var label_rejected_date: UILabel!
    // Rejection
    // cancel
    @IBOutlet weak var view_cancelled: UIView!
    @IBOutlet weak var label_cancel_details: UILabel!
    @IBOutlet weak var label_cancel_date: UILabel!
    // cancel
    // dispatched
    @IBOutlet weak var view_dispatched: UIView!
    @IBOutlet weak var label_dispatch_details: UILabel!
    @IBOutlet weak var label_dispatch_date: UILabel!
    @IBOutlet weak var view_dispatch_pathline: UIView!
    
    // dispatched
    @IBOutlet weak var view_intransit: UIView!
    @IBOutlet weak var label_transit_date: UILabel!
    
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callgetstatuslist()
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isbookstatus(status: Bool, bookval : String){
        self.view_booked.isHidden = status
        self.label_bookeddate.text = bookval
        self.view_pathline.isHidden = status
    }
    
    func isconfirmorder(status: Bool, bookval : String){
        self.view_confirmation.isHidden = status
        self.label_confrim_date.text = bookval
        self.view_pathline.isHidden = status
        self.view_confrim_pathline.isHidden = false
    }
    
    func isrejectedorder(status: Bool, bookval : String, details: String){
        self.view_rejected.isHidden = status
        self.label_rejected_details.text = details
        self.label_rejected_date.text = bookval
        self.view_confrim_pathline.isHidden = false
        self.view_rejected_pathline.isHidden = false
        self.view_pathline.isHidden = false
    }
    
    func iscancelorder(status: Bool, bookval : String, details: String){
        self.view_cancelled.isHidden = status
        self.label_cancel_details.text = details
        self.label_cancel_date.text = bookval
        self.view_confrim_pathline.isHidden = false
        self.view_rejected_pathline.isHidden = status
        self.view_pathline.isHidden = false
        
    }
    
    func isdispatchorder(status: Bool, bookval : String, details: String){
        self.view_dispatched.isHidden = status
        self.label_dispatch_details.text = details
        self.label_dispatch_date.text = bookval
        self.label_transit_date.text = bookval
        self.view_dispatch_pathline.isHidden = status
        self.view_confrim_pathline.isHidden = status
        self.view_rejected_pathline.isHidden = false
        self.view_cancelled.isHidden = status
        self.view_rejected.isHidden = status
    }
    
    func istransitorder(status: Bool, bookval : String){
        self.view_intransit.isHidden = status
        self.label_transit_date.text = bookval
    }
    
    
    func callgetstatuslist(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_status_orderlist, method: .post, parameters:
            ["_id": Servicefile.shared.orderid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        self._id = Data["_id"] as! String
                        self.billing_address = Data["billing_address"] as! String
                        self.billling_address_id = Data["billling_address_id"] as! String
                        self.coupon_code = Data["coupon_code"] as! String
                        self.date_of_booking = Data["date_of_booking"] as! String
                        self.date_of_booking_display = Data["date_of_booking_display"] as! String
                        self.delivery_date = Data["delivery_date"] as! String
                        self.delivery_date_display = Data["delivery_date_display"] as! String
                        self.discount_price = Data["discount_price"] as! Int
                        self.grand_total = Data["grand_total"] as! Int
                        self.order_id = Data["order_id"] as! String;
                        self.order_status = Data["order_status"] as! String
                        self.over_all_total = Data["over_all_total"] as! Int
                        self.payment_id = Data["payment_id"] as! String
                        self.prodcut_image = Data["prodcut_image"] as? String ?? Servicefile.sample_img
                        self.prodouct_total = Data["prodouct_total"] as! Int
                        self.product_name = Data["product_name"] as? String ?? ""
                        self.product_price = Data["product_price"] as? Int ?? 0
                        self.product_quantity = Data["product_quantity"] as! Int
                        self.shipping_address = Data["shipping_address"] as! String
                        self.shipping_address_id = Data["shipping_address_id"] as! String
                        self.shipping_charge = Data["shipping_charge"] as! Int
                        self.status = Data["status"] as! String
                        self.user_cancell_date = Data["user_cancell_date"] as! String
                        self.user_cancell_info = Data["user_cancell_info"] as! String
                        self.vendor_accept_cancel = Data["vendor_accept_cancel"] as! String
                        self.vendor_cancell_date = Data["vendor_cancell_date"] as! String
                        self.vendor_cancell_info = Data["vendor_cancell_info"] as! String
                        self.vendor_complete_date = Data["vendor_complete_date"] as! String
                        self.vendor_complete_info = Data["vendor_complete_info"] as! String
                        let prodcut_track_details = Data["prodcut_track_details"] as! NSArray
                        self.product_title.text = self.product_name
                        self.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: self.prodcut_image)) { (image, error, cache, urls) in
                            if (error != nil) {
                                self.image_product.image = UIImage(named: "sample")
                            } else {
                                self.image_product.image = image
                            }
                        }
                        self.label_orderdate.text = self.date_of_booking
                        self.label_id.text = self.order_id
                        self.label_paymentmethod.text = "Online"
                        self.label_ordertotal.text = "₹" + String(self.grand_total)
                        self.label_quality.text = "₹" + String(self.product_quantity)
                        for i in 0..<prodcut_track_details.count{
                            let itdata = prodcut_track_details[i] as! NSDictionary
                            let Status = itdata["Status"] as! Bool
                            let date = itdata["date"] as! String
                            let id = itdata["id"] as! Int
                            let title = itdata["title"] as! String
                            if title == "Order Booked" {
                                if Status {
                                    self.isbookstatus(status: false, bookval : date)
                                }else{
                                    self.isbookstatus(status: true, bookval : date)
                                }
                            }else if title == "Order Accept" {
                                if Status {
                                    self.isconfirmorder(status: false, bookval : date)
                                }else{
                                    self.isconfirmorder(status: true, bookval : date)
                                }
                            }else if title == "Order Dispatch" {
                                if Status {
                                    self.isdispatchorder(status: false, bookval : date, details: self.vendor_complete_info)
                                }else{
                                    self.isdispatchorder(status: true, bookval : date, details: self.vendor_complete_info)
                                }
                            }else if title == "Order Cancelled" {
                                if Status {
                                    self.isrejectedorder(status: false, bookval : date, details: self.user_cancell_info)
                                }else{
                                    self.isrejectedorder(status: true, bookval : date, details: self.user_cancell_info)
                                }
                            }else if title == "Vendor cancelled" {
                                if Status {
                                    self.iscancelorder(status: false, bookval : date, details: self.vendor_cancell_info)
                                }else {
                                    self.iscancelorder(status: true, bookval : date, details: self.vendor_cancell_info)
                                }
                            }else{
                                if Status {
                                    self.istransitorder(status: false, bookval : date)
                                }else{
                                    self.istransitorder(status: true, bookval : date)
                                }
                            }
                            Servicefile.shared.vendor_orderstatuss.append(vendor_orderstatus.init(In_Status: Status, In_date: date, In_id: id, In_title: title))
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
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
