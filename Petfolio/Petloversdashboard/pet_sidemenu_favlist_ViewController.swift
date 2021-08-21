//
//  pet_sidemenu_favlist_ViewController.swift
//  Petfolio
//
//  Created by Admin on 14/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class pet_sidemenu_favlist_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var view_current: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_cancelled: UIView!
    @IBOutlet weak var label_current: UILabel!
    @IBOutlet weak var label_complete: UILabel!
    @IBOutlet weak var label_cancelled: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    @IBOutlet weak var view_footer: petowner_footerview!
    
    @IBOutlet weak var col_selected_list: UICollectionView!
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    var appointtype = "Doctor"
    var indextag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        let docnibName = UINib(nibName: "dash_doc_CollectionViewCell", bundle:nil)
        self.col_selected_list.register(docnibName, forCellWithReuseIdentifier: "cell1")
        self.intial_setup_action()
        self.label_nodata.text = "No favourites available"
        self.col_selected_list.delegate = self
        self.col_selected_list.dataSource = self
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Favorites"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.backaction), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: true, b2: false, b3: false, b4: true)
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: true, b2: false, b3: false, b4: false, b5: false)
    // footer action
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view_current.view_cornor()
        self.view_cancelled.view_cornor()
        self.view_completed.view_cornor()
        self.view_current.layer.borderWidth = 0.5
        self.view_cancelled.layer.borderWidth = 0.5
        self.view_completed.layer.borderWidth = 0.5
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_cancelled.layer.borderColor = appcolor.cgColor
        self.view_current.backgroundColor = appcolor
        self.label_current.textColor = UIColor.white
        self.view_completed.backgroundColor = UIColor.white
        self.view_cancelled.backgroundColor = UIColor.white
        self.label_complete.textColor = appcolor
        self.label_cancelled.textColor = appcolor
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_cancelled.layer.borderColor = appcolor.cgColor
        self.appointtype = "Doctor"
         self.calldoc()
    }
    
   
  
    
    @objc func backaction() {
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    
    
    @IBAction func action_cancelled(_ sender: Any) {
        let nibName = UINib(nibName: "pet_product_CollectionViewCell", bundle:nil)
        self.col_selected_list.register(nibName, forCellWithReuseIdentifier: "cell")
        self.label_nodata.text = "No favourites available"
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_cancelled.backgroundColor = appcolor
        self.label_cancelled.textColor = UIColor.white
        self.view_current.backgroundColor = UIColor.white
        self.label_current.textColor = appcolor
        self.label_complete.textColor = appcolor
        self.view_completed.backgroundColor = UIColor.white
        self.view_current.layer.borderColor = appcolor.cgColor
        self.view_current.backgroundColor = UIColor.white
        self.appointtype = "Shop"
        self.callproductdetails()
    }
    
    @IBAction func action_completeappoint(_ sender: Any) {
        let docnibName = UINib(nibName: "dash_doc_CollectionViewCell", bundle:nil)
        self.col_selected_list.register(docnibName, forCellWithReuseIdentifier: "cell")
        self.label_nodata.text = "No favourites available"
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.backgroundColor = appcolor
        self.label_complete.textColor = UIColor.white
        self.view_current.backgroundColor = UIColor.white
        self.view_cancelled.backgroundColor = UIColor.white
        self.label_current.textColor = appcolor
        self.label_cancelled.textColor = appcolor
        self.view_current.layer.borderColor = appcolor.cgColor
        self.view_cancelled.layer.borderColor = appcolor.cgColor
        self.appointtype = "Service"
        self.callservice()
        
    }
    
    @IBAction func action_currentappoint(_ sender: Any) {
        let docnibName = UINib(nibName: "dash_doc_CollectionViewCell", bundle:nil)
        self.col_selected_list.register(docnibName, forCellWithReuseIdentifier: "cell")
        self.label_nodata.text = "No favourites available"
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_current.backgroundColor = appcolor
        self.label_current.textColor = UIColor.white
        self.view_completed.backgroundColor = UIColor.white
        self.view_cancelled.backgroundColor = UIColor.white
        self.label_complete.textColor = appcolor
        self.label_cancelled.textColor = appcolor
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_cancelled.layer.borderColor = appcolor.cgColor
        self.appointtype = "Doctor"
        self.calldoc()
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.appointtype == "Doctor" {
            return Servicefile.shared.petdoc.count
        }else if self.appointtype == "Service" {
            return Servicefile.shared.pet_SP_service_details.count
        }else {
            return Servicefile.shared.petnewprod.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.appointtype == "Doctor" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! dash_doc_CollectionViewCell
            cell.image_vet.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_vet.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petdoc[indexPath.row].doctor_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_vet.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_vet.image = image
                }
            }
            if Servicefile.shared.petdoc[indexPath.row].fav {
                cell.image_fav.image = UIImage(named: imagelink.fav_true)
            }else {
                cell.image_fav.image = UIImage(named: imagelink.fav_false)
            }
//            let fav = Data["fav"] as? Bool ?? false
//            if fav {
//
//            cell.image_fav.image = Servicefile.shared.petdoc[indexPath.row].
            cell.view_main.dropShadow()
            cell.view_main.View_dropshadow(cornordarius: CGFloat(2.0), iscircle : true)
            cell.label_DR.text = Servicefile.shared.petdoc[indexPath.row].doctor_name
            cell.label_clinic.text = Servicefile.shared.petdoc[indexPath.row].clinic_name
            cell.view_rating.rating = Double(Servicefile.shared.petdoc[indexPath.row].star_count)
            cell.view_vets.view_cornor()
            cell.image_vet.view_cornor()
            cell.view_main.view_cornor()
            cell.view_bottom_curve.view_cornor()
            cell.view_main.layer.borderWidth = 0.3
            cell.view_rating.isUserInteractionEnabled = false
            cell.view_pet_paw.layer.cornerRadius = cell.view_pet_paw.frame.height / 2
            return cell
        }else if self.appointtype == "Service" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! dash_doc_CollectionViewCell
            cell.image_vet.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_vet.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_SP_service_details[indexPath.row].image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_vet.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_vet.image = image
                }
            }
            if true {
                cell.image_fav.image = UIImage(named: imagelink.fav_true)
            }else {
                cell.image_fav.image = UIImage(named: imagelink.fav_false)
            }
