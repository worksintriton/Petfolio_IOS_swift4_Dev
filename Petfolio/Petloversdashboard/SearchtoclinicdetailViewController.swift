//
//  SearchtoclinicdetailViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 15/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Cosmos
import GoogleMaps
import SDWebImage

class SearchtoclinicdetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GMSMapViewDelegate  {
    
    @IBOutlet weak var GMS_mapView: GMSMapView!
    @IBOutlet weak var label_clinicname: UILabel!
    @IBOutlet weak var label_clinicdetails: UILabel!
    @IBOutlet weak var coll_imgview: UICollectionView!
    @IBOutlet weak var label_city: UILabel!
    //    @IBOutlet weak var label_Noofcomments: UILabel!
    //    @IBOutlet weak var Label_ratingval: UILabel!
    //    @IBOutlet weak var label_specdetails: UILabel!
    @IBOutlet weak var view_book: UIView!
    @IBOutlet weak var label_descrption: UILabel!
    @IBOutlet weak var label_distance: UILabel!
    @IBOutlet weak var label_cont_amt: UILabel!
    @IBOutlet weak var label_edu_year: UILabel!
    @IBOutlet weak var label_edu: UILabel!
    
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var image_fav: UIImageView!
    
    var clinicpic = [""]
    var edu = ""
    var _id = ""
    var clinic_name = ""
    var descri = ""
    var dr_name = ""
    var dr_title = ""
    var star_count = ""
    
    var pet_type = [""]
    var petid = [""]
    var Pet_breed = [""]
    
    var pet_spec = [""]
    var pet_handle = [""]
    var latitude : Double!
    var longitude : Double!
    let marker = GMSMarker()
    
    @IBOutlet weak var view_location: UIView!
    @IBOutlet weak var view_experience: UIView!
    @IBOutlet weak var view_fee: UIView!
    
    @IBOutlet weak var col_pet_handle: UICollectionView!
    @IBOutlet weak var col_sepc_list: UICollectionView!
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var ratingval: CosmosView!
    var pagcount = 0
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intial_setup_action()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.pet_handle.removeAll()
        self.pet_spec.removeAll()
        let spec_nibName = UINib(nibName: "spec_details_page_CollectionViewCell", bundle:nil)
        //let nibName = UINib(nibName: "pet_handle_details_CollectionViewCell", bundle:nil)
        let nibName = UINib(nibName: "spec_details_page_CollectionViewCell", bundle:nil)
        
        self.col_sepc_list.register(spec_nibName, forCellWithReuseIdentifier: "cell1")
        self.col_pet_handle.register(nibName, forCellWithReuseIdentifier: "cell1")
        self.GMS_mapView.delegate = self
        self.GMS_mapView.view_cornor()
        self.view_back.layer.cornerRadius = self.view_back.frame.height / 2
        self.view_main.layer.cornerRadius = 20.0
        self.view_fee.layer.cornerRadius = 38.0
        self.view_location.layer.cornerRadius = 38.0
        self.view_experience.layer.cornerRadius = 38.0
        self.view_fee.dropShadow()
        self.view_location.dropShadow()
        self.view_experience.dropShadow()
        
