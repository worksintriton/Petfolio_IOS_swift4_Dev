//
//  vendorTrackorderViewController.swift
//  Petfolio
//
//  Created by Admin on 24/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class vendorTrackorderViewController: UIViewController {
    
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var product_title: UILabel!
    
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
    @IBOutlet weak var label_confrim_details: UILabel!
    
    // confirmation
   
    // dispatched
    @IBOutlet weak var view_dispatched: UIView!
    @IBOutlet weak var label_dispatch_details: UILabel!
    @IBOutlet weak var label_dispatch_date: UILabel!
    @IBOutlet weak var view_dispatch_pathline: UIView!
    @IBOutlet weak var image_dispatched: UIImageView!
    
    // dispatched
    @IBOutlet weak var view_intransit: UIView!
    @IBOutlet weak var label_transit_date: UILabel!
    @IBOutlet weak var image_transit: UIImageView!
    @IBOutlet weak var view_intransit_pathline: UIView!
    
    @IBOutlet weak var view_return_status: UIView!
    @IBOutlet weak var label_return_status_details: UILabel!
    @IBOutlet weak var label_return_status_date: UILabel!
    @IBOutlet weak var view_return_status_pathline: UIView!
    @IBOutlet weak var image_return_status: UIImageView!
    
    @IBOutlet weak var view_header: petowner_otherpage_header!
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var view_return: UIView!
    @IBOutlet weak var label_return: UILabel!
    @IBOutlet weak var image_return: UIImageView!
    @IBOutlet weak var view_return_pathline: UIView!
    
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
    var confirmdate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inital_setup()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_intransit_pathline.isHidden = true
        self.view_return.isHidden = true
        self.view_return_status.isHidden = true
        self.view_return_status_pathline.isHidden = true
        self.image_confrim_status.image = UIImage(named: "")
        self.image_dispatched.image = UIImage(named: "")
        self.image_transit.image = UIImage(named: "")
        self.image_return.image = UIImage(named: "")
        self.image_return_status.image = UIImage(named: "")
        self.label_confrim_date.text = ""
        self.label_confrim_details.text = ""
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
        
        self.view_pathline.backgroundColor = UIColor.gray
        self.view_confrim_pathline.backgroundColor = UIColor.gray
        self.view_dispatch_pathline.backgroundColor = UIColor.gray
        self.view_intransit_pathline.backgroundColor = UIColor.gray
        self.view_return_pathline.backgroundColor = UIColor.gray
        self.callgetstatuslist()
    }
    
    func inital_setup(){
        // header action
            self.view_header.label_header_title.text = "Track Order"
            self.view_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
            self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_header.btn_profile.addTarget(self, action: #selector(self.vendorprofile), for: .touchUpInside)
        self.view_header.btn_bel.addTarget(self, action: #selector(self.notification), for: .touchUpInside)
            self.view_header.view_sos.isHidden = true
            self.view_header.view_bag.isHidden = true
        // header action
        self.view_footer.setup(b1: true, b2: false, b3: false)
        self.view_footer.label_Fprocess_two.text = "Products"
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.vendorproduct), for: .touchUpInside)
       // self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
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
        
        print("confirm status",status)
        if bookval != ""{
            self.label_confrim_date.text = bookval
            
        }
        if details != "" {
            self.label_confrim_details.text = details
        }
       
//        if status {
//            self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
//        }else{
//            self.view_pathline.backgroundColor = UIColor.gray
//        }
    }
    
