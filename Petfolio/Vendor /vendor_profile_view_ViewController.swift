//
//  vendor_profile_view_ViewController.swift
//  Petfolio
//
//  Created by Admin on 07/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class vendor_profile_view_ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var view_img_user: UIView!
    @IBOutlet weak var View_profile: UIView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_phono: UILabel!
    @IBOutlet weak var label_sp_bussinessname: UILabel!
    @IBOutlet weak var label_bussiness: UILabel!
    
    @IBOutlet weak var view_header: petowner_otherpage_header!
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var coll_bussi_img: UICollectionView!
    @IBOutlet weak var label_business_email: UILabel!
    @IBOutlet weak var label_business_phone: UILabel!
    
    var ismenu = ["0"]
    var isorgi = ["0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.inital_setup()
        self.view_footer.view_cornor()
        self.view_img_user.view_cornor()
        self.coll_bussi_img.delegate = self
        self.coll_bussi_img.dataSource = self
    }
    
    func inital_setup(){
        // header action
            self.view_header.label_header_title.text = "Profile"
            self.view_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
            self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_header.btn_profile.addTarget(self, action: #selector(self.vendorprofile), for: .touchUpInside)
        self.view_header.btn_bel.addTarget(self, action: #selector(self.notification), for: .touchUpInside)
            self.view_header.view_sos.isHidden = true
            self.view_header.view_bag.isHidden = true
        // header action
        self.view_footer.setup(b1: true, b2: false, b3: false)
        self.view_footer.label_Fprocess_two.text = "Manage Products"
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.vendorproduct), for: .touchUpInside)
       // self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
    }
    
    @IBAction func action_home(_ sender: Any) {
        let vc = UIStoryboard.Sp_dash_ViewController()
                                 self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.call_vendor_details()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                           UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                           Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
         Servicefile.shared.pet_status = ""
        self.ismenu.removeAll()
        Servicefile.shared.pet_petlist.removeAll()
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.label_phono.text = Servicefile.shared.user_phone
        if Servicefile.shared.userimage == "" {
                   self.imag_user.image = UIImage(named: imagelink.sample)
               }else{
                   self.imag_user.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.userimage)) { (image, error, cache, urls) in
                       if (error != nil) {
                           self.imag_user.image = UIImage(named: imagelink.sample)
                       } else {
                           self.imag_user.image = image
                       }
                   }
               }
        self.imag_user.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
    }
    
    @IBAction func action_upload_image(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileimageuploadViewController") as! ProfileimageuploadViewController
                      self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.Sp_profile_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
         
         @IBAction func action_notifi(_ sender: Any) {
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
                    self.present(vc, animated: true, completion: nil)
         }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return Servicefile.shared.vendor_gallary_img.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
           let img = Servicefile.shared.vendor_gallary_img[indexPath.row] as! NSDictionary
           let imgval = img["bussiness_gallery"]  as? String ?? Servicefile.sample_img
            cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: imgval)) { (image, error, cache, urls) in
                                  if (error != nil) {
                                      cell.img_banner.image = UIImage(named: imagelink.sample)
                                  } else {
                                      cell.img_banner.image = image
                                  }
                              }
           cell.img_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.view_banner.view_cornor()
        cell.view_banner_two.view_cornor()
           return cell
       }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.coll_bussi_img.frame.size.width , height:  self.coll_bussi_img.frame.size.height)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_profile_edit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile_edit_ViewController") as! profile_edit_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
   
    @IBAction func action_bussi_edit(_ sender: Any) {
        let vc = UIStoryboard.vendor_edit_profile_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
   
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func action_manageaddress(_ sender: Any) {
        
    }
    
    func call_vendor_details(){
     Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
      Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
           self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_getlistid, method: .post, parameters:
        [   "user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                               switch (response.result) {
                                               case .success:
                                                     let res = response.value as! NSDictionary
                                                     print("success data",res)
                                                     let Code  = res["Code"] as! Int
                                                     if Code == 200 {
                                                        let Data = res["Data"] as! NSDictionary
                                                        let id =  Data["_id"] as? String ?? ""
                                                        let business_reg =  Data["business_reg"] as? String ?? ""
                                                        let bussiness =  Data["bussiness"] as? String ?? ""
                                                        let bus_service_gall = Data["bussiness_gallery"] as! NSArray
                                                        Servicefile.shared.vendor_gallary_img = bus_service_gall as! [Any]
                                                        let bussiness_lat = Data["bussiness_lat"] as? String ?? ""
                                                        let bussiness_long = Data["bussiness_long"] as? String ?? ""
                                                        let bussiness_loc = Data["bussiness_loc"] as? String ?? ""
                                                        let bus_certif = Data["certifi"] as! NSArray
                                                        let date_and_time = Data["date_and_time"] as? String ?? ""
                                                        let delete_status = Data["delete_status"] as? String ?? ""
                                                        let govt_id_proof = Data["govt_id_proof"] as? String ?? ""
                                                        let mobile_type = Data["mobile_type"] as? String ?? ""
                                                        let photo_id_proof = Data["photo_id_proof"] as? String ?? ""
                                                        let profile_status = Data["profile_status"] as? String ?? ""
                                                        let profile_verification_status = Data["profile_verification_status"] as? String ?? ""
                                                        let user_email = Data["user_email"] as? String ?? ""
                                                        let user_id = Data["user_id"] as? String ?? ""
                                                        let user_name = Data["user_name"] as? String ?? ""
                                                        
                                                        self.label_bussiness.text = Data["bussiness"] as? String ?? ""
                                                        self.label_business_email.text =  Data["bussiness_email"] as? String ?? ""
                                                        self.label_business_phone.text = Data["bussiness_phone"] as? String ?? ""
                                                        self.coll_bussi_img.reloadData()
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
