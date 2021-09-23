//
//  petowner_new_dashboard_ViewController.swift
//  Petfolio
//
//  Created by Admin on 19/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.

import UIKit
import Alamofire
import Toucan
import SDWebImage
import CoreLocation

class petloverDashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {

    @IBOutlet weak var view_header: petowner_header!
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var view_banner: UIView!
    @IBOutlet weak var view_service_more: UIView!
    
    @IBOutlet weak var col_banner: UICollectionView!
    @IBOutlet weak var pagecontrol_banner: UIPageControl!
    @IBOutlet weak var col_service: UICollectionView!
    @IBOutlet weak var col_shop_banner: UICollectionView!
    @IBOutlet weak var col_vet: UICollectionView!
    @IBOutlet weak var col_shop: UICollectionView!
    
    @IBOutlet weak var view_vet_seemore: UIView!
    @IBOutlet weak var view_shop_seemore: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_denypop: UIView!
    @IBOutlet weak var view_allowpop: UIView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        CacheManager.shared.clearCache()
//        Servicefile.shared.getuserdata()
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        print("user name",Servicefile.shared.user_type, Servicefile.shared.first_name)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
        self.view_popup.view_cornor()
        self.view_denypop.view_cornor()
        self.view_allowpop.view_cornor()
        self.view_denypop.dropShadow()
        self.view_allowpop.dropShadow()
        self.view_popup.isHidden = true
        self.view_shadow.isHidden = true
        self.view_banner.layer.cornerRadius = 20.0
        self.view_service_more.layer.cornerRadius = self.view_service_more.frame.height / 2
        self.view_vet_seemore.layer.cornerRadius = self.view_service_more.frame.height / 2
        self.view_shop_seemore.layer.cornerRadius = self.view_service_more.frame.height / 2
        self.calldelegate()
        let nibName = UINib(nibName: "dash_doc_CollectionViewCell", bundle:nil)
        self.col_vet.register(nibName, forCellWithReuseIdentifier: "cell1")
        let niName = UINib(nibName: "pet_product_CollectionViewCell", bundle:nil)
        self.col_shop.register(niName, forCellWithReuseIdentifier: "cell")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollview.addSubview(refreshControl) // not required when using UITableViewController
        print("Referral code :",Servicefile.shared.my_ref_code)
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        NotificationCenter.default.addObserver(self, selector: #selector(checklocation), name: UIApplication.willEnterForegroundNotification
                    , object: nil)
        
    }
    
    @objc func checklocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callnoticartcount()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
//                let alert = UIAlertController(title: "Please turn on Your Location for service", message: "", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//                }))
//                self.present(alert, animated: true, completion: nil)
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
                if CLLocationManager.locationServicesEnabled() {

                        locationManager.delegate = self
                        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                        locationManager.startUpdatingLocation()
                    }
            break
            case .restricted, .denied:
                let alert = UIAlertController(title: "Please turn on Your Location for service", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                self.present(alert, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            @unknown default:
                let alert = UIAlertController(title: "Please turn on Your Location for service", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                self.present(alert, animated: true, completion: nil)
              
            }
        }else{
            let alert = UIAlertController(title: "Please turn on Your Location for service", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        self.latLong(lat: self.latitude,long: self.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func intial_setup_action(){
    // header action
        self.view_header.label_location.text = Servicefile.shared.pet_header_city
        self.view_header.btn_sidemenu.addTarget(self, action: #selector(sidemenu), for: .touchUpInside)
        self.view_header.btn_button2.addTarget(self, action: #selector(action_cart), for: .touchUpInside)
        self.view_header.image_button2.image = UIImage(named: imagelink.image_bag)
        self.view_header.image_profile.image = UIImage(named: imagelink.image_bel)
        self.view_header.btn_profile.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
//        self.view_header.btn_profile.addTarget(self, action: #selector(profile), for: .touchUpInside)
//        self.view_header.btn_button2.addTarget(self, action: #selector(action_notifi), for: .touchUpInside)
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
//        self.view_header.image_profile.layer.cornerRadius = self.view_header.image_profile.frame.height / 2
        self.view_header.btn_location.addTarget(self, action: #selector(manageaddress), for: .touchUpInside)
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        //self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        self.view_footer.setup(b1: false, b2: false, b3: true, b4: false, b5: false)
    // footer action
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.call_dashboard_api_details()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
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
                    self.call_dashboard_api_details()
                }
                print(addressString)
            })
        }
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
                self.col_banner.isPagingEnabled = false
                self.col_banner.scrollToItem(at: indexPath, at: .left, animated: false)
                self.col_banner.isPagingEnabled = true
               }else{
                   let indexPath = IndexPath(row: pagcount, section: 0)
                self.col_banner.isPagingEnabled = false
                self.col_banner.scrollToItem(at: indexPath, at: .left, animated: false)
                self.col_banner.isPagingEnabled = true
               }
               self.pagecontrol.currentPage = self.pagcount
           }
       }
    
    
    func calldelegate(){
        self.col_banner.delegate = self
        self.col_banner.dataSource = self
        self.col_service.delegate = self
        self.col_service.dataSource = self
        self.col_shop_banner.delegate = self
        self.col_shop_banner.dataSource = self
        self.col_vet.delegate = self
        self.col_vet.dataSource = self
        self.col_shop.delegate = self
        self.col_shop.dataSource = self
        self.col_banner.isPagingEnabled = true
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.col_banner == collectionView {
            return Servicefile.shared.petbanner.count
        }else if self.col_service == collectionView {
            return Servicefile.shared.petser.count
        }else if self.col_shop_banner == collectionView {
            return Servicefile.shared.petshopbanner.count
        }else if self.col_vet == collectionView {
            return Servicefile.shared.petdoc.count
        }else{
            return  Servicefile.shared.petnewprod.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.col_banner == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_dash_banner_CollectionViewCell
            cell.image_banner.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petbanner[indexPath.row].img_path)) { (image, error, cache, urls) in
                print(error)
                if (error != nil) {
                    cell.image_banner.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_banner.image = image
                }
            }
            cell.image_banner.contentMode = .scaleAspectFill
//            cell.image_banner.image = UIImage(named: "b_sample")
            cell.label_banner.text = Servicefile.shared.petbanner[indexPath.row].title
            return cell
        }else if self.col_service == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_dashboard_Service_CollectionViewCell
            cell.view_service.backgroundColor = .clear
            cell.image_service.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.image_service.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petser[indexPath.row].service_icon)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_service.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_service.image = image
                }
            }
            //cell.view_service.dropShadow()
