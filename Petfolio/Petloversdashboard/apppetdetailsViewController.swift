//
//  apppetdetailsViewController.swift
//  Petfolio
//
//  Created by Admin on 23/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class apppetdetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
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
                cell.image_data.image = UIImage(named: imagelink.sample)
            }else{
                cell.image_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: petimg)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_data.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.image_data.image = image
                    }
                }
            }
        }else{
            cell.image_data.image = UIImage(named: imagelink.sample)
        }
        cell.img_ischeckbox.isHidden = true
        cell.image_data.view_cornor()
        cell.view_main.view_cornor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.pet_index = indexPath.row
        Servicefile.shared.petlistimg = Servicefile.shared.pet_petlist[indexPath.row].pet_img
        Servicefile.shared.pet_type_val = Servicefile.shared.pet_petlist[indexPath.row].pet_type
        Servicefile.shared.Pet_breed_val = Servicefile.shared.pet_petlist[indexPath.row].pet_breed
        let vc = UIStoryboard.pethealthissueViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 168 , height:  168)
    }
    
    @IBAction func action_addpetdetails(_ sender: Any) {
        Servicefile.shared.pet_index = 0
        Servicefile.shared.pet_status = "Add"
        Servicefile.shared.pet_save_for = "d"
        let vc = UIStoryboard.petloverEditandAddViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        let vc = UIStoryboard.petdoccalenderViewController()
        self.present(vc, animated: true, completion: nil)
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
