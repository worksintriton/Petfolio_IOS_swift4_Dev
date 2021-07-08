//
//  pet_sp_service_details_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 08/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Cosmos
import GoogleMaps
import SDWebImage


class pet_sp_service_details_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , GMSMapViewDelegate {
   
    @IBOutlet weak var GMS_mapView: GMSMapView!
    @IBOutlet weak var view_rate: CosmosView!
    @IBOutlet weak var view_img_service: UIView!
    @IBOutlet weak var label_service_com_name: UILabel!
    @IBOutlet weak var label_serview_provider: UILabel!
    @IBOutlet weak var coll_service: UICollectionView!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var label_distance: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var image_service: UIImageView!
    @IBOutlet weak var label_service: UILabel!
    @IBOutlet weak var view_book: UIView!
    
    @IBOutlet weak var view_back: UIView!
    @IBOutlet weak var label_fee: UILabel!
    @IBOutlet weak var view_location: UIView!
    @IBOutlet weak var view_fee: UIView!
    
    @IBOutlet weak var image_fav: UIImageView!
    @IBOutlet weak var view_rate_back: UIView!
    @IBOutlet weak var col_pet_ser: UICollectionView!
    var latitude : Double!
    var longitude : Double!
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_back.layer.cornerRadius = self.view_back.frame.height / 2
        let spec_nibName = UINib(nibName: "spec_details_page_CollectionViewCell", bundle:nil)
        self.view_rate_back.layer.cornerRadius = 30.0
        self.col_pet_ser.register(spec_nibName, forCellWithReuseIdentifier: "cell1")
        self.view_fee.layer.cornerRadius = 30.0
        self.view_location.layer.cornerRadius = 30.0
        self.view_rate.rating = 0.0
        self.call_ser_details()
        self.coll_service.delegate = self
        self.coll_service.dataSource = self
        self.col_pet_ser.delegate = self
        self.col_pet_ser.dataSource = self
        self.image_service.layer.cornerRadius = self.image_service.frame.size.height / 2
        self.view_img_service.View_image_dropshadow(cornordarius: self.image_service.frame.size.height / 2, iscircle: true)
        self.view_book.view_cornor()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if col_pet_ser == collectionView {
            return Servicefile.shared.sp_bus_spec_list.count
        }else{
            return Servicefile.shared.sp_bus_service_galldicarray.count
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if col_pet_ser == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as!  spec_details_page_CollectionViewCell
            
            let ser = Servicefile.shared.sp_bus_spec_list[indexPath.row] as! NSDictionary
            
            cell.label_spec.text = ser["bus_spec_list"] as? String ?? ""
            
            return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
        let bannerdic = Servicefile.shared.sp_bus_service_galldicarray[indexPath.row] as! NSDictionary
        let image = bannerdic["bus_service_gall"] as? String ?? Servicefile.sample_bannerimg
            cell.img_banner.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                   cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: image)) { (image, error, cache, urls) in
                       if (error != nil) {
                           cell.img_banner.image = UIImage(named: imagelink.sample)
                       } else {
                           cell.img_banner.image = image
                       }
                   }
            
                   cell.img_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
