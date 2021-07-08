//
//  pet_medical_history_ViewController.swift
//  Petfolio
//
//  Created by Admin on 11/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class pet_medical_history_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var col_pet_list: UICollectionView!
    @IBOutlet weak var tbl_medihislist: UITableView!
    var orgidata = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        Servicefile.shared.pet_medi_detail.removeAll()
        Servicefile.shared.pet_petlist.removeAll()
        let nibName = UINib(nibName: "medi_pet_CollectionViewCell", bundle:nil)
        self.col_pet_list.register(nibName, forCellWithReuseIdentifier: "cell")
        self.tbl_medihislist.register(UINib(nibName: "select_medi_TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tbl_medihislist.register(UINib(nibName: "unselect_medi_TableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.intial_setup_action()
        self.tbl_medihislist.delegate = self
        self.tbl_medihislist.dataSource = self
        self.col_pet_list.delegate = self
        self.col_pet_list.dataSource = self
        self.callpetdash()
       
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Health Records"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: true, b2: false, b3: true, b4: false)
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: false, b2: false, b3: false, b4: false, b5: false)
    // footer action
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.pet_medi_detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Servicefile.shared.pet_medi_detail[indexPath.row].isselct == "0" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! select_medi_TableViewCell
            cell.image_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_medi_detail[indexPath.row].vet_image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_data.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_data.image = image
                }
            }
            cell.label_doc.text =  Servicefile.shared.pet_medi_detail[indexPath.row].vet_name
            cell.label_pet.text = Servicefile.shared.pet_medi_detail[indexPath.row].pet_name
            cell.label_dateandtime.text = Servicefile.shared.pet_medi_detail[indexPath.row].appointment_date
            cell.image_data.layer.cornerRadius = 8.0
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! unselect_medi_TableViewCell
            cell.image_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_medi_detail[indexPath.row].vet_image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.image_data.image = UIImage(named: imagelink.sample)
                } else {
                    cell.image_data.image = image
                }
            }
            cell.label_doc.text =  Servicefile.shared.pet_medi_detail[indexPath.row].vet_name
            cell.label_pet.text = Servicefile.shared.pet_medi_detail[indexPath.row].pet_name
            cell.label_dateandtime.text = Servicefile.shared.pet_medi_detail[indexPath.row].appointment_date
            cell.label_allergi.text = Servicefile.shared.pet_medi_detail[indexPath.row].allergies
            cell.label_vaccinba.text = String(Servicefile.shared.pet_medi_detail[indexPath.row].vacination)
            cell.label_commu.text = Servicefile.shared.pet_medi_detail[indexPath.row].communication_type
            cell.label_prescrip.text = Servicefile.shared.pet_medi_detail[indexPath.row].prescrip_type
            cell.view_download.view_cornor()
            cell.btn_download.tag = indexPath.row
            cell.btn_download.addTarget(self, action: #selector(action_downlaod), for: .touchUpInside)
            cell.image_data.layer.cornerRadius = 8.0
            return cell
        }
    }
    
    @objc func action_downlaod(sender: UIButton){
        let tag = sender.tag
        self.callpescription(Appointment_ID: Servicefile.shared.pet_medi_detail[tag].appointement_id)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.orgidata = Servicefile.shared.pet_medi_detail
        if Servicefile.shared.pet_medi_detail[indexPath.row].isselct != "0" {
            Servicefile.shared.pet_medi_detail[indexPath.row].isselct = "0"
        }else{
            Servicefile.shared.pet_medi_detail[indexPath.row].isselct = "1"
        }
        self.tbl_medihislist.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  Servicefile.shared.pet_medi_detail[indexPath.row].isselct != "0"  {
            return 230
        }else{
            return 120
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.pet_petlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! medi_pet_CollectionViewCell
        if Servicefile.shared.pet_petlist[indexPath.row].pet_img.count > 0{
            let pet_img = Servicefile.shared.pet_petlist[indexPath.row].pet_img.last as! NSDictionary
            let pet_im = pet_img["pet_img"] as? String ?? ""
            if  pet_im != "" {
                cell.image_pet.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.image_pet.sd_setImage(with: Servicefile.shared.StrToURL(url: pet_im)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_pet.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.image_pet.image = image
                    }
                }
            }else{
                cell.image_pet.image = UIImage(named: imagelink.sample)
            }
        }else{
            cell.image_pet.image = UIImage(named: imagelink.sample)
        }
        cell.view_pet.view_cornor()
        cell.image_pet.view_cornor()
        cell.label_pet.text =  Servicefile.shared.pet_petlist[indexPath.row].pet_name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Servicefile.shared.petid", Servicefile.shared.petid)
        Servicefile.shared.petid = Servicefile.shared.pet_petlist[indexPath.row].id
        self.callpet_appdetails()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 130 , height:  130)
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
                                                            let fav = Bval["fav"] as? Bool ?? false
                                                            let clinic_name = Bval["clinic_name"] as? String ?? ""
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
                                                            
                                                            if Servicefile.shared.pet_petlist.count > 0 {
                                                                Servicefile.shared.petid = Servicefile.shared.pet_petlist[0].id
                                                                self.callpet_appdetails()
                                                            }
                                                                
                                                           
                                                            self.col_pet_list.reloadData()
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
    
   
    func callpet_appdetails(){
      
              self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sidemenu_medicalhistory, method: .post, parameters:
           [   "user_id" : Servicefile.shared.userid,
               "pet_id": Servicefile.shared.petid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                  switch (response.result) {
                                                  case .success:
                                                        let res = response.value as! NSDictionary
                                                        print("selected pet id success data",res)
                                                        let Code  = res["Code"] as! Int
                                                    if Code == 200 {
                                                        let Data = res["Data"] as! NSArray
                                                        Servicefile.shared.pet_medi_detail.removeAll()
                                                        for i in 0..<Data.count {
                                                            let D_dic = Data[i] as! NSDictionary
                                                            let allergies = D_dic["allergies"] as? String ?? ""
                                                            let appointement_id = D_dic["appointement_id"] as? String ?? ""
                                                            let appointment_date = D_dic["appointment_date"] as? String ?? ""
                                                            let communication_type = D_dic["communication_type"] as? String ?? ""
                                                            let pet_id = D_dic["pet_id"] as? String ?? ""
                                                            let pet_name = D_dic["pet_name"] as? String ?? ""
                                                            let prescrip_type = D_dic["prescrip_type"] as? String ?? ""
                                                            let vacination = D_dic["vacination"] as? Bool ?? false
                                                            let vet_image = D_dic["vet_image"] as? String ?? Servicefile.sample_img
                                                            let vet_name = D_dic["vet_name"] as? String ?? ""
                                                            let vet_spec = D_dic["vet_spec"] as? [Any]
                                                            let isselect = "0"
                                                            Servicefile.shared.pet_medi_detail.append(pet_medi_details.init(In_allergies: allergies, In_appointement_id: appointement_id, In_appointment_date: appointment_date, In_communication_type: communication_type, In_pet_id: pet_id, In_pet_name: pet_name, In_prescrip_type: prescrip_type, In_vacination: vacination, In_vet_image: vet_image, In_vet_name: vet_name, In_vet_spec: vet_spec!, In_isselct: isselect))
                                                        }
                                                        self.orgidata = Servicefile.shared.pet_medi_detail
                                                        self.tbl_medihislist.reloadData()
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
    
    
    func callpescription(Appointment_ID:String){
    print("data in prescription")
             Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
            self.startAnimatingActivityIndicator()
      if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.view_prescription_create, method: .post, parameters: [
        "Appointment_ID": Appointment_ID]
           , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                         let Data = res["Data"] as! NSDictionary
                                                        let Prescription_data = Data["PDF_format"] as? String ?? ""
                                                        let url = Servicefile.shared.StrToURL(url: Prescription_data)
                                                        self.loadFileAsync(url: url) { (str, erro) in
                                                            print("downloaded pdf",str, erro)
                                                        }
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
    
    func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
    
}
