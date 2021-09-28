//
//  Petlover_myorder_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 28/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import SDWebImage

class Petlover_myorder_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var view_new: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_missed: UIView!
    
    
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var label_new: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    @IBOutlet weak var tblview_applist: UITableView!
    @IBOutlet weak var label_completed: UILabel!
    @IBOutlet weak var label_missed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
         self.tblview_applist.register(UINib(nibName: "pet_vendor_new_myorder_TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.label_nodata.isHidden = true
        self.view_new.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.view_missed.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.view_footer.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.view_completed.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.view_completed.layer.borderWidth = 0.5
        self.view_missed.layer.borderWidth = 0.5
        self.view_new.layer.borderWidth = 0.5
        self.view_new.dropShadow()
        self.view_missed.dropShadow()
        self.view_footer.dropShadow()
        self.view_completed.dropShadow()
        let appgree = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appgree.cgColor
        self.view_missed.layer.borderColor = appgree.cgColor
        self.view_new.layer.borderColor = appgree.cgColor
        self.tblview_applist.delegate = self
        self.tblview_applist.dataSource = self
        
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "My orders"
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.checksetup()
    }
    
    func checksetup(){
        if Servicefile.shared.ordertype == "New" {
            self.callnew()
            self.design_set_newapp()
        }else if Servicefile.shared.ordertype == "Completed"{
            self.callcomm()
            self.design_set_complete()
        }else{
            self.callmissed()
            self.desing_set_mis()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.order_productdetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  Servicefile.shared.ordertype == "Completed" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! pet_vendor_new_myorder_TableViewCell
            cell.selectionStyle = .none
            cell.image_order.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[indexPath.row].v_order_image)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.image_order.image = UIImage(named: imagelink.sample)
            } else {
                cell.image_order.image = image
            }
        }
            cell.image_order.contentMode = .scaleAspectFill
            cell.label_orderID.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_id
            cell.label_product_title.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_text
        let quantity = Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count
        if quantity == 1 {
            cell.label_cost.text = "INR " + String(Servicefile.shared.order_productdetail[indexPath.row].v_order_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count)) product)"
        }else {
            cell.label_cost.text = "INR " + String(Servicefile.shared.order_productdetail[indexPath.row].v_order_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count)) products)"
        }
          
      
            cell.selectionStyle = .none
            cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_booked_on
            cell.label_prod_date_title.text = "Delivered on : "
            cell.btn_order_details.tag = indexPath.row
            
            cell.btn_order_details.addTarget(self, action: #selector(orderdetails), for: .touchUpInside)
            return cell
        } else if  Servicefile.shared.ordertype == "New"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! pet_vendor_new_myorder_TableViewCell
            
            cell.selectionStyle = .none
            cell.image_order.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[indexPath.row].v_order_image)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.image_order.image = UIImage(named: imagelink.sample)
            } else {
                cell.image_order.image = image
            }
        }
            cell.image_order.contentMode = .scaleAspectFill
            cell.label_orderID.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_id
            cell.label_product_title.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_text
        let quantity = Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count
        if quantity == 1 {
            cell.label_cost.text = "INR " + String(Servicefile.shared.order_productdetail[indexPath.row].v_order_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count)) product)"
        }else {
            cell.label_cost.text = "INR " + String(Servicefile.shared.order_productdetail[indexPath.row].v_order_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count)) products)"
        }
            cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_booked_on
            cell.btn_order_details.tag = indexPath.row
            cell.label_prod_date_title.text = "Booked for : "
            cell.btn_order_details.addTarget(self, action: #selector(orderdetails), for: .touchUpInside)
            return cell
        }  else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! pet_vendor_new_myorder_TableViewCell
            
            cell.selectionStyle = .none
            cell.image_order.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[indexPath.row].v_order_image)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.image_order.image = UIImage(named: imagelink.sample)
            } else {
                cell.image_order.image = image
            }
        }
            cell.image_order.contentMode = .scaleAspectFill
            cell.label_orderID.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_id
            cell.label_product_title.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_text
        let quantity = Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count
        if quantity == 1 {
            cell.label_cost.text = "INR " + String(Servicefile.shared.order_productdetail[indexPath.row].v_order_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count)) product)"
        }else {
            cell.label_cost.text = "INR " + String(Servicefile.shared.order_productdetail[indexPath.row].v_order_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].v_order_product_count)) products)"
        }
            cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].v_order_booked_on
            cell.label_prod_date_title.text = "Cancelled on : "
            cell.btn_order_details.tag = indexPath.row
            cell.btn_order_details.addTarget(self, action: #selector(orderdetails), for: .touchUpInside)
            return cell
        }
    }
    
    
    @objc func orderdetails(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.vendorid = Servicefile.shared.order_productdetail[tag].v_vendor_id
        Servicefile.shared.orderid = Servicefile.shared.order_productdetail[tag].v_order_id
        let vc = UIStoryboard.pet_vendor_orderdetails_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    
    @IBAction func action_missed(_ sender: Any) {
        self.desing_set_mis()
        Servicefile.shared.ordertype = "Cancelled"
        self.tblview_applist.reloadData()
        self.callmissed()
    }
    
    func desing_set_mis(){
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_missed.backgroundColor = appcolor
        self.label_missed.textColor = UIColor.white
        self.view_new.backgroundColor = UIColor.white
        self.label_new.textColor = appcolor
        self.label_completed.textColor = appcolor
        self.view_completed.backgroundColor = UIColor.white
        self.view_new.layer.borderColor = appcolor.cgColor
        self.view_new.backgroundColor = UIColor.white
    }
    
    @IBAction func action_completeappoint(_ sender: Any) {
        self.design_set_complete()
        Servicefile.shared.ordertype = "Completed"
        self.tblview_applist.reloadData()
        self.callcomm()
    }
    
    func design_set_complete(){
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.backgroundColor = appcolor
        self.label_completed.textColor = UIColor.white
        self.view_new.backgroundColor = UIColor.white
        self.view_missed.backgroundColor = UIColor.white
        self.label_new.textColor = appcolor
        self.label_missed.textColor = appcolor
        self.view_new.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
    }
    
    @IBAction func action_newappoint(_ sender: Any) {
        self.design_set_newapp()
        Servicefile.shared.ordertype = "New"
        self.tblview_applist.reloadData()
        self.callnew()
    }
    
    func design_set_newapp(){
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_new.backgroundColor = appcolor
        self.label_new.textColor = UIColor.white
        self.view_completed.backgroundColor = UIColor.white
        self.view_missed.backgroundColor = UIColor.white
        self.label_completed.textColor = appcolor
        self.label_missed.textColor = appcolor
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
    }
    
    @IBAction func action_logout(_ sender: Any) {
        
    }
    
    func callnew(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.orderlist, method: .post, parameters:
            ["petlover_id":Servicefile.shared.userid,"skip_count":1,"status":"New"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.order_productdetail.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let itmval = Data[itm] as! NSDictionary
//                            let _id = itmval["_id"] as! String
//                            let date_of_booking = itmval["date_of_booking"] as? String ?? ""
//                            let order_id = itmval["order_id"] as? String ?? ""
//                            let prodcut_image = itmval["prodcut_image"] as? String ?? Servicefile.sample_img
//                            let product_name = itmval["product_name"]  as? String ?? ""
//                            let product_price = itmval["product_price"]  as? Int ?? 0
//                            let product_quantity = itmval["product_quantity"] as? Int ?? 0
//                            let status = itmval["status"] as? String ?? ""
//                            let user_cancell_date = itmval["user_cancell_date"] as? String ?? ""
//                            let user_cancell_info = itmval["user_cancell_info"] as? String ?? ""
//                            let vendor_accept_cancel = itmval["vendor_accept_cancel"] as? String ?? ""
//                            let vendor_cancell_date = itmval["vendor_cancell_date"] as? String ?? ""
//                            let vendor_cancell_info = itmval["vendor_cancell_info"] as? String ?? ""
//                            let vendor_complete_date = itmval["vendor_complete_date"] as? String ?? ""
//                            let vendor_complete_info = itmval["vendor_complete_info"] as? String ?? ""
//                            let user_return_date = itmval["user_return_date"] as? String ?? ""
//                            let user_return_info = itmval["user_return_info"] as? String ?? ""
//                            let user_return_pic = itmval["user_return_pic"] as? String ?? ""
//
//                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_var_id: _id, In_date_of_booking: date_of_booking, In_order_id: order_id, In_prodcut_image: prodcut_image, In_product_name: product_name, In_product_price: product_price, In_product_quantity: product_quantity, In_status: status, In_user_cancell_date: user_cancell_date, In_user_cancell_info: user_cancell_info, In_vendor_accept_cancel: vendor_accept_cancel, In_vendor_cancell_date: vendor_cancell_date, In_vendor_cancell_info: vendor_cancell_info, In_vendor_complete_date: vendor_complete_date, In_vendor_complete_info: vendor_complete_info, In_user_return_date: user_return_date, In_user_return_info: user_return_info, In_user_return_pic: user_return_pic))
                            let v_order_booked_on = itmval["p_order_booked_on"] as? String ?? ""
                            let v_order_id = itmval["p_order_id"] as? String ?? ""
                            let v_order_image = itmval["p_order_image"] as? String ?? ""
                            let v_order_price = itmval["p_order_price"] as? Int ?? 0
                            let v_order_product_count = itmval["p_order_product_count"] as? Int ?? 0
                            let v_order_status = itmval["p_order_status"] as? String ?? ""
                            let v_order_text = itmval["p_order_text"] as? String ?? ""
                            let v_payment_id = itmval["p_payment_id"] as? String ?? ""
                            let v_shipping_address = itmval["p_shipping_address"] as? String ?? ""
                            let v_user_id = itmval["p_user_id"] as? String ?? ""
                            let v_vendor_id = itmval["p_vendor_id"] as? String ?? ""
                            
                            let v_cancelled_date = itmval["p_cancelled_date"] as? String ?? ""
                            let v_completed_date = itmval["p_completed_date"] as? String ?? ""
                            let v_user_feedback = itmval["p_user_feedback"] as? String ?? ""
                            let v_user_rate = itmval["p_user_rate"] as? Int ?? 0
                            
                            
                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_v_order_booked_on: v_order_booked_on, In_v_order_id: v_order_id, In_v_order_image: v_order_image, In_v_order_price: v_order_price, In_v_order_product_count: v_order_product_count, In_v_order_status: v_order_status, In_v_order_text: v_order_text, In_v_payment_id: v_payment_id, In_v_shipping_address: v_shipping_address, In_v_user_id: v_user_id, In_v_vendor_id: v_vendor_id, In_v_cancelled_date: v_cancelled_date, In_v_completed_date: v_completed_date, In_v_user_feedback: v_user_feedback, In_v_user_rate: v_user_rate))
                        }
                        if Servicefile.shared.order_productdetail.count > 0 {
                            self.label_nodata.isHidden = true
                        }else{
                            self.label_nodata.isHidden = false
                        }
                            
                        self.tblview_applist.reloadData()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func callcomm(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.orderlist, method: .post, parameters:
            ["petlover_id":Servicefile.shared.userid,"skip_count":1,"status":"Complete"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.order_productdetail.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let itmval = Data[itm] as! NSDictionary
//                            let _id = itmval["_id"] as! String
//                            let date_of_booking = itmval["date_of_booking"] as? String ?? ""
//                            let order_id = itmval["order_id"] as? String ?? ""
//                            let prodcut_image = itmval["prodcut_image"] as? String ?? Servicefile.sample_img
//                            let product_name = itmval["product_name"]  as? String ?? ""
//                            let product_price = itmval["product_price"]  as? Int ?? 0
//                            let product_quantity = itmval["product_quantity"] as? Int ?? 0
//                            let status = itmval["status"] as? String ?? ""
//                            let user_cancell_date = itmval["user_cancell_date"] as? String ?? ""
//                            let user_cancell_info = itmval["user_cancell_info"] as? String ?? ""
//                            let vendor_accept_cancel = itmval["vendor_accept_cancel"] as? String ?? ""
//                            let vendor_cancell_date = itmval["vendor_cancell_date"] as? String ?? ""
//                            let vendor_cancell_info = itmval["vendor_cancell_info"] as? String ?? ""
//                            let vendor_complete_date = itmval["vendor_complete_date"] as? String ?? ""
//                            let vendor_complete_info = itmval["vendor_complete_info"] as? String ?? ""
//                            let user_return_date = itmval["user_return_date"] as? String ?? ""
//                            let user_return_info = itmval["user_return_info"] as? String ?? ""
//                            let user_return_pic = itmval["user_return_pic"] as? String ?? ""
//
//                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_var_id: _id, In_date_of_booking: date_of_booking, In_order_id: order_id, In_prodcut_image: prodcut_image, In_product_name: product_name, In_product_price: product_price, In_product_quantity: product_quantity, In_status: status, In_user_cancell_date: user_cancell_date, In_user_cancell_info: user_cancell_info, In_vendor_accept_cancel: vendor_accept_cancel, In_vendor_cancell_date: vendor_cancell_date, In_vendor_cancell_info: vendor_cancell_info, In_vendor_complete_date: vendor_complete_date, In_vendor_complete_info: vendor_complete_info, In_user_return_date: user_return_date, In_user_return_info: user_return_info, In_user_return_pic: user_return_pic))
                            let v_order_booked_on = itmval["p_order_booked_on"] as? String ?? ""
                            let v_order_id = itmval["p_order_id"] as? String ?? ""
                            let v_order_image = itmval["p_order_image"] as? String ?? ""
                            let v_order_price = itmval["p_order_price"] as? Int ?? 0
                            let v_order_product_count = itmval["p_order_product_count"] as? Int ?? 0
                            let v_order_status = itmval["p_order_status"] as? String ?? ""
                            let v_order_text = itmval["p_order_text"] as? String ?? ""
                            let v_payment_id = itmval["p_payment_id"] as? String ?? ""
                            let v_shipping_address = itmval["p_shipping_address"] as? String ?? ""
                            let v_user_id = itmval["p_user_id"] as? String ?? ""
                            let v_vendor_id = itmval["p_vendor_id"] as? String ?? ""
                            
                            let v_cancelled_date = itmval["p_cancelled_date"] as? String ?? ""
                            let v_completed_date = itmval["p_completed_date"] as? String ?? ""
                            let v_user_feedback = itmval["p_user_feedback"] as? String ?? ""
                            let v_user_rate = itmval["p_user_rate"] as? Int ?? 0
                            
                            
                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_v_order_booked_on: v_order_booked_on, In_v_order_id: v_order_id, In_v_order_image: v_order_image, In_v_order_price: v_order_price, In_v_order_product_count: v_order_product_count, In_v_order_status: v_order_status, In_v_order_text: v_order_text, In_v_payment_id: v_payment_id, In_v_shipping_address: v_shipping_address, In_v_user_id: v_user_id, In_v_vendor_id: v_vendor_id, In_v_cancelled_date: v_cancelled_date, In_v_completed_date: v_completed_date, In_v_user_feedback: v_user_feedback, In_v_user_rate: v_user_rate))
                        }
                        if Servicefile.shared.order_productdetail.count > 0 {
                            self.label_nodata.isHidden = true
                        }else{
                            self.label_nodata.isHidden = false
                        }
                        self.tblview_applist.reloadData()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func callmissed(){  
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.orderlist, method: .post, parameters:
            ["petlover_id":Servicefile.shared.userid,"skip_count":1,"status":"Cancelled"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.order_productdetail.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let itmval = Data[itm] as! NSDictionary
//                            let _id = itmval["_id"] as! String
//                            let date_of_booking = itmval["date_of_booking"] as? String ?? ""
//                            let order_id = itmval["order_id"] as? String ?? ""
//                            let prodcut_image = itmval["prodcut_image"] as? String ?? Servicefile.sample_img
//                            let product_name = itmval["product_name"]  as? String ?? ""
//                            let product_price = itmval["product_price"]  as? Int ?? 0
//                            let product_quantity = itmval["product_quantity"] as? Int ?? 0
//                            let status = itmval["status"] as? String ?? ""
//                            let user_cancell_date = itmval["user_cancell_date"] as? String ?? ""
//                            let user_cancell_info = itmval["user_cancell_info"] as? String ?? ""
//                            let vendor_accept_cancel = itmval["vendor_accept_cancel"] as? String ?? ""
//                            let vendor_cancell_date = itmval["vendor_cancell_date"] as? String ?? ""
//                            let vendor_cancell_info = itmval["vendor_cancell_info"] as? String ?? ""
//                            let vendor_complete_date = itmval["vendor_complete_date"] as? String ?? ""
//                            let vendor_complete_info = itmval["vendor_complete_info"] as? String ?? ""
//                            let user_return_date = itmval["user_return_date"] as? String ?? ""
//                            let user_return_info = itmval["user_return_info"] as? String ?? ""
//                            let user_return_pic = itmval["user_return_pic"] as? String ?? ""
//
//                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_var_id: _id, In_date_of_booking: date_of_booking, In_order_id: order_id, In_prodcut_image: prodcut_image, In_product_name: product_name, In_product_price: product_price, In_product_quantity: product_quantity, In_status: status, In_user_cancell_date: user_cancell_date, In_user_cancell_info: user_cancell_info, In_vendor_accept_cancel: vendor_accept_cancel, In_vendor_cancell_date: vendor_cancell_date, In_vendor_cancell_info: vendor_cancell_info, In_vendor_complete_date: vendor_complete_date, In_vendor_complete_info: vendor_complete_info, In_user_return_date: user_return_date, In_user_return_info: user_return_info, In_user_return_pic: user_return_pic))
                            let v_order_booked_on = itmval["p_order_booked_on"] as? String ?? ""
                            let v_order_id = itmval["p_order_id"] as? String ?? ""
                            let v_order_image = itmval["p_order_image"] as? String ?? ""
                            let v_order_price = itmval["p_order_price"] as? Int ?? 0
                            let v_order_product_count = itmval["p_order_product_count"] as? Int ?? 0
                            let v_order_status = itmval["p_order_status"] as? String ?? ""
                            let v_order_text = itmval["p_order_text"] as? String ?? ""
                            let v_payment_id = itmval["p_payment_id"] as? String ?? ""
                            let v_shipping_address = itmval["p_shipping_address"] as? String ?? ""
                            let v_user_id = itmval["p_user_id"] as? String ?? ""
                            let v_vendor_id = itmval["p_vendor_id"] as? String ?? ""
                            
                            let v_cancelled_date = itmval["p_cancelled_date"] as? String ?? ""
                            let v_completed_date = itmval["p_completed_date"] as? String ?? ""
                            let v_user_feedback = itmval["p_user_feedback"] as? String ?? ""
                            let v_user_rate = itmval["p_user_rate"] as? Int ?? 0
                            
                            
                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_v_order_booked_on: v_order_booked_on, In_v_order_id: v_order_id, In_v_order_image: v_order_image, In_v_order_price: v_order_price, In_v_order_product_count: v_order_product_count, In_v_order_status: v_order_status, In_v_order_text: v_order_text, In_v_payment_id: v_payment_id, In_v_shipping_address: v_shipping_address, In_v_user_id: v_user_id, In_v_vendor_id: v_vendor_id, In_v_cancelled_date: v_cancelled_date, In_v_completed_date: v_completed_date, In_v_user_feedback: v_user_feedback, In_v_user_rate: v_user_rate))
                        }
                        if Servicefile.shared.order_productdetail.count > 0 {
                            self.label_nodata.isHidden = true
                        }else{
                            self.label_nodata.isHidden = false
                        }
                        self.tblview_applist.reloadData()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    
    func callcompleteMissedappoitment(Appointmentid: String, appointmentstatus: String){
        
        var params = ["":""]
        if appointmentstatus != "cancel"{
            params = ["_id": Appointmentid,
                      "completed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                      "appoinment_status" : "Completed"]
        }else{
            params = [ "_id": Appointmentid,
                       "missed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                       "doc_feedback" : "",
                       "appoinment_status" : "Missed",
                       "appoint_patient_st": "Doctor Cancelled appointment"]
        }
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_complete_and_Missedapp, method: .post, parameters: params
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        
                        
                        self.callnew()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
  
}
