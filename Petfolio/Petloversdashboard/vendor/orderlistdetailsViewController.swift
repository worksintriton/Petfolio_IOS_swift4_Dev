//
//  orderlistdetailsViewController.swift
//  Petfolio
//
//  Created by Admin on 22/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class orderlistdetailsViewController: UIViewController {

    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var product_title: UILabel!
    @IBOutlet weak var Label_product_amt: UILabel!
    
    @IBOutlet weak var Label_status: UILabel!
    @IBOutlet weak var image_status: UIImageView!
    @IBOutlet weak var label_status_date: UILabel!
    @IBOutlet weak var view_status: UIView!
    
    @IBOutlet weak var label_orderdate: UILabel!
    @IBOutlet weak var label_id: UILabel!
    @IBOutlet weak var label_paymentmethod: UILabel!
    @IBOutlet weak var label_ordertotal: UILabel!
    @IBOutlet weak var label_quality: UILabel!
    //@IBOutlet weak var label_shipping_address: UILabel!
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    @IBOutlet weak var label_ship_name: UILabel!
    @IBOutlet weak var label_doorno_street: UILabel!
    @IBOutlet weak var label_city_state: UILabel!
    @IBOutlet weak var label_phone: UILabel!
    
    @IBOutlet weak var label_landmark: UILabel!
    @IBOutlet weak var view_footer: petowner_footerview!
    
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
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.intial_setup_action()
        self.label_orderdate.text = ""
        self.label_id.text = ""
        self.label_paymentmethod.text = ""
        self.label_ordertotal.text = "₹" + String(0)
        self.Label_product_amt.text = "₹" + String(0)
        self.label_quality.text = "₹" + String(0)
        self.product_title.text = ""
        self.image_product.image = UIImage(named: Servicefile.sample_img)
        self.view_status.isHidden = true
        self.callgetstatuslist()
        
        
        // Do any additional setup after loading the view.
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Order details"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
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
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_bel(_ sender: Any) {
    }
    @IBAction func action_profile(_ sender: Any) {
    }
    @IBAction func action_bag(_ sender: Any) {
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
                        self.shipping_address = Data["shipping_details"] as! String
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
                        self.image_product.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                        self.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: self.prodcut_image)) { (image, error, cache, urls) in
                            if (error != nil) {
                                self.image_product.image = UIImage(named: imagelink.sample)
                            } else {
                                self.image_product.image = image
                            }
                        }
                        self.image_product.contentMode = .scaleAspectFill
                        self.view_status.isHidden = false
                        self.label_orderdate.text = self.date_of_booking
                        self.label_id.text = self.order_id
                        self.label_paymentmethod.text = "Online"
                        self.label_ordertotal.text = "₹" + String(self.grand_total)
                        self.Label_product_amt.text = "₹" + String(self.grand_total)
                        self.label_quality.text = String(self.product_quantity)
                        if Servicefile.shared.ordertype == "" {
                            self.image_status.image = UIImage(named: "success")
                        }else{
                            self.image_status.image = UIImage(named: "047")
                        }
                        for i in 0..<prodcut_track_details.count{
                            let itdata = prodcut_track_details[i] as! NSDictionary
                            let Status = itdata["Status"] as! Bool
                            let date = itdata["date"] as! String
                            let id = itdata["id"] as! Int
                            let title = itdata["title"] as! String
                            if Servicefile.shared.ordertype == "Complete" {
                                if title == "Order Dispatch" {
                                    self.label_status_date.text = date
                                    self.Label_status.text = "Delivered on"
                                }
                            }else if Servicefile.shared.ordertype == "current"{
                                if title == "Order Booked" {
                                    self.Label_status.text = "Booked on"
                                    self.label_status_date.text = date
                                }
                                
                            }else{
                                if title == "Order Cancelled" || title == "Vendor cancelled"{
                                    self.Label_status.text = "Cancelled on"
                                    self.label_status_date.text = date
                                }
                                
                            }
                        }
                        let shipping_details_id = Data["shipping_details_id"] as? NSDictionary ?? ["":""]
                        let city =  shipping_details_id["user_city"] as? String ?? ""
                        let Fname =  shipping_details_id["user_first_name"] as? String ?? ""
                        let lname =  shipping_details_id["user_last_name"] as? String ?? ""
                        let Doorno =  shipping_details_id["user_flat_no"] as? String ?? ""
                        let user_stree =  shipping_details_id["user_stree"] as? String ?? ""
                        let user_mobile =  shipping_details_id["user_mobile"] as? String ?? ""
                        let user_picocode =  shipping_details_id["user_picocode"] as? String ?? ""
                        let user_landmark =  shipping_details_id["user_landmark"] as? String ?? ""
                        let user_state =  shipping_details_id["user_state"] as? String ?? ""
                        self.label_ship_name.text = Fname + " " + lname
                        self.label_doorno_street.text = Doorno + ", " + user_stree +  ", "
                        self.label_city_state.text = city + ", " + user_state +  " - " + user_picocode + ". "
                        
                        self.label_landmark.text = "Landmark : " + " " + user_landmark + ". "
                        self.label_phone.text = "Phone : " + " " + user_mobile + ". "
                        self.image_status.image = UIImage(named: "success")
                        //self.label_shipping_address.text = self.shipping_address
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
