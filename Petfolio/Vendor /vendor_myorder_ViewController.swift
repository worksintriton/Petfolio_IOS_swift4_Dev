//
//  vendor_myorder_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 28/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import SDWebImage

class vendor_myorder_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var view_new: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_missed: UIView!
    @IBOutlet weak var view_footer: UIView!
    
    @IBOutlet weak var label_new: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    
    @IBOutlet weak var tblview_applist: UITableView!
    @IBOutlet weak var label_completed: UILabel!
    @IBOutlet weak var label_missed: UILabel!
    
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_alert: UIView!
    @IBOutlet weak var label_failedstatus: UILabel!
    @IBOutlet weak var view_refresh: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.ordertype = "current"
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.view_alert.isHidden = true
        self.label_nodata.isHidden = true
        
        self.view_new.view_cornor()
        self.view_missed.view_cornor()
        self.view_footer.view_cornor()
        self.view_completed.view_cornor()
        self.view_completed.layer.borderWidth = 0.5
        self.view_missed.layer.borderWidth = 0.5
        self.view_new.layer.borderWidth = 0.5
        self.view_new.dropShadow()
        self.view_missed.dropShadow()
        self.view_popup.view_cornor()
        self.view_refresh.view_cornor()
        self.view_alert.view_cornor()
        self.view_completed.dropShadow()
        let appgree = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appgree.cgColor
        self.view_missed.layer.borderColor = appgree.cgColor
        self.view_new.layer.borderColor = appgree.cgColor
        
        self.tblview_applist.delegate = self
        self.tblview_applist.dataSource = self
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func action_sidemenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vendor_sidemenu_ViewController") as! vendor_sidemenu_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_refresh(_ sender: Any) {
        self.callcheckstatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callcheckstatus()
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.order_productdetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  Servicefile.shared.ordertype == "current" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "curcell", for: indexPath) as! vendor_new_TableViewCell
            cell.selectionStyle = .none
        cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[indexPath.row].prodcut_image)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.image_order.image = UIImage(named: "sample")
            } else {
                cell.image_order.image = image
            }
        }
        cell.label_orderID.text = Servicefile.shared.order_productdetail[indexPath.row].order_id
        cell.label_product_title.text = Servicefile.shared.order_productdetail[indexPath.row].product_name
        let quantity = Servicefile.shared.order_productdetail[indexPath.row].product_quantity
        if quantity == 1 {
            cell.label_cost.text = "₹ " + String(Servicefile.shared.order_productdetail[indexPath.row].product_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].product_quantity)) item)"
        }else {
            cell.label_cost.text = "₹ " + String(Servicefile.shared.order_productdetail[indexPath.row].product_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].product_quantity)) items)"
        }
        cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].date_of_booking
        cell.view_update_status.layer.cornerRadius = 4.0
        //cell.view_main.dropShadow()
            cell.image_order.layer.cornerRadius = 8.0
        //cell.view_update_status.startAnimating()
            cell.btn_order_details.tag = indexPath.row
            cell.btn_update_status.tag = indexPath.row
            cell.btn_order_details.addTarget(self, action: #selector(orderdetails), for: .touchUpInside)
            cell.btn_update_status.addTarget(self, action: #selector(updatestatusorderdetails), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        } else  if  Servicefile.shared.ordertype == "Complete"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "comcell", for: indexPath) as! vendor_complete_TableViewCell
            cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[indexPath.row].prodcut_image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_order.image = UIImage(named: "sample")
                } else {
                    cell.image_order.image = image
                }
            }
            cell.image_order.layer.cornerRadius = 8.0
            cell.selectionStyle = .none
            cell.label_orderID.text = Servicefile.shared.order_productdetail[indexPath.row].order_id
            cell.label_product_title.text = Servicefile.shared.order_productdetail[indexPath.row].product_name
            let quantity = Servicefile.shared.order_productdetail[indexPath.row].product_quantity
            if quantity == 1 {
                cell.label_cost.text = "₹ " + String(Servicefile.shared.order_productdetail[indexPath.row].product_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].product_quantity)) item)"
            }else {
                cell.label_cost.text = "₹ " + String(Servicefile.shared.order_productdetail[indexPath.row].product_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].product_quantity)) items)"
            }
            cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].vendor_complete_date
            
           // cell.view_main.dropShadow()
            cell.btn_order_details.tag = indexPath.row
            cell.btn_track_order.tag = indexPath.row
            cell.btn_order_details.addTarget(self, action: #selector(orderdetails), for: .touchUpInside)
            cell.btn_track_order.addTarget(self, action: #selector(trackorderdetails), for: .touchUpInside)

            return cell
        } else{
//            if Servicefile.shared.order_productdetail[indexPath.row].user_return_info != "" &&  Servicefile.shared.order_productdetail[indexPath.row].vendor_accept_cancel == ""{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "retcell", for: indexPath) as! vendor_return_TableViewCell
//                cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[indexPath.row].prodcut_image)) { (image, error, cache, urls) in
//                    if (error != nil) {
//                        cell.image_order.image = UIImage(named: "sample")
//                    } else {
//                        cell.image_order.image = image
//                    }
//                }
//                    cell.image_order.layer.cornerRadius = 8.0
//                cell.selectionStyle = .none
//                cell.label_orderID.text = Servicefile.shared.order_productdetail[indexPath.row].order_id
//                cell.label_product_title.text = Servicefile.shared.order_productdetail[indexPath.row].product_name
//                cell.label_cost.text = "₹ " + String(Servicefile.shared.order_productdetail[indexPath.row].product_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].product_quantity)) items)"
//                cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].date_of_booking
//                cell.btn_order_details.tag = indexPath.row
//                cell.btn_track_order.tag = indexPath.row
//                cell.btn_order_details.addTarget(self, action: #selector(orderdetails), for: .touchUpInside)
//                cell.btn_track_order.addTarget(self, action: #selector(trackorderdetails), for: .touchUpInside)
//                cell.view_main.dropShadow()
//                cell.btn_reject.tag = indexPath.row
//                cell.btn_reject.addTarget(self, action: #selector(Rejectdetails), for: .touchUpInside)
//                cell.btn_accept.tag = indexPath.row
//                cell.btn_accept.addTarget(self, action: #selector(Acceptdetails), for: .touchUpInside)
//                cell.view_accept.view_cornor()
//                cell.view_reject.view_cornor()
//                return cell
//            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "miscell", for: indexPath) as! vendor_missed_TableViewCell
                cell.image_order.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.order_productdetail[indexPath.row].prodcut_image)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_order.image = UIImage(named: "sample")
                    } else {
                        cell.image_order.image = image
                    }
                }
                cell.image_order.layer.cornerRadius = 8.0
                cell.selectionStyle = .none
                cell.label_orderID.text = Servicefile.shared.order_productdetail[indexPath.row].order_id
                cell.label_product_title.text = Servicefile.shared.order_productdetail[indexPath.row].product_name
                let quantity = Servicefile.shared.order_productdetail[indexPath.row].product_quantity
            if quantity == 1 {
                cell.label_cost.text = "₹ " + String(Servicefile.shared.order_productdetail[indexPath.row].product_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].product_quantity)) item)"
            }else {
                cell.label_cost.text = "₹ " + String(Servicefile.shared.order_productdetail[indexPath.row].product_price) + " (\(String(Servicefile.shared.order_productdetail[indexPath.row].product_quantity)) items)"
            }
               
            
            if Servicefile.shared.order_productdetail[indexPath.row].vendor_cancell_date != "" {
                cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].vendor_cancell_date
                cell.label_order_status.text = "Cancelled on"
            }else if Servicefile.shared.order_productdetail[indexPath.row].user_cancell_date != "" {
                cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].user_cancell_date
                cell.label_order_status.text = "Cancelled on"
            }else if Servicefile.shared.order_productdetail[indexPath.row].user_return_date != "" {
                cell.label_prod_ord_datetime.text = Servicefile.shared.order_productdetail[indexPath.row].user_return_date
                cell.label_order_status.text = "Retured on"
            }
           
                cell.btn_order_details.tag = indexPath.row
                
                cell.btn_order_details.addTarget(self, action: #selector(orderdetails), for: .touchUpInside)
            cell.btn_track_order.tag = indexPath.row
                cell.btn_track_order.addTarget(self, action: #selector(trackorderdetails), for: .touchUpInside)
                //cell.view_main.dropShadow()
                return cell
//            }
        }
    }
    
    @objc func Acceptdetails(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.orderid = Servicefile.shared.order_productdetail[tag]._id
        let alert = UIAlertController(title: "Are you sure need to accept order", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.callacceptorderreturn()
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func Rejectdetails(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.orderid = Servicefile.shared.order_productdetail[tag]._id
        let alert = UIAlertController(title: "Are you sure need to reject order", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.callreturnorderreturn()
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func orderdetails(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.orderid = Servicefile.shared.order_productdetail[tag]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "orderdetailsViewController") as! orderdetailsViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func trackorderdetails(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.orderid = Servicefile.shared.order_productdetail[tag]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vendorTrackorderViewController") as! vendorTrackorderViewController
        self.present(vc, animated: true, completion: nil)
    }
    @objc func updatestatusorderdetails(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.orderid = Servicefile.shared.order_productdetail[tag]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vendor_orderstatus_ViewController") as! vendor_orderstatus_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Servicefile.shared.orderid = Servicefile.shared.order_productdetail[indexPath.row]._id
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vendor_orderstatus_ViewController") as! vendor_orderstatus_ViewController
//        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    
    @IBAction func action_missed(_ sender: Any) {
        self.missed_btn()
        Servicefile.shared.ordertype = "cancelled"
        self.tblview_applist.reloadData()
        self.callcancelled()
        
    }
    
    
    
    @IBAction func action_completeappoint(_ sender: Any) {
        self.complete_btn()
        Servicefile.shared.ordertype = "Complete"
        self.tblview_applist.reloadData()
        self.callcomm()
        
    }
    
    func call_by_status(){
        if Servicefile.shared.ordertype == "current" {
            self.new_btn()
            self.callnew()
        }else if Servicefile.shared.ordertype == "Complete" {
            self.complete_btn()
            self.callcomm()
        }else{
            self.missed_btn()
            self.callcancelled()
        }
    }
    func complete_btn(){
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
    
    func missed_btn(){
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
    
    func new_btn(){
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
    
    
    
    
    @IBAction func action_newappoint(_ sender: Any) {
        self.new_btn()
        Servicefile.shared.ordertype = "current"
        self.tblview_applist.reloadData()
        self.callnew()
        
    }
    
    @IBAction func action_logout(_ sender: Any) {
        
    }
    
    func callacceptorderreturn(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_update_status_accept_return, method: .post, parameters:
                                                                    [ "_id": Servicefile.shared.orderid,
              "activity_id": 6,
              "activity_title": "Vendor Accept Return",
              "activity_date": Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()),
              "vendor_accept_cancel": "Ok I will accept the Return",
              "vendor_accept_cancel_date": Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.callcancelled()
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
    
    func callreturnorderreturn(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_update_status_accept_return, method: .post, parameters:
                                                                    [ "_id": Servicefile.shared.orderid,
              "activity_id": 7,
              "activity_title": "Vendor Reject Return",
              "activity_date": Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()),
              "vendor_accept_cancel": "Ok I will Reject the Return",
              "vendor_accept_cancel_date": Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.callcancelled()
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
    
   
    func callgetlist(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_getlistid, method: .post, parameters:
            ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        
                        let Data = res["Data"] as! NSDictionary
                        Servicefile.shared.vendorid = Data["_id"] as? String ?? ""
                        print("vendor id data",Servicefile.shared.vendorid)
                        self.call_by_status()
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
    
   
    
    
    func callnew(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_new_orderlist, method: .post, parameters:
            ["vendor_id": Servicefile.shared.vendorid,
             "order_status" : "New"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                            let _id = itmval["_id"] as? String ?? ""
                            let date_of_booking = itmval["date_of_booking"] as? String ?? ""
                            let order_id = itmval["order_id"] as? String ?? ""
                            let prodcut_image = itmval["prodcut_image"] as? String ?? Servicefile.sample_img
                            let product_name = itmval["product_name"]  as? String ?? ""
                            let product_price = itmval["product_price"]  as? Int ?? 0
                            let product_quantity = itmval["product_quantity"] as? Int ?? 0
                            let status = itmval["status"] as? String ?? ""
                            let user_cancell_date = itmval["user_cancell_date"] as? String ?? ""
                            let user_cancell_info = itmval["user_cancell_info"] as? String ?? ""
                            let vendor_accept_cancel = itmval["vendor_accept_cancel"] as? String ?? ""
                            let vendor_cancell_date = itmval["vendor_cancell_date"] as? String ?? ""
                            let vendor_cancell_info = itmval["vendor_cancell_info"] as? String ?? ""
                            let vendor_complete_date = itmval["vendor_complete_date"] as? String ?? ""
                            let vendor_complete_info = itmval["vendor_complete_info"] as? String ?? ""
                            let user_return_date = itmval["user_return_date"] as? String ?? ""
                            let user_return_info = itmval["user_return_info"] as? String ?? ""
                            let user_return_pic = itmval["user_return_pic"] as? String ?? ""
                            
                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_var_id: _id, In_date_of_booking: date_of_booking, In_order_id: order_id, In_prodcut_image: prodcut_image, In_product_name: product_name, In_product_price: product_price, In_product_quantity: product_quantity, In_status: status, In_user_cancell_date: user_cancell_date, In_user_cancell_info: user_cancell_info, In_vendor_accept_cancel: vendor_accept_cancel, In_vendor_cancell_date: vendor_cancell_date, In_vendor_cancell_info: vendor_cancell_info, In_vendor_complete_date: vendor_complete_date, In_vendor_complete_info: vendor_complete_info, In_user_return_date: user_return_date, In_user_return_info: user_return_info, In_user_return_pic: user_return_pic))
                        }
                        self.label_nodata.text = "No new orders"
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func callcomm(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_new_orderlist, method: .post, parameters:
            ["vendor_id": Servicefile.shared.vendorid,
             "order_status" : "Complete"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                            let _id = itmval["_id"] as? String ?? ""
                            let date_of_booking = itmval["date_of_booking"] as? String ?? ""
                            let order_id = itmval["order_id"] as? String ?? ""
                            let prodcut_image = itmval["prodcut_image"] as? String ?? Servicefile.sample_img
                            let product_name = itmval["product_name"]  as? String ?? ""
                            let product_price = itmval["product_price"]  as? Int ?? 0
                            let product_quantity = itmval["product_quantity"] as? Int ?? 0
                            let status = itmval["status"] as? String ?? ""
                            let user_cancell_date = itmval["user_cancell_date"] as? String ?? ""
                            let user_cancell_info = itmval["user_cancell_info"] as? String ?? ""
                            let vendor_accept_cancel = itmval["vendor_accept_cancel"] as? String ?? ""
                            let vendor_cancell_date = itmval["vendor_cancell_date"] as? String ?? ""
                            let vendor_cancell_info = itmval["vendor_cancell_info"] as? String ?? ""
                            let vendor_complete_date = itmval["vendor_complete_date"] as? String ?? ""
                            let vendor_complete_info = itmval["vendor_complete_info"] as? String ?? ""
                            let user_return_date = itmval["user_return_date"] as? String ?? ""
                            let user_return_info = itmval["user_return_info"] as? String ?? ""
                            let user_return_pic = itmval["user_return_pic"] as? String ?? ""
                            
                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_var_id: _id, In_date_of_booking: date_of_booking, In_order_id: order_id, In_prodcut_image: prodcut_image, In_product_name: product_name, In_product_price: product_price, In_product_quantity: product_quantity, In_status: status, In_user_cancell_date: user_cancell_date, In_user_cancell_info: user_cancell_info, In_vendor_accept_cancel: vendor_accept_cancel, In_vendor_cancell_date: vendor_cancell_date, In_vendor_cancell_info: vendor_cancell_info, In_vendor_complete_date: vendor_complete_date, In_vendor_complete_info: vendor_complete_info, In_user_return_date: user_return_date, In_user_return_info: user_return_info, In_user_return_pic: user_return_pic))
                        }
                        self.label_nodata.text = "No completed orders"
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func callcancelled(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_new_orderlist, method: .post, parameters:
            ["vendor_id": Servicefile.shared.vendorid,
             "order_status" : "Cancelled"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                            let _id = itmval["_id"] as? String ?? ""
                            let date_of_booking = itmval["date_of_booking"] as? String ?? ""
                            let order_id = itmval["order_id"] as? String ?? ""
                            let prodcut_image = itmval["prodcut_image"] as? String ?? Servicefile.sample_img
                            let product_name = itmval["product_name"]  as? String ?? ""
                            let product_price = itmval["product_price"]  as? Int ?? 0
                            let product_quantity = itmval["product_quantity"] as? Int ?? 0
                            let status = itmval["status"] as? String ?? ""
                            let user_cancell_date = itmval["user_cancell_date"] as? String ?? ""
                            let user_cancell_info = itmval["user_cancell_info"] as? String ?? ""
                            let vendor_accept_cancel = itmval["vendor_accept_cancel"] as? String ?? ""
                            let vendor_cancell_date = itmval["vendor_cancell_date"] as? String ?? ""
                            let vendor_cancell_info = itmval["vendor_cancell_info"] as? String ?? ""
                            let vendor_complete_date = itmval["vendor_complete_date"] as? String ?? ""
                            let vendor_complete_info = itmval["vendor_complete_info"] as? String ?? ""
                            let user_return_date = itmval["user_return_date"] as? String ?? ""
                            let user_return_info = itmval["user_return_info"] as? String ?? ""
                            let user_return_pic = itmval["user_return_pic"] as? String ?? ""
                            
                            Servicefile.shared.order_productdetail.append(order_productdetails.init(In_var_id: _id, In_date_of_booking: date_of_booking, In_order_id: order_id, In_prodcut_image: prodcut_image, In_product_name: product_name, In_product_price: product_price, In_product_quantity: product_quantity, In_status: status, In_user_cancell_date: user_cancell_date, In_user_cancell_info: user_cancell_info, In_vendor_accept_cancel: vendor_accept_cancel, In_vendor_cancell_date: vendor_cancell_date, In_vendor_cancell_info: vendor_cancell_info, In_vendor_complete_date: vendor_complete_date, In_vendor_complete_info: vendor_complete_info, In_user_return_date: user_return_date, In_user_return_info: user_return_info, In_user_return_pic: user_return_pic))
                            self.label_nodata.text = "No cancelled orders"
                            if Servicefile.shared.order_productdetail.count > 0 {
                                self.label_nodata.isHidden = true
                            }else{
                                self.label_nodata.isHidden = false
                            }
                            
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
            self.alert(Message: "No Intenet Please check and try again ")
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
                        
                        
                        self.callgetlist()
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
    
    func callcheckstatus(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Vendor_check_status, method: .post, parameters: ["user_id": Servicefile.shared.userid]
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let profile_status = Data["profile_status"] as? Bool ?? false
                        if profile_status == false {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Vendor_reg_ViewController") as! Vendor_reg_ViewController
                            self.present(vc, animated: true, completion: nil)
                        }else {
                            let profile_verification_status = Data["profile_verification_status"] as? String ?? ""
                            if profile_verification_status == "Not Verified" {
                                self.view_shadow.isHidden = false
                                self.view_popup.isHidden = false
                                let Message = res["Message"] as? String ?? ""
                                self.label_failedstatus.text = Message
                            }else{
                                self.view_shadow.isHidden = true
                                self.view_popup.isHidden = true
                                self.callgetlist()
                            }
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
    
   
    
    @IBAction func actionl_ogout(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
}
