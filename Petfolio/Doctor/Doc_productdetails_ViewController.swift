//
//  Doc_productdetails_ViewController.swift
//  Petfolio
//
//  Created by Admin on 11/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Cosmos


class Doc_productdetails_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var label_product_count: UILabel!
    @IBOutlet weak var view_dec: UIView!
    @IBOutlet weak var view_inc: UIView!
    @IBOutlet weak var view_addtocart: UIView!
   
   
    @IBOutlet weak var view_cart_main: UIView!
    @IBOutlet weak var view_select_count: UIView!
    @IBOutlet weak var coll_product_img: UICollectionView!
    @IBOutlet weak var coll_productlist: UICollectionView!
    
    @IBOutlet weak var view_rate: CosmosView!
    @IBOutlet weak var image_like: UIImageView!
    @IBOutlet weak var label_product_title: UILabel!
    
    @IBOutlet weak var label_product_cost: UILabel!
    @IBOutlet weak var label_discount: UILabel!
    @IBOutlet weak var label_quantity: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var label_cartcount: UILabel!
    @IBOutlet weak var label_addtocart: UILabel!
    
    @IBOutlet weak var label_categ: UILabel!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var View_outofstock: UIView!
    @IBOutlet weak var view_isqualityprod: UIView!
    @IBOutlet weak var pagecontroller: UIPageControl!
    
    @IBOutlet weak var view_off: UIView!
    var _id = ""
    var ca_id = ""
    var cat_img_path = ""
    var product_cate = ""
    var product_cart_count = 1
    var product_discount = 0
    var product_discription = ""
    var product_fav = false
    var product_img = [""]
    var product_vendor_list = [""]
    var product_price = 0
    var product_rating = 0.0
    var product_review = ""
    var product_title = ""
    var threshould = ""
    var timer = Timer()
    var pagcount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_back.layer.cornerRadius = self.view_back.frame.height / 2
        
        self.label_cartcount.layer.cornerRadius = 10.0
        let nibName = UINib(nibName: "pet_product_CollectionViewCell", bundle:nil)
        self.coll_productlist.register(nibName, forCellWithReuseIdentifier: "cell")
        self.image_like.isHidden = true
        self.View_outofstock.isHidden = true
        self.view_isqualityprod.isHidden = true
        self.view_addtocart.isHidden = true
        self.view_select_count.isHidden = true
        self.view_cart_main.isHidden = true
        self.view_dec.layer.cornerRadius =  self.view_dec.frame.height / 2
        self.view_inc.layer.cornerRadius =  self.view_inc.frame.height / 2
        self.view_addtocart.view_cornor()
        self.view_off.view_cornor()
        self.view_addtocart.view_cornor()
        self.view_select_count.view_cornor()
        self.coll_product_img.delegate = self
        self.coll_product_img.dataSource = self
        self.coll_productlist.delegate = self
        self.coll_productlist.dataSource = self
        self.startTimer()
    }
    
  
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    func startTimer() {
        self.timer.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
           if self.product_img.count > 0 {
               self.pagcount += 1
               if self.pagcount == self.product_img.count {
                   self.pagcount = 0
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.coll_product_img.scrollToItem(at: indexPath, at: .left, animated: true)
               }else{
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.coll_product_img.scrollToItem(at: indexPath, at: .left, animated: true)
               }
           self.pagecontroller.currentPage = self.pagcount
              
           }
       }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callproddeal()
        self.product_vendor_list.removeAll()
        Servicefile.shared.vendor_product_id_details.removeAll()
    }
    
   

    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    @IBAction func action_dec(_ sender: Any) {
        if self.product_cart_count > 1  {
            self.label_addtocart.text = "Go to cart"
            if  self.product_cart_count <= Int(self.threshould)! {
                self.product_cart_count -= 1
                self.label_cartcount.text = String(self.product_cart_count)
            }
        }else{
            self.label_addtocart.text = "Add to cart"
        }
    }
    
    @IBAction func action_inc(_ sender: Any) {
        if  self.product_cart_count < Int(self.threshould)! {
        //self.callinctheproductcount()
        self.product_cart_count += 1
            self.label_addtocart.text = "Add to cart"
        self.label_cartcount.text = String(self.product_cart_count)
        }else{
            self.alert(Message: "You can buy only up to "+self.threshould+" quantity of this "+self.product_title)
        }
    }
    
    
    @IBAction func action_addtocart(_ sender: Any) {
        self.callgotocart()
    }
    
    
    @IBAction func action_fav_unfav(_ sender: Any) {
        self.callfav()
    }
    
    
    func callfav(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_shop_fav, method: .post, parameters:
            ["product_id": Servicefile.shared.product_id,"user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.callproddeal()
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
    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == coll_product_img {
                return self.product_img.count
            }else{
                return Servicefile.shared.vendor_product_id_details.count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == coll_product_img {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
                cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: self.product_img[indexPath.row])) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.img_banner.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.img_banner.image = image
                    }
                }
                cell.img_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
                return cell
            }else{
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_product_CollectionViewCell
                cell.view_main.view_cornor()
                cell.label_prod_title.text = Servicefile.shared.vendor_product_id_details[indexPath.row].product_title
               cell.label_price.text = "₹ " + String(Servicefile.shared.vendor_product_id_details[indexPath.row].product_price)
                
                if Servicefile.shared.vendor_product_id_details[indexPath.row].product_fav {
                    cell.image_fav.image = UIImage(named: imagelink.favtrue)
                }else{
                    cell.image_fav.image = UIImage(named: imagelink.favfalse)
                }
               cell.image_product.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
               cell.image_product.dropShadow()
                if Servicefile.shared.vendor_product_id_details[indexPath.row].product_fav {
                    cell.image_fav.image = UIImage(named: imagelink.favtrue)
                }else{
                    cell.image_fav.image = UIImage(named: imagelink.favfalse)
                }
                
               if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.vendor_product_id_details[indexPath.row].product_img) {
                   
                cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.vendor_product_id_details[indexPath.row].product_img)) { (image, error, cache, urls) in
                       if (error != nil) {
                           cell.image_product.image = UIImage(named: imagelink.sample)
                       } else {
                           cell.image_product.image = image
                       }
                   }
               }else{
                   cell.image_product.image = UIImage(named: imagelink.sample)
               }
                cell.view_rating.rating = Double(Servicefile.shared.vendor_product_id_details[indexPath.row].product_rating)!
                cell.label_vendor.text = self.product_cate
               return cell
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if coll_product_img == collectionView {
                return CGSize(width: self.coll_product_img.frame.size.width, height: self.coll_product_img.frame.size.height)
            }else{
                return CGSize(width: 160, height: 260)
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             if coll_product_img != collectionView {
                Servicefile.shared.product_id = Servicefile.shared.vendor_product_id_details[indexPath.row]._id
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_productdetails_ViewController") as!  Doc_productdetails_ViewController
            self.present(vc, animated: true, completion: nil)
            }
        }
}