//            let fav = Data["fav"] as? Bool ?? false
//            if fav {
//
//            cell.image_fav.image = Servicefile.shared.petdoc[indexPath.row].
            cell.view_main.dropShadow()
            
            cell.view_main.View_dropshadow(cornordarius: CGFloat(2.0), iscircle : true)
            cell.view_main.layer.borderWidth = 0.3
            cell.label_DR.text = Servicefile.shared.pet_SP_service_details[indexPath.row].service_provider_name
            cell.label_clinic.text = Servicefile.shared.pet_SP_service_details[indexPath.row].service_place
            cell.view_rating.rating = Double(Servicefile.shared.pet_SP_service_details[indexPath.row].rating_count)
            cell.view_vets.view_cornor()
            cell.image_vet.view_cornor()
            cell.view_main.view_cornor()
            cell.view_bottom_curve.view_cornor()
            cell.view_rating.isUserInteractionEnabled = false
            cell.view_pet_paw.layer.cornerRadius = cell.view_pet_paw.frame.height / 2
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_product_CollectionViewCell
            cell.view_main.layer.borderWidth = 0.5
            let color = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.extralightgray)
            cell.view_main.layer.borderColor = color.cgColor
         cell.view_main.View_dropshadow(cornordarius: CGFloat(2.0), iscircle : true)
         cell.label_prod_title.text = Servicefile.shared.petnewprod[indexPath.row].product_title
            cell.label_price.text = "INR " + String(Servicefile.shared.petnewprod[indexPath.row].product_prices)
         
            if Servicefile.shared.petnewprod[indexPath.row].product_fav_status {
             cell.image_fav.image = UIImage(named: imagelink.favtrue)
         }else{
             cell.image_fav.image = UIImage(named: imagelink.favfalse)
         }
        cell.image_product.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.image_product.dropShadow()
            if Servicefile.shared.petnewprod[indexPath.row].product_fav_status {
             cell.image_fav.image = UIImage(named: imagelink.favtrue)
         }else{
             cell.image_fav.image = UIImage(named: imagelink.favfalse)
         }
         
            if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.petnewprod[indexPath.row].products_img) {
                cell.image_product.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petnewprod[indexPath.row].products_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_product.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_product.image = image
                }
            }
        }else{
            cell.image_product.image = UIImage(named: imagelink.sample)
        }
            cell.view_rating.rating = Double(Servicefile.shared.petnewprod[indexPath.row].product_rate)!
         cell.label_vendor.text = ""
            cell.view_main.view_cornor()
            cell.view_shopbag.layer.cornerRadius = cell.view_shopbag.frame.height / 2
            cell.contentView.layer.borderWidth = 0.3
            cell.contentView.view_cornor()
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.appointtype == "Doctor" {
            return CGSize(width: 160 , height:  250)
        }else if self.appointtype == "Service" {
            return CGSize(width: 160 , height:  250)
        }else {
            return CGSize(width: 160 , height:  280)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.appointtype == "Doctor" {
            Servicefile.shared.selectedindex = indexPath.row
            let vc = UIStoryboard.petlov_DocselectViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.appointtype == "Service" {
            Servicefile.shared.service_sp_id = Servicefile.shared.pet_SP_service_details[indexPath.row]._id
            let vc = UIStoryboard.pet_sp_service_details_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else {
            Servicefile.shared.product_id = Servicefile.shared.petnewprod[indexPath.row]._id
            let vc = UIStoryboard.productdetailsViewController()
            self.present(vc, animated: true, completion: nil)
        }
      
    }
    
    
    func calldoc(){
        Servicefile.shared.petdoc.removeAll()
        self.col_selected_list.reloadData()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_fav_doc, method: .post, parameters:
            ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.pet_applist_do_sp.removeAll()
                        let Doctor_details = res["Data"] as! NSArray
                        Servicefile.shared.petdoc.removeAll()
                        for item in 0..<Doctor_details.count {
                            let Bval = Doctor_details[item] as! NSDictionary
                            let id = Bval["_id"] as? String ?? ""
                            let imgpath = Bval["doctor_img"] as? String ?? Servicefile.sample_img
                            let title =  Bval["doctor_name"] as? String ?? ""
                            let review_count =  Bval["review_count"] as? Int ?? 0
                            let star_count =  Bval["star_count"] as? Int ?? 0
                            let distance = Bval["distance"] as? String ?? ""
                            let specialization = Bval["specialization"] as! NSArray
                            let Dicspec = specialization[specialization.count-1] as! NSDictionary
                            let spec = Dicspec["specialization"] as? String ?? ""
                            let clinic_name = Bval["clinic_name"] as? String ?? ""
                            let fav = Bval["fav"] as? Bool ?? false
                            let thumbnail_image = Bval["thumbnail_image"] as? String ?? ""
                            Servicefile.shared.petdoc.append(Petnewdashdoc.init(UID: id, doctor_img: imgpath, doctor_name: title, review_count: review_count, star_count: star_count, ispec: spec, idistance: distance, Iclinic_name: clinic_name, Ifav : fav, Ithumbnail_image: thumbnail_image))
                        }
                        if Servicefile.shared.petdoc.count > 0 {
                            self.label_nodata.isHidden = true
                        }else{
                            self.label_nodata.isHidden = false
                        }
                        self.col_selected_list.reloadData()
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
    
    func callproductdetails(){
        Servicefile.shared.petnewprod.removeAll()
        self.col_selected_list.reloadData()
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
                        Servicefile.shared.pet_applist_do_sp.removeAll()
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
                            let thumbnail_image = Bval["thumbnail_image"] as? String ?? ""
//                            Servicefile.shared.petprod.append(Petdashproduct.init(I_id: id, Idelete_status: delete_status, Ishow_status: show_status, Iimg_index: img_index, Iproduct_title: product_title, Iproducts_img: products_img))
                            Servicefile.shared.petnewprod.append(Petnewdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count, cat_name: cat_name, Ithumbnail_image: thumbnail_image))
                           
                        }
                        if Servicefile.shared.petnewprod.count > 0 {
                            self.label_nodata.isHidden = true
                        }else{
                            self.label_nodata.isHidden = false
                        }
                        self.col_selected_list.reloadData()
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
    
    func callservice(){
        Servicefile.shared.pet_SP_service_details.removeAll()
        self.col_selected_list.reloadData()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_fav_service, method: .post, parameters:
            ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                       
                        let Service_provider = res["Data"] as! NSArray
                        Servicefile.shared.pet_SP_service_details.removeAll()
                        for itm in 0..<Service_provider.count{
                            let itmval = Service_provider[itm] as! NSDictionary
                            let _id = itmval["_id"] as? String ?? ""
                            let comments_count = itmval["comments_count"] as? Int ?? 0
                            let distance = itmval["distance"] as? Double ?? 0.0
                            let image = itmval["image"] as? String ?? Servicefile.sample_img
                            let rating_count = itmval["rating_count"] as? Int ?? 0
                            let service_offer = itmval["service_offer"] as? Int ?? 0
                            let service_place = itmval["service_place"] as? String ?? ""
                            let city_name = itmval["city_name"] as? String ?? ""
                            let service_price = Int(truncating: itmval["service_price"] as? NSNumber ?? 0)
                            let service_provider_name = itmval["service_provider_name"] as? String ?? ""
                            let thumbnail_image = itmval["thumbnail_image"] as? String ?? ""
                            let bus_service_list = itmval["bus_service_list"] as? NSArray ?? [Any]() as NSArray
                            Servicefile.shared.pet_SP_service_details.append(SP_service_details.init(I_id: _id, Icomments_count: comments_count, Idistance: distance, Iimage: image, Irating_count: rating_count, Iservice_offer: service_offer, Iservice_place: service_place, Iservice_price: service_price, Iservice_provider_name: service_provider_name, in_thumbnail_image: thumbnail_image, Icity_name: city_name, Iservicelist: bus_service_list as! [Any]))
                        }
                        if Servicefile.shared.pet_SP_service_details.count > 0 {
                            self.label_nodata.isHidden = true
                        }else{
                            self.label_nodata.isHidden = false
                        }
                        self.col_selected_list.reloadData()
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
