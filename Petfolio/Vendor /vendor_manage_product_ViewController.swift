//
//  vendor_manage_product_ViewController.swift
//  Petfolio
//
//  Created by Admin on 24/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class vendor_manage_product_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var tbl_manage_product: UITableView!
    @IBOutlet weak var textfield_search: UITextField!
    var isselect = [""]
    var orgiselect = [""]
    var  isappdeal = false
    @IBOutlet weak var view_discard: UIView!
    @IBOutlet weak var view_app_deal: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_discard.isHidden = true
        self.view_discard.view_cornor()
        self.view_app_deal.view_cornor()
        
        self.isselect.removeAll()
        self.orgiselect = self.isselect
        self.textfield_search.delegate = self
        self.callgetproductdetails()
        self.tbl_manage_product.delegate = self
        self.tbl_manage_product.dataSource = self
    }
    
    @IBAction func action_appdeal(_ sender: Any) {
        self.isappdeal = true
        self.view_discard.isHidden = false
    }
    
    @IBAction func action_discard(_ sender: Any) {
        self.isappdeal = false
        self.view_discard.isHidden = true
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
        if self.isselect[indexPath.row] == "1"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "unhide", for: indexPath) as! manageproduct_withval_TableViewCell
            let data = Servicefile.shared.manageproductDic[indexPath.row] as! NSDictionary
            cell.label_product_title.text = data["product_name"] as? String ?? ""
            cell.label_pettype.text = data["product_name"] as? String ?? ""
            cell.label_breed.text = data["product_name"] as? String ?? ""
            let age = data["pet_age"] as! NSArray
            let pet_breed = data["pet_breed"] as! NSArray
            let pet_prod_img = data["products_image"] as! NSArray
            
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
            cell.label_breed.text = Arraytobreed(arr: pet_breed)
            cell.label_age.text = Arraytostring(arr: age)
            cell.label_threshold.text = data["pet_threshold"] as? String ?? ""
            //cell.image_ischeck.image = UIImage(named: "checkbox-1")
            cell.selectionStyle = .none
            cell.image_ischeck.image = UIImage(named: "checkbox")
            if self.isappdeal {
                cell.image_ischeck.isHidden = true
                cell.btn_ischeck.isHidden = true
            }else{
                cell.image_ischeck.isHidden = false
                cell.btn_ischeck.isHidden = false
            }
            
            cell.btn_hide.tag = indexPath.row
            cell.btn_hide.addTarget(self, action: #selector(ishide), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "hide", for: indexPath) as! mangeproduct_withoutvalTableViewCell
            let data = Servicefile.shared.manageproductDic[indexPath.row] as! NSDictionary
            cell.image_ischeck.image = UIImage(named: "checkbox")
            let pet_prod_img = data["products_image"] as! NSArray
            cell.selectionStyle = .none
                cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Arraytoimage(arr: pet_prod_img))) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_product.image = UIImage(named: "sample")
                    } else {
                        cell.image_product.image = image
                    }
                }
            cell.image_ischeck.image = UIImage(named: "checkbox")
            if self.isappdeal {
                cell.image_ischeck.isHidden = true
                cell.btn_ischeck.isHidden = true
            }else{
                cell.image_ischeck.isHidden = false
                cell.btn_ischeck.isHidden = false
            }
            cell.label_product_title.text = data["product_name"] as? String ?? ""
            cell.btn_hide.tag = indexPath.row
            cell.btn_hide.addTarget(self, action: #selector(ishide), for: .touchUpInside)
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
        if self.isselect[tag] == "1"{
            self.isselect =  self.orgiselect
            self.tbl_manage_product.reloadData()
        }else{
            self.isselect =  self.orgiselect
            self.isselect.remove(at: tag)
            self.isselect.insert("1", at: tag)
            self.tbl_manage_product.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isselect[indexPath.row] == "1"{
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
                            self.isselect.append("0")
                        }
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
}
