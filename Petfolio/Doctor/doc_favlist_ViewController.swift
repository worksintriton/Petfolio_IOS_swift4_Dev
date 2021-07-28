//
//  doc_favlist_ViewController.swift
//  Petfolio
//
//  Created by Admin on 15/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class doc_favlist_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var view_footer: doc_footer!
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    
    @IBOutlet weak var col_doc_fav: UICollectionView!
    @IBOutlet weak var label_nodatafound: UILabel!
    var isselect = [""]
    var isorgiselect = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.isselect.removeAll()
        self.isorgiselect.removeAll()
        let docnibName = UINib(nibName: "product_fav_cell_CollectionViewCell", bundle:nil)
        self.col_doc_fav.register(docnibName, forCellWithReuseIdentifier: "cell")
        self.intial_setup_action()
        self.col_doc_fav.delegate = self
        self.col_doc_fav.dataSource = self
        self.callproductdetails()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Servicefile.shared.petnewprod.removeAll()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.petnewprod.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : product_fav_cell_CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! product_fav_cell_CollectionViewCell
        cell.view_main.dropShadow()
        cell.view_main.view_cornor()
        cell.view_main.layer.borderWidth = 0.2
        cell.btn_menu.tag = indexPath.row
        cell.btn_remove.tag = indexPath.row
        cell.btn_menu.addTarget(self, action: #selector(menu), for: .touchUpInside)
        cell.btn_remove.addTarget(self, action: #selector(remove), for: .touchUpInside)
        cell.view_remove.isHidden = true
        if self.isselect[indexPath.row] == "1"{
            cell.view_remove.isHidden = false
        }else{
            cell.view_remove.isHidden = true
        }
        
        cell.label_prod_title.text = Servicefile.shared.petnewprod[indexPath.row].product_title
        cell.label_price.text = "INR " + String(Servicefile.shared.petnewprod[indexPath.row].product_prices)
        cell.label_ratting.text = Servicefile.shared.petnewprod[indexPath.row].product_rate
        cell.image_product.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petnewprod[indexPath.row].products_img)) { (image, error, cache, urls) in
        if (error != nil) {
            cell.image_product.image = UIImage(named: imagelink.sample)
        } else {
            cell.image_product.image = image
        }
        }
        cell.image_product.contentMode = .scaleAspectFill
        if Servicefile.shared.petnewprod[indexPath.row].product_fav_status {
         cell.image_fav.image = UIImage(named: imagelink.favtrue)
     }else{
         cell.image_fav.image = UIImage(named: imagelink.favfalse)
     }
        return  cell
        
    }
    
    @objc func menu(sender : UIButton){
        let tag = sender.tag
        self.isselect = self.isorgiselect
        self.isselect.remove(at: tag)
        self.isselect.insert("1", at: tag)
        self.col_doc_fav.reloadData()
    }
    
    @objc func remove(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.product_id = Servicefile.shared.petnewprod[tag]._id
        self.callfav()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: 140 , height:  280)
      
    }
    
    
     func intial_setup_action(){
     // header action
         self.view_subpage_header.label_header_title.text = "Favorites"
         self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
         self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
         self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.docprofile), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.view_sos.isHidden = true
        self.view_subpage_header.view_profile.isHidden = true
        self.view_subpage_header.view_bag.isHidden = false
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(doccartpage), for: .touchUpInside)
        self.view_subpage_header.image_bag.image = UIImage(named: imagelink.image_bag)
        self.view_subpage_header.image_profile.image = UIImage(named: imagelink.image_bel)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
     // header action
     // footer action
         self.view_footer.setup(b1: false, b2: true, b3: false)
         self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.docshop), for: .touchUpInside)
         self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
     // footer action
     }
    
    func callproductdetails(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_fav_product, method: .post, parameters:
            ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        
                        let Products_details = res["Data"] as! NSArray
                        Servicefile.shared.petnewprod.removeAll()
                        for item in 0..<Products_details.count {
                            let Bval = Products_details[item] as! NSDictionary
//                            let id = Bval["_id"] as? String ?? ""
//                            let delete_status = Bval["delete_status"] as? Bool ?? false
//                            let show_status =  Bval["show_status"] as? Bool ?? false
//                            let img_index =  Bval["img_index"] as? Int ?? 0
//                            let product_title =  Bval["product_cate"] as? String ?? ""
//                            let products_img =  Bval["product_img"] as? String ?? Servicefile.sample_img
                            let id = Bval["_id"] as? String ?? ""
                            let cat_name = Bval["cat_name"] as? String ?? ""
                            let product_offer_value = Bval["product_discount"] as? Int ?? 0
                            let product_offer_status = false
                            let product_fav_status = Bval["product_fav"] as? Bool ?? false
                            let products_img = Bval["product_img"] as? String ?? ""
                            let product_prices = Bval["product_price"] as? Int ?? 0
                            let product_rate = String(Bval["product_rating"] as? Float ?? 0.0) //?? ""
                            let review_count = Bval["product_review"] as? Int ?? 0
                            let product_title = Bval["product_title"] as? String ?? ""
//                            Servicefile.shared.petprod.append(Petdashproduct.init(I_id: id, Idelete_status: delete_status, Ishow_status: show_status, Iimg_index: img_index, Iproduct_title: product_title, Iproducts_img: products_img))
                            self.isselect.append("0")
                            let thumbnail_image = Bval["thumbnail_image"] as? String ?? ""
                            Servicefile.shared.petnewprod.append(Petnewdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count, cat_name: cat_name, Ithumbnail_image: thumbnail_image))
                           
                        }
                        self.isorgiselect = self.isselect
                        if Servicefile.shared.petnewprod.count > 0 {
                            self.label_nodatafound.isHidden = true
                        }else{
                            self.label_nodatafound.isHidden = false
                        }
                        self.col_doc_fav.reloadData()
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
                        self.callproductdetails()
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