//    func isrejectedorder(status: Bool, bookval : String, details: String){
//        self.view_rejected.isHidden = status
//        self.label_rejected_details.text = details
//        self.label_rejected_date.text = bookval
//        self.view_confrim_pathline.isHidden = false
//        self.view_rejected_pathline.isHidden = false
//        self.view_pathline.isHidden = false
//    }
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
    
    func isdispatchorder(status: Bool, bookval : String, details: String){
        print("dispatched status",status)
        self.view_dispatched.isHidden = false
        if details != "" {
            self.label_dispatch_details.text = details
            self.label_confrim_details.text = ""
        }
        self.label_dispatch_date.text = bookval
        self.label_transit_date.text = bookval
        self.view_dispatch_pathline.isHidden = false
        self.view_confrim_pathline.isHidden = false
//        if status {
//            self.view_dispatch_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
//            self.view_confrim_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
//        }else{
//            self.view_dispatch_pathline.backgroundColor = UIColor.gray
//            self.view_confrim_pathline.backgroundColor = UIColor.gray
//        }
    }
    
    func istransitorder(status: Bool, bookval : String){
        print("dispatched status",status)
        self.view_intransit.isHidden = false
        self.label_transit_date.text = bookval
    }
    
    
    func callgetstatuslist(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_status_orderlist, method: .post, parameters:
            ["vendor_id": Servicefile.shared.vendorid,"_id": Servicefile.shared.orderid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        self._id = Data["_id"] as! String
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
                        self.prodcut_image = Data["prodcut_image"] as? String ?? Servicefile.sample_img
                        self.prodouct_total = Data["prodouct_total"] as? Int ?? 0
                        self.product_name = Data["product_name"] as? String ?? ""
                        self.product_price = Data["product_price"] as? Int ?? 0
                        self.product_quantity = Data["product_quantity"] as? Int ?? 0
                        self.shipping_address = Data["shipping_address"] as? String ?? ""
                        self.shipping_address_id = Data["shipping_address_id"] as? String ?? ""
                        self.shipping_charge = Data["shipping_charge"] as? Int ?? 0
                        self.status = Data["status"] as? String ?? ""
                        self.user_cancell_date = Data["user_cancell_date"] as? String ?? ""
                        self.user_cancell_info = Data["user_cancell_info"] as? String ?? ""
                        self.vendor_accept_cancel = Data["vendor_accept_cancel"] as? String ?? ""
                        self.vendor_cancell_date = Data["vendor_cancell_date"] as? String ?? ""
                        self.vendor_cancell_info = Data["vendor_cancell_info"] as? String ?? ""
                        self.vendor_complete_date = Data["vendor_complete_date"] as? String ?? ""
                        self.vendor_complete_info = Data["vendor_complete_info"] as? String ?? ""
                        let prodcut_track_details = Data["prodcut_track_details"] as! NSArray
                        self.product_title.text = self.product_name
                        self.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: self.prodcut_image)) { (image, error, cache, urls) in
                            if (error != nil) {
                                self.image_product.image = UIImage(named: imagelink.sample)
                            } else {
                                self.image_product.image = image
                            }
                        }
                        self.label_orderdate.text = self.date_of_booking
                        self.label_id.text = self.order_id
                        self.label_paymentmethod.text = "Online"
                        self.label_ordertotal.text = "₹" + String(self.grand_total)
                        self.label_quality.text = String(self.product_quantity)
                        for i in 0..<prodcut_track_details.count{
                            let itdata = prodcut_track_details[i] as! NSDictionary
                            let Status = itdata["Status"] as! Bool
                            let date = itdata["date"] as! String
                            let id = itdata["id"] as! Int
                            let title = itdata["title"] as! String
                            if title == "Order Booked" {
                                self.isbookstatus(status: Status, bookval : date)
                                
                            }else if title == "Order Accept" {
                                self.isconfirmorder(status: Status, bookval : date, details: self.vendor_complete_info, other: false)
                                if Status {
                                    self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.image_confrim_status.image = UIImage(named: "success")
                                }
                            }else if title == "Order Dispatch" {
                                self.isdispatchorder(status: Status, bookval : date, details: self.vendor_complete_info)
                                if Status {
                                self.image_dispatched.image = UIImage(named: "success")
                                self.image_transit.image = UIImage(named: "success")
                                self.view_dispatch_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    
                                }
                               
                            }else if title == "Order Cancelled" {
                                self.isconfirmorder(status: Status, bookval : date, details: self.user_cancell_info, other: Status)
                                if Status {
                                    self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.image_confrim_status.image = UIImage(named: "047")
                                    self.image_confrim_status.backgroundColor = .clear
                                    
                                }
                                
                            }else if title == "Vendor cancelled" {
                                    self.isconfirmorder(status: Status, bookval : date, details: self.vendor_cancell_info, other: Status)
                                if Status {
                                    self.view_pathline.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                                    self.image_confrim_status.image = UIImage(named: "047")
                                    self.image_confrim_status.backgroundColor = .clear
                                   
                                }
                            }else{
                                self.istransitorder(status: Status, bookval : date)
                                
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
    
   
    
    
}
