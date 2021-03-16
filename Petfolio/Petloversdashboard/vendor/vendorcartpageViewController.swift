//
//  vendorcartpageViewController.swift
//  Petfolio
//
//  Created by Admin on 10/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Razorpay
import SafariServices
import WebKit

class vendorcartpageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , RazorpayPaymentCompletionProtocol, RazorpayPaymentCompletionProtocolWithData {
    
    
    @IBOutlet weak var textfield_coupon: UITextField!
    @IBOutlet weak var tbl_productlist: UITableView!
    
    @IBOutlet weak var label_subtotal_itmcount: UILabel!
    @IBOutlet weak var label_amt_subtotal: UILabel!
    @IBOutlet weak var label_amt_discount: UILabel!
    @IBOutlet weak var label_amt_shipping: UILabel!
    @IBOutlet weak var label_amt_total: UILabel!
    @IBOutlet weak var label_coupon: UILabel!
    
    @IBOutlet weak var view_proceedtobuy: UIView!
    var cartdata = [Any]()
    
    var labelamt_total = 0
    var labelamt_discount = 0
    var labelamt_shipping = 0
    var labelamt_subtotal = 0
    var labelsubtotal_itmcount = 0
     var razorpay: RazorpayCheckout!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_proceedtobuy.view_cornor()
        self.tbl_productlist.delegate = self
        self.tbl_productlist.dataSource = self
        self.callcartdetails()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        
    }
    
    @IBAction func action_notification(_ sender: Any) {
        
    }
    
    
    @IBAction func action_profile(_ sender: Any) {
        
    }
    
    @IBAction func action_home(_ sender: Any) {
        
    }
    
    @IBAction func action_petservice(_ sender: Any) {
    }
    
    @IBAction func action_petcares(_ sender: Any) {
        
    }
    
    @IBAction func action_comunity(_ sender: Any) {
        
    }
    
    @IBAction func action_coupon(_ sender: Any) {
        
    }
    
    @IBAction func action_proceedtobuy(_ sender: Any) {
        self.showPaymentForm()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cartproductTableViewCell
        cell.view_inc.layer.cornerRadius = cell.view_inc.frame.size.height / 2
        cell.view_dec.layer.cornerRadius = cell.view_dec.frame.size.height / 2
        let cartlist =  self.cartdata[indexPath.row] as! NSDictionary
        let productdata = cartlist["product_id"] as! NSDictionary
        let product_img = productdata["product_img"] as! NSArray
        cell.label_product_title.text = productdata["product_name"] as? String ?? ""
        cell.label_product_cart_count.text = String(cartlist["product_count"] as? Int ?? 0)
        cell.label_offer.text = String(productdata["discount"] as? Int ?? 0) + " % off"
        let costamt = "₹ " + String(productdata["cost"] as? Int ?? 0)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: costamt)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.label_product_amt.attributedText = attributeString
        cell.label_final_amt.text = "₹ " + String(productdata["discount_amount"] as? Int ?? 0)
        if product_img.count > 0 {
            cell.img_product.sd_setImage(with: Servicefile.shared.StrToURL(url: product_img[0] as? String ?? Servicefile.sample_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_product.image = UIImage(named: "sample")
                } else {
                    cell.img_product.image = image
                }
            }
        }
        cell.btn_decrement.tag = indexPath.row
        cell.btn_increament.tag = indexPath.row
        cell.btn_decrement.addTarget(self, action: #selector(action_decreament), for: .touchUpInside)
        cell.btn_increament.addTarget(self, action: #selector(action_insert), for: .touchUpInside)
        return cell
    }
    
    @objc func action_insert(sender: UIButton){
        let tag = sender.tag
        let cartlist =  self.cartdata[tag] as! NSDictionary
        let productdata = cartlist["product_id"] as! NSDictionary
        Servicefile.shared.product_id = productdata["_id"] as! String
        self.callinctheproductcount()
    }
    
    @objc func action_decreament(sender: UIButton){
         let tag = sender.tag
               let cartlist =  self.cartdata[tag] as! NSDictionary
               let productdata = cartlist["product_id"] as! NSDictionary
               Servicefile.shared.product_id = productdata["_id"] as! String
        self.calldectheproductcount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func showPaymentForm(){
        if self.labelamt_total != 0 {
               let data = Double(self.labelamt_total) * Double(100)
               print("value changed",data)
               self.razorpay = RazorpayCheckout.initWithKey("rzp_test_zioohqmxDjJJtd", andDelegate: self)
               let options: [String:Any] = [
                   "amount": data, //This is in currency subunits. 100 = 100 paise= INR 1.
                   "currency": "INR",//We support more that 92 international currencies.
                   "description": "some some",
                   "image": "http://52.25.163.13:3000/api/uploads/template.png",
                   "name": "sriram",
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
    
}
extension vendorcartpageViewController {
    
    func callsubmitproduct(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Createproduct, method: .post, parameters:
            ["user_id":Servicefile.shared.userid,
             "payment_id" : Servicefile.shared.pet_apoint_payment_id,
             "Data": self.cartdata,
             "date_of_booking_display" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "date_of_booking" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "prodouct_total": self.labelamt_subtotal,
             "shipping_charge": self.labelamt_shipping,
             "coupon_code" : "",
             "discount_price": self.labelamt_discount,
             "shipping_address_id" : "",
             "billling_address_id" : "",
             "shipping_address" : "",
             "billing_address" : "",
             "grand_total": self.labelamt_total], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("create order success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.pet_apoint_payment_id = ""
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func callcartdetails(){
        print("product_id", Servicefile.shared.product_id,"user_id",Servicefile.shared.userid)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.cartdetails, method: .post, parameters:
            ["user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data = res["Data"] as! NSArray
                        let discount_price = res["discount_price"] as? Int ?? 0
                        let grand_total = res["grand_total"] as? Int ?? 0
                        _ = res["prodcut_count"] as? Int ?? 0
                        let prodcut_item_count = res["prodcut_item_count"] as? Int ?? 0
                        let prodouct_total = res["prodouct_total"] as? Int ?? 0
                        let shipping_charge = res["shipping_charge"] as? Int ?? 0
                        self.cartdata = data as! [Any]
                        self.labelamt_total = grand_total
                        self.labelamt_discount = discount_price
                        self.labelamt_shipping = shipping_charge
                        self.labelamt_subtotal = prodouct_total
                        self.labelsubtotal_itmcount = prodcut_item_count
                        self.label_amt_total.text = String(self.labelamt_total)
                        self.label_amt_discount.text = String(self.labelamt_discount)
                        self.label_amt_shipping.text = String(self.labelamt_shipping)
                        self.label_amt_subtotal.text = String(self.labelamt_subtotal)
                        self.label_subtotal_itmcount.text = "Subtotal (" + String(self.labelsubtotal_itmcount) + ")"
                        self.tbl_productlist.reloadData()
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    
    func callinctheproductcount(){
        print("product_id", Servicefile.shared.product_id,"user_id",Servicefile.shared.userid)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.inc_prod_count, method: .post, parameters:
            ["product_id": Servicefile.shared.product_id,"user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.callcartdetails()
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func calldectheproductcount(){
        print("product_id", Servicefile.shared.product_id,"user_id",Servicefile.shared.userid)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.dec_prod_count, method: .post, parameters:
            ["product_id": Servicefile.shared.product_id,"user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.callcartdetails()
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
