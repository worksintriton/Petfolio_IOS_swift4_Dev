//
//  pet_vendor_shop_search_ViewController.swift
//  Petfolio
//
//  Created by Admin on 25/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_vendor_shop_search_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    @IBOutlet weak var coll_prodlist: UICollectionView!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var textfield_search: UITextField!
    
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var label_noproduct: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intial_setup_action()
        self.label_noproduct.isHidden = true
        self.textfield_search.delegate = self
        self.view_search.view_cornor()
        Servicefile.shared.sp_dash_Today_Special.removeAll()
        self.coll_prodlist.delegate = self
        self.coll_prodlist.dataSource = self
        self.callsearch()
    }
    
    func intial_setup_action(){
    
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: false, b2: false, b3: false, b4: true, b5: false)
    // footer action
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Servicefile.shared.pet_shop_search = self.textfield_search.text!
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func action_search(_ sender: Any) {
        Servicefile.shared.pet_shop_search = self.textfield_search.text!
        self.view.endEditing(true)
        self.callsearch()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Servicefile.shared.pet_shop_search = self.textfield_search.text!
        self.callsearch()
        return true
    }
    
    @IBAction func action_home(_ sender: Any) {
        Servicefile.shared.tabbar_selectedindex = 2
        let tapbar = self.storyboard?.instantiateViewController(withIdentifier: "pettabbarViewController") as! SHCircleBarControll
        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_petcare(_ sender: Any) {
        Servicefile.shared.tabbar_selectedindex = 0
        let tapbar = self.storyboard?.instantiateViewController(withIdentifier: "pettabbarViewController") as! SHCircleBarControll
        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_petservice(_ sender: Any) {
        Servicefile.shared.tabbar_selectedindex = 1
               let tapbar = self.storyboard?.instantiateViewController(withIdentifier: "pettabbarViewController") as! SHCircleBarControll
               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
               self.present(tapbar, animated: true, completion: nil)

    }
    
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? pet_sp_shop_dashboard_ViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
       }
    
    @IBAction func action_back(_ sender: Any) {
        Servicefile.shared.tabbar_selectedindex = 3
               let tapbar = self.storyboard?.instantiateViewController(withIdentifier: "pettabbarViewController") as! SHCircleBarControll
               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
               self.present(tapbar, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if Servicefile.shared.loadingcount != 0 {
//            return 10
//        }else{
            return Servicefile.shared.sp_dash_search.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if Servicefile.shared.loadingcount != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prodload", for: indexPath) as! ProductshimmerCollectionViewCell
            cell.view_img.startAnimating()
            cell.view_wish.startAnimating()
            cell.view_title.startAnimating()
            cell.view_cot.startAnimating()
            cell.view_rate.startAnimating()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prod", for: indexPath) as! pet_shop_product_CollectionViewCell
            cell.label_prod_title.text = Servicefile.shared.sp_dash_search[indexPath.row].product_title
            cell.label_price.text = "₹ " + String(Servicefile.shared.sp_dash_search[indexPath.row].product_price)
            cell.image_product.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.image_product.dropShadow()
            if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.sp_dash_search[indexPath.row].product_img) {
                cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.sp_dash_search[indexPath.row].product_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_product.image = UIImage(named: "sample")
                    } else {
                        cell.image_product.image = image
                    }
                }
            } else {
                cell.image_product.image = UIImage(named: "sample")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.coll_prodlist.frame.size.width/2.1, height: self.coll_prodlist.frame.size.width/2.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.product_id = Servicefile.shared.sp_dash_search[indexPath.row]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "productdetailsViewController") as!  productdetailsViewController
        self.present(vc, animated: true, completion: nil)
    }
}


extension pet_vendor_shop_search_ViewController {
    
    func callsearch(){
//        Servicefile.shared.loadingcount = 1
//        self.loadcount = self.loadcount + 1
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_manage_search, method: .post, parameters:
                                                                    ["search_string": Servicefile.shared.pet_shop_search], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    self.label_noproduct.isHidden = true
                    if Code == 200 {
                        let search_val = res["Data"] as! NSArray
                        Servicefile.shared.sp_dash_search.removeAll()
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
                            Servicefile.shared.sp_dash_search.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
                        }
                        if Servicefile.shared.sp_dash_search.count > 0{
                            self.label_noproduct.isHidden = true
                        }else{
                            self.label_noproduct.isHidden = false
                        }
                        //Servicefile.shared.loadingcount = 0
                        self.stopAnimatingActivityIndicator()
                        self.coll_prodlist.reloadData()
                    }else{
                        self.stopAnimatingActivityIndicator()
                        //Servicefile.shared.loadingcount = 0
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
    
  
}

