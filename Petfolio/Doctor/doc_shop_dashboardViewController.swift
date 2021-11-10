//
//  doc_shop_dashboardViewController.swift
//  Petfolio
//
//  Created by Admin on 11/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class doc_shop_dashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectItmDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tbl_dash_list: UITableView!
   
    @IBOutlet weak var view_header: petowner_header!
    
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var view_allcategory: UIView!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var textfield_search: UITextField!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.inital_setup()
        self.textfield_search.delegate = self
        self.textfield_search.autocapitalizationType = .sentences
        self.view_allcategory.view_cornor()
        self.view_allcategory.isHidden = true
        self.view_search.view_cornor()
        self.tbl_dash_list.delegate = self
        self.tbl_dash_list.dataSource = self
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.tbl_dash_list.addSubview(refreshControl)
    }
    
    @objc func refresh(){
        self.callpetshopdashget()
        self.refreshControl.endRefreshing()
    }
    
    
    func inital_setup(){
        self.view_header.btn_sidemenu.addTarget(self, action: #selector(self.docsidemenu), for: .touchUpInside)
//        var img = Servicefile.shared.userimage
//        if img != "" {
//            img = Servicefile.shared.userimage
//        }else{
//            img = Servicefile.sample_img
//        }
        //self.view_header.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//        self.view_header.image_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: img)) { (image, error, cache, urls) in
//            if (error != nil) {
//                self.view_header.image_profile.image = UIImage(named: imagelink.sample)
//            } else {
//                self.view_header.image_profile.image = image
//            }
//        }
        self.view_header.label_location.text = Servicefile.shared.shiplocation
        self.view_header.image_profile.layer.cornerRadius = self.view_header.image_profile.frame.height / 2
        self.view_header.btn_location.addTarget(self, action: #selector(self.docmanageaddress), for: .touchUpInside)
//        self.view_header.btn_profile.addTarget(self, action: #selector(self.docprofile), for: .touchUpInside)
//        self.view_header.image_button2.image = UIImage(named: imagelink.image_bag)
//        self.view_header.btn_button2.addTarget(self, action: #selector(self.doccartpage), for: .touchUpInside)
//
        self.view_header.btn_button2.addTarget(self, action: #selector(doccartpage), for: .touchUpInside)
        self.view_header.image_button2.image = UIImage(named: imagelink.image_bag)
        self.view_header.image_profile.image = UIImage(named: imagelink.image_bel)
        self.view_header.btn_profile.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        
        
        
        self.view_footer.setup(b1: false, b2: true, b3: false)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.docshop), for: .touchUpInside)
        //self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Servicefile.shared.pet_shop_search = self.textfield_search.text!
        self.view.endEditing(true)
        self.textfield_search.text = ""
        let vc = UIStoryboard.doc_shop_search_ViewController()
        self.present(vc, animated: true, completion: nil)
        return true
    }
    
    @IBAction func action_cartpage(_ sender: Any) {
        let vc = UIStoryboard.vendorcartpageViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callpetshopdashget()
    }
    
    @IBAction func action_search(_ sender: Any) {
        Servicefile.shared.pet_shop_search = self.textfield_search.text!
        self.view.endEditing(true)
        self.textfield_search.text = ""
        let vc = UIStoryboard.doc_shop_search_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
  
    
    @IBAction func action_sidemenu(_ sender: Any) {
        let vc = UIStoryboard.Pet_sidemenu_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if Servicefile.shared.sp_dash_Banner_details.count > 0{
                return 1
            }else{
                return 0
            }
        }else if section == 1 {
            if Servicefile.shared.sp_dash_Today_Special.count > 0 {
                return 1
            }else{
                return 0
            }
        }else{
            return Servicefile.shared.sp_dash_Product_details.count
        }
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! sp_shop_dash_bannerTableViewCell
            cell.coll_pet_dash_shop_banner.tag = indexPath.row
            cell.coll_pet_dash_shop_banner.reloadData()
            cell.selectionStyle = .none
            return cell
        }else if indexPath.section == 1 {
            let cells = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as! todayspecialTableViewCell
            cells.delegate = self
            cells.label_cate_value.text = "Deals of the day"
            cells.btn_cate_seemore_btn.tag = indexPath.row
            Servicefile.shared.sp_shop_dash_tbl_total_index = indexPath.row
            cells.coll_cat_prod_list.tag = indexPath.row
            cells.coll_cat_prod_list.reloadData()
            cells.btn_cate_seemore_btn.addTarget(self, action: #selector(action_todaydeal_seemore), for: .touchUpInside)
            cells.selectionStyle = .none
            return cells
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scell", for: indexPath) as! sp_dash_product_TableViewCell
            cell.delegate = self
            cell.label_cate_value.text = Servicefile.shared.sp_dash_Product_details[indexPath.row].cat_name
            Servicefile.shared.sp_shop_dash_tbl_index = indexPath.row
            cell.btn_cate_seemore_btn.tag = indexPath.row
            cell.btn_cate_seemore_btn.addTarget(self, action: #selector(action_category_seemore), for: .touchUpInside)
            cell.coll_cat_prod_list.tag = indexPath.row
            cell.coll_cat_prod_list.reloadData()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func buttonPressed(passdata: String) {
           print("pass data from protocal",passdata)
        let vc = UIStoryboard.Doc_productdetails_ViewController()
                      self.present(vc, animated: true, completion: nil)
        
       
       }
    
    @objc func action_todaydeal_seemore(sender: UIButton){
           let tag = sender.tag
        Servicefile.shared.today_deals_status = true
        let vc = UIStoryboard.doc_todaysdealseemoreViewController()
        self.present(vc, animated: true, completion: nil)
        
       }
       
       @objc func action_category_seemore(sender: UIButton){
           let tag = sender.tag
        Servicefile.shared.today_deals_status = false
        Servicefile.shared.vendor_catid = Servicefile.shared.sp_dash_Product_details[tag].cat_id
        let vc = UIStoryboard.doc_ProductdealsViewController()
               self.present(vc, animated: true, completion: nil)
       }
    
    func callpetshopdashget(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_shop_dash, method: .post, parameters: ["user_id": Servicefile.shared.userid]
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let Banner_details = Data["Banner_details"] as! NSArray
                        let Product_details = Data["Product_details"] as! NSArray
                        let Today_Special = Data["Today_Special"] as! NSArray
                        //                        var sp_dash_Banner_details = [pet_sp_dash_banner]()
                        //                           var sp_dash_Product_details = [pet_sp_dash_productdetails]()
                        //                           var sp_dash_Today_Special = [productdetails]()
                        Servicefile.shared.sp_dash_Banner_details.removeAll()
                        Servicefile.shared.sp_dash_Product_details.removeAll()
                        Servicefile.shared.sp_dash_Today_Special.removeAll()
                        for bann in 0..<Banner_details.count{
                            let idata = Banner_details[bann] as! NSDictionary
                            let bann_imag = idata["banner_img"] as? String ?? Servicefile.sample_bannerimg
                            let banner_title = idata["banner_title"] as? String ?? ""
                            Servicefile.shared.sp_dash_Banner_details.append(pet_sp_dash_banner.init(In_banner: bann_imag, In_banner_title: banner_title))
                        }
                        for itm in 0..<Today_Special.count{
                            let itmdata = Today_Special[itm] as! NSDictionary
                            let id  = itmdata["_id"] as? String ?? ""
                            let product_discount = itmdata["product_discount"] as? Int ?? 0
                            let product_fav = itmdata["product_fav"] as? Bool ?? false
                            let product_img = itmdata["product_img"] as? String ?? Servicefile.sample_img
                            let product_price = itmdata["product_price"] as? Int ?? 0
                            let product_rating = String(itmdata["product_rating"] as? Double ?? 0.0 )
                            let product_review = String(itmdata["product_review"] as? Int ?? 0)
                            let product_title = itmdata["product_title"] as? String ?? ""
                            let thumbnail_image = itmdata["thumbnail_image"] as? String ?? ""
                            let product_discount_price = itmdata["product_discount_price"] as? Int ?? 0
                            Servicefile.shared.sp_dash_Today_Special.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title, In_thumbnail_image: thumbnail_image, Iproduct_discount_price: product_discount_price))
                        }
                        for cat_prod_deta in 0..<Product_details.count{
                            let catval = Product_details[cat_prod_deta] as! NSDictionary
                            let cat_id = catval["cat_id"] as? String ?? ""
                            let cat_name = catval["cat_name"] as? String ?? ""
                            let product_list = catval["product_list"] as! NSArray
                            Servicefile.shared.sp_dash_productdetails.removeAll()
                            for prodi in 0..<product_list.count{
                                let prodval = product_list[prodi] as! NSDictionary
                                let id  = prodval["_id"] as? String ?? ""
                                let product_discount = prodval["product_discount"] as? Int ?? 0
                                let product_fav = prodval["product_fav"] as? Bool ?? false
                                let product_img = prodval["product_img"] as? String ?? Servicefile.sample_img
                                let product_price = prodval["product_price"] as? Int ?? 0
                                let product_rating = String(prodval["product_rating"] as? Double ?? 0.0)
                                let product_review = String(prodval["product_review"] as? Int ?? 0)
                                let product_title = prodval["product_title"] as? String ?? ""
                                let thumbnail_image = prodval["thumbnail_image"] as? String ?? ""
                                let product_discount_price = prodval["product_discount_price"] as? Int ?? 0
                                
                                Servicefile.shared.sp_dash_productdetails.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title, In_thumbnail_image: thumbnail_image, Iproduct_discount_price: product_discount_price))
                            }
                            if Servicefile.shared.sp_dash_productdetails.count > 0 {
                                Servicefile.shared.sp_dash_Product_details.append(pet_sp_dash_productdetails.init(In_cartid: cat_id, In_cart_name: cat_name, In_product_details: Servicefile.shared.sp_dash_productdetails))
                            }
                        }
                        self.tbl_dash_list.reloadData()
                        self.stopAnimatingActivityIndicator()
                        self.callnoticartcount()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func callnoticartcount(){
        print("notification")
        Servicefile.shared.notifi_count = 0
        Servicefile.shared.cart_count = 0
        self.view_header.checknoti()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.cartnoticount, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("notification success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let notification_count = Data["notification_count"] as! Int
                        let product_count = Data["product_count"] as! Int
                        Servicefile.shared.notifi_count = notification_count
                        Servicefile.shared.cart_count = product_count
                        self.view_header.checknoti()
                    }else{
                        print("status code service denied")
                    }
                    break
                case .failure(let Error):
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }
            }
        }else{
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    
}


