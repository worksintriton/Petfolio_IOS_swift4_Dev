//
//  sp_shop_shippingaddressViewController.swift
//  Petfolio
//
//  Created by Admin on 17/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

 import UIKit
 import Alamofire
 import Razorpay
 import SafariServices
 import WebKit

class sp_shop_shippingaddressViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource , RazorpayPaymentCompletionProtocol, RazorpayPaymentCompletionProtocolWithData {

            @IBOutlet weak var tableview_list_address: UITableView!
            @IBOutlet weak var label_cost: UILabel!
            
            @IBOutlet weak var View_final_pay: UIView!
            var razorpay: RazorpayCheckout!
            var selectedid = ""
            
        @IBOutlet weak var view_header: petowner_otherpage_header!
        @IBOutlet weak var view_shadow: UIView!
            @IBOutlet weak var view_alert: UIView!
            @IBOutlet weak var view_btn_alert: UIView!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
                self.intial_setup_action()
                self.view_shadow.isHidden = true
                self.view_alert.isHidden = true
                self.view_alert.view_cornor()
                self.view_btn_alert.view_cornor()
                self.label_cost.text = "INR " + String(Servicefile.shared.labelamt_total)
                Servicefile.shared.shipaddresslist.removeAll()
                self.View_final_pay.view_cornor()
                self.tableview_list_address.register(UINib(nibName: "shipingaddressTableViewCell", bundle: nil), forCellReuseIdentifier: "listaddress")
                // Do any additional setup after loading the view.
                self.tableview_list_address.delegate = self
                self.tableview_list_address.dataSource = self
               
            }
        
        func intial_setup_action(){
        // header action
            self.view_header.label_header_title.text = "Shipping Address"
            self.view_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
            self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
            self.view_header.view_profile.isHidden = true
            self.view_header.view_sos.isHidden = true
            self.view_header.view_bel.isHidden = true
            self.view_header.view_bag.isHidden = true
        // header action
        
        }
            
            override func viewWillDisappear(_ animated: Bool) {
                    if let firstVC = presentingViewController as? pet_vendor_editshiplistViewController {
                              DispatchQueue.main.async {
                               firstVC.viewWillAppear(true)
                              }
                          }
            }
            
            override func viewWillAppear(_ animated: Bool) {
                Servicefile.shared.shipaddresslist.removeAll()
                self.tableview_list_address.reloadData()
                self.call_list_shipping_address()
            }
            
            
            @IBAction func action_success_continue(_ sender: Any) {
                let vc = UIStoryboard.sp_shop_dashboard_ViewController()
                self.present(vc, animated: true, completion: nil)
               
                
            }
            
            @IBAction func action_back(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
            }
            
            @IBAction func action_changeaddress(_ sender: Any) {
                Servicefile.shared.shipaddresslist.removeAll()
                let vc = UIStoryboard.sp_editshippingaddress_ViewController()
                self.present(vc, animated: true, completion: nil)
            }
            
            @IBAction func action_final_pay(_ sender: Any) {
                if Servicefile.shared.shipaddresslist.count > 0{
                    self.showPaymentForm()
                }else{
                    let alert = UIAlertController(title: "", message: "No address found Please add the address", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        Servicefile.shared.long = 0.0
                        Servicefile.shared.lati = 0.0
                        Servicefile.shared.locaaccess = "Add"
                        Servicefile.shared.ishiping = "ship"
                        let vc = UIStoryboard.pet_vendor_shipingaddlocationViewController()
                        self.present(vc, animated: true, completion: nil)
                        
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                       
            }
            
            func showPaymentForm(){
                if Servicefile.shared.labelamt_total != 0 {
                    let data = Double(Servicefile.shared.labelamt_total) * Double(100)
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
                }else{
                    self.callsubmitproduct()
                }
               }
               
               func onPaymentError(_ code: Int32, description str: String) {
                   print("Payment failed with code")
                  
               }
               
               func onPaymentSuccess(_ payment_id: String) {
                   print("Payment Success payment")
                   Servicefile.shared.pet_apoint_payment_id = payment_id
                    self.callsubmitproduct()
                  
               }
               
               func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
                   print("error: ", code)
                   
               }
               
               func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
                   print("success: ", payment_id)
                   
               }
            
            
            func callsubmitproduct(){
                self.startAnimatingActivityIndicator()
                if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Createproduct, method: .post, parameters:
                    ["user_id":Servicefile.shared.userid,
                     "payment_id" : Servicefile.shared.pet_apoint_payment_id,
                     "Data": Servicefile.shared.cartdata,
                     "date_of_booking_display" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                     "date_of_booking" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                     "prodouct_total": Servicefile.shared.labelamt_subtotal,
                     "shipping_charge": Servicefile.shared.labelamt_shipping,
                     "shipping_details_id": self.selectedid,
                     "coupon_code" : Servicefile.shared.prod_couponcode,
                     "coupon_status" :  Servicefile.shared.prod_couponstatus,
                     "coupon_discount_price":Servicefile.shared.prod_coupondiscountprice,
                     "original_price" :  Servicefile.shared.prod_originalprice,
                     "total_price" : Servicefile.shared.prod_totalprice,
                     "discount_price": Servicefile.shared.labelamt_discount,
                     "shipping_address_id" : "",
                     "billling_address_id" : "",
                     "shipping_address" : "",
                     "billing_address" : "",
                     "grand_total": Servicefile.shared.labelamt_total], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                        switch (response.result) {
                        case .success:
                            let res = response.value as! NSDictionary
                            print("create order success data",res)
                            let Code  = res["Code"] as! Int
                            if Code == 200 {
                                Servicefile.shared.pet_apoint_payment_id = ""
                                self.view_shadow.isHidden = false
                                self.view_alert.isHidden = false
                                self.stopAnimatingActivityIndicator()
                            }else{
                                
                                self.stopAnimatingActivityIndicator()
                            }
                            break
                        case .failure( _):
                            
                            self.stopAnimatingActivityIndicator()
                            
                            break
                        }
                    }
                }else{
                    self.stopAnimatingActivityIndicator()
                    self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
                }
            }
            
            
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return Servicefile.shared.shipaddresslist.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell: shipingaddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listaddress", for: indexPath) as! shipingaddressTableViewCell
                let details = Servicefile.shared.shipaddresslist[indexPath.row] as! NSDictionary
                let user_det = details["user_id"] as! NSDictionary
                
        //        "_id": "605a4b9cbaeb4c22731c9248",
        //                "user_id": "604081d12c2b43125f8cb840",
        //                "user_first_name": "SandySan",
        //                "user_last_name": "Kumar",
        //                "user_flat_no": "225/1,",
        //                "user_stree": "Duraiswamy Nagar Main Road",
        //                "user_landmark": "Mariyamman Kovil near By",
        //                "user_picocode": "636009",
        //                "user_state": "TamilNadu",
        //                "user_city": "Salem",
        //                "user_mobile": "948773536",
        //                "user_alter_mobile": "9443135306",
        //                "user_address_stauts": "Last Used",
        //                "user_address_type": "Home",
        //                "user_display_date": "24-03-2021",
        //                "updatedAt": "2021-03-23T20:19:20.031Z",
        //                "createdAt": "2021-03-23T20:12:12.991Z",
        //                "__v": 0
                let fname  = user_det["first_name"] as? String ?? ""
                let lname  = user_det["last_name"] as? String ?? ""
                let user_phone = user_det["user_phone"] as? String ?? "" + ", "
                let location_nickname = details["location_nickname"] as? String ?? "" + ", "
                let location_city =  details["location_city"] as? String ?? ""
                self.selectedid = details["_id"] as? String ?? ""
                cell.label_name.text = fname + " " + lname
                cell.label_mobileno.text = user_phone
                cell.label_addressline1.text = location_nickname
                cell.label_addressline2.text = location_city
                cell.label_addressline3.text = details["location_address"] as? String ?? ""
                cell.label_add_type.text = details["location_title"] as? String ?? ""
                cell.view_main.view_cornor()
                cell.view_add_type.view_cornor()
                cell.view_add_type.layer.borderWidth = 0.5
                cell.selectionStyle = .none
                cell.view_add_type.layer.borderColor = UIColor.lightGray.cgColor
                cell.btn_delete.tag = indexPath.row
                cell.btn_edit.tag = indexPath.row
                
                        return cell
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 180
            }
            
            func call_list_shipping_address(){
                self.startAnimatingActivityIndicator()
                if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_shiping_address_list, method: .post, parameters:
                                                                            ["user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                                switch (response.result) {
                                                                                case .success:
                                                                                    let res = response.value as! NSDictionary
                                                                                    print("success data",res)
                                                                                    let Code  = res["Code"] as! Int
                                                                                    if Code == 200 {
                                                                                        Servicefile.shared.shipaddresslist.removeAll()
                                                                                        let data = res["Data"] as! NSDictionary
                                                                                        let id = data["_id"] as? String ?? ""
                                                                                        if id != "" {
                                                                                            Servicefile.shared.shipaddresslist.append(data)
                                                                                        }
                                                                                        self.tableview_list_address.reloadData()
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
                    self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
                }
                
            }
          

        }
