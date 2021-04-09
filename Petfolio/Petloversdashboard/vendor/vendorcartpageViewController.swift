//  vendorcartpageViewController.swift
//  Petfolio
//  Created by Admin on 10/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.

import UIKit
import Alamofire

class vendorcartpageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var textfield_coupon: UITextField!
    @IBOutlet weak var tbl_productlist: UITableView!
    @IBOutlet weak var label_subtotal_itmcount: UILabel!
    @IBOutlet weak var label_amt_subtotal: UILabel!
    @IBOutlet weak var label_amt_discount: UILabel!
    @IBOutlet weak var label_amt_shipping: UILabel!
    @IBOutlet weak var label_amt_total: UILabel!
    @IBOutlet weak var label_coupon: UILabel!
    @IBOutlet weak var view_cart_empty: UIView!
    @IBOutlet weak var view_proceedtobuy: UIView!
    
    
    
    // var razorpay: RazorpayCheckout!
    
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_alert: UIView!
    @IBOutlet weak var view_btn_alert: UIView!
    @IBOutlet weak var view_coupon: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.labelamt_total = 0
        Servicefile.shared.labelamt_discount = 0
        Servicefile.shared.labelamt_shipping = 0
        Servicefile.shared.labelamt_subtotal = 0
        Servicefile.shared.labelsubtotal_itmcount = 0
        self.view_cart_empty.isHidden = true
        self.view_shadow.isHidden = true
        self.view_alert.isHidden = true
        self.view_alert.view_cornor()
        self.view_coupon.view_cornor()
        self.view_btn_alert.view_cornor()
        self.view_proceedtobuy.view_cornor()
        self.tbl_productlist.delegate = self
        self.tbl_productlist.dataSource = self
        self.callcartdetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func action_continue(_ sender: Any) {
       
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_vendor_shippingaddressconfrimViewController") as! pet_vendor_shippingaddressconfrimViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.cartdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cartproductTableViewCell
        cell.view_inc.layer.cornerRadius = cell.view_inc.frame.size.height / 2
        cell.view_dec.layer.cornerRadius = cell.view_dec.frame.size.height / 2
        let cartlist = Servicefile.shared.cartdata[indexPath.row] as! NSDictionary
        let productdata = cartlist["product_id"] as! NSDictionary
        let product_img = productdata["product_img"] as! NSArray
        cell.label_product_title.text = productdata["product_name"] as? String ?? ""
        cell.label_product_cart_count.text = String(cartlist["product_count"] as? Int ?? 0)
        
        if String(productdata["discount"] as? Int ?? 0) != "0" {
            cell.label_offer.text = String(productdata["discount"] as? Int ?? 0) + " % off"
        }else{
            cell.label_offer.isHidden = true
        }
        
        let costamt = "₹ " + String(productdata["discount_amount"] as? Int ?? 0)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: costamt)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.label_product_amt.attributedText = attributeString
        cell.label_final_amt.text = "₹ " + String(productdata["cost"] as? Int ?? 0)
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
        let cartlist =  Servicefile.shared.cartdata[tag] as! NSDictionary
        let productdata = cartlist["product_id"] as! NSDictionary
        Servicefile.shared.product_id = productdata["_id"] as! String
        let cartcount = cartlist["product_count"] as? Int ?? 0
        let product_name = cartlist["product_name"] as? String ?? ""
        let threshould = productdata["threshould"] as? String ?? "0"
        if cartcount < Int(threshould)! {
            self.callinctheproductcount()
        }else{
            self.alert(Message: "You can buy only up to "+threshould+" quantity of this "+product_name)
        }
       
    }
    
    @objc func action_decreament(sender: UIButton){
         let tag = sender.tag
        let cartlist =  Servicefile.shared.cartdata[tag] as! NSDictionary
               let productdata = cartlist["product_id"] as! NSDictionary
        let cartcount = cartlist["product_count"] as? Int ?? 0
        let threshould = productdata["threshould"] as? String ?? "0"
        Servicefile.shared.product_id = productdata["_id"] as! String
        if cartcount > 0  {
            if  cartcount <= Int(threshould)! {
            self.calldectheproductcount()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
}
extension vendorcartpageViewController {
    
//    func callsubmitproduct(){
//        self.startAnimatingActivityIndicator()
//        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Createproduct, method: .post, parameters:
//            ["user_id":Servicefile.shared.userid,
//             "payment_id" : Servicefile.shared.pet_apoint_payment_id,
//             "Data": Servicefile.shared.cartdata,
//             "date_of_booking_display" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
//             "date_of_booking" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
//             "prodouct_total": Servicefile.shared.labelamt_subtotal,
//             "shipping_charge": Servicefile.shared.labelamt_shipping,
//             "shipping_details_id": "60587225344d9b55ceeec259",
//             "coupon_code" : "",
//             "discount_price": Servicefile.shared.labelamt_discount,
//             "shipping_address_id" : "",
//             "billling_address_id" : "",
//             "shipping_address" : "",
//             "billing_address" : "",
//             "grand_total": Servicefile.shared.labelamt_total], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
//                switch (response.result) {
//                case .success:
//                    let res = response.value as! NSDictionary
//                    print("create order success data",res)
//                    let Code  = res["Code"] as! Int
//                    if Code == 200 {
//                        Servicefile.shared.pet_apoint_payment_id = ""
//                        self.view_shadow.isHidden = false
//                        self.view_alert.isHidden = false
//                        self.stopAnimatingActivityIndicator()
//                    }else{
//
//                        self.stopAnimatingActivityIndicator()
//                    }
//                    break
//                case .failure( _):
//
//                    self.stopAnimatingActivityIndicator()
//
//                    break
//                }
//            }
//        }else{
//            self.stopAnimatingActivityIndicator()
//            self.alert(Message: "No Intenet Please check and try again ")
//        }
//    }
    
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
                        Servicefile.shared.cartdata.removeAll()
                        let discount_price = res["discount_price"] as? Int ?? 0
                        let grand_total = res["grand_total"] as? Int ?? 0
                        _ = res["prodcut_count"] as? Int ?? 0
                        let prodcut_item_count = res["prodcut_item_count"] as? Int ?? 0
                        let prodouct_total = res["prodouct_total"] as? Int ?? 0
                        let shipping_charge = res["shipping_charge"] as? Int ?? 0
                        Servicefile.shared.cartdata = data as! [Any]
                        Servicefile.shared.labelamt_total = grand_total
                        Servicefile.shared.labelamt_discount = discount_price
                        Servicefile.shared.labelamt_shipping = shipping_charge
                        Servicefile.shared.labelamt_subtotal = prodouct_total
                        Servicefile.shared.labelsubtotal_itmcount = prodcut_item_count
                        self.label_amt_total.text = String(Servicefile.shared.labelamt_total) + " ₹"
                        self.label_amt_discount.text = String(Servicefile.shared.labelamt_discount) + " ₹"
                        self.label_amt_shipping.text = String(Servicefile.shared.labelamt_shipping) + " ₹"
                        self.label_amt_subtotal.text = String(Servicefile.shared.labelamt_subtotal) + " ₹"
                        var item = " item"
                        if Servicefile.shared.labelsubtotal_itmcount == 1 {
                            item = " item"
                        }else{
                            item = " items"
                        }
                        self.label_subtotal_itmcount.text = "Subtotal (" + String(Servicefile.shared.labelsubtotal_itmcount) + item + ")"
                        if Servicefile.shared.cartdata.count > 0{
                            self.view_cart_empty.isHidden = true
                        }else{
                            self.view_cart_empty.isHidden = false
                        }
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
   
}
