//
//  doc_shop_cartpage_ViewController.swift
//  Petfolio
//
//  Created by Admin on 12/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class doc_vendorcartpageViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
    @IBOutlet weak var view_movetoshop: UIView!
    @IBOutlet weak var view_cart_count: UIView!
    
    @IBOutlet weak var view_empty_cart: UIView!
    @IBOutlet weak var label_cart_count: UILabel!
    
    
    @IBOutlet weak var view_footer: doc_footer!
    // var razorpay: RazorpayCheckout!
    
    @IBOutlet weak var label_btn_apply: UILabel!
    @IBOutlet weak var view_coupon_discount: UIView!
    @IBOutlet weak var label_coupon_discount: UILabel!
    
    
    @IBOutlet weak var view_btn_apply: UIView!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_alert: UIView!
    @IBOutlet weak var view_btn_alert: UIView!
    @IBOutlet weak var view_coupon: UIView!
    
    
    
    var textbtncoupon = "Apply"
    
    var discountprice = "0"
    var originalprice = "0"
    var totalprice = "0"
    var coupon_status = "Not Applied" // "Applied"
    var couponcode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
        self.view_cart_count.isHidden = true
        self.view_cart_count.layer.cornerRadius = self.view_cart_count.frame.height / 2
        self.label_cart_count.text = "0"
        self.view_movetoshop.view_cornor()
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
        self.view_coupon_discount.isHidden = true
        self.view_btn_apply.view_cornor()
    }
    
    
    func intial_setup_action(){
    
        // footer action
            self.view_footer.setup(b1: false, b2: true, b3: false)
            self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.docshop), for: .touchUpInside)
            self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        // footer action
    }
    
    @IBAction func action_empty_cart(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure need to Empty the Cart?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.callDeleteoverallproduct()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func action_movetoshop(_ sender: Any) {
        let vc = UIStoryboard.doc_shop_dashboardViewController()
        self.present(vc, animated: true, completion: nil)
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
        print("Coupon action")
        self.view.endEditing(true)
        let cou = self.textfield_coupon.text?.removingLeadingSpaces()
        if cou != "" {
            if textbtncoupon != "Remove" {
                coupon_status = "Applied" // "Not Applied"
                self.callcheckcoupon()
            }else{
                removedata()
            }
        }else{
            self.alert(Message: "Please enter the coupon code")
        }
       
        
    }
    
    func removedata(){
        couponcode = ""
        coupon_status =  "Not Applied" // "Applied"
        self.textfield_coupon.text = ""
        self.textbtncoupon = "Apply"
        self.view_coupon_discount.isHidden = true
        self.label_btn_apply.text = self.textbtncoupon
        self.discountprice = "0"
        self.label_coupon_discount.text = "₹ " + self.discountprice
        Servicefile.shared.labelamt_total = Servicefile.shared.label_Original_amt_total
        self.totalprice = String(Servicefile.shared.label_Original_amt_total)
        self.label_amt_total.text = "₹ " + self.totalprice
    }
    
    func callcheckcoupon(){
        self.startAnimatingActivityIndicator()
        print("current_date" , Servicefile.shared.MMddyyyystringformat(date: Date()),
              "total_amount" , Servicefile.shared.labelamt_total,
              "coupon_type" , "3",
              "user_id" , Servicefile.shared.userid,
              "code", self.textfield_coupon.text!)
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_coupon, method: .post, parameters:
                                                                    ["current_date" : Servicefile.shared.MMddyyyystringformat(date: Date()),
             "total_amount" : Servicefile.shared.labelamt_total,
             "coupon_type" : "3",
             "user_id" : Servicefile.shared.userid,
             "code": self.textfield_coupon.text!], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.stopAnimatingActivityIndicator()
                        let data  = res["Data"] as! NSDictionary
                        self.textbtncoupon = "Remove"
                        self.view_coupon_discount.isHidden = false
                        self.couponcode = self.textfield_coupon.text!
                        self.label_btn_apply.text = self.textbtncoupon
                        self.discountprice = String(data["discount_price"] as! Int)
                        self.label_coupon_discount.text = "₹ " + self.discountprice
                        self.originalprice = String(data["original_price"] as! Int)
                        self.totalprice = String(data["total_price"] as! Int)
                        Servicefile.shared.labelamt_total = data["total_price"] as! Int
                        self.label_amt_total.text = "₹ " + self.totalprice
                        let Message = res["Message"] as? String ?? ""
                        self.alert(Message: Message)
                    }else{
                        self.stopAnimatingActivityIndicator()
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
    
    @IBAction func action_proceedtobuy(_ sender: Any) {
        let vc = UIStoryboard.doc_shop_shipaddress_ViewController()
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
        cell.selectionStyle = .none
        if String(productdata["discount"] as? Int ?? 0) != "0" {
            cell.label_offer.text = String(productdata["discount"] as? Int ?? 0) + " % off"
        }else{
            cell.label_offer.isHidden = true
        }
        cell.selectionStyle = .none
//        let costamt = "₹ " + String(productdata["discount_amount"] as? Int ?? 0)
//        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: costamt)
//        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
//        cell.label_product_amt.attributedText = attributeString
//        cell.label_final_amt.text = "₹ " + String(productdata["cost"] as? Int ?? 0)
//
        let costamt = "₹ " + String(productdata["discount_amount"] as? Int ?? 0)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: costamt)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.label_product_amt.text = "₹ " + String(productdata["cost"] as? Int ?? 0)
        cell.label_final_amt.attributedText = attributeString
        
        
        if product_img.count > 0 {
            cell.img_product.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_product.sd_setImage(with: Servicefile.shared.StrToURL(url: product_img[0] as? String ?? Servicefile.sample_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_product.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_product.image = image
                }
            }
        }
        cell.img_product.contentMode = .scaleAspectFill
        cell.btn_decrement.tag = indexPath.row
        cell.btn_increament.tag = indexPath.row
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(action_delete), for: .touchUpInside)
        cell.btn_decrement.addTarget(self, action: #selector(action_decreament), for: .touchUpInside)
        cell.btn_increament.addTarget(self, action: #selector(action_insert), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cartlist = Servicefile.shared.cartdata[indexPath.row] as! NSDictionary
        let productdata = cartlist["product_id"] as! NSDictionary
        let product_id = productdata["_id"] as? String ?? ""
        Servicefile.shared.product_id = product_id
        let vc = UIStoryboard.Doc_productdetails_ViewController()
                      self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_delete(sender: UIButton){
        let tag = sender.tag
        let cartlist =  Servicefile.shared.cartdata[tag] as! NSDictionary
        let productdata = cartlist["product_id"] as! NSDictionary
        Servicefile.shared.product_id = productdata["_id"] as! String
        let alert = UIAlertController(title: "Are you sure need to delete the product?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.callDeletetheproductcount()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
       
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
extension doc_vendorcartpageViewController {
    
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
                        Servicefile.shared.label_Original_amt_total = grand_total
                        self.label_amt_total.text = "₹ " + String(Servicefile.shared.labelamt_total)
                        self.label_amt_discount.text = "₹ " + String(Servicefile.shared.labelamt_discount)
                        self.label_amt_shipping.text = "₹ " + String(Servicefile.shared.labelamt_shipping)
                        self.label_amt_subtotal.text = "₹ " + String(Servicefile.shared.labelamt_subtotal) 
                        var item = " item"
                        if Servicefile.shared.labelsubtotal_itmcount == 1 {
                            item = " item"
                        }else{
                            item = " items"
                        }
                        self.label_subtotal_itmcount.text = "Subtotal (" + String(Servicefile.shared.labelsubtotal_itmcount) + item + ")"
                        if Servicefile.shared.cartdata.count > 0{
                            self.view_cart_empty.isHidden = true
                            self.view_cart_count.isHidden = false
                            self.label_cart_count.text = String(Servicefile.shared.cartdata.count)
                        }else{
                            self.view_cart_empty.isHidden = false
                            self.view_cart_count.isHidden = true
                            self.label_cart_count.text = "0"
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
    
    func callDeletetheproductcount(){
        print("product_id", Servicefile.shared.product_id,"user_id",Servicefile.shared.userid)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_delete_single_cart, method: .post, parameters:
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
    func callDeleteoverallproduct(){
        print("user_id",Servicefile.shared.userid)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_delete_overall_cart, method: .post, parameters:
            ["user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
