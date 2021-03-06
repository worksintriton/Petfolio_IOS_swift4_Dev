//
//  petloverDashboardViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 17/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import SDWebImage
import CoreLocation

class petloverDashboardViewController1: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var colleView_banner: UICollectionView!
    @IBOutlet weak var colleView_Doctor: UICollectionView!
    @IBOutlet weak var colleView_Service: UICollectionView!
    @IBOutlet weak var colleView_product: UICollectionView!
    @IBOutlet weak var colleView_puppylove: UICollectionView!
    
    @IBOutlet weak var view_footer: UIView!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_denypop: UIView!
    @IBOutlet weak var view_allowpop: UIView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    @IBOutlet weak var view_banner: UIView!
    @IBOutlet weak var view_service: UIView!
    @IBOutlet weak var view_doctor: UIView!
    @IBOutlet weak var view_products: UIView!
    @IBOutlet weak var view_puppy_love: UIView!
    @IBOutlet weak var view_home: UIView!
    
    
    var doc = 0
    var pro = 0
    var ser = 0
    var pagcount = 0
    var timer = Timer()
    var refreshControl = UIRefreshControl()
    var locationaddress = ""
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        //self.view_home.view_cornor()
        self.view_footer.view_cornor()
        self.view_footer.dropShadow()
        self.view_popup.view_cornor()
        self.view_denypop.view_cornor()
        self.view_allowpop.view_cornor()
        self.view_denypop.dropShadow()
        self.view_allowpop.dropShadow()
        
        self.colleView_banner.delegate = self
        self.colleView_banner.dataSource = self
        self.colleView_Doctor.delegate = self
        self.colleView_Doctor.dataSource = self
        self.colleView_product.delegate = self
        self.colleView_product.dataSource = self
        self.colleView_Service.delegate = self
        self.colleView_Service.dataSource = self
        self.colleView_puppylove.delegate = self
        self.colleView_puppylove.dataSource = self
        self.colleView_banner.isPagingEnabled = true
        self.callpetdash()
        
        
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollview.addSubview(refreshControl) // not required when using UITableViewController
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //    func checklatlong(){
    //        let lat  = String(self.latitude)
    //        let long = String(self.longitude)
    //        if lat == "0.0" & long == "0.0" {
    //            self.callpetdash()
    //        }
    //    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.callpetdash()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        self.latLong(lat: self.latitude,long: self.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func latLong(lat: Double,long: Double)  {
        if Servicefile.shared.updateUserInterface(){
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lat , longitude: long)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                var pm: CLPlacemark!
                pm = placemarks?[0]
                
                var addressString : String = ""
                if placemarks?[0] != nil {
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    self.locationaddress = addressString
                    self.callpetdash()
                }
                print(addressString)
            })
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    func startTimer() {
        self.timer.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
           if Servicefile.shared.petbanner.count > 0 {
               self.pagcount += 1
               if self.pagcount == Servicefile.shared.petbanner.count {
                   self.pagcount = 0
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.colleView_banner.scrollToItem(at: indexPath, at: .right, animated: false)
               }else{
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.colleView_banner.scrollToItem(at: indexPath, at: .left, animated: false)
               }
               self.pagecontrol.currentPage = self.pagcount
           }
       }
    
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_shop(_ sender: Any) {
        
    //        Servicefile.shared.tabbar_selectedindex = 3
                   let tapbar = UIStoryboard.pet_sp_shop_dashboard_ViewController() // shop
    //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                   self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_notification(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_care(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_petservice(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 1
                       let tapbar = UIStoryboard.pet_dashfooter_servicelist_ViewController()
        //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                       self.present(tapbar, animated: true, completion: nil)

    }
    
    @IBAction func action_petservice_seemore(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 1
                       let tapbar = UIStoryboard.pet_dashfooter_servicelist_ViewController()
        //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                       self.present(tapbar, animated: true, completion: nil)

    }
    
    @IBAction func action_sidemenu(_ sender: Any) {
        let vc = UIStoryboard.Pet_sidemenu_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_denypop(_ sender: Any) {
        Servicefile.shared.locaaccess = "Deny"
        self.view_popup.isHidden = true
        self.view_shadow.isHidden = true
        let vc = UIStoryboard.locationsettingViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_allowpop(_ sender: Any) {
        Servicefile.shared.locaaccess = "Allow"
        self.view_popup.isHidden = true
        self.view_shadow.isHidden = true
        let vc = UIStoryboard.locationsettingViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_DocSeeMore(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.colleView_banner == collectionView {
            return Servicefile.shared.petbanner.count
        }else if self.colleView_Doctor == collectionView {
            return Servicefile.shared.petdoc.count
        }else if self.colleView_Service == collectionView {
            return Servicefile.shared.petser.count
        }else if self.colleView_puppylove == collectionView {
            return Servicefile.shared.Petpuppylove.count
        }else {
            return Servicefile.shared.petprod.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.colleView_banner == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
            cell.img_banner.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petbanner[indexPath.row].img_path)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_banner.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_banner.image = image
                }
            }
            cell.img_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            //cell.view_banner_two.isHidden = true
            cell.view_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            //cell.view_banner.View_imagebanner_dropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle: false)
            //cell.view_banner_two.View_imagebanner_appcolordropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle: false)
            //cell.view_banner_two.isHidden = true
            return cell
        }else if self.colleView_Doctor == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doc", for: indexPath) as! petdocCollectionViewCell
            cell.img_doc.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_doc.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petdoc[indexPath.row].doctor_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_doc.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_doc.image = image
                }
            }
            cell.img_doc.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.img_doc.dropShadow()
            cell.img_doc.layer.borderWidth = 1.0
            cell.img_doc.layer.borderColor = UIColor.gray.cgColor
            cell.label_docname.text = Servicefile.shared.petdoc[indexPath.row].doctor_name
            cell.label_spec.text = Servicefile.shared.petdoc[indexPath.row].spec
            cell.label_rateing.text = String(Servicefile.shared.petdoc[indexPath.row].star_count)
            cell.label_ratedno.text = String(Servicefile.shared.petdoc[indexPath.row].review_count)
            cell.view_docimg.View_image_dropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle : false)
            return cell
        }else if self.colleView_Service == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ser", for: indexPath) as! petServCollectionViewCell
            let uicolo = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.petser[indexPath.row].background_color)
            cell.label_ser.text = Servicefile.shared.petser[indexPath.row].service_title
            cell.img_ser.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_ser.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petser[indexPath.row].service_icon)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_ser.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_ser.image = image
                }
            }
            
            cell.img_ser.layer.cornerRadius = cell.img_ser.frame.size.height / 2
            cell.view_img.View_image_dropshadow(cornordarius: cell.view_img.frame.size.height / 2, iscircle : true)
            return cell
        }else if self.colleView_puppylove == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "puppyprod", for: indexPath) as! petprodCollectionViewCell
            cell.img_prod.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_prod.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petprod[indexPath.row].products_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_prod.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_prod.image = image
                }
            }
            cell.view_pord.View_image_dropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle: false)
            cell.img_prod.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prod", for: indexPath) as! petprodCollectionViewCell
            cell.img_prod.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_prod.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petprod[indexPath.row].products_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_prod.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_prod.image = image
                }
            }
             cell.view_pord.View_image_dropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle: false)
            cell.img_prod.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.colleView_banner == collectionView {
            return CGSize(width: self.colleView_banner.frame.size.width , height:  self.colleView_banner.frame.size.height)
        }else if self.colleView_Doctor == collectionView {
            return CGSize(width: 163 , height:  161)
        }else if self.colleView_Service == collectionView {
            return CGSize(width: 90 , height:  129)
        }else {
            return CGSize(width: 200 , height:  121)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.colleView_banner == collectionView {
            print("data in")
        }else if self.colleView_Doctor == collectionView {
            Servicefile.shared.selectedindex = indexPath.row
            let vc = UIStoryboard.petlov_DocselectViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.colleView_Service == collectionView {
            
            Servicefile.shared.service_id = Servicefile.shared.petser[indexPath.row]._id
            Servicefile.shared.service_index = indexPath.row
            let vc = UIStoryboard.pet_servicelist_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else {
            print("data in")
        }
    }
    
    func callpetdash(){
        Servicefile.shared.pet_dash_lati = self.latitude
        Servicefile.shared.pet_dash_long = self.longitude
        Servicefile.shared.pet_dash_address = self.locationaddress
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petdashboard, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid,
             "lat" : Servicefile.shared.pet_dash_lati,
             "long" : Servicefile.shared.pet_dash_long,
             "user_type" : 1 ,
             "address" : Servicefile.shared.pet_dash_address,
             "Doctor": self.doc,
             "Product" : self.pro,
             "service" : self.ser], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let dash = Data["Dashboarddata"] as! NSDictionary
                        let user_details = Data["userdetails"] as! NSDictionary
                        Servicefile.shared.first_name = user_details["first_name"] as? String ?? ""
                        Servicefile.shared.last_name = user_details["last_name"] as? String ?? ""
                        Servicefile.shared.user_email = user_details["user_email"]  as? String ?? ""
                        Servicefile.shared.user_phone = user_details["user_phone"]  as? String ?? ""
                        Servicefile.shared.user_type = String(user_details["user_type"] as? Int ?? 0)
                        Servicefile.shared.date_of_reg = user_details["date_of_reg"] as? String ?? ""
                        Servicefile.shared.otp = String(user_details["otp"] as? Int ?? 0)
                        let userid = user_details["_id"] as? String ?? ""
                        UserDefaults.standard.set(userid, forKey: "userid")
                        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                        print("user id",Servicefile.shared.userid)
                        Servicefile.shared.petbanner.removeAll()
                        let LocationDetails = Data["LocationDetails"] as! NSArray
                        if LocationDetails.count == 0 {
                            self.view_shadow.isHidden = false
                            self.view_popup.isHidden = false
                        }else{
                            self.view_shadow.isHidden = true
                            self.view_popup.isHidden = true
                        }
                        let Banner_details = dash["Banner_details"] as! NSArray
                        for item in 0..<Banner_details.count {
                            let Bval = Banner_details[item] as! NSDictionary
                            let id = Bval["_id"] as? String ?? ""
                            let imgpath = Bval["img_path"] as? String ?? Servicefile.sample_bannerimg
                            let title =  Bval["title"] as? String ?? ""
                            Servicefile.shared.petbanner.append(Petdashbanner.init(UID: id, img_path: imgpath, title: title))
                        }
                        
                        
                        Servicefile.shared.petdoc.removeAll()
                        let Doctor_details = dash["Doctor_details"] as! NSArray
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
                            Servicefile.shared.petdoc.append(Petnewdashdoc.init(UID: id, doctor_img: imgpath, doctor_name: title, review_count: review_count, star_count: star_count, ispec: spec, idistance: distance, Iclinic_name: clinic_name, Ifav: fav, Ithumbnail_image: thumbnail_image))
                        }
                        Servicefile.shared.petprod.removeAll()
                        let Products_details = dash["Products_details"] as! NSArray
                        for item in 0..<Products_details.count {
                            let Bval = Products_details[item] as! NSDictionary
                            let id = Bval["_id"] as? String ?? ""
                            let delete_status = Bval["delete_status"] as? Bool ?? false
                            let show_status =  Bval["show_status"] as? Bool ?? false
                            let img_index =  Bval["img_index"] as? Int ?? 0
                            let product_title =  Bval["product_cate"] as? String ?? ""
                            let products_img =  Bval["img_path"] as? String ?? Servicefile.sample_img
                            
                            Servicefile.shared.petprod.append(Petdashproduct.init(I_id: id, Idelete_status: delete_status, Ishow_status: show_status, Iimg_index: img_index, Iproduct_title: product_title, Iproducts_img: products_img))
                            //                                                            Servicefile.shared.petprod.append(Petdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count))
                        }
                        Servicefile.shared.Petpuppylove.removeAll()
                        let Puppy_Products_details = dash["Puppy_Products_details"] as! NSArray
                        for item in 0..<Puppy_Products_details.count {
                            let Bval = Puppy_Products_details[item] as! NSDictionary
                            let id = Bval["_id"] as? String ?? ""
                            let delete_status = Bval["delete_status"] as? Bool ?? false
                            let show_status =  Bval["show_status"] as? Bool ?? false
                            let img_index =  Bval["img_index"] as? Int ?? 0
                            let product_title =  Bval["product_cate"] as? String ?? ""
                            let products_img =  Bval["img_path"] as? String ?? Servicefile.sample_img
                            Servicefile.shared.Petpuppylove.append(Petdashpuppylove.init(I_id: id, Idelete_status: delete_status, Ishow_status: show_status, Iimg_index: img_index, Iproduct_title: product_title, Iproducts_img: products_img))
                            //                                                            Servicefile.shared.petprod.append(Petdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count))
                        }
                        Servicefile.shared.petser.removeAll()
                        let Service_details = dash["Service_details"] as! NSArray
                        for item in 0..<Service_details.count {
                            let Bval = Service_details[item] as! NSDictionary
                            let id = Bval["_id"] as? String ?? ""
                            let background_color = Bval["background_color"] as? String ?? ""
                            let service_icon =  Bval["service_icon"] as? String ?? ""
                            let service_title =  Bval["service_title"] as? String ?? ""
                            Servicefile.shared.petser.append(Petdashservice.init(UID: id, background_color: background_color, service_icon: service_icon, service_title: service_title))
                        }
                        
                        Servicefile.shared.sosnumbers.removeAll()
                        let SOS = Data["SOS"] as! NSArray
                        for item in 0..<SOS.count {
                            let Bval = SOS[item] as! NSDictionary
                            let Number = String(Bval["Number"] as? Int ?? 0)
                            Servicefile.shared.sosnumbers.append(sosnumber.init(i_number: Number))
                        }
                        Servicefile.shared.pet_petlist.removeAll()
                        
                        let pet_details = Data["PetDetails"] as! NSArray
                        for item in 0..<pet_details.count {
                            let Bval = pet_details[item] as! NSDictionary
                            let id = Bval["_id"] as? String ?? ""
                            let default_status = Bval["default_status"] as? Bool ?? false
                            let last_vaccination_date = Bval["last_vaccination_date"] as? String ?? ""
                            let pet_age = Bval["pet_age"] as? String ?? ""
                            let pet_breed = Bval["pet_breed"] as? String ?? ""
                            let pet_color = Bval["pet_color"] as? String ?? ""
                            let pet_gender = Bval["pet_gender"] as? String ?? ""
                            let pet_img = Bval["pet_img"] as! [Any]
                            let pet_name = Bval["pet_name"] as? String ?? ""
                            let pet_type = Bval["pet_type"] as? String ?? ""
                            let pet_weight = Bval["pet_weight"] as? Double ?? 0.0
                            let user_id = Bval["user_id"] as? String ?? ""
                            let vaccinated = Bval["vaccinated"] as? Bool ?? false
                            let pet_frnd_with_cat = Bval["pet_frnd_with_cat"] as? Bool ?? false
                            let pet_frnd_with_dog = Bval["pet_frnd_with_dog"] as? Bool ?? false
                            let pet_frnd_with_kit = Bval["pet_frnd_with_kit"] as? Bool ?? false
                            let pet_microchipped = Bval["pet_microchipped"] as? Bool ?? false
                            let pet_private_part = Bval["pet_private_part"] as? Bool ?? false
                            let pet_purebred = Bval["pet_purebred"] as? Bool ?? false
                            let pet_spayed = Bval["pet_spayed"] as? Bool ?? false
                            let pet_tick_free = Bval["pet_tick_free"] as? Bool ?? false
                            let pet_dob = Bval["pet_dob"] as? String ?? ""
                         Servicefile.shared.pet_petlist.append(petlist.init(in_default_status: default_status, in_last_vaccination_date: last_vaccination_date, in_pet_age: pet_age, in_pet_breed: pet_breed, in_pet_color: pet_color, in_pet_gender: pet_gender, in_pet_img: pet_img, in_pet_name: pet_name, in_pet_type: pet_type, in_pet_weight: pet_weight, in_user_id: user_id, in_vaccinated: vaccinated, in_id: id, in_pet_frnd_with_cat: pet_frnd_with_cat, in_pet_frnd_with_dog: pet_frnd_with_dog, in_pet_frnd_with_kit: pet_frnd_with_kit, in_pet_microchipped: pet_microchipped, in_pet_private_part: pet_private_part, in_pet_purebred: pet_purebred, in_pet_spayed: pet_spayed, in_pet_tick_free: pet_tick_free, in_pet_dob: pet_dob))
                        }
                        if  Servicefile.shared.petdoc.count == 0 {
                            //                                                            let alert = UIAlertController(title: "Alert", message: "", preferredStyle: .alert)
                            //                                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            //                                                                self.doc = 1
                            //                                                                self.callpetdash()
                            //                                                                 }))
                            //                                                            self.present(alert, animated: true, completion: nil)
                        }
                        self.pagecontrol.numberOfPages = Servicefile.shared.petbanner.count
                        self.startTimer()
                        self.refreshControl.endRefreshing()
                        self.colleView_banner.reloadData()
                        self.colleView_Doctor.reloadData()
                        self.colleView_product.reloadData()
                        self.colleView_Service.reloadData()
                        self.colleView_puppylove.reloadData()
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
    
    
    @IBAction func actionl_ogout(_ sender: Any) {
        
    }
    
    
}