        //self.view_home.view_cornor()
        self.pet_type.removeAll()
        self.petid.removeAll()
        self.Pet_breed.removeAll()
        self.clinicpic.removeAll()
        self.coll_imgview.delegate = self
        self.coll_imgview.dataSource = self
        self.coll_imgview.isPagingEnabled = true
        self.view_book.layer.cornerRadius = self.view_book.frame.height / 2
        self.view_book.dropShadow()
        self.col_pet_handle.delegate = self
        self.col_pet_handle.dataSource = self
        self.col_sepc_list.delegate = self
        self.col_sepc_list.dataSource = self
        self.coll_imgview.isPagingEnabled = true
        // Do any additional setup after loading the view.
        print("selected doctor details",Servicefile.shared.sear_Docapp_id)
        // Do any additional setup after loading the view.
        self.calldocdetails()
    }
    
    
    func intial_setup_action(){
        
        // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        self.view_footer.setup(b1: false, b2: false, b3: true, b4: false, b5: false)
        // footer action
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    func startTimer() {
        self.timer.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if self.clinicpic.count > 0 {
            self.pagcount += 1
            if self.pagcount == self.clinicpic.count {
                self.pagcount = 0
                let indexPath = IndexPath(row: pagcount, section: 0)
                self.coll_imgview.scrollToItem(at: indexPath, at: .right, animated: false)
            }else{
                let indexPath = IndexPath(row: pagcount, section: 0)
                self.coll_imgview.scrollToItem(at: indexPath, at: .left, animated: false)
            }
            
        }
    }
    
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_notifica(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_pet_service(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 1
        let tapbar = UIStoryboard.pet_dashfooter_servicelist_ViewController()
        //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    
    @IBAction func action_home(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
        let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_care(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
        let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        //        //        Servicefile.shared.tabbar_selectedindex = 0
        //                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        //        self.present(tapbar, animated: true, completion: nil)
        let vc = UIStoryboard.Pet_searchlist_DRViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_fav_unfav(_ sender: Any) {
        self.callfav()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if col_sepc_list == collectionView {
            return self.pet_spec.count
        }else if col_pet_handle == collectionView {
            return self.pet_handle.count
        }else{
            return self.clinicpic.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if col_sepc_list == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as!  spec_details_page_CollectionViewCell
            cell.label_spec.text = self.pet_spec[indexPath.row]
            
            return cell
        }else if col_pet_handle == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)  as!  spec_details_page_CollectionViewCell
            cell.label_spec.text = self.pet_handle[indexPath.row]
            //            cell.label_pet_handle.text = self.pet_handle[indexPath.row]
            //            cell.view_pethandle.view_cornor()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as!  petbannerCollectionViewCell
            cell.img_banner.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url:self.clinicpic[indexPath.row])) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_banner.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_banner.image = image
                }
            }
            //            cell.img_banner.view_cornor()
            //            cell.view_banner_two.view_cornor()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if col_sepc_list == collectionView {
            return CGSize(width: col_sepc_list.frame.width / 2.1, height:  30)
        }else if col_pet_handle == collectionView {
            return CGSize(width: col_pet_handle.frame.width / 3.2 , height:  30)
        }else{
            return CGSize(width: self.coll_imgview.frame.size.width , height:  self.coll_imgview.frame.size.height)
        }
    }
    
    @IBAction func action_share(_ sender: Any) {
        
    }
    
    @IBAction func action_book(_ sender: Any) {
        print("search pet app ",Servicefile.shared.clinic_name,Servicefile.shared.dr_name)
        let vc = UIStoryboard.searchcalenderdetailsViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func calldocdetails(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_fetchdocdetails, method: .post, parameters:
                                                                    ["doctor_id": Servicefile.shared.sear_Docapp_id,"user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("272 doc details api success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                self.clinicpic.removeAll()
                                                                                let Data = res["Data"] as! NSDictionary
                                                                                self._id = Data["_id"] as? String ?? ""
                                                                                self.clinic_name = Data["clinic_name"] as? String ?? ""
                                                                                Servicefile.shared.clinic_name = self.clinic_name
                                                                                Servicefile.shared.pet_apoint_communication_type = Data["communication_type"] as? String ?? ""
                                                                                let clidet = Data["clinic_pic"] as! NSArray
                                                                                let clicloc =  Data["clinic_loc"] as? String ?? ""
                                                                                let amount =  Data["amount"] as? Int ?? 0
                                                                                Servicefile.shared.pet_apoint_amount = amount
                                                                                self.label_cont_amt.text = " INR " + String(Servicefile.shared.pet_apoint_amount)
                                                                                self.label_city.text = clicloc + ". "
                                                                                self.label_distance.text = Servicefile.shared.moredocd[Servicefile.shared.selectedindex].distance + " KM away"
                                                                                for itm in 0..<clidet.count{
                                                                                    let dat = clidet[itm] as! NSDictionary
                                                                                    let pic = dat["clinic_pic"] as? String ?? Servicefile.sample_img
                                                                                    self.clinicpic.append(pic)
                                                                                }
                                                                                let educ_details = Data["education_details"] as! NSArray
                                                                                for itm in 0..<educ_details.count{
                                                                                    let dat = educ_details[itm] as! NSDictionary
                                                                                    let ed = dat["education"] as? String ?? ""
                                                                                    if self.edu == "" {
                                                                                        self.edu = ed  + self.edu
                                                                                    }else{
                                                                                        self.edu =  self.edu + ", " +  ed
                                                                                    }
                                                                                    
                                                                                }
                                                                                let fav = Data["fav"] as? Bool ?? false
                                                                                if fav {
                                                                                    self.image_fav.image = UIImage(named: imagelink.fav_true)
                                                                                }else {
                                                                                    self.image_fav.image = UIImage(named: imagelink.fav_false)
                                                                                }
                                                                                self.label_edu.text = self.edu
                                                                                var specarray = ""
                                                                                let spec =  Data["specialization"] as! NSArray
                                                                                self.pet_spec.removeAll()
                                                                                for itm in 0..<spec.count{
                                                                                    let dat = spec[itm] as! NSDictionary
                                                                                    let pic = dat["specialization"] as? String ?? ""
                                                                                    self.pet_spec.append(pic)
                                                                                    if itm == 0 {
                                                                                        specarray =   pic
                                                                                    }else{
                                                                                        let val = specarray + ", "
                                                                                        specarray = val + pic
                                                                                    }
                                                                                }
                                                                                print("pet handle",self.pet_spec)
                                                                                self.col_sepc_list.reloadData()
                                                                                self.pet_handle.removeAll()
                                                                                let pet_ha =  Data["pet_handled"] as! NSArray
                                                                                for itm in 0..<pet_ha.count{
                                                                                    let dat = pet_ha[itm] as! NSDictionary
                                                                                    let pic = dat["pet_handled"] as? String ?? ""
                                                                                    self.pet_handle.append(pic)
                                                                                }
                                                                                print("pet handle",self.pet_handle)
                                                                                self.col_pet_handle.reloadData()
                                                                                self.coll_imgview.reloadData()
                                                                                self.descri = Data["descri"] as? String ?? ""
                                                                                self.dr_name = Data["dr_name"] as? String ?? ""
                                                                                Servicefile.shared.dr_name = self.dr_name
                                                                                self.dr_title = Data["dr_title"] as? String ?? ""
                                                                                let strcount = Double(truncating: Data["star_count"] as? NSNumber ?? 0)
                                                                                let r_count =  Data["review_count"] as? Int ?? 0
                                                                                self.star_count = String(strcount)
                                                                                
                                                                                let rcount = String(r_count)
                                                                                if self.star_count == "" {
                                                                                    self.ratingval.rating = 0.0
                                                                                }else{
                                                                                    self.ratingval.rating = Double(strcount)
                                                                                }
                                                                                //                        if rcount == "" {
                                                                                //                            self.label_Noofcomments.text = "0"
                                                                                //                        }else{
                                                                                //                            self.label_Noofcomments.text = rcount
                                                                                //                        }
                                                                                
                                                                                self.label_edu_year.text = String(Data["doctor_exp"] as? Int ?? 0) + " Year"
                                                                                self.latitude = Data["clinic_lat"] as? Double ?? 0.0
                                                                                self.longitude = Data["clinic_long"] as? Double ?? 0.0
                                                                                self.setmarker(lat: self.latitude, long: self.longitude)
                                                                                self.label_clinicdetails.text = self.dr_title + " " + self.dr_name
                                                                                self.label_clinicname.text = self.clinic_name
                                                                                //self.label_specdetails.text = specarray
                                                                                self.label_descrption.text = self.descri
                                                                                self.startTimer()
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_fav, method: .post, parameters:
                                                                    ["doctor_id": Servicefile.shared.sear_Docapp_id,"user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                self.clinicpic.removeAll()
                                                                                
                                                                                self.calldocdetails()
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
    
    
    
    func callpetdetailget(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.petdetailget, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let Pet_type = Data["usertypedata"] as! NSArray
                        self.pet_type.removeAll()
                        self.petid.removeAll()
                        self.Pet_breed.removeAll()
                        
                        for item in 0..<Pet_type.count{
                            let pb = Pet_type[item] as! NSDictionary
                            let pbv = pb["pet_type_title"] as? String ?? ""
                            if pbv != "" {
                                self.pet_type.append(pbv)
                            }
                        }
                        for item in 0..<Pet_type.count{
                            let pb = Pet_type[item] as! NSDictionary
                            let pbv = pb["_id"] as? String ?? ""
                            if pbv != "" {
                                self.petid.append(pbv)
                            }
                        }
                        //                self.tblview_pettype.reloadData()
                        //                self.tblview_petbreed.reloadData()
                        
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
    
    func callpetbreedbyid(petid: String){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petbreedid, method: .post, parameters:
                                                                    ["pet_type_id" : petid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                let Pet_breed = res["Data"] as! NSArray
                                                                                self.Pet_breed.removeAll()
                                                                                for item in 0..<Pet_breed.count{
                                                                                    let pb = Pet_breed[item] as! NSDictionary
                                                                                    let pbv = pb["pet_breed"] as? String ?? ""
                                                                                    if pbv != "" {
                                                                                        self.Pet_breed.append(pbv)
                                                                                    }
                                                                                }
                                                                                self.stopAnimatingActivityIndicator()
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
    func setmarker(lat: Double,long: Double){
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        Servicefile.shared.lati = lat
        Servicefile.shared.long = long
        self.latitude = lat
        self.longitude = long
        marker.title = "Area Details"
        marker.snippet = "my loc"
        marker.map = self.GMS_mapView
        let markerImage = UIImage(named: "location")!
        let markerView = UIImageView(image: markerImage)
        markerView.frame = CGRect(x: 0, y: 0, width: 22, height: 30)
        markerView.tintColor = UIColor.red
        marker.iconView = markerView
        GMS_mapView.camera =  GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        print("You tapped at")
        print("did select",Servicefile.shared.lati,Servicefile.shared.long)
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.openURL(NSURL(string:
                                                "comgooglemaps://?saddr=&daddr=\(Servicefile.shared.lati),\(Servicefile.shared.long)&directionsmode=driving")! as URL)
            
        } else {
            UIApplication.shared.openURL(NSURL(string:
                                                "http://maps.apple.com/?daddr=\(Servicefile.shared.lati),\(Servicefile.shared.long)")! as URL)
        }
    }
}
