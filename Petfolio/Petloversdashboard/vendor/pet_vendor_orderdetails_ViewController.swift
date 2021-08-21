//
//  pet_vendor_orderdetails_ViewController.swift
//  Petfolio
//
//  Created by Admin on 26/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class pet_vendor_orderdetails_ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var image_product: UIImageView!
    @IBOutlet weak var product_title: UILabel!
    @IBOutlet weak var Label_status: UILabel!
    @IBOutlet weak var image_status: UIImageView!
    @IBOutlet weak var label_status_date: UILabel!
    @IBOutlet weak var view_status: UIView!
    
    @IBOutlet weak var view_orderdetails: UIView!
    @IBOutlet weak var label_orderdate: UILabel!
    @IBOutlet weak var label_id: UILabel!
    @IBOutlet weak var label_paymentmethod: UILabel!
    @IBOutlet weak var label_ordertotal: UILabel!
    @IBOutlet weak var label_quality: UILabel!
    @IBOutlet weak var label_product_amt: UILabel!
    //@IBOutlet weak var label_shipping_address: UILabel!
    
    @IBOutlet weak var image_orderdetails: UIImageView!
    @IBOutlet weak var image_shipping_drop: UIImageView!
    @IBOutlet weak var image_productdetails: UIImageView!
    @IBOutlet weak var view_productdetails: UIView!
    @IBOutlet weak var view_shipingaddress: UIView!
    @IBOutlet weak var label_ship_name: UILabel!
    @IBOutlet weak var label_address: UILabel!
    @IBOutlet weak var label_city_state_pincode: UILabel!
    @IBOutlet weak var label_landmark: UILabel!
    @IBOutlet weak var label_phoneno: UILabel!
    @IBOutlet weak var tbl_prod_details: UITableView!
    @IBOutlet weak var view_confirmall: UIView!
    @IBOutlet weak var label_confirmall: UILabel!
    
   
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    
    
    
    var order_change_status = [""] // 0 non_status, 1 confirm status , 2 dispatch status, 3 reject status
    var orgi_order_change_status = [""]
    var isconfirmed = [""]
    var isrejected = [""]
    var isdispatched = [""]
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
    
    var isorderdetails = false
    var isshipingdetails = false
    var isproductdetails = true
    var isprod_status = true
    var isconfirm = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
        self.view_footer.view_cornor()
        self.label_confirmall.text = "Cancel All"
        self.order_change_status.removeAll()
        self.orgi_order_change_status.removeAll()
        Servicefile.shared.orderdetail_prod.removeAll()
        self.view_status.isHidden = true
        self.view_shipingaddress.isHidden = true
        self.view_orderdetails.isHidden = true
        self.tbl_prod_details.register(UINib(nibName: "vendor_orderdetails_status_TableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.tbl_prod_details.register(UINib(nibName: "pet_vendor_orderdetails_cancel_TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tbl_prod_details.delegate = self
        self.tbl_prod_details.dataSource = self
        self.view_confirmall.isHidden = true
        self.image_orderdetails.image = UIImage(named: imagelink.down1)
        self.image_shipping_drop.image = UIImage(named: imagelink.down1)
        self.image_productdetails.image = UIImage(named: imagelink.up)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.callgetstatuslist()
    }
    
   
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Order Details"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: true, b2: false, b3: false, b4: true)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.orderdetail_prod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.check_vendor_details(index : indexPath.row) == 0{
            
            let cell = tbl_prod_details.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! pet_vendor_orderdetails_cancel_TableViewCell
            cell.selectionStyle = .none
            cell.image_order.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.orderdetail_prod[indexPath.row].product_image)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_order.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.image_order.image = image
                    }
                }
            cell.image_order.contentMode = .scaleAspectFill
            cell.image_order.layer.cornerRadius = 8.0
            cell.label_order_id.text = Servicefile.shared.order_id
            cell.label_product_title.text = Servicefile.shared.orderdetail_prod[indexPath.row].product_name
            if Servicefile.shared.orderdetail_prod[indexPath.row].product_count > 1{
                cell.label_AmtAndProdCount.text = "₹ " + String(Servicefile.shared.orderdetail_prod[indexPath.row].product_price) + " ( \(String(Servicefile.shared.orderdetail_prod[indexPath.row].product_count)) Qty)"
            }else{
                cell.label_AmtAndProdCount.text = "₹ " + String(Servicefile.shared.orderdetail_prod[indexPath.row].product_price) + " ( \(String(Servicefile.shared.orderdetail_prod[indexPath.row].product_count)) Qty)"
            }
            cell.label_bookdate.text = Servicefile.shared.orderdetail_prod[indexPath.row].product_booked
            cell.label_orderdatetitle.text = self.check_order_details_status()
            
           
            cell.btn_trackorder.tag = indexPath.row
            cell.btn_trackorder.addTarget(self, action: #selector(action_btn_trackorder), for: .touchUpInside)
            
            cell.btn_cancel_order.tag = indexPath.row
            cell.btn_cancel_order.addTarget(self, action: #selector(action_btn_cancelorder), for: .touchUpInside)
            
            return cell
            
            //
            
          
        }else{
            let cell = tbl_prod_details.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! vendor_orderdetails_status_TableViewCell
            cell.selectionStyle = .none
            cell.image_order.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.orderdetail_prod[indexPath.row].product_image)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_order.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.image_order.image = image
                    }
                }
            cell.image_order.contentMode = .scaleAspectFill
            cell.image_order.layer.cornerRadius = 8.0
            cell.label_order_id.text = Servicefile.shared.order_id
            cell.label_product_title.text = Servicefile.shared.orderdetail_prod[indexPath.row].product_name
            if Servicefile.shared.orderdetail_prod[indexPath.row].product_count > 1{
                cell.label_AmtAndProdCount.text = "₹ " + String(Servicefile.shared.orderdetail_prod[indexPath.row].product_price) + "( \(String(Servicefile.shared.orderdetail_prod[indexPath.row].product_count)) products)"
            }else{
                cell.label_AmtAndProdCount.text = "₹ " + String(Servicefile.shared.orderdetail_prod[indexPath.row].product_price) + "( \(String(Servicefile.shared.orderdetail_prod[indexPath.row].product_count)) product)"
            }
            cell.label_order_date.text = Servicefile.shared.orderdetail_prod[indexPath.row].product_booked
            cell.label_orderdatetitle.text = self.check_order_details_status()
            if self.check_confrim_all(index: indexPath.row) {
                self.view_confirmall.isHidden = false
            }else{
                self.view_confirmall.isHidden = true
            }
            print("confrim all",check_confrim_all(index: indexPath.row))
            cell.label_order_status.text = Servicefile.shared.orderdetail_prod[indexPath.row].product_stauts
            cell.btn_trackorder.tag = indexPath.row
            cell.btn_trackorder.addTarget(self, action: #selector(action_btn_trackorder), for: .touchUpInside)
            return cell
        }
    }
    
    
    func check_vendor_details(index : Int)->Int{
        var index_result = 0
        if Servicefile.shared.orderdetail_prod[index].product_stauts == "Order Booked"  {
            index_result = 0 // vendor_orderDetails_neworder_TableViewCell
            self.view_confirmall.isHidden = false
        }else {
            index_result = 1
        }
        return index_result
    }
    
    func check_order_details_status()-> String{
        if Servicefile.shared.ordertype == "Complete" {
                return "Delivered on :"
        }else if Servicefile.shared.ordertype == "current"{
            return  "Booked on :"
        }else{
            return   "Cancelled on :"
        }
    }
    
    func check_confrim_all(index: Int)->Bool{
        if isprod_status == false {
            return false
        }else{
            if Servicefile.shared.orderdetail_prod[index].product_stauts == "Order Booked" {
                self.view_confirmall.isHidden = false
                return true
            }else if Servicefile.shared.orderdetail_prod[index].product_stauts == "Order Accept" {
                self.view_confirmall.isHidden = false
                return true // vendor_orderdetails_dispathorder_TableViewCell
            }else {
                isprod_status =  false
                return false // vendor_orderdetails_status_TableViewCell
            }
        }
    }
    
    
    
    @objc func action_btn_trackorder(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.productid = Servicefile.shared.orderdetail_prod[tag].product_id
        let vc = UIStoryboard.pet_vendor_trackorderViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_btn_cancelorder(sender: UIButton){
        Servicefile.shared.iscancelmulti = false
        let tag = sender.tag
        Servicefile.shared.iscancelselect.removeAll()
        Servicefile.shared.productid = Servicefile.shared.orderdetail_prod[tag].product_id
        Servicefile.shared.iscancelselect.append(Servicefile.shared.productid)
        let vc = UIStoryboard.orderlist_cancel_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
    
    @IBAction func action_orderdetails(_ sender: Any) {
        if isorderdetails {
            isorderdetails = false
            self.view_orderdetails.isHidden = true
            self.image_orderdetails.image = UIImage(named: imagelink.down1)
        } else {
            isorderdetails = true
            self.view_orderdetails.isHidden = false
            self.image_orderdetails.image = UIImage(named: imagelink.up)
        }
    }
    
    @IBAction func action_comfirm_all(_ sender: Any) {
        Servicefile.shared.iscancelmulti = true
        Servicefile.shared.iscancelselect.removeAll()
        for i in 0..<self.order_change_status.count{
            if self.order_change_status[i] == "0"{
                Servicefile.shared.iscancelselect.append(Servicefile.shared.orderdetail_prod[i].product_id)
            }
        }
        let vc = UIStoryboard.orderlist_cancel_ViewController()
        self.present(vc, animated: true, completion: nil)
       
    }
    
   
    
    @IBAction func action_shipingdetails(_ sender: Any) {
        if isshipingdetails {
            isshipingdetails = false
            self.view_shipingaddress.isHidden = true
            self.image_shipping_drop.image = UIImage(named: imagelink.down1)
        }else{
            isshipingdetails = true
            self.view_shipingaddress.isHidden = false
            self.image_shipping_drop.image = UIImage(named: imagelink.up)
        }
    }
    
    @IBAction func action_productdetails(_ sender: Any) {
        if isproductdetails {
            isproductdetails = false
            self.view_productdetails.isHidden = true
            self.image_productdetails.image = UIImage(named: imagelink.down1)
        }else{
            isproductdetails = true
            self.view_productdetails.isHidden = false
            self.image_productdetails.image = UIImage(named: imagelink.up)
        }
    }
    
    func callgetstatuslist() {
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petlover_status_orderlist, method: .post, parameters:
            ["vendor_id": Servicefile.shared.vendorid,"order_id": Servicefile.shared.orderid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        
                        self.isconfirm = true
                        self.order_change_status.removeAll()
                        Servicefile.shared.orderdetail_prod.removeAll()
                        let Data = res["Data"] as! NSDictionary
                        let  order_details = Data["order_details"] as! NSDictionary
                        Servicefile.shared.product_price = order_details["order_price"] as? Int ?? 0
                        Servicefile.shared.date_of_booking = order_details["order_booked"] as? String ?? ""
                        Servicefile.shared.product_quantity = order_details["order_product"] as? Int ?? 0
                        Servicefile.shared.order_id = order_details["order_id"] as? String ?? ""
                        Servicefile.shared.product_title = order_details["order_text"] as? String ?? ""
                        self.product_title.text = Servicefile.shared.product_title
                        if Servicefile.shared.product_quantity > 1 {
                            self.label_product_amt.text = "₹ " + String(Servicefile.shared.product_price)+" ( \(Servicefile.shared.product_quantity) products )"
                        }else{
                            self.label_product_amt.text = "₹ " + String(Servicefile.shared.product_price)+" ( \(Servicefile.shared.product_quantity) product )"
                        }
                        
                        self.view_status.isHidden = false
                        self.label_orderdate.text = self.date_of_booking
                        self.label_id.text = Servicefile.shared.order_id
                        self.label_paymentmethod.text = "Online"
                        self.label_ordertotal.text = "₹ " + String(self.product_price)
                        self.label_quality.text =  String(self.product_quantity)
                        //Servicefile.shared.orderid = Servicefile.shared.order_id
                        self.image_status.image = UIImage(named: "success")
                        if Servicefile.shared.ordertype == "Complete" {
                                let date = order_details["order_completed"] as? String ?? ""
                                self.label_status_date.text = date
                                self.Label_status.text = "Delivered on"
                            self.view_confirmall.isHidden = true
                        }else if Servicefile.shared.ordertype == "current"{
                                let date = order_details["order_booked"] as? String ?? ""
                                self.Label_status.text = "Booked on"
                                self.label_status_date.text = date
                        }else{
                                self.Label_status.text = "Cancelled on"
                                let date = order_details["order_cancelled"] as? String ?? ""
                                self.label_status_date.text = date
                            self.image_status.image = UIImage(named: "047")
                            self.view_confirmall.isHidden = true
                            }
                        self.prodcut_image = order_details["order_image"] as? String ?? Servicefile.sample_img
                        self.image_product.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                        self.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: self.prodcut_image)) { (image, error, cache, urls) in
                                if (error != nil) {
                                    self.image_product.image = UIImage(named: imagelink.sample)
                                } else {
                                    self.image_product.image = image
                                }
                            }
                        self.image_product.contentMode = .scaleAspectFill
                        Servicefile.shared.orderdetail_prod.removeAll()
                        let product_details = Data["product_details"] as! NSArray
                        for i in 0..<product_details.count{
                            let prddetails = product_details[i] as! NSDictionary
                            let product_booked = prddetails["product_booked"] as! String
                            let product_count = prddetails["product_count"] as! Int
                            let product_discount = prddetails["product_discount"] as! Int
                            let product_id = prddetails["product_id"] as! Int
                            let product_image = prddetails["product_image"] as! String
                            let product_name = prddetails["product_name"] as! String
                            let product_price = prddetails["product_price"] as! Int
                            let product_stauts = prddetails["product_stauts"] as! String
                            let product_total_discount = prddetails["product_total_discount"] as! Int
                            let product_total_price = prddetails["product_total_price"] as! Int
                            if product_stauts == "Order Booked" {
                                self.order_change_status.append("0")
                            }else if product_stauts == "Order Accept" {
                                self.order_change_status.append("0")
                            }else{
                                self.order_change_status.append("4")
                            }
                            Servicefile.shared.orderdetail_prod.append(orderdetails_prod.init(In_product_booked: product_booked, In_product_count: product_count, In_product_discount: product_discount, In_product_id: product_id, In_product_image: product_image, In_product_name: product_name, In_product_price: product_price, In_product_stauts: product_stauts, In_product_total_discount: product_total_discount, In_product_total_price: product_total_price))
                        }
                        self.orgi_order_change_status = self.order_change_status
                        self.tbl_prod_details.reloadData()
                        let  shipping_details_id = Data["shipping_address"] as! NSDictionary
                        let city =  shipping_details_id["user_city"] as? String ?? ""
                        let Fname =  shipping_details_id["user_first_name"] as? String ?? ""
                        let lname =  shipping_details_id["user_last_name"] as? String ?? ""
                        let Doorno =  shipping_details_id["user_flat_no"] as? String ?? ""
                        let user_stree =  shipping_details_id["user_stree"] as? String ?? ""
                        let user_mobile =  shipping_details_id["user_mobile"] as? String ?? ""
                        let user_picocode =  shipping_details_id["user_picocode"] as? String ?? ""
                        let user_state =  shipping_details_id["user_state"] as? String ?? ""
                        let user_landmark =  shipping_details_id["user_landmark"] as? String ?? ""
                        self.label_ship_name.text = Fname + " " + lname
                        self.label_address.text = Doorno +  ", " + user_stree +  ", "
                        self.label_city_state_pincode.text = city +  ", " + user_state +  " - " +  user_picocode + ". "
                        self.label_landmark.text = "landmark : " + " " + user_landmark + ". "
                        self.label_phoneno.text = "Phone : " + " " + user_mobile + ". "
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
    
    func checkoverall(){
        self.isconfirmed.removeAll()
        self.isrejected.removeAll()
        self.isdispatched.removeAll()
        for i in 0..<Servicefile.shared.orderdetail_prod.count{
                if self.order_change_status[i] == "1" {
                    self.isconfirmed.append(String(Servicefile.shared.orderdetail_prod[i].product_id))
                }else if self.order_change_status[i] == "3" {
                    self.isrejected.append(String(Servicefile.shared.orderdetail_prod[i].product_id))
                }else if self.order_change_status[i] == "2"{
                    self.isdispatched.append(String(Servicefile.shared.orderdetail_prod[i].product_id))
                }else{
                   
                }
        }
        print("confirm",self.isconfirmed)
        print("reject",self.isrejected)
        print("dispatch",self.isdispatched)
        
    }
    
    @IBAction func action_update_status(_ sender: Any) {
        self.checkoverall()
    }
    
}