extension Doc_productdetails_ViewController {
    
    func callproddeal(){
        print("product_id", Servicefile.shared.product_id,"user_id",Servicefile.shared.userid)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.product_by_id, method: .post, parameters:
            ["product_id": Servicefile.shared.product_id,"user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data = res["Product_details"] as! NSDictionary
                        self._id = data["_id"] as! String
                        let cat_details = data["cat_id"] as! NSDictionary
                        self.ca_id = cat_details["_id"] as! String
                        self.cat_img_path = cat_details["img_path"] as? String ?? Servicefile.sample_img
                        self.product_cate = cat_details["product_cate"] as! String
                        self.label_categ.text =   self.product_cate
                        //self.product_cart_count = data["product_cart_count"] as! Int
                        self.product_discount = data["product_discount"] as? Int ?? 0
                        if self.product_discount != 0 {
                            self.label_discount.text =  String(self.product_discount) + "% off"
                        }else{
                            self.view_off.isHidden = true
                        }
                        self.product_discription = data["product_discription"] as! String
                        self.product_fav = data["product_fav"] as? Bool ?? false
                        self.image_like.isHidden = false
                        if self.product_fav {
                            self.image_like.image = UIImage(named: imagelink.fav_true)
                        }else{
                            self.image_like.image = UIImage(named: imagelink.fav_false)
                        }
                        self.product_img = data["product_img"] as! [String]
                        self.pagecontroller.numberOfPages = self.product_img.count
                        self.product_price = data["product_price"] as? Int ?? 0
                        self.product_rating = data["product_rating"] as? Double ?? 0.0
                        let product_related = data["product_related"] as! NSArray
                        self.product_review = String(data["product_review"] as? Int ?? 0)
                        self.product_title = data["product_title"] as! String
                        self.threshould = data["threshould"] as! String
                        //self.label_likes.text = self.product_review
                       
                        self.view_rate.rating = self.product_rating
                        self.label_product_cost.text = "₹ " + String(self.product_price)
                        self.label_discount.text = String(self.product_discount) + "% off"
                        self.label_quantity.text = String(self.threshould)
                        self.label_description.text = self.product_discription
                        self.label_description.sizeToFit()
                        self.label_cartcount.text = String(self.product_cart_count)
                        let quantity = Int(self.threshould) ?? 0
                        if quantity > 0 {
                            self.View_outofstock.isHidden = true
                            self.view_isqualityprod.isHidden = false
                            self.view_addtocart.isHidden = false
                            self.view_select_count.isHidden = false
                            self.view_cart_main.isHidden = false
                        }else{
                            self.View_outofstock.isHidden = false
                            self.view_isqualityprod.isHidden = true
                            self.view_addtocart.isHidden = true
                            self.view_select_count.isHidden = true
                            self.view_cart_main.isHidden = true
                        }
                        
                        
                        
                        Servicefile.shared.vendor_product_id_details.removeAll()
                        for prodi in 0..<product_related.count{
                            let prodval = product_related[prodi] as! NSDictionary
                            let id  = prodval["_id"] as? String ?? ""
                            let product_discount = prodval["product_discount"] as? Int ?? 0
                            let product_fav = prodval["product_fav"] as? Bool ?? false
                            let product_img = prodval["product_img"] as? String ?? Servicefile.sample_img
                            let product_price = prodval["product_price"] as? Int ?? 0
                            let product_rating = String(prodval["product_rating"] as? Double ?? 0.0)
                            let product_review = String(prodval["product_review"] as? Int ?? 0)
                            let product_title = prodval["product_title"] as? String ?? ""
                            self.label_product_title.text =  product_title
                            Servicefile.shared.vendor_product_id_details.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
                        }
                        
                       
                        
                        self.coll_productlist.reloadData()
                        self.coll_product_img.reloadData()
                        self.stopAnimatingActivityIndicator()
                    }else{
                        
                        self.stopAnimatingActivityIndicator()
                    }
                    break
                case .failure(let Error):
                    
                    self.stopAnimatingActivityIndicator()
                    
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    
    
    
    func callinctheproductcount(){
           print("product_id", Servicefile.shared.product_id,"user_id",Servicefile.shared.userid)
           self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.inc_prod_count, method: .post, parameters:
               ["product_id": Servicefile.shared.product_id,"user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                   switch (response.result) {
                   case .success:
                       let res = response.value as! NSDictionary
                       print("success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                            self.callproddeal()
                           self.stopAnimatingActivityIndicator()
                       }else{
                           
                           self.stopAnimatingActivityIndicator()
                       }
                       break
                   case .failure(let Error):
                       print(Error)
                       self.stopAnimatingActivityIndicator()
                       break
                   }
               }
           }else{
               self.stopAnimatingActivityIndicator()
               self.alert(Message: "No Intenet Please check and try again ")
           }
       }
    
    
   
    func callgotocart(){
           self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_productdetauils_gotocart, method: .post, parameters:
                                                                        ["product_id": Servicefile.shared.product_id,"user_id":Servicefile.shared.userid,"count" : self.product_cart_count], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                   switch (response.result) {
                   case .success:
                       let res = response.value as! NSDictionary
                       print("success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "doc_vendorcartpageViewController") as!  doc_vendorcartpageViewController
                               self.present(vc, animated: true, completion: nil)
                           self.stopAnimatingActivityIndicator()
                       }else{
                           
                           self.stopAnimatingActivityIndicator()
                       }
                       break
                   case .failure(let Error):
                       print(Error)
                       self.stopAnimatingActivityIndicator()
                       break
                   }
               }
           }else{
               self.stopAnimatingActivityIndicator()
               self.alert(Message: "No Intenet Please check and try again ")
           }
       }
    
    func calldectheproductcount(){
             print("product_id", Servicefile.shared.product_id,"user_id",Servicefile.shared.userid)
             self.startAnimatingActivityIndicator()
             if Servicefile.shared.updateUserInterface() {
                AF.request(Servicefile.dec_prod_count, method: .post, parameters:
                 ["product_id": Servicefile.shared.product_id,"user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                     switch (response.result) {
                     case .success:
                         let res = response.value as! NSDictionary
                         print("success data",res)
                         let Code  = res["Code"] as! Int
                         if Code == 200 {
                              self.callproddeal()
                             self.stopAnimatingActivityIndicator()
                         }else{
                             
                             self.stopAnimatingActivityIndicator()
                         }
                         break
                     case .failure(let Error):
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
