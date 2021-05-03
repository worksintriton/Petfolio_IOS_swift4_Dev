//
//  vendor_manage_product_ViewController.swift
//  Petfolio
//
//  Created by Admin on 24/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import JJFloatingActionButton

class vendor_manage_product_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var tbl_manage_product: UITableView!
    @IBOutlet weak var textfield_search: UITextField!
    var isselect = [""]
    var orgiselect = [""]
    var isDrop = [""]
    var orgiDrop = [""]
    var isselectval = [""]
    var singleselect = ""
    var isappdeal = false
    var sdate = ""
    var expdate = ""
    var isstart = true
    @IBOutlet weak var view_discard: UIView!
    @IBOutlet weak var view_app_deal: UIView!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_prod_selected: UIView!
    @IBOutlet weak var view_datepicker: UIView!
    @IBOutlet weak var datepicker_date: UIDatePicker!
    
    @IBOutlet weak var view_manage: UIView!
    @IBOutlet weak var view_discount_unit: UIView!
    @IBOutlet weak var view_deal_price: UIView!
    @IBOutlet weak var view_discount_details: UIView!
    @IBOutlet weak var view_startdate: UIView!
    @IBOutlet weak var view_expirydate: UIView!
    @IBOutlet weak var view_btn_update_discount: UIView!
    
    @IBOutlet weak var label_discount_val: UILabel!
    @IBOutlet weak var label_cost: UILabel!
    
    @IBOutlet weak var label_apply_status: UILabel!
    
    @IBOutlet weak var textfield_discount_perunit: UITextField!
    @IBOutlet weak var textfield_deal_price: UITextField!
    @IBOutlet weak var textfield_startdate: UITextField!
    @IBOutlet weak var textfield_expirydate: UITextField!
    @IBOutlet weak var view_stackview: UIStackView!
    @IBOutlet weak var view_fistview: UIView!
    @IBOutlet weak var view_lastview: UIView!
    
    
    var discount = 0
    var dis_amt = 0
    var textdiscount = ""
    var textamt = ""
    
    let actionButton = JJFloatingActionButton()
    var applylabelval = "Apply Deal"
    var disstatus = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_app_deal.isHidden = false
        self.label_apply_status.text = applylabelval
        self.view_discount_details.isHidden = true
        self.view_stackview.layer.cornerRadius = 10.0
        self.view_datepicker.view_cornor()
        self.view_fistview.view_cornor()
        self.view_lastview.view_cornor()
        self.view_prod_selected.view_cornor()
        self.view_discount_unit.view_cornor()
        self.view_deal_price.view_cornor()
        self.view_startdate.view_cornor()
        self.view_expirydate.view_cornor()
        self.view_btn_update_discount.view_cornor()
        self.view_shadow.isHidden = true
        self.view_prod_selected.isHidden = true
        self.datepicker_date.datePickerMode = .date
        self.view_discard.isHidden = true
        self.view_datepicker.isHidden = true
        self.view_discard.view_cornor()
        self.view_app_deal.view_cornor()
        self.isselect.removeAll()
        self.isselectval.removeAll()
        self.orgiselect = self.isselect
        self.orgiDrop = self.isDrop
        self.textfield_search.delegate = self
        self.callgetproductdetails()
        self.tbl_manage_product.delegate = self
        self.tbl_manage_product.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidetbl))
        self.view_shadow.addGestureRecognizer(tap)
        self.datepicker_date.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.datepicker_date.minimumDate = Date()
        self.discounttextfielddelegate()
        self.floatbtn()
        self.actionButton.isHidden = true
        self.textfield_discount_perunit.addTarget(self, action: #selector(textFielddiscount_perunit), for: .editingChanged)
        self.textfield_deal_price.addTarget(self, action: #selector(textFielddeal_price), for: .editingChanged)
    }
    
    @objc func textFielddiscount_perunit(textField:UITextField) {
        self.disstatus = true
        if textField == self.textfield_discount_perunit {
            self.textfield_deal_price.text = ""
            self.textfield_discount_perunit.text = textField.text
            self.textdiscount = self.textfield_discount_perunit.text!
            if self.textfield_discount_perunit.text == "" {
                self.view_discount_details.isHidden = true
            }
            if self.self.isselectval.count == 0 {
                print("if text empty")
            }else if self.isselectval.count == 1  {
                print("if one data present")
                self.callsinglediscount()
            }else{
                print("if more data present")
            }
        }
    }
    
    @objc func textFielddeal_price(textField:UITextField) {
        self.disstatus = false
        if textField == self.textfield_deal_price {
            self.textfield_discount_perunit.text = ""
            self.textfield_deal_price.text = textField.text
            self.textamt = textField.text!
            if self.textfield_deal_price.text == "" {
                self.view_discount_details.isHidden = true
            }
            if self.self.isselectval.count == 0 {
                print("if text empty")
            }else if self.isselectval.count == 1  {
                print("if one data present")
                self.callsingleamount()
            }else{
                print("if more data present")
            }
        }
    }
    
    
    
    func floatbtn(){
        actionButton.addItem(title: "Discard", image: UIImage(named: "047")?.withRenderingMode(.alwaysTemplate)) { item in
          // do something
            self.isselectval.removeAll()
            self.singleselect = ""
            self.isselect = self.orgiselect
            self.isappdeal = false
            self.view_discard.isHidden = true
            self.view_app_deal.isHidden = false
            self.actionButton.isHidden = true
            self.tbl_manage_product.reloadData()
            self.hidediscount()
        }
        actionButton.addItem(title: applylabelval, image: UIImage(named: "047")?.withRenderingMode(.alwaysTemplate)) { item in
            self.isappdeal = true
            self.tbl_manage_product.reloadData()
            if self.isselectval.count > 0  || self.singleselect != ""{
                self.showdiscount()
            }
        }
        self.view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -68).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
   
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        if isstart {
            let senderdate = sender.date
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy"
            self.sdate = format.string(from: senderdate)
            self.textfield_startdate.text = self.sdate
            self.view_datepicker.isHidden = true
        }else{
            let senderdate = sender.date
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy"
            self.expdate = format.string(from: senderdate)
            self.textfield_expirydate.text = self.expdate
            self.view_datepicker.isHidden = true
        }
    }
    @objc func hidetbl() {
        self.hidediscount()
        self.discount = 0
        self.dis_amt = 0
        self.textfield_deal_price.text = ""
        self.textfield_discount_perunit.text = ""
        self.view_discount_details.isHidden = true
        self.view_datepicker.isHidden = true
        self.textfield_startdate.text = ""
        self.textfield_expirydate.text = ""
    }
    
    func discounttextfielddelegate(){
        self.textfield_discount_perunit.delegate = self
        self.textfield_deal_price.delegate = self
        self.textfield_startdate.delegate = self
        self.textfield_startdate.delegate = self
    }
    
    func showdiscount(){
        self.view_shadow.isHidden = false
        self.view_prod_selected.isHidden = false
        
    }
    
    func hidediscount(){
        self.view.endEditing(true)
        self.view_shadow.isHidden = true
        self.view_prod_selected.isHidden = true
    }
    
    @IBAction func action_startdate(_ sender: Any) {
        self.datepicker_date.minimumDate = Date()
        self.isstart = true
        self.view_datepicker.isHidden = false
    }
    
    @IBAction func action_expirydate(_ sender: Any) {
        if self.sdate != "" {
            let sdat = Servicefile.shared.ddMMyyyydateformat(date: self.sdate)
            self.datepicker_date.minimumDate = sdat
            self.isstart = false
            self.view_datepicker.isHidden = false
        }else{
            self.alert(Message: "Please select the start date")
        }
        
    }
    
    
    @IBAction func action_update_discount(_ sender: Any) {
        self.textdiscount = self.textfield_discount_perunit.text!
        self.textamt = self.textfield_deal_price.text!
        
       if self.textfield_startdate.text == "" &&  self.textfield_expirydate.text == ""{
            self.alert(Message: "Please enter the Discount or  Amount")
        }else if self.textfield_startdate.text == ""{
            self.alert(Message: "Please select the start date")
        }else if self.textfield_expirydate.text == ""{
            self.alert(Message: "Please select the end date")
        }else if self.isselectval.count == 1  {
            print("if one data present")
            self.callsinglesubmit()
        }else{
            print("if more data present")
            self.callmultisubmit()
        }
    }
    
    @IBAction func action_appdeal(_ sender: Any) {
        self.view_app_deal.isHidden = true
        self.actionButton.isHidden = false
        self.isappdeal = true
        self.tbl_manage_product.reloadData()
//        self.view_discard.isHidden = false
//        self.tbl_manage_product.reloadData()
//        if self.isselectval.count > 0  || singleselect != ""{
//            self.showdiscount()
//        }
    }
    
    @IBAction func action_discard(_ sender: Any) {
        self.view_app_deal.isHidden = false
        self.actionButton.isHidden = true
        self.isappdeal = false
        self.tbl_manage_product.reloadData()
        if self.isselectval.count > 0  || singleselect != ""{
            self.tbl_manage_product.reloadData()
            self.showdiscount()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    @IBAction func action_search(_ sender: Any) {
        
    }
    
    @IBAction func action_disacrd(_ sender: Any) {
        
    }
    
    @IBAction func action_applydeal(_ sender: Any) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.manageproductDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.isDrop[indexPath.row] == "1"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "unhide", for: indexPath) as! manageproduct_withval_TableViewCell
            let data = Servicefile.shared.manageproductDic[indexPath.row] as! NSDictionary
            cell.label_product_title.text = data["product_name"] as? String ?? ""
            cell.label_amt.text = data["product_price"] as? String ?? ""
            cell.selectionStyle = .none
            let age = data["pet_age"] as! NSArray
            let pet_breed = data["pet_breed"] as! NSArray
            let pet_prod_img = data["products_image"] as! NSArray
            let pet_type = data["pet_type"] as! NSArray
            
                cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Arraytoimage(arr: pet_prod_img))) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_product.image = UIImage(named: "sample")
                    } else {
                        cell.image_product.image = image
                    }
                }
            cell.label_amt.text = "₹ " + String(data["product_price"] as? Int ?? 0)
            let pet_prod_status = data["today_deal"] as! Bool
            cell.label_deal_status.isHidden = true
            if pet_prod_status {
                cell.label_deal_status.isHidden = false
                cell.label_deal_status.text = "Today deal"
            }else{
                cell.label_deal_status.isHidden = true
            }
            cell.label_breed.text = Arraytobreed(arr: pet_breed)
            cell.label_age.text = Arraytostring(arr: age)
            cell.label_pettype.text = Arraytotype(arr: pet_type)
            cell.label_threshold.text = data["pet_threshold"] as? String ?? ""
            cell.selectionStyle = .none
            if self.isselect[indexPath.row] == "0"{
                cell.image_ischeck.image = UIImage(named: imagelink.checkbox)
            }else{
                cell.image_ischeck.image = UIImage(named: imagelink.checkbox_1)
            }
            
            if self.isappdeal {
                cell.image_ischeck.isHidden = false
                cell.btn_ischeck.isHidden = false
            }else{
                cell.image_ischeck.isHidden = true
                cell.btn_ischeck.isHidden = true
            }
           
            cell.btn_hide.tag = indexPath.row
            cell.btn_hide.addTarget(self, action: #selector(ishide), for: .touchUpInside)
            cell.btn_ischeck.tag = indexPath.row
            cell.btn_ischeck.addTarget(self, action: #selector(ischeck), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "hide", for: indexPath) as! mangeproduct_withoutvalTableViewCell
            let data = Servicefile.shared.manageproductDic[indexPath.row] as! NSDictionary
            let pet_prod_img = data["products_image"] as! NSArray
            cell.selectionStyle = .none
                cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Arraytoimage(arr: pet_prod_img))) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_product.image = UIImage(named: "sample")
                    } else {
                        cell.image_product.image = image
                    }
            }
            let pet_prod_status = data["today_deal"] as! Bool
            cell.label_deal_status.isHidden = true
            if pet_prod_status {
                cell.label_deal_status.isHidden = false
                cell.label_deal_status.text = "Today deal"
            }else{
                cell.label_deal_status.isHidden = true
            }
            if self.isselect[indexPath.row] == "0"{
                cell.image_ischeck.image = UIImage(named: imagelink.checkbox)
            }else{
                cell.image_ischeck.image = UIImage(named: imagelink.checkbox_1)
            }
            if self.isappdeal {
                cell.image_ischeck.isHidden = false
                cell.btn_ischeck.isHidden = false
            }else{
                cell.image_ischeck.isHidden = true
                cell.btn_ischeck.isHidden = true
            }
            cell.label_product_title.text = data["product_name"] as? String ?? ""
            cell.label_amt.text = "₹ " + String(data["product_price"] as? Int ?? 0)
            cell.btn_hide.tag = indexPath.row
            cell.btn_hide.addTarget(self, action: #selector(ishide), for: .touchUpInside)
            cell.btn_ischeck.tag = indexPath.row
            cell.btn_ischeck.addTarget(self, action: #selector(ischeck), for: .touchUpInside)
            return cell
        }
    }
    
    func Arraytostring(arr: NSArray) -> String{
        var agedata = ""
        for i in 0..<arr.count{
            let val = String(arr[i] as? Int ?? 0)
            if i == 0 {
                agedata = val
            }else{
                agedata = agedata + ", " +  val
            }
        }
        return agedata
    }
    
    func Arraytobreed(arr: NSArray) -> String{
        var agedata = ""
        for i in 0..<arr.count{
            let breed = arr[i] as! NSDictionary
            let val = breed["pet_breed"] as? String ?? ""
            if i == 0 {
                agedata = val
            }else{
                agedata = agedata + ", " +  val
            }
        }
        return agedata
    }
    
    func Arraytotype(arr: NSArray) -> String{
        var agedata = ""
        for i in 0..<arr.count{
            let breed = arr[i] as! NSDictionary
            let val = breed["pet_type_title"] as? String ?? ""
            if i == 0 {
                agedata = val
            }else{
                agedata = agedata + ", " +  val
            }
        }
        return agedata
    }
    
    func Arraytoimage(arr: NSArray) -> String{
        var agedata = ""
        for i in 0..<arr.count{
            let val = arr[i] as! String
            if i == 0 {
                agedata = val
            }
        }
        return agedata
    }
    
    @objc func ishide(sender: UIButton){
        let tag = sender.tag
        if self.isDrop[tag] == "1"{
            self.isDrop =  self.orgiDrop
            self.tbl_manage_product.reloadData()
        }else{
            self.isDrop = self.orgiDrop
            self.isDrop.remove(at: tag)
            self.isDrop.insert("1", at: tag)
            self.tbl_manage_product.reloadData()
        }
    }
    
    @objc func ischeck(sender: UIButton){
        var selectdata = [""]
        selectdata.removeAll()
        selectdata = self.isselectval
        let tag = sender.tag
        if self.isselect[tag] == "1"{
            self.isselect.remove(at: tag)
            self.isselect.insert("0", at: tag)
            let data = Servicefile.shared.manageproductDic[tag] as! NSDictionary
            let val = data["product_id"] as? String ?? ""
            
                    for j in 0..<self.isselectval.count{
                        if  val == self.isselectval[j] {
                                    selectdata.remove(at: j)
                                }
                    }
            self.isselectval = selectdata
             if self.isselectval.count == 1{
                self.singleselect = self.isselectval[0]
            }else if self.isselectval.count > 1{
                self.singleselect = ""
            }else{
                self.isselectval.removeAll()
                self.singleselect = ""
            }
            self.tbl_manage_product.reloadData()
            
        }else{
            self.isselect.remove(at: tag)
            self.isselect.insert("1", at: tag)
            let data = Servicefile.shared.manageproductDic[tag] as! NSDictionary
            let prod_id = data["product_id"] as? String ?? ""
            self.isselectval.append(prod_id)
            if self.isselectval.count == 1 {
                self.singleselect = prod_id
            }
            self.tbl_manage_product.reloadData()
        }
        
//        if self.isselectval.count > 0 {
//            self.label_apply_status.text = "Submit"
//            self.view_discard.isHidden = false
//        }else{
//            self.label_apply_status.text = "Apply Deal"
//            self.view_discard.isHidden = true
//        }
        print("ischeck final",self.isselectval,"selected", selectdata)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isDrop[indexPath.row] == "1"{
            return 260
        }else{
            return 200
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        Servicefile.shared.manageproductDic.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_bell(_ sender: Any) {
        
    }
    
    @IBAction func action_bag(_ sender: Any) {
        
    }
    
    @IBAction func action_profile(_ sender: Any) {
        
    }
    
    @IBAction func action_community(_ sender: Any) {
        
    }
    
    @IBAction func action_shop(_ sender: Any) {
        
    }
    
    @IBAction func action_home(_ sender: Any) {
        
    }
    
    func callgetproductdetails(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_manage_product, method: .post, parameters:
                                                                    ["vendor_id": Servicefile.shared.vendorid,
                                                                        "search_string":""], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSArray
                        Servicefile.shared.manageproductDic = Data as! [Any]
                        for _ in 0..<Servicefile.shared.manageproductDic.count{
                            self.isDrop.append("0")
                            self.isselect.append("0")
                        }
                         self.orgiDrop = self.isDrop
                        self.orgiselect = self.isselect
                        self.tbl_manage_product.reloadData()
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
    
    func calldiscountanddealprice(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_manage_product, method: .post, parameters:
                                                                    ["vendor_id": Servicefile.shared.vendorid,
                                                                        "search_string":""], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSArray
                        Servicefile.shared.manageproductDic = Data as! [Any]
                        for _ in 0..<Servicefile.shared.manageproductDic.count{
                            self.isDrop.append("0")
                            self.isselect.append("0")
                        }
                         self.orgiDrop = self.isDrop
                        self.orgiselect = self.isselect
                        self.tbl_manage_product.reloadData()
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
    
    func callsinglediscount(){
        let discount = Int(self.textdiscount) ?? 0
        let cost = Int(self.textamt) ?? 0
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_manage_discountsingle, method: .post, parameters:
                                                                    ["_id": self.singleselect,"discount":discount,"discount_amount":cost,"discount_status":self.disstatus], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        self.discount = Data["discount"] as? Int ?? 0
                        self.dis_amt = Data["cost"] as? Int ?? 0
                        self.label_discount_val.text = String(self.discount) + " %"
                        self.label_cost.text = "₹" + String(self.dis_amt)
                        if self.textfield_discount_perunit.text! != "" {
                            self.view_discount_details.isHidden = false
                        }else{
                            self.view_discount_details.isHidden = true
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
    func callsingleamount(){
        self.disstatus =  false
        let discount = Int(self.textdiscount) ?? 0
        let cost = Int(self.textamt) ?? 0
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_manage_discountsingle, method: .post, parameters:
                                                                    ["_id": self.singleselect,"discount":discount,"discount_amount":cost,"discount_status":self.disstatus], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        self.discount = Data["discount"] as? Int ?? 0
                        self.dis_amt = Data["cost"] as? Int ?? 0
                        self.label_discount_val.text = String(self.discount) + " %"
                        self.label_cost.text = "₹" + String(self.dis_amt)
                        if self.textfield_deal_price.text! != "" {
                            self.view_discount_details.isHidden = false
                        }else{
                            self.view_discount_details.isHidden = true
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
    
    func callsinglesubmit(){
        let discount = Int(self.textdiscount) ?? 0
        let cost = Int(self.textamt) ?? 0
        print("single submit","_id", self.singleselect,"discount",discount,"discount_amount",cost,"discount_end_date",self.textfield_expirydate.text!,"discount_start_date",self.textfield_startdate.text!,"discount_status",self.disstatus)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_manage_submitsingle, method: .post,
                                                                 parameters: ["_id": self.singleselect,"discount":discount,"discount_amount":cost,"discount_end_date":self.textfield_expirydate.text!,"discount_start_date":self.textfield_startdate.text!,"discount_status":self.disstatus], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        //let Data = res["Data"] as! NSDictionary
                        self.isselectval.removeAll()
                        self.singleselect = ""
                        self.isselect = self.orgiselect
                        self.isappdeal = false
                        self.view_discard.isHidden = true
                        self.view_app_deal.isHidden = false
                        self.actionButton.isHidden = true
                        self.tbl_manage_product.reloadData()
                        self.hidediscount()
                        self.callgetproductdetails()
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
    
    
    
    func callmultisubmit(){
        let discount = Int(self.textdiscount) ?? 0
        let cost = Int(self.textamt) ?? 0
        print("single submit","_id", self.isselectval,"discount",discount,"discount_amount",cost,"discount_end_date",self.textfield_expirydate.text!,"discount_start_date",self.textfield_startdate.text!,"discount_status",self.disstatus)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_manage_submitmultiple, method: .post, parameters:["_id": self.isselectval,"discount":discount,"discount_amount":cost,"discount_end_date":self.textfield_expirydate.text!,"discount_start_date":self.textfield_startdate.text!,"discount_status":self.disstatus], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in manage product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        //let Data = res["Data"] as! NSArray
                        self.isselectval.removeAll()
                        self.singleselect = ""
                        self.isselect = self.orgiselect
                        self.isappdeal = false
                        self.view_discard.isHidden = true
                        self.view_app_deal.isHidden = false
                        self.actionButton.isHidden = true
                        self.tbl_manage_product.reloadData()
                        self.hidediscount()
                        self.callgetproductdetails()
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
