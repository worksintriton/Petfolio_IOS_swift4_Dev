//
//  pet_sp_app_payment_ViewController.swift
//  Petfolio
//
//  Created by Admin on 19/08/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//


import UIKit
import Alamofire
import Toucan
import MobileCoreServices
import SDWebImage
import Razorpay
import SafariServices
import WebKit

class pet_sp_app_payment_ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate , RazorpayPaymentCompletionProtocol, RazorpayPaymentCompletionProtocolWithData {
    
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    
    
    var razorpay: RazorpayCheckout!
    
    
    @IBOutlet weak var label_clinicname: UILabel!
    @IBOutlet weak var label_docname: UILabel!
    
    @IBOutlet weak var label_petname: UILabel!
    @IBOutlet weak var label_app_type: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    @IBOutlet weak var label_bookingdatetime: UILabel!
    @IBOutlet weak var img_online: UIImageView!
    @IBOutlet weak var img_cash: UIImageView!
    @IBOutlet weak var textfield_coupon: UITextField!
    @IBOutlet weak var label_applyremove: UILabel!
    @IBOutlet weak var label_app_cost: UILabel!
    @IBOutlet weak var label_app_discount: UILabel!
    @IBOutlet weak var label_total_app_discount: UILabel!
    @IBOutlet weak var view_coupon: UIView!
    @IBOutlet weak var view_isonline: UIView!
    @IBOutlet weak var View_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_appremove: UIView!
    @IBOutlet weak var view_makepay: UIView!
    @IBOutlet weak var view_textfield_coupon: UIView!
    @IBOutlet weak var view_popupbook: UIView!
    
