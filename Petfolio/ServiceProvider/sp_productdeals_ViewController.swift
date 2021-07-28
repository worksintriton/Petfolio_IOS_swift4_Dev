//
//  sp_productdeals_ViewController.swift
//  Petfolio
//
//  Created by Admin on 17/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class sp_productdeals_ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
        
        @IBOutlet weak var coll_prodlist: UICollectionView!
        var loadcount = 0
        var isPageRefreshing  = false
        @IBOutlet weak var view_search: UIView!
        @IBOutlet weak var view_sortby: UIView!
        @IBOutlet weak var view_filter: UIView!
        
        
        @IBOutlet weak var view_footer: doc_footer!
        @IBOutlet weak var label_noproduct: UILabel!
        @IBOutlet weak var textfield_search: UITextField!
        @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let nibName = UINib(nibName: "product_fav_cell_CollectionViewCell", bundle:nil)
                    self.coll_prodlist.register(nibName, forCellWithReuseIdentifier: "cell")
            self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.intial_setup_action()
            self.label_noproduct.text = "No products available"
            self.label_noproduct.isHidden = true
            self.textfield_search.text = ""
            self.textfield_search.autocapitalizationType = .sentences
            self.textfield_search.delegate = self
            self.view_search.view_cornor()
            self.view_sortby.view_cornor()
            self.view_filter.view_cornor()
             Servicefile.shared.sp_dash_productdetails.removeAll()
            self.coll_prodlist.delegate = self
            self.coll_prodlist.dataSource = self
            Servicefile.shared.productsearchpage = "Productdeal"
            self.callproddeal()
        }
        
        func intial_setup_action(){
        // header action
            self.view_subpage_header.label_header_title.text = "Shop"
            self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
            self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
            self.view_subpage_header.view_profile.isHidden = true
            self.view_subpage_header.view_sos.isHidden = true
            self.view_subpage_header.view_bel.isHidden = true
            self.view_subpage_header.view_bag.isHidden = true
        // header action
        // footer action
            self.view_footer.setup(b1: false, b2: true, b3: false)
            self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.spshop), for: .touchUpInside)
            self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.spDashboard), for: .touchUpInside)
            self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        // footer action
        }
        
        override func viewWillAppear(_ animated: Bool) {
            self.coll_prodlist.reloadData()
        }
        
        @IBAction func action_sortby(_ sender: Any) {
            self.textfield_search.text = ""
            let vc = UIStoryboard.pet_vendor_total_sortbyViewController()
            self.present(vc, animated: true, completion: nil)
            
        }
        
        @IBAction func action_filer(_ sender: Any) {
            self.textfield_search.text = ""
            let vc = UIStoryboard.vendorfilterViewController()
            self.present(vc, animated: true, completion: nil)
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
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if(self.coll_prodlist.contentOffset.y >= (self.coll_prodlist.contentSize.height - self.coll_prodlist.bounds.size.height)) {
                if !isPageRefreshing {
                    isPageRefreshing = true
                    if self.loadcount != Servicefile.shared.sp_dash_productdetails.count {
                        self.callproddeal()
                    }
                    
                }
            }
        }
        
        
        @IBAction func action_back(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if Servicefile.shared.loadingcount != 0 {
                return 10
            }else{
                return Servicefile.shared.sp_dash_productdetails.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if Servicefile.shared.loadingcount != 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prodload", for: indexPath) as! ProductshimmerCollectionViewCell
                cell.view_img.startAnimatings()
                cell.view_wish.startAnimatings()
                cell.view_title.startAnimatings()
                cell.view_cot.startAnimatings()
                cell.view_rate.startAnimatings()
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! product_fav_cell_CollectionViewCell
                cell.label_prod_title.text = Servicefile.shared.sp_dash_productdetails[indexPath.row].product_title
                cell.label_price.text = "₹ " + String(Servicefile.shared.sp_dash_productdetails[indexPath.row].product_price)
                cell.image_product.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
                cell.image_product.dropShadow()
                cell.label_offer.isHidden = true
                if Servicefile.shared.sp_dash_productdetails[indexPath.row].product_discount > 0 {
                    cell.label_offer.isHidden = false
                    cell.label_offer.text = String(Servicefile.shared.sp_dash_productdetails[indexPath.row].product_discount) + " % off"
                }
                //cell.image_product.image = UIImage(named: imagelink.sample)
                if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.sp_dash_productdetails[indexPath.row].product_img) {
                    cell.image_product.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                    cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.sp_dash_productdetails[indexPath.row].product_img)) { (image, error, cache, urls) in
                        if (error != nil) {
                            cell.image_product.image = UIImage(named: imagelink.sample)
                        } else {
                            cell.image_product.image = image
                        }
                    }
                }else{
                    cell.image_product.image = UIImage(named: imagelink.sample)
                }
                cell.label_ratting.text = Servicefile.shared.sp_dash_productdetails[indexPath.row].product_rating
                cell.label_likes.text = Servicefile.shared.sp_dash_productdetails[indexPath.row].product_review
                cell.view_remove.isHidden = true
                cell.view_menu.isHidden = true
                cell.view_main.view_cornor()
                cell.view_main.dropShadow()
                return cell
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.coll_prodlist.frame.size.width/2.1, height: 200)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            Servicefile.shared.product_id = Servicefile.shared.sp_dash_productdetails[indexPath.row]._id
            let vc = UIStoryboard.sp_productdetailspage_ViewController()
             self.present(vc, animated: true, completion: nil)
        }
    }


    extension sp_productdeals_ViewController {
        
        func callproddeal(){
            Servicefile.shared.loadingcount = 1
            self.loadcount = self.loadcount + 1
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.productdeal, method: .post, parameters:
                [ "skip_count": self.loadcount ,
                   "cat_id" : Servicefile.shared.vendor_catid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                    switch (response.result) {
                    case .success:
                        let res = response.value as! NSDictionary
                        print("success data",res)
                        let Code  = res["Code"] as! Int
                        if Code == 200 {
                            let product_list = res["Data"] as! NSArray
                            
                            //let product_list = catval["product_list"] as! NSArray
                           
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
                                self.label_noproduct.isHidden = true
                            }else{
                                self.label_noproduct.isHidden = false
                            }
                               
                            Servicefile.shared.loadingcount = 0
                            self.coll_prodlist.reloadData()
                        }else{
                            Servicefile.shared.loadingcount = 0
                        }
                        break
                    case .failure(let Error):
                        Servicefile.shared.loadingcount = 0
                        self.stopAnimatingActivityIndicator()
                        
                        break
                    }
                }
            }else{
                self.stopAnimatingActivityIndicator()
                self.alert(Message: "No Intenet Please check and try again ")
            }
        }
        
        func callsearch(){
    //        Servicefile.shared.loadingcount = 1
    //        self.loadcount = self.loadcount + 1
            self.startAnimatingActivityIndicator()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_cat_search, method: .post, parameters:
                                                                        ["search_string": Servicefile.shared.pet_shop_search,
                                                                           "cat_id" : Servicefile.shared.vendor_catid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                    switch (response.result) {
                    case .success:
                        let res = response.value as! NSDictionary
                        print("success data",res)
                        let Code  = res["Code"] as! Int
                        self.label_noproduct.isHidden = true
                        if Code == 200 {
                            let search_val = res["Data"] as! NSArray
                            Servicefile.shared.sp_dash_productdetails.removeAll()
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
                                let thumbnail_image = itmdata["thumbnail_image"] as? String ?? ""
                                let product_discount_price = itmdata["product_discount_price"] as? Int ?? 0
                                Servicefile.shared.sp_dash_productdetails.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title, In_thumbnail_image: thumbnail_image, Iproduct_discount_price: product_discount_price))
                            }
                            if Servicefile.shared.sp_dash_productdetails.count > 0{
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