//            cell.view_service.View_dropshadow(cornordarius: CGFloat(2.0), iscircle : true)
//            cell.view_service.layer.cornerRadius = 40.0
            print("service title",Servicefile.shared.petser[indexPath.row].service_title)
            cell.label_service.text = Servicefile.shared.petser[indexPath.row].service_title
            return cell
        }else if self.col_shop_banner == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_dashboard_shop_banner_CollectionViewCell
            cell.image_banner.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.image_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petshopbanner[indexPath.row].img_path)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_banner.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_banner.image = image
                }
            }
            cell.view_banner.dropShadow()
            cell.image_banner.contentMode = .scaleToFill
            cell.image_banner.layer.cornerRadius = 15.0
            return cell
        }else if self.col_vet == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! dash_doc_CollectionViewCell
            cell.image_paw.image = UIImage(named: "paw1")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            cell.image_paw.tintColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.appfootcolor)
            cell.image_vet.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.image_vet.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petdoc[indexPath.row].thumbnail_image)) { (image, error, cache, urls) in
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
            cell.label_DR.text = Servicefile.shared.petdoc[indexPath.row].doctor_name
            cell.label_clinic.text = Servicefile.shared.petdoc[indexPath.row].clinic_name
            cell.view_rating.rating = Double(Servicefile.shared.petdoc[indexPath.row].star_count)
            cell.view_vets.view_cornor()
            cell.image_vet.view_cornor()
            cell.view_main.view_cornor()
            cell.view_bottom_curve.view_cornor()
            
            cell.view_rating.isUserInteractionEnabled = false
            cell.view_pet_paw.layer.cornerRadius = cell.view_pet_paw.frame.height / 2
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_product_CollectionViewCell
            cell.image_shopping_bag.image = UIImage(named: "shopping-bag")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            cell.image_shopping_bag.tintColor = Servicefile.shared.hexStringToUIColor(hex: colorpickert.appfootcolor)
            cell.image_product.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url:  Servicefile.shared.petnewprod[indexPath.row].thumbnail_image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_product.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_product.image = image
                }
            }
            if Servicefile.shared.petnewprod[indexPath.row].product_fav_status {
                cell.image_fav.image = UIImage(named: imagelink.fav_true)
            }else {
                cell.image_fav.image = UIImage(named: imagelink.fav_false)
            }
            cell.image_product.layer.cornerRadius = 8.0
            cell.view_main.dropShadow()
            if Servicefile.shared.petnewprod[indexPath.row].product_discount_price != 0 {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "INR " + String(Servicefile.shared.petnewprod[indexPath.row].product_discount_price))
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.label_offer.attributedText = attributeString
            }else{
                cell.label_offer.text = ""
            }
            
            cell.label_off_percentage.text = ""
            if Servicefile.shared.petnewprod[indexPath.row].product_offer_value > 0 {
                cell.label_off_percentage.text = String(Servicefile.shared.petnewprod[indexPath.row].product_offer_value) + " % off"
            }else{
                cell.label_off_percentage.text = ""
            }
            /*
             
             if Servicefile.shared.vendor_product_id_details[indexPath.row].product_discount > 0 {
                 cell.label_off_percentage.text =  String(Servicefile.shared.vendor_product_id_details[indexPath.row].product_discount) + "% off"
             }else{
                 cell.label_off_percentage.text = ""
             }
             if Servicefile.shared.vendor_product_id_details[indexPath.row].product_discount_price > 0 {
                 let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "INR " + String(Servicefile.shared.vendor_product_id_details[indexPath.row].product_discount_price))
                 attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                 cell.label_offer.attributedText = attributeString
             }else{
                 cell.label_offer.text = ""
             }
             
             */
            
            
            cell.label_prod_title.text = Servicefile.shared.petnewprod[indexPath.row].product_title
            cell.label_vendor.text = Servicefile.shared.petnewprod[indexPath.row].cat_names
            cell.label_price.text = "INR " + String(Servicefile.shared.petnewprod[indexPath.row].product_prices)
            cell.view_rating.rating = Double(Servicefile.shared.petnewprod[indexPath.row].product_rate) ?? 0.0
            cell.view_rating.isUserInteractionEnabled = false
            cell.view_shopbag.view_cornor()
            cell.image_product.view_cornor()
            //cell.image_shop.view_cornor()
            cell.view_main.view_cornor()
            cell.view_y_main.view_cornor()
            cell.view_y_main.dropShadow()
            cell.contentView.dropShadow()
            cell.view_shopbag.layer.cornerRadius = cell.view_shopbag.frame.height / 2
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.col_banner == collectionView {
            return CGSize(width: self.col_banner.frame.size.width , height:  self.col_banner.frame.size.height)
        }else if self.col_service == collectionView {
            return CGSize(width: 140 , height:  140)
        }else if self.col_shop_banner == collectionView {
            return CGSize(width: 280 , height:  90)
        }else if self.col_vet == collectionView {
            return CGSize(width: 170 , height:  230)
        }else {
            return CGSize(width: 170 , height:  260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.col_banner == collectionView {
            print("data in")
        } else if self.col_vet == collectionView {
            Servicefile.shared.selectedindex = indexPath.row
            let vc = UIStoryboard.petlov_DocselectViewController()
            self.present(vc, animated: true, completion: nil)
        } else if self.col_service == collectionView {
            Servicefile.shared.service_id = Servicefile.shared.petser[indexPath.row]._id
            Servicefile.shared.service_index = indexPath.row
            let vc = UIStoryboard.pet_servicelist_ViewController()
            self.present(vc, animated: true, completion: nil)
        } else if self.col_shop_banner == collectionView {
            if Servicefile.shared.petshopbanner[indexPath.row].title == "Pet Care" { //; title = Shop, title = "Pet Care";
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
                self.present(tapbar, animated: true, completion: nil)
            }else if Servicefile.shared.petshopbanner[indexPath.row].title == "Pet Service" { //; title = Shop, title = "Pet Care"
                let tapbar = UIStoryboard.pet_dashfooter_servicelist_ViewController()
                self.present(tapbar, animated: true, completion: nil)
            }else if Servicefile.shared.petshopbanner[indexPath.row].title == "Shop" { //; title = Shop, title = "Pet Care";
                let tapbar = UIStoryboard.pet_sp_shop_dashboard_ViewController() // shop
                self.present(tapbar, animated: true, completion: nil)
            }
        }else{
            Servicefile.shared.product_id = Servicefile.shared.petnewprod[indexPath.row]._id
            let vc = UIStoryboard.productdetailsViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func action_DocSeeMore(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_petservice_seemore(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 1
                       let tapbar = UIStoryboard.pet_dashfooter_servicelist_ViewController()
        //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                       self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_petshop_seemore(_ sender: Any) {
        
    //        Servicefile.shared.tabbar_selectedindex = 3
                   let tapbar = UIStoryboard.pet_sp_shop_dashboard_ViewController() // shop
    //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                   self.present(tapbar, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    @objc func button1(sender: UIButton){
        //        Servicefile.shared.tabbar_selectedindex = 0
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
       
    }
    
    @objc func button2(sender: UIButton){
        //        Servicefile.shared.tabbar_selectedindex = 1
                       let tapbar = UIStoryboard.pet_dashfooter_servicelist_ViewController()
        //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                       self.present(tapbar, animated: true, completion: nil)
    }
    
    @objc func button3(sender: UIButton){
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
        
    }
    
    @objc func button4(sender: UIButton){
        
    //        Servicefile.shared.tabbar_selectedindex = 3
                   let tapbar = UIStoryboard.pet_sp_shop_dashboard_ViewController() // shop
    //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                   self.present(tapbar, animated: true, completion: nil)
       
    }
//    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
//    self.present(vc, animated: true, completion: nil)
    
    @objc func button5(sender: UIButton){
//        Servicefile.shared.tabbar_selectedindex = 4
        let tapbar = UIStoryboard.comunityViewController()
//        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
        
    }
    
    func setup_footer_image(){
        
    }
    
    @objc func sidemenu(sender: UIButton){
        let vc = UIStoryboard.Pet_sidemenu_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func manageaddress(sender: UIButton){
        let vc = UIStoryboard.petManageaddressViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func profile(sender: UIButton){
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func notification(sender: UIButton){
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_cart(sender: UIButton){
        let vc = UIStoryboard.vendorcartpageViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_sos(sender: UIButton){
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_notifi(sender: UIButton){
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_back(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func action_backlogin(sender: UIButton){
        self.pushtologin()
    }
}


extension petloverDashboardViewController {
    
    func call_dashboard_api_details(){
        Servicefile.shared.pet_dash_lati = self.latitude
        Servicefile.shared.pet_dash_long = self.longitude
        Servicefile.shared.pet_dash_address = self.locationaddress
        print("user_id" , Servicefile.shared.userid,
              "lat" , self.latitude,
              "long" , self.longitude,
              "user_type" , 1 ,
              "address" , self.locationaddress,
              "Doctor", self.doc,
              "Product" , self.pro,
              "service" , self.ser)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petdashboard_new, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid,
             "lat" : self.latitude,
             "long" : self.longitude,
             "user_type" : 1 ,
             "address" : self.locationaddress,
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
                        
                        let middle_Banner_details = dash["middle_Banner_details"] as! NSArray
                        Servicefile.shared.petshopbanner.removeAll()
                        for item in 0..<middle_Banner_details.count {
                            let Bval = middle_Banner_details[item] as! NSDictionary
                            let id = Bval["_id"] as? String ?? ""
                            let imgpath = Bval["img_path"] as? String ?? Servicefile.sample_bannerimg
                            let title =  Bval["title"] as? String ?? ""
                            Servicefile.shared.petshopbanner.append(Petdashbanner.init(UID: id, img_path: imgpath, title: title))
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
                            Servicefile.shared.petdoc.append(Petnewdashdoc.init(UID: id, doctor_img: imgpath, doctor_name: title, review_count: review_count, star_count: star_count, ispec: spec, idistance: distance, Iclinic_name: clinic_name, Ifav : fav, Ithumbnail_image: thumbnail_image))
                        }
                        Servicefile.shared.petnewprod.removeAll()
                        let Products_details = dash["Products_details"] as! NSArray
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
                            let product_discount_price = Bval["product_discount_price"] as? Int ?? 0
//                            Servicefile.shared.petprod.append(Petdashproduct.init(I_id: id, Idelete_status: delete_status, Ishow_status: show_status, Iimg_index: img_index, Iproduct_title: product_title, Iproducts_img: products_img))
                            
                            Servicefile.shared.petnewprod.append(Petnewdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count, cat_name: cat_name, Ithumbnail_image: thumbnail_image, Iproduct_discount_price: product_discount_price))
                           
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
//                            Servicefile.shared.petprod.append(Petdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count))
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
                        
//                        Servicefile.shared.sosnumbers.removeAll()
//                        let SOS = Data["SOS"] as! NSArray
//                        for item in 0..<SOS.count {
//                            let Bval = SOS[item] as! NSDictionary
//                            let Number = String(Bval["Number"] as? Int ?? 0)
//                            Servicefile.shared.sosnumbers.append(sosnumber.init(i_number: Number))
//                        }
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
                        let location_details = Data["LocationDetails"] as! NSArray
                        if location_details.count > 0 {
                            let city_list = location_details[0] as! NSDictionary
                            let city = city_list["location_city"] as? String ?? ""
                            Servicefile.shared.pet_header_city = city
                            self.view_header.label_location.text = Servicefile.shared.pet_header_city
                        } else {
                            Servicefile.shared.pet_header_city = ""
                            self.view_header.label_location.text = Servicefile.shared.pet_header_city
                        }
                        self.pagecontrol.numberOfPages = Servicefile.shared.petbanner.count
                        self.col_banner.reloadData()
                        self.col_service.reloadData()
                        self.col_shop_banner.reloadData()
                        self.col_vet.reloadData()
                        self.col_shop.reloadData()
                        self.startTimer()
                        self.refreshControl.endRefreshing()
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
        self.startAnimatingActivityIndicator()
    }
    
    func callnoticartcount(){
        print("notification")
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
}
