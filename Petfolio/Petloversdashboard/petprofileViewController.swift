//
//  petprofileViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 08/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire


class petprofileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var View_profile: UIView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_phono: UILabel!
    @IBOutlet weak var coll_petlist: UICollectionView!
    @IBOutlet weak var view_footer: UIView!
    var ismenu = ["0"]
    var isorgi = ["0"]
    override func viewDidLoad() {
        super.viewDidLoad()
         Servicefile.shared.pet_status = ""
        self.ismenu.removeAll()
        self.view_footer.layer.cornerRadius = 15.0
        Servicefile.shared.pet_petlist.removeAll()
        self.coll_petlist.delegate = self
        self.coll_petlist.dataSource = self
        self.callpetdash()
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.label_phono.text = Servicefile.shared.user_phone
//        self.imag_user.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petbanner[indexPath.row].img_path)) { (image, error, cache, urls) in
//                       if (error != nil) {
//                           self.imag_user.image = UIImage(named: "sample")
//                       } else {
//                           self.imag_user.image = image
//                       }
//                   }
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
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
            if Servicefile.shared.pet_petlist[indexPath.row].pet_img == "" {
                cell.imag_profile.image = UIImage(named: "sample")
            }else{
                cell.imag_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_petlist[indexPath.row].pet_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.imag_profile.image = UIImage(named: "sample")
                    } else {
                        cell.imag_profile.image = image
                    }
                }
            }
            cell.imag_profile.layer.cornerRadius =  cell.imag_profile.frame.width / 2
            if self.ismenu[indexPath.row] == "1"{
               cell.View_menu.isHidden = false
            }else{
                cell.View_menu.isHidden = true
            }
            cell.btn_menu.tag = indexPath.row
            cell.btn_menu.addTarget(self, action: #selector(action_clickmenu), for: .touchUpInside)
            cell.btn_edit.tag = indexPath.row
            cell.btn_edit.addTarget(self, action: #selector(action_clickedit), for: .touchUpInside)
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(action_clickdelete), for: .touchUpInside)
            cell.btn_healthrecord.tag = indexPath.row
            cell.btn_healthrecord.addTarget(self, action: #selector(action_healthrecord), for: .touchUpInside)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellimg", for: indexPath) as! petaddimgCollectionViewCell
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if indexPath.section == 1 {
            Servicefile.shared.pet_status = "Add"
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverEditandAddViewController") as! petloverEditandAddViewController
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverEditandAddViewController") as! petloverEditandAddViewController
        self.present(vc, animated: true, completion: nil)
       }
    
    @objc func action_clickdelete(sender: UIButton){
              let tag = sender.tag
             
          }
    
    @objc func action_healthrecord(sender: UIButton){
                 let tag = sender.tag
                
             }
       
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 128 , height:  151)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_editprofile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile_edit_ViewController") as! profile_edit_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_manageaddress(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petManageaddressViewController") as! petManageaddressViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func callpetdash(){
              self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petdashboard, method: .post, parameters:
           [   "user_id" : Servicefile.shared.userid,
           "lat" : 12.09090,
           "long" : 80.09093,
           "user_type" : 1 ,
           "address" : "Muthamil nager, Kodugaiyur, Chennai - 600 118"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                  switch (response.result) {
                                                  case .success:
                                                        let res = response.value as! NSDictionary
                                                        print("success data",res)
                                                        let Code  = res["Code"] as! Int
                                                        if Code == 200 {
                                                          let Data = res["Data"] as! NSDictionary
                                                          let dash = Data["Dashboarddata"] as! NSDictionary
                                                          let user_details = Data["userdetails"] as! NSDictionary
                                                           Servicefile.shared.first_name = user_details["first_name"] as! String
                                                           Servicefile.shared.last_name = user_details["last_name"] as! String
                                                           Servicefile.shared.user_email = user_details["user_email"] as! String
                                                           Servicefile.shared.user_phone = user_details["user_phone"] as! String
                                                           Servicefile.shared.user_type = String(user_details["user_type"] as! Int)
                                                          Servicefile.shared.date_of_reg = user_details["date_of_reg"] as! String
                                                          Servicefile.shared.otp = String(user_details["otp"] as! Int)
                                                          let userid = user_details["_id"] as! String
                                                          UserDefaults.standard.set(userid, forKey: "userid")
                                                           Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                                                          print("user id",Servicefile.shared.userid)
                                                           Servicefile.shared.petbanner.removeAll()
                                                           let LocationDetails = Data["LocationDetails"] as! NSArray
                                                          
                                                           let Banner_details = dash["Banner_details"] as! NSArray
                                                           for item in 0..<Banner_details.count {
                                                               let Bval = Banner_details[item] as! NSDictionary
                                                               let id = Bval["_id"] as! String
                                                               let imgpath = Bval["img_path"] as! String
                                                               let title =  Bval["title"] as! String
                                                               Servicefile.shared.petbanner.append(Petdashbanner.init(UID: id, img_path: imgpath, title: title))
                                                           }
                                                           Servicefile.shared.petdoc.removeAll()
                                                           let Doctor_details = dash["Doctor_details"] as! NSArray
                                                           for item in 0..<Doctor_details.count {
                                                               let Bval = Doctor_details[item] as! NSDictionary
                                                               let id = Bval["_id"] as! String
                                                               let imgpath = Bval["doctor_img"] as! String
                                                               let title =  Bval["doctor_name"] as! String
                                                               let review_count =  Bval["review_count"] as! Int
                                                                let star_count =  Bval["star_count"] as! Int
                                                               Servicefile.shared.petdoc.append(Petdashdoc.init(UID: id, doctor_img: imgpath, doctor_name: title, review_count: review_count, star_count: star_count))
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
                                                            let id = Bval["_id"] as! String
                                                             let delete_status = Bval["delete_status"] as! Bool
                                                             let show_status =  Bval["show_status"] as! Bool
                                                             let img_index =  Bval["img_index"] as! Int
                                                             let product_title =  Bval["product_cate"] as! String
                                                             let products_img =  Bval["img_path"] as! String
                                                            
                                                             Servicefile.shared.petprod.append(Petdashproduct.init(I_id: id, Idelete_status: delete_status, Ishow_status: show_status, Iimg_index: img_index, Iproduct_title: product_title, Iproducts_img: products_img))
                                                           }
                                                           Servicefile.shared.petser.removeAll()
                                                           let Service_details = dash["Service_details"] as! NSArray
                                                           for item in 0..<Service_details.count {
                                                               let Bval = Service_details[item] as! NSDictionary
                                                               let id = Bval["_id"] as! String
                                                               let background_color = Bval["background_color"] as! String
                                                               let service_icon =  Bval["service_icon"] as! String
                                                                let service_title =  Bval["service_title"] as! String
                                                               Servicefile.shared.petser.append(Petdashservice.init(UID: id, background_color: background_color, service_icon: service_icon, service_title: service_title))
                                                           }
                                                           
                                                           Servicefile.shared.pet_petlist.removeAll()
                                                           
                                                           let pet_details = Data["PetDetails"] as! NSArray
                                                           for item in 0..<pet_details.count {
                                                               let Bval = pet_details[item] as! NSDictionary
                                                               let id = Bval["_id"] as! String
                                                               let default_status = Bval["default_status"] as! Bool
                                                               let last_vaccination_date = Bval["last_vaccination_date"] as! String
                                                               let pet_age = Bval["pet_age"] as! Int
                                                               let pet_breed = Bval["pet_breed"] as! String
                                                               let pet_color = Bval["pet_color"] as! String
                                                               let pet_gender = Bval["pet_gender"] as! String
                                                               let pet_img = Bval["pet_img"] as! String
                                                               let pet_name = Bval["pet_name"] as! String
                                                               let pet_type = Bval["pet_type"] as! String
                                                               let pet_weight = Bval["pet_weight"] as! Int
                                                               let user_id = Bval["user_id"] as! String
                                                               let vaccinated = Bval["vaccinated"] as! Bool
                                                               Servicefile.shared.pet_petlist.append(petlist.init(in_default_status: default_status, in_last_vaccination_date: last_vaccination_date, in_pet_age: pet_age, in_pet_breed: pet_breed, in_pet_color: pet_color, in_pet_gender: pet_gender, in_pet_img: pet_img, in_pet_name: pet_name, in_pet_type: pet_type, in_pet_weight: pet_weight, in_user_id: user_id, in_vaccinated: vaccinated, in_id: id))
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
    
    func alert(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
             }))
        self.present(alert, animated: true, completion: nil)
    }
}
