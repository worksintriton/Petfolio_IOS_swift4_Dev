//
//  ProductdealsViewController.swift
//  Petfolio
//
//  Created by Admin on 09/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class ProductdealsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var coll_prodlist: UICollectionView!
    var loadcount = 0
    var isPageRefreshing  = false
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var view_sortby: UIView!
    @IBOutlet weak var view_filter: UIView!
    @IBOutlet weak var view_footer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_search.view_cornor()
        self.view_sortby.view_cornor()
        self.view_filter.view_cornor()
        self.view_footer.view_cornor()
         Servicefile.shared.sp_dash_productdetails.removeAll()
        self.coll_prodlist.delegate = self
        self.coll_prodlist.dataSource = self
        self.callproddeal()
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
            cell.view_img.startAnimating()
            cell.view_wish.startAnimating()
            cell.view_title.startAnimating()
            cell.view_cot.startAnimating()
            cell.view_rate.startAnimating()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prod", for: indexPath) as! pet_shop_product_CollectionViewCell
            cell.label_prod_title.text = Servicefile.shared.sp_dash_productdetails[indexPath.row].product_title
            cell.label_price.text = "₹ " + String(Servicefile.shared.sp_dash_productdetails[indexPath.row].product_price)
            cell.image_product.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.image_product.dropShadow()
            //cell.image_product.image = UIImage(named: "sample")
            
            if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.sp_dash_productdetails[indexPath.row].product_img) {
                
                cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.sp_dash_productdetails[indexPath.row].product_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_product.image = UIImage(named: "sample")
                    } else {
                        cell.image_product.image = image
                    }
                }
            }else{
                cell.image_product.image = UIImage(named: "sample")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.coll_prodlist.frame.size.width/2.1, height: self.coll_prodlist.frame.size.width/2.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.product_id = Servicefile.shared.sp_dash_productdetails[indexPath.row]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "productdetailsViewController") as!  productdetailsViewController
        self.present(vc, animated: true, completion: nil)
    }
}


extension ProductdealsViewController {
    
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
                            Servicefile.shared.sp_dash_productdetails.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
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
    
   
}
