//
//  pet_sp_service_details_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 08/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_sp_service_details_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var label_service_com_name: UILabel!
    @IBOutlet weak var label_serview_provider: UILabel!
    @IBOutlet weak var coll_service: UICollectionView!
    @IBOutlet weak var label_location: UILabel!
    @IBOutlet weak var label_distance: UILabel!
    @IBOutlet weak var label_nooflikes: UILabel!
    @IBOutlet weak var label_rating: UILabel!
    @IBOutlet weak var label_description: UILabel!
    @IBOutlet weak var image_service: UIImageView!
    @IBOutlet weak var label_service: UILabel!
    @IBOutlet weak var view_book: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_ser_details()
        self.coll_service.delegate = self
        self.coll_service.dataSource = self
        self.image_service.layer.cornerRadius = self.image_service.frame.size.height / 2
        self.view_book.layer.cornerRadius = 10
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.sp_bus_service_galldicarray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
        let bannerdic = Servicefile.shared.sp_bus_service_galldicarray[indexPath.row] as! NSDictionary
        let image = bannerdic["bus_service_gall"] as! String
                   cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: image)) { (image, error, cache, urls) in
                       if (error != nil) {
                           cell.img_banner.image = UIImage(named: "sample")
                       } else {
                           cell.img_banner.image = image
                       }
                   }
                   cell.img_banner.layer.cornerRadius = 5.0
        return cell
    }
    
    
    
    
    @IBAction func action_book(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_sp_calender_ViewController") as! pet_sp_calender_ViewController
                     self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_home(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
        self.present(vc, animated: true, completion: nil)
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
                                                                    let _id  = Data["_id"] as! String
                                                                    let bus_profile  = Data["bus_profile"] as! String
                                                                    let bus_proof  = Data["bus_proof"] as! String
                                                                    let bus_user_email  = Data["bus_user_email"] as! String
                                                                    let bus_user_name  = Data["bus_user_name"] as! String
                                                                    let bus_user_phone  = Data["bus_user_phone"] as! String
                                                                    let bussiness_name  = Data["bussiness_name"] as! String
                                                                    let distance  = Data["distance"] as! Int
                                                                    let date_and_time  = Data["date_and_time"] as! String
                                                                    let delete_status  = Data["delete_status"] as! Bool
                                                                    let profile_status  = Data["profile_status"] as! Bool
                                                                    let profile_verification_status  = Data["profile_verification_status"] as! String
                                                                    let sp_lat  = Data["sp_lat"] as! Double
                                                                    let sp_long  = Data["sp_long"] as! Double
                                                                    let sp_loc  = Data["sp_loc"] as! String
                                                                    let user_id  = Data["user_id"] as! String
                                                                    let bus_service_gall = Data["bus_service_gall"] as! NSArray
                                                                    let bus_service_list = Data["bus_service_list"] as! NSArray
                                                                let bus_spec_list = Data["bus_spec_list"] as! NSArray
                                                                let Details = res["Details"] as! NSDictionary
                                                                let Sp_comments  = Data["distance"] as! Int
                                                                let Sp_rating  = Data["distance"] as! Int
                                                                var dicarray = [Any]()
                                                                dicarray.removeAll()
                                                                dicarray.append(Data)
                                                                Servicefile.shared.service_prov_buss_info.removeAll()
                                                                Servicefile.shared.service_prov_buss_info = dicarray
                                                                Servicefile.shared.service_id = Details["_id"] as! String
                                                                Servicefile.shared.service_id_count = Details["count"] as! Int
                                                                Servicefile.shared.service_id_image_path = Details["image_path"] as! String
                                                                Servicefile.shared.service_id_title = Details["title"] as! String
                                                                Servicefile.shared.service_id_amount = String(Details["amount"] as! Int)
                                                                Servicefile.shared.service_id_time = Details["time"] as! String
                                                                
                                                                
                                                                
                                                                self.label_service.text = Servicefile.shared.service_id_title
                                                                       self.image_service.sd_setImage(with: Servicefile.shared.StrToURL(url:  Servicefile.shared.service_id_image_path )) { (image, error, cache, urls) in
                                                                                             if (error != nil) {
                                                                                                 self.image_service.image = UIImage(named: "sample")
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
                                                                self.label_service_com_name.text = Servicefile.shared.sp_bussiness_name
                                                                self.label_serview_provider.text = bus_user_name
                                                                self.label_location.text = Servicefile.shared.sp_loc
                                                                self.label_distance.text = Servicefile.shared.sp_distance + " Km away"
                                                                self.label_nooflikes.text = Servicefile.shared.Sp_comments
                                                                self.label_rating.text = Servicefile.shared.Sp_rating
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
         func alert(Message: String){
              let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                   }))
              self.present(alert, animated: true, completion: nil)
          }

}
