//
//  searchpetappdetailViewController.swift
//  Petfolio
//
//  Created by Admin on 23/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class searchpetappdetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var label_hey_name: UILabel!
    @IBOutlet weak var col_app_pet: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.callpetdash()
        Servicefile.shared.pet_type_val = ""
        Servicefile.shared.Pet_breed_val = ""
        self.label_hey_name.text = "Hey " + Servicefile.shared.first_name + ","
        let nibName = UINib(nibName: "getpettypeCollectionViewCell", bundle:nil)
        self.col_app_pet.register(nibName, forCellWithReuseIdentifier: "cell")
        self.col_app_pet.delegate = self
        self.col_app_pet.dataSource = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.pet_petlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! getpettypeCollectionViewCell
        cell.label_title.text = Servicefile.shared.pet_petlist[indexPath.row].pet_name
        if Servicefile.shared.pet_petlist[indexPath.row].pet_img.count > 0 {
            let petdic = Servicefile.shared.pet_petlist[indexPath.row].pet_img[0] as! NSDictionary
            let petimg =  petdic["pet_img"] as? String ?? Servicefile.sample_img
            if petimg == "" {
                cell.image_data.image = UIImage(named: "sample")
            }else{
                cell.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: petimg)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_data.image = UIImage(named: "sample")
                    } else {
                        cell.image_data.image = image
                    }
                }
            }
        }else{
            cell.image_data.image = UIImage(named: "sample")
        }
        
        cell.image_data.view_cornor()
        cell.view_main.view_cornor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.pet_index = indexPath.row
        Servicefile.shared.petlistimg = Servicefile.shared.pet_petlist[indexPath.row].pet_img
        Servicefile.shared.pet_type_val = Servicefile.shared.pet_petlist[indexPath.row].pet_type
        Servicefile.shared.Pet_breed_val = Servicefile.shared.pet_petlist[indexPath.row].pet_breed
        let vc = UIStoryboard.searchhealthlistViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 168 , height:  168)
    }
    
    @IBAction func action_addpetdetails(_ sender: Any) {
        
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func callpetdash(){
      
              self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petdashboard, method: .post, parameters:
           [   "user_id" : Servicefile.shared.userid,
           "lat" : Servicefile.shared.pet_dash_lati,
           "long" : Servicefile.shared.pet_dash_long,
           "user_type" : 1 ,
           "address" : Servicefile.shared.pet_dash_address], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                                                           Servicefile.shared.user_email = user_details["user_email"] as? String ?? ""
                                                           Servicefile.shared.user_phone = user_details["user_phone"] as? String ?? ""
                                                           Servicefile.shared.user_type = String(user_details["user_type"] as? Int ?? 0)
                                                          Servicefile.shared.date_of_reg = user_details["date_of_reg"] as? String ?? ""
                                                          Servicefile.shared.otp = String(user_details["otp"] as? Int ?? 0)
                                                          Servicefile.shared.email_status = user_details["user_email_verification"] as? Bool ?? false
                                                          let userid = user_details["_id"] as? String ?? ""
                                                          UserDefaults.standard.set(userid, forKey: "userid")
                                                           Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                                                          print("user id",Servicefile.shared.userid)
                                                           Servicefile.shared.petbanner.removeAll()
                                                           let LocationDetails = Data["LocationDetails"] as! NSArray
                                                          
                                                           let Banner_details = dash["Banner_details"] as! NSArray
                                                           for item in 0..<Banner_details.count {
                                                               let Bval = Banner_details[item] as! NSDictionary
                                                               let id = Bval["_id"] as? String ?? ""
                                                               let imgpath = Bval["img_path"] as? String ?? Servicefile.sample_img
                                                               let title =  Bval["title"] as? String ?? ""
                                                               Servicefile.shared.petbanner.append(Petdashbanner.init(UID: id, img_path: imgpath, title: title))
                                                           }
                                                           Servicefile.shared.petdoc.removeAll()
                                                           let Doctor_details = dash["Doctor_details"] as! NSArray
                                                           for item in 0..<Doctor_details.count {
                                                               let Bval = Doctor_details[item] as! NSDictionary
                                                               let id = Bval["_id"] as? String ?? ""
                                                               let imgpath = Bval["doctor_img"] as? String ?? ""
                                                               let title =  Bval["doctor_name"] as? String ?? ""
                                                               let review_count =  Bval["review_count"] as? Int ?? 0
                                                                let star_count =  Bval["star_count"] as? Int ?? 0
                                                               let distance = Bval["distance"] as? String ?? ""
                                                               let specialization = Bval["specialization"] as! NSArray
                                                               let Dicspec = specialization[specialization.count-1] as! NSDictionary
                                                               var spec = Dicspec["specialization"] as? String ?? ""
                                                            let clinic_name = Bval["clinic_name"] as? String ?? ""
                                                            let fav = Bval["fav"] as? Bool ?? false
                                                            Servicefile.shared.petdoc.append(Petnewdashdoc.init(UID: id, doctor_img: imgpath, doctor_name: title, review_count: review_count, star_count: star_count, ispec: spec, idistance: distance, Iclinic_name: clinic_name, Ifav: fav))
                                                           }
                                                           Servicefile.shared.petprod.removeAll()
                                                           let Products_details = dash["Products_details"] as! NSArray
                                                           for item in 0..<Products_details.count {
                                                               let Bval = Products_details[item] as! NSDictionary
//                                                               let id = Bval["_id"] as! String
//                                                               let product_fav_status = Bval["product_fav_status"] as! Bool
//                                                               let product_offer_status =  Bval["product_offer_status"] as! Bool
//                                                               let product_offer_value =  Bval["product_offer_value"] as! Int
//                                                               let product_prices =  Bval["product_prices"] as! Int
//                                                               let product_rate =  String(Double(Bval["product_rate"] as! NSNumber))
//                                                               let product_title =  Bval["product_title"] as! String
//                                                               let products_img =  Bval["products_img"] as! String
//                                                               let review_count =  Bval["review_count"] as! Int
//                                                               Servicefile.shared.petprod.append(Petdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count))
                                                            let id = Bval["_id"] as? String ?? ""
                                                             let delete_status = Bval["delete_status"] as? Bool ?? false
                                                             let show_status =  Bval["show_status"] as? Bool ?? false
                                                             let img_index =  Bval["img_index"] as? Int ?? 0
                                                             let product_title =  Bval["product_cate"] as? String ?? ""
                                                             let products_img =  Bval["img_path"] as? String ?? Servicefile.sample_img
                                                            
                                                             Servicefile.shared.petprod.append(Petdashproduct.init(I_id: id, Idelete_status: delete_status, Ishow_status: show_status, Iimg_index: img_index, Iproduct_title: product_title, Iproducts_img: products_img))
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
                                                            self.col_app_pet.reloadData()
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