//        cell.view_banner_two.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.col_pet_ser == collectionView {
            return CGSize(width: col_pet_ser.frame.width / 2.1, height:  30)
        }else{
            return CGSize(width: self.coll_service.frame.size.width , height:  self.coll_service.frame.size.height)
        }
       
    }
    
    
    @IBAction func action_notifica(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_book(_ sender: Any) {
        let vc = UIStoryboard.pet_sp_calender_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        let vc = UIStoryboard.pet_servicelist_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_fav_unfav(_ sender: Any) {
        self.callfav()
    }
    
    
    func callfav(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_fav, method: .post, parameters:
            ["user_id": Servicefile.shared.userid,
             "cata_id":Servicefile.shared.service_id,
             "sp_id":Servicefile.shared.service_sp_id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.call_ser_details()
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
    
    
    @IBAction func action_petcare(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_home(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    
    func call_ser_details(){
        print("url",Servicefile.pet_sp_service_details,"user_id", Servicefile.shared.userid,
              "cata_id", Servicefile.shared.service_id,
              "sp_id", Servicefile.shared.service_sp_id)
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
            self.startAnimatingActivityIndicator()
          if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_service_details, method: .post, parameters:
            ["user_id": Servicefile.shared.userid,
             "cata_id":Servicefile.shared.service_id,
             "sp_id":Servicefile.shared.service_sp_id]
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                        switch (response.result) {
                                                        case .success:
                                                              let res = response.value as! NSDictionary
                                                              print("success service details data",res)
                                                              let Code  = res["Code"] as! Int
                                                              if Code == 200 {
                                                                   let Data = res["Data"] as! NSDictionary
                                                                 let bus_certif = Data["bus_certif"] as! NSArray
                                                                    let _id  = Data["_id"] as? String ?? ""
                                                                    let bus_profile  = Data["bus_profile"] as? String ?? ""
                                                                    let bus_proof  = Data["bus_proof"] as? String ?? ""
                                                                    let bus_user_email  = Data["bus_user_email"] as? String ?? ""
                                                                    let bus_user_name  = Data["bus_user_name"] as? String ?? ""
                                                                    let bus_user_phone  = Data["bus_user_phone"] as? String ?? ""
                                                                    let bussiness_name  = Data["bussiness_name"] as? String ?? ""
                                                                    let distance  = Data["distance"] as? Double ?? 0.0
                                                                    let fav = Data["fav"] as? Bool ?? false
                                                                    if fav {
                                                                        self.image_fav.image = UIImage(named: imagelink.fav_true)
                                                                    }else {
                                                                        self.image_fav.image = UIImage(named: imagelink.fav_false)
                                                                    }
                                                                    let date_and_time  = Data["date_and_time"] as? String ?? ""
                                                                    let delete_status  = Data["delete_status"] as? Bool ?? false
                                                                    let profile_status  = Data["profile_status"] as? Bool ?? false
                                                                    let profile_verification_status  = Data["profile_verification_status"] as? String ?? ""
                                                                let sp_lat  = Data["sp_lat"] as? Double ?? 0.0
                                                                let sp_long  = Data["sp_long"] as! Double ?? 0.0
                                                                let sp_loc  = Data["sp_loc"] as? String ?? ""
                                                                self.latitude = sp_lat
                                                                self.longitude = sp_long
                                                                self.setmarker(lat: self.latitude, long: self.longitude)
                                                                let user_id  = Data["user_id"] as? String ?? ""
                                                                let bus_service_gall = Data["bus_service_gall"] as! NSArray
                                                                let bus_service_list = Data["bus_service_list"] as! NSArray
                                                                let bus_spec_list = Data["bus_spec_list"] as! NSArray
                                                                let Details = res["Details"] as! NSDictionary
                                                                let Sp_comments  = Data["comments"] as? Int ?? 0
                                                                let Sp_rating  = Data["rating"] as? Int ?? 0
                                                                var dicarray = [Any]()
                                                                dicarray.removeAll()
                                                                dicarray.append(Data)
                                                                Servicefile.shared.service_prov_buss_info.removeAll()
                                                                Servicefile.shared.service_prov_buss_info = dicarray
                                                                Servicefile.shared.service_id = Details["_id"] as? String ?? ""
                                                                Servicefile.shared.service_id_count = Details["count"] as? Int ?? 0
                                                                Servicefile.shared.service_id_image_path = Details["image_path"] as? String ?? ""
                                                                Servicefile.shared.service_id_title = Details["title"] as? String ?? ""
                                                                Servicefile.shared.service_id_amount = Details["amount"] as? Int ?? 0
                                                                Servicefile.shared.service_id_time = Details["time"] as? String ?? ""
                                                                self.label_fee.text = "INR " +  String(Servicefile.shared.service_id_amount)
                                                                
                                                                
                                                                self.label_service.text = Servicefile.shared.service_id_title
                                                                self.image_service.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                                                                       self.image_service.sd_setImage(with: Servicefile.shared.StrToURL(url:  Servicefile.shared.service_id_image_path )) { (image, error, cache, urls) in
                                                                                             if (error != nil) {
                                                                                                 self.image_service.image = UIImage(named: imagelink.sample)
                                                                                             } else {
                                                                                                 self.image_service.image = image
                                                                                             }
                                                                                         }
                                                                
                                                                 Servicefile.shared.Sp_bus_certifdicarray.removeAll()
                                                                 Servicefile.shared.sp_bus_service_galldicarray.removeAll()
                                                                 Servicefile.shared.sp_bus_service_list.removeAll()
                                                                 Servicefile.shared.sp_bus_spec_list.removeAll()
                                                                    Servicefile.shared.sp_id = _id
                                                                    Servicefile.shared.sp_bus_profile = bus_profile
                                                                    Servicefile.shared.sp_bus_proof = bus_proof
                                                                  Servicefile.shared.Sp_bus_certifdicarray =  bus_certif as! [Any]
                                                                    Servicefile.shared.sp_bus_service_galldicarray = bus_service_gall as! [Any]
                                                                    Servicefile.shared.sp_bus_service_list = bus_service_list as! [Any]
                                                                    Servicefile.shared.sp_bus_spec_list = bus_spec_list as! [Any]
                                                                    Servicefile.shared.sp_bus_user_email = bus_user_email
                                                                    Servicefile.shared.sp_bus_user_name = bus_user_name
                                                                    Servicefile.shared.sp_bus_user_phone = bus_user_phone
                                                                    Servicefile.shared.sp_bussiness_name = bussiness_name
                                                                    Servicefile.shared.sp_date_and_time  = date_and_time
                                                                    Servicefile.shared.sp_delete_status = delete_status
                                                                    Servicefile.shared.sp_mobile_type = "IOS"
                                                                    Servicefile.shared.sp_profile_status = profile_status
                                                                    Servicefile.shared.sp_profile_verification_status = profile_verification_status
                                                                    Servicefile.shared.sp_lat = sp_lat
                                                                    Servicefile.shared.sp_loc = sp_loc
                                                                    Servicefile.shared.sp_long = sp_long
                                                                    Servicefile.shared.sp_user_id = user_id
                                                                    Servicefile.shared.sp_distance = String(distance)
                                                                Servicefile.shared.Sp_comments = String(Sp_comments)
                                                                Servicefile.shared.Sp_rating = String(Sp_rating)
                                                                self.view_rate.rating = Double(Sp_rating)
                                                                self.label_service_com_name.text = Servicefile.shared.sp_bussiness_name
                                                                self.label_serview_provider.text = bus_user_name
                                                                self.label_location.text = Servicefile.shared.sp_loc
                                                                self.label_distance.text = String(Servicefile.shared.pet_SP_service_details[Servicefile.shared.service_index].distance) + " Km away"
                                                                
                                                                self.col_pet_ser.reloadData()
                                                                //self.label_description.text = ""
                                                                self.coll_service.reloadData()
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

}