    var pay_method = "Online"
    var textbtncoupon = "Apply"
    var discountprice = "0"
    var originalprice = "0"
    var totalprice = "0"
    var coupon_status = "Not Applied" // "Applied"
    var couponcode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_popupbook.view_cornor()
        self.view_makepay.view_cornor()
        self.view_popup.view_cornor()
        self.view_appremove.view_cornor()
        self.view_textfield_coupon.view_cornor()
        self.intial_setup_action()
        self.label_clinicname.text = Servicefile.shared.service_id_title
        self.label_docname.text = Servicefile.shared.sp_bussiness_name
        self.label_app_type.text = Servicefile.shared.pet_apoint_appointment_types
        self.label_cost.text = "₹ " + String(Servicefile.shared.pet_apoint_amount)
        self.label_bookingdatetime.text = Servicefile.shared.pet_apoint_booking_date + " " + Servicefile.shared.pet_apoint_booking_time
        self.label_app_cost.text = "₹ " + String(Servicefile.shared.service_id_amount)
        self.label_total_app_discount.text = "₹ " + String(Servicefile.shared.service_id_amount)
        self.label_petname.text =  Servicefile.shared.pet_petlist[Servicefile.shared.pet_index].pet_name
        self.checkradio(str: pay_method)
        self.label_app_discount.text = "0"
        self.discountprice = "0"
        self.originalprice = String(Servicefile.shared.service_id_amount)
        self.totalprice = String(Servicefile.shared.service_id_amount)
        self.label_applyremove.text = textbtncoupon
        self.view_isonline.isHidden = true
        coupon_status = "Not Applied" // "Applied"
        self.couponcode = ""
        self.View_shadow.isHidden = true
        self.view_popup.isHidden = true
    }
    
    func checkradio(str: String){
        if pay_method != "Online" {
            coupon_status = "Not Applied" // "Applied"
            self.couponcode = ""
            self.img_online.image = UIImage(named: imagelink.Radio)
            self.img_cash.image = UIImage(named: imagelink.selectedRadio)
            self.view_isonline.isHidden = true
        }else{
            coupon_status = "Not Applied" // "Applied"
            self.couponcode = ""
            self.img_online.image = UIImage(named: imagelink.selectedRadio)
            self.img_cash.image = UIImage(named: imagelink.Radio)
            self.view_isonline.isHidden = true
        }
    }
    
    @IBAction func action_online(_ sender: Any) {
        self.pay_method = "Online"
        removedata()
        self.checkradio(str: pay_method)
    }
    
    @IBAction func action_cash(_ sender: Any) {
        self.pay_method = "Cash"
        removedata()
        self.checkradio(str: pay_method)
    }
    
    func intial_setup_action(){
        // header action
        self.view_subpage_header.label_header_title.text = "Appoinment"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: false, b2: false, b3: true, b4: false)
        // header action
    }
    
    
    @IBAction func action_makepay(_ sender: Any) {
        self.checkappointdetails()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    @IBAction func action_applyremove(_ sender: Any) {
        if textbtncoupon != "Remove" {
            coupon_status = "Applied" // "Not Applied"
            self.callcheckcoupon()
        }else{
            removedata()
        }
        
    }
    
    func removedata(){
        couponcode = ""
        coupon_status =  "Not Applied" // "Applied"
        self.textfield_coupon.text = ""
        self.textbtncoupon = "Apply"
        self.view_isonline.isHidden = true
        self.label_applyremove.text = self.textbtncoupon
        self.discountprice = "0"
        self.label_app_discount.text = "₹ " + self.discountprice
        self.totalprice = String(Servicefile.shared.pet_apoint_amount)
        self.label_total_app_discount.text = "₹ " + self.totalprice
    }
    
    @IBAction func action_view_appointmentbooked(_ sender: Any) {
        let vc = UIStoryboard.Pet_applist_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func checkappointdetails(){
        //        if self.textfield_petname.text == "" {
        //            self.alert(Message: "please enter the petname")
        //        }else if self.textfield_pettype.text == "" {
        //            self.alert(Message: "please select the pet type")
        //        }else if self.textfield_petbreed.text == "" {
        //            self.alert(Message: "please select the pet breed")
        //        }else if self.textfield_alergies.text == "" {
        //            self.alert(Message: "please enter the allergy")
        //        }else if self.textview_descrip.text == "" {
        //            self.alert(Message: "please enter the description")
        //        }else if self.textview_descrip.text == "Add comment here.." {
        //            self.alert(Message: "please enter the description")
        //        }else if self.petimage == ""{
        //            self.alert(Message: "please upload the")
        //        }else{
        print("discount_price" , Int(self.discountprice)!,
              "original_price" , Int(self.originalprice)!,
              "total_price" , Int(self.totalprice)!,
              "coupon_status" , coupon_status,
              "coupon_code" , couponcode)
        if Servicefile.shared.pet_apoint_communication_type == "Visit" {
            if Servicefile.shared.pet_apoint_visit_type == "" {
                self.alert(Message: "Please select the visit type")
            }else{
                showPaymentForm()
            }
        }else{
            showPaymentForm()
            
        }
        
        
        //        }
    }
    
    func callcheckcoupon(){
        print("current_date" , Servicefile.shared.MMddyyyystringformat(date: Date()),
              "total_amount" , Servicefile.shared.pet_apoint_amount,
              "coupon_type" , "2",
              "user_id" , Servicefile.shared.userid,
              "code", self.textfield_coupon.text!)
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_coupon, method: .post, parameters:
                                                                    ["current_date" : Servicefile.shared.MMddyyyystringformat(date: Date()),
                                                                     "total_amount" : Servicefile.shared.pet_apoint_amount,
                                                                     "coupon_type" : "2",
                                                                     "user_id" : Servicefile.shared.userid,
                                                                     "code": self.textfield_coupon.text!], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                let data  = res["Data"] as! NSDictionary
                                                                                self.textbtncoupon = "Remove"
                                                                                self.view_isonline.isHidden = false
                                                                                self.couponcode = self.textfield_coupon.text!
                                                                                self.label_applyremove.text = self.textbtncoupon
                                                                                self.discountprice = String(data["discount_price"] as! Int)
                                                                                self.label_app_discount.text = "₹ " + self.discountprice
                                                                                self.originalprice = String(data["original_price"] as! Int)
                                                                                self.totalprice = String(data["total_price"] as! Int)
                                                                                self.label_total_app_discount.text = "₹ " + self.totalprice
                                                                                let Message = res["Message"] as? String ?? ""
                                                                                self.alert(Message: Message)
                                                                            }else{
                                                                                let Message = res["Message"] as? String ?? ""
                                                                                self.alert(Message: Message)
                                                                            }
                                                                            break
                                                                        case .failure(let Error):
                                                                            self.stopAnimatingActivityIndicator()
                                                                            
                                                                            break
                                                                        }
                                                                     }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    
    
        
    func moveTextField(textview: UITextView, up: Bool){
        let movementDistance:CGFloat = -230
        let movementDuration: Double = 0.3
        var movement:CGFloat = 0
        if up {
            movement = movementDistance
        } else {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func showPaymentForm(){
        if Int(self.totalprice)! != 0 {
            let data = Double(Int(self.totalprice)!) * Double(100)
            print("value changed",data)
            self.razorpay = RazorpayCheckout.initWithKey("rzp_test_zioohqmxDjJJtd", andDelegate: self)
            let options: [String:Any] = [
                "amount": data, //This is in currency subunits. 100 = 100 paise= INR 1.
                "currency": "INR",//We support more that 92 international currencies.
                "description": "",
                "image": "http://52.25.163.13:3000/api/uploads/template.png",
                "name": Servicefile.shared.first_name,
                "prefill": [
                    "contact": Servicefile.shared.user_phone,
                    "email": Servicefile.shared.user_email
                ],
                "theme": [
                 "color": Servicefile.shared.appgreen
                ]
            ]
            
            if let rzp = self.razorpay {
                // rzp.open(options)
                rzp.open(options,displayController:self)
            } else {
                print("Unable to initialize")
            }
            
            //        self.razorpay = RazorpayCheckout.initWithKey("rzp_test_zioohqmxDjJJtd", andDelegate: self)
            //               let options: [AnyHashable:Any] = [
            //                   "amount": 100, //This is in currency subunits. 100 = 100 paise= INR 1.
            //                   "currency": "INR",//We support more that 92 international currencies.
            //                   "description": "some data",
            //                   "order_id": "order_DBJOWzybf0sJbb",
            //                   "image": "http://52.25.163.13:3000/api/uploads/template.png",
            //                   "name": "sriram",
            //                   "prefill": [
            //                       "contact": "9003525711",
            //                       "email": "sriramchanr@gmail.com"
            //                   ],
            //                   "theme": [
            //                       "color": "#F37254"
            //                   ]
            //               ]
            //               if let rzp = self.razorpay {
            //                   rzp.open(options)
            //               } else {
            //                   print("Unable to initialize")
            //               }
        }
    }
           
           func onPaymentError(_ code: Int32, description str: String) {
                   print("Payment failed with code")
            self.callpaymentfail()
              }
              
              func onPaymentSuccess(_ payment_id: String) {
                    print("Payment Success payment")
                Servicefile.shared.pet_apoint_payment_id = payment_id
                 self.callsubmit()
              }
           
           func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
                  print("error: ", code)
                 
              }
              
              func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
                  print("success: ", payment_id)
                  
              }
    
    func callsubmit(){
              self.startAnimatingActivityIndicator()
          if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_createappointm, method: .post, parameters:
             ["sp_id" : Servicefile.shared.sp_user_id,
              "booking_date" :  Servicefile.shared.pet_apoint_booking_date,
              "booking_time" : Servicefile.shared.pet_apoint_booking_time,
              "booking_date_time" : Servicefile.shared.pet_apoint_booking_date + " " + Servicefile.shared.pet_apoint_booking_time,
              "user_id" : Servicefile.shared.userid,
              "pet_id" : Servicefile.shared.pet_apoint_pet_id,
              "additional_info" : Servicefile.shared.pet_apoint_problem_info,
              "sp_attched" : [],
              "sp_feedback" : "",
              "sp_rate" : "",
              "user_feedback" : "",
              "user_rate" : "0",
              "display_date" : Servicefile.shared.pet_apoint_display_date,
              "server_date_time" : "",
              "payment_id" : Servicefile.shared.pet_apoint_payment_id,
              "payment_method" : pay_method,
              "service_name" : Servicefile.shared.service_id_title,
              "service_amount" : Servicefile.shared.service_id_amount,
              "service_time" : Servicefile.shared.service_id_time,
              "completed_at" : "",
              "missed_at" : "",
              "mobile_type" : "IOS",
              "discount_price" : Int(self.discountprice)!,
              "original_price" : Int(self.originalprice)!,
              "total_price" : Int(self.totalprice)!,
              "coupon_status" : coupon_status,
              "coupon_code" : couponcode], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                  switch (response.result) {
                                                  case .success:
                                                        let res = response.value as! NSDictionary
                                                        print("success data",res)
                                                        let Code  = res["Code"] as! Int
                                                        if Code == 200 {
                                                           self.View_shadow.isHidden = false
                                                           self.view_popup.isHidden = false
                                                           self.stopAnimatingActivityIndicator()
                                                        }else{
                                                          self.stopAnimatingActivityIndicator()
                                                          print("status code service denied")
                                                            let Message = res["Message"] as? String ?? ""
                                                           self.alert(Message: Message)
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
    
    func callpaymentfail(){
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_notification, method: .post, parameters:
               ["appointment_UID": "",
                "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                "sp_id":Servicefile.shared.sp_user_id,
                "status":"Payment Failed",
                "user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                   switch (response.result) {
                   case .success:
                       let res = response.value as! NSDictionary
                       print("success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                       }else{
                       }
                       break
                   case .failure(_):
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