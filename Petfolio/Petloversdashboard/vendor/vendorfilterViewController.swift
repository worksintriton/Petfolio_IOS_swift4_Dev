//
//  vendorfilterViewController.swift
//  Petfolio
//
//  Created by Admin on 30/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class vendorfilterViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var view_sortby: UIView!
    @IBOutlet weak var tbl_sortlist: UITableView!
    @IBOutlet weak var view_apply: UIView!
    @IBOutlet weak var view_clearall: UIView!
    
    var discountvalue = ["30 % and More","20 % and More","10 % and More","10 % and below",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_clearall.view_cornor()
        self.view_apply.view_cornor()
        self.view_sortby.view_cornor()
        
        self.tbl_sortlist.delegate = self
        self.tbl_sortlist.dataSource = self
        
        self.callpetdetailget()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if Servicefile.shared.productsearchpage == "todaysdeal" {
            if let firstVC = presentingViewController as? todaysdealseemoreViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
        }else{
            if let firstVC = presentingViewController as? ProductdealsViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
        }
       }
    
    @IBAction func action_filter(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func hidetbl() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Servicefile.shared.vendor_fdata.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Servicefile.shared.vendor_fdata[section].isselect {
            return Servicefile.shared.vendor_fdata[section].row_val.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! isselectionTableViewCell
        cell.label_val.text = Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].title
        if Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].isselect {
            cell.image_isselect.image = UIImage(named: "selectedRadio")
        }else{
            cell.image_isselect.image = UIImage(named: "Radio")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Servicefile.shared.vendor_fdata[indexPath.section].row_val = Servicefile.shared.vendor_orgifdata[indexPath.section].row_val
        if Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].isselect {
            Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].isselect = false
        }else{
            Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].isselect = true
        }
        if Servicefile.shared.vendor_fdata[indexPath.section].sectionname == "Pet type" {
            self.callpetbreedbyid(petid: Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].id)
        }
        if Servicefile.shared.vendor_fdata[indexPath.section].sectionname == "Pet Breed" {
            Servicefile.shared.vendor_filter_pet_breed_id = Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].id
        }
        
        if Servicefile.shared.vendor_fdata[indexPath.section].sectionname == "Discount"{
            Servicefile.shared.vendor_filter_discount = String(indexPath.row)
        }
        
        if Servicefile.shared.vendor_fdata[indexPath.section].sectionname == "Category"{
            Servicefile.shared.vendor_filter_catid = Servicefile.shared.vendor_fdata[indexPath.section].row_val[indexPath.row].id
        }
        
        print("data in pet type",Servicefile.shared.vendor_fdata[0])
        self.tbl_sortlist.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        let titleLabel = UILabel()
        let arrowLabel = UILabel()
        let button = UIButton()
        
        // Title label
        vw.addSubview(titleLabel)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: vw.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: vw.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: vw.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: vw.leadingAnchor).isActive = true
        titleLabel.text = Servicefile.shared.vendor_fdata[section].sectionname
        vw.addSubview(arrowLabel)
        if Servicefile.shared.vendor_fdata[section].isselect {
            arrowLabel.text = "▲"
        }else{
            arrowLabel.text = "▼"
        }
        
        arrowLabel.textColor = UIColor.black
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 18).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: vw.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: vw.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: vw.bottomAnchor).isActive = true
        vw.addSubview(button)
        button.titleLabel?.text = ""
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: vw.topAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: vw.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: vw.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: vw.leadingAnchor).isActive = true
        button.tag = section
        button.addTarget(self, action: #selector(issection), for: .touchUpInside)
        return vw
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView()
        let arrowLabel = UIImageView()
        let arrowLabel1 = UIImageView()
        vw.addSubview(arrowLabel1)
        arrowLabel1.image = UIImage(named: "")
        arrowLabel1.backgroundColor = .clear
        arrowLabel1.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel1.topAnchor.constraint(equalTo: vw.topAnchor).isActive = true
        arrowLabel1.trailingAnchor.constraint(equalTo: vw.trailingAnchor).isActive = true
        arrowLabel1.widthAnchor.constraint(equalToConstant: 7).isActive = true
        arrowLabel1.leadingAnchor.constraint(equalTo: vw.leadingAnchor).isActive = true
        vw.addSubview(arrowLabel)
        arrowLabel.image = UIImage(named: "dotted black")
        arrowLabel.backgroundColor = .clear
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.topAnchor.constraint(equalTo: vw.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: vw.trailingAnchor).isActive = true
        arrowLabel.widthAnchor.constraint(equalToConstant: 1).isActive = true
        arrowLabel.leadingAnchor.constraint(equalTo: vw.leadingAnchor).isActive = true
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    @objc func issection(sender: UIButton){
        let tag = sender.tag
        if Servicefile.shared.vendor_fdata[tag].isselect {
            Servicefile.shared.vendor_fdata[tag].isselect = false
        }else{
            Servicefile.shared.vendor_fdata[tag].isselect = true
        }
        self.tbl_sortlist.reloadData()
    }
    
    
    
    @objc func action_isselect(sender : Int, section: Int){
        
       
    }
    @IBAction func action_clearall(_ sender: Any) {
        Servicefile.shared.vendor_fdata = Servicefile.shared.vendor_orgifdata
        self.tbl_sortlist.reloadData()
    }
    
    @IBAction func action_apply(_ sender: Any) {
        self.callfilterby()
    }
    
    func callfilterby(){
//        Servicefile.shared.loadingcount = 1
//        self.loadcount = self.loadcount + 1
        var params  = [String:Any]()
        
            params = [ "pet_type": Servicefile.shared.vendor_filter_pet_type_id,
                       "pet_breed": Servicefile.shared.vendor_filter_pet_breed_id,
                       "discount_value": Servicefile.shared.vendor_filter_discount,
                       "cat_id": Servicefile.shared.vendor_filter_catid]
        
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_filter, method: .post, parameters:
                                                                    params, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("filter success data",res)
                    let Code  = res["Code"] as! Int
                    
                    if Code == 200 {
                        let search_val = res["Data"] as! NSArray
                        if Servicefile.shared.today_deals_status {
                            Servicefile.shared.sp_dash_Today_Special.removeAll()
                        }else{
                            Servicefile.shared.sp_dash_productdetails.removeAll()
                        }
                        for itm in 0..<search_val.count{
                            let itmdata = search_val[itm] as! NSDictionary
                            let id  = itmdata["_id"] as? String ?? ""
                            let product_discount = itmdata["product_discount"] as? Int ?? 0
                            let product_fav = itmdata["product_fav"] as? Bool ?? false
                            let product_img = itmdata["product_img"] as? String ?? Servicefile.sample_img
                            let product_price = itmdata["product_price"] as? Int ?? 0
                            let product_rating = String(itmdata["product_rating"] as? Double ?? 0.0 )
                            let product_review = String(itmdata["product_review"] as? Int ?? 0)
                            let product_title = itmdata["product_title"] as? String ?? ""
                            if Servicefile.shared.today_deals_status {
                                Servicefile.shared.sp_dash_Today_Special.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
                            }else{
                                Servicefile.shared.sp_dash_productdetails.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
                            }
                        }
                        self.stopAnimatingActivityIndicator()
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.stopAnimatingActivityIndicator()
                    }
                    break
                case .failure(let Error):
                    //Servicefile.shared.loadingcount = 0
                    self.stopAnimatingActivityIndicator()
                    
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func callpetdetailget(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.petdetailget, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let Pet_type = Data["usertypedata"] as! NSArray
                        Servicefile.shared.vendor_fdata.removeAll()
                        Servicefile.shared.vendor_fstatus.removeAll()
                        for item in 0..<Pet_type.count{
                            let pb = Pet_type[item] as! NSDictionary
                            let pbtittle = pb["pet_type_title"] as? String ?? ""
                            let pbid = pb["_id"] as? String ?? ""
                            let isselect = false
                            Servicefile.shared.vendor_fstatus.append(vendor_filterstatus.init(In_id: pbid, In_title: pbtittle, In_isselect: isselect))
                        }
                        Servicefile.shared.vendor_fdata.append(vendor_filterdata.init(In_sectionname: "Pet type", In_row_val: Servicefile.shared.vendor_fstatus, In_isselect: false))
                        Servicefile.shared.vendor_fstatus.removeAll()
                        Servicefile.shared.vendor_fdata.append(vendor_filterdata.init(In_sectionname: "Pet Breed", In_row_val: Servicefile.shared.vendor_fstatus, In_isselect: false))
                        Servicefile.shared.vendor_fstatus.removeAll()
                        for i in 0..<self.discountvalue.count{
                            let isselect = false
                            Servicefile.shared.vendor_fstatus.append(vendor_filterstatus.init(In_id: "0", In_title: self.discountvalue[i], In_isselect: isselect))
                        }
                        Servicefile.shared.vendor_fdata.append(vendor_filterdata.init(In_sectionname: "Discount", In_row_val: Servicefile.shared.vendor_fstatus, In_isselect: false))
                        Servicefile.shared.vendor_fstatus.removeAll()
                        Servicefile.shared.vendor_fdata.append(vendor_filterdata.init(In_sectionname: "Category", In_row_val: Servicefile.shared.vendor_fstatus, In_isselect: false))
                        Servicefile.shared.vendor_orgifdata = Servicefile.shared.vendor_fdata
                        self.tbl_sortlist.reloadData()
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
                }        }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func callpetbreedbyid(petid: String){
        Servicefile.shared.vendor_filter_pet_type_id = petid
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petbreedid, method: .post, parameters:
            ["pet_type_id" : petid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Pet_breed = res["Data"] as! NSArray
                        Servicefile.shared.vendor_fstatus.removeAll()
                        for item in 0..<Pet_breed.count{
                            let pb = Pet_breed[item] as! NSDictionary
                            let pbtittle = pb["pet_breed"] as? String ?? ""
                            let pbid = pb["_id"] as? String ?? ""
                            let isselect = false
                            Servicefile.shared.vendor_fstatus.append(vendor_filterstatus.init(In_id: pbid, In_title: pbtittle, In_isselect: isselect))
                        }
                        Servicefile.shared.vendor_fdata.remove(at: 1)
                        Servicefile.shared.vendor_fdata.insert(vendor_filterdata.init(In_sectionname: "Pet Breed", In_row_val: Servicefile.shared.vendor_fstatus, In_isselect: false), at: 1)
                        Servicefile.shared.vendor_orgifdata[1] = Servicefile.shared.vendor_fdata[1]
                        self.tbl_sortlist.reloadData()
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
