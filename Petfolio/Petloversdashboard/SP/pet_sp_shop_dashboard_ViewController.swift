//
//  pet_sp_shop_dashboard_ViewController.swift
//  Petfolio
//
//  Created by Admin on 18/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_sp_shop_dashboard_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl_dash_list: UITableView!
    @IBOutlet weak var view_footer: UIView!
    @IBOutlet weak var view_allcategory: UIView!
    @IBOutlet weak var view_search: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_footer.view_cornor()
        self.view_allcategory.view_cornor()
        self.view_search.view_cornor()
        self.tbl_dash_list.delegate = self
        self.tbl_dash_list.dataSource = self
        self.callpetshopdashget()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_home(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_petcare(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_searchlist_DRViewController") as! Pet_searchlist_DRViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_petservice(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_dashfooter_servicelist_ViewController") as! pet_dashfooter_servicelist_ViewController
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
    @objc func action_todaydeal_seemore(sender: UIButton){
        let tag = sender.tag
        print("data in index of today deal", tag)
    }
    
    @objc func action_category_seemore(sender: UIButton){
        let tag = sender.tag
        print("data in index of category", tag)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! sp_shop_dash_bannerTableViewCell
            cell.coll_pet_dash_shop_banner.tag = indexPath.row
            cell.coll_pet_dash_shop_banner.reloadData()
            return cell
        }else if indexPath.section == 1 {
            let cells = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as! todayspecialTableViewCell
            cells.label_cate_value.text = "Todays deal"
            cells.btn_cate_seemore_btn.tag = indexPath.row
            Servicefile.shared.sp_shop_dash_tbl_index = indexPath.row
            cells.coll_cat_prod_list.tag = indexPath.row
            cells.coll_cat_prod_list.reloadData()
            cells.btn_cate_seemore_btn.addTarget(self, action: #selector(action_todaydeal_seemore), for: .touchUpInside)
            return cells
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "scell", for: indexPath) as! sp_dash_product_TableViewCell
            cell.label_cate_value.text = "cat "+"\(indexPath.row)"
            Servicefile.shared.sp_shop_dash_tbl_index = indexPath.row
            cell.btn_cate_seemore_btn.tag = indexPath.row
            cell.btn_cate_seemore_btn.addTarget(self, action: #selector(action_category_seemore), for: .touchUpInside)
            cell.coll_cat_prod_list.tag = indexPath.row
            cell.coll_cat_prod_list.reloadData()
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            Servicefile.shared.sp_shop_dash_tbl_index = indexPath.row
            print("category index value",Servicefile.shared.sp_shop_dash_tbl_index)
        }else{
            print("dashboard banner",indexPath.row)
        }
        
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
                            Servicefile.shared.sp_dash_Today_Special.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
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
                                Servicefile.shared.sp_dash_productdetails.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
                            }
                            if Servicefile.shared.sp_dash_productdetails.count > 0 {
                                Servicefile.shared.sp_dash_Product_details.append(pet_sp_dash_productdetails.init(In_cartid: cat_id, In_cart_name: cat_name, In_product_details: Servicefile.shared.sp_dash_productdetails))
                            }
                        }
                        self.tbl_dash_list.reloadData()
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
    
    func alert(Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}