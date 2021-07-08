//
//  petprofileViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 08/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class petprofileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var view_img: UIView!
    @IBOutlet weak var View_profile: UIView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_phono: UILabel!
    @IBOutlet weak var coll_petlist: UICollectionView!
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    var ismenu = ["0"]
    var isorgi = ["0"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.intial_setup_action()
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Profile"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.backpage), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        //self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        self.view_footer.setup(b1: false, b2: false, b3: true, b4: false, b5: false)
    // footer action
    }
    
    @IBAction func action_care(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
       }
    
    
    @IBAction func action_notification(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
             Servicefile.shared.pet_status = ""
             self.ismenu.removeAll()
             self.isorgi.removeAll()
             self.view_footer.view_cornor()
             Servicefile.shared.pet_petlist.removeAll()
             self.coll_petlist.delegate = self
             self.coll_petlist.dataSource = self
             self.callpetdash()
             
             self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
             self.label_email.text = Servicefile.shared.user_email
             self.label_phono.text = Servicefile.shared.user_phone
        
        if Servicefile.shared.userimage == "" {
            self.imag_user.image = UIImage(named: imagelink.sample)
        }else{
            self.imag_user.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.imag_user.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.userimage)) { (image, error, cache, urls) in
                if (error != nil) {
                    self.imag_user.image = UIImage(named: imagelink.sample)
                } else {
                    self.imag_user.image = image
                }
            }
        }
        self.imag_user.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.view_img.View_image_dropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle: false)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
             return Servicefile.shared.pet_petlist.count
        }else{
            return 1
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! petloverProfilepetlistCollectionViewCell
            cell.label_petname.text = Servicefile.shared.pet_petlist[indexPath.row].pet_name
            if Servicefile.shared.pet_petlist[indexPath.row].pet_img.count > 0 {
                let petdic = Servicefile.shared.pet_petlist[indexPath.row].pet_img[0] as! NSDictionary
                let petimg =  petdic["pet_img"] as? String ?? Servicefile.sample_img
                if petimg == "" {
                    cell.imag_profile.image = UIImage(named: imagelink.sample)
                }else{
                    cell.imag_profile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                    cell.imag_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: petimg)) { (image, error, cache, urls) in
                        if (error != nil) {
                            cell.imag_profile.image = UIImage(named: imagelink.sample)
                        } else {
                            cell.imag_profile.image = image
                        }
                    }
                }
            }else{
                cell.imag_profile.image = UIImage(named: imagelink.sample)
            }
            
            cell.imag_profile.view_cornor()
            if self.ismenu[indexPath.row] == "1"{
               cell.View_menu.isHidden = false
            }else{
                cell.View_menu.isHidden = true
            }
            cell.view_main.view_cornor()
            cell.btn_menu.tag = indexPath.row
            cell.btn_menu.addTarget(self, action: #selector(action_clickmenu), for: .touchUpInside)
//            cell.btn_edit.tag = indexPath.row
//            cell.btn_edit.addTarget(self, action: #selector(action_clickedit), for: .touchUpInside)
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(action_clickdelete), for: .touchUpInside)
//            cell.btn_healthrecord.tag = indexPath.row
//            cell.btn_healthrecord.addTarget(self, action: #selector(action_healthrecord), for: .touchUpInside)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellimg", for: indexPath) as! petaddimgCollectionViewCell
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if indexPath.section == 1 {
            Servicefile.shared.pet_index = 0
            Servicefile.shared.pet_status = "Add"
            Servicefile.shared.pet_save_for = "p"
            let vc = UIStoryboard.petloverEditandAddViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func action_clickmenu(sender: UIButton){
        let tag = sender.tag
        self.ismenu = self.isorgi
        self.ismenu.remove(at: tag)
        self.ismenu.insert("1", at: tag)
        self.coll_petlist.reloadData()
    }
    
    @objc func action_clickedit(sender: UIButton){
           let tag = sender.tag
        Servicefile.shared.pet_status = "edit"
        Servicefile.shared.pet_index = tag
        let vc = UIStoryboard.petloverEditandAddViewController()
        self.present(vc, animated: true, completion: nil)
       }
    
    @objc func action_clickdelete(sender: UIButton){
              let tag = sender.tag
              Servicefile.shared.pet_index = tag
        let alert = UIAlertController(title: "", message: "Are you sure you need to delete pet details", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.calldeleteaddress(id: Servicefile.shared.pet_petlist[Servicefile.shared.pet_index].id)
                    }))
                alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { action in
        
            }))
               self.present(alert, animated: true, completion: nil)
                
          }
    
    @objc func action_healthrecord(sender: UIButton){
                 let tag = sender.tag
                
             }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 168 , height:  168)
    }
    
    @objc func backpage(){
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_editprofile(_ sender: Any) {
        let vc = UIStoryboard.profile_edit_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_myaddress(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "myaddresslistViewController") as!  myaddresslistViewController
//        self.present(vc, animated: true, completion: nil)
       
    }
    
    @IBAction func action_manageaddress(_ sender: Any) {
        let vc = UIStoryboard.petManageaddressViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_upload_pic(_ sender: Any) {
        let vc = UIStoryboard.ProfileimageuploadViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func calldeleteaddress(id : String){
           self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_deletedetails, method: .post, parameters:
               ["_id": id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                   switch (response.result) {
                   case .success:
                       let res = response.value as! NSDictionary
                       print("success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                           self.ismenu = self.isorgi
                            self.callpetdash()
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
                                                            let thumbnail_image = Bval["thumbnail_image"] as? String ?? ""
                                                            Servicefile.shared.petdoc.append(Petnewdashdoc.init(UID: id, doctor_img: imgpath, doctor_name: title, review_count: review_count, star_count: star_count, ispec: spec, idistance: distance, Iclinic_name: clinic_name, Ifav: fav, Ithumbnail_image: thumbnail_image))
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
                                                            for itm in 0..<Servicefile.shared.pet_petlist.count{
                                                                       self.ismenu.append("0")
                                                                   }
                                                            self.isorgi = self.ismenu
                                                            self.coll_petlist.reloadData()
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
