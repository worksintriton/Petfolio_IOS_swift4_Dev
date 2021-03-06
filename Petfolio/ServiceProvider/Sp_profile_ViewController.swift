//
//  Sp_profile_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class Sp_profile_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var view_img_user: UIView!
    @IBOutlet weak var View_profile: UIView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_phono: UILabel!
    @IBOutlet weak var label_sp_bussinessname: UILabel!
    @IBOutlet weak var label_special: UILabel!
    @IBOutlet weak var label_myservices: UILabel!
    
    @IBOutlet weak var view_header: petowner_otherpage_header!
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var coll_bussi_img: UICollectionView!
    
    var ismenu = ["0"]
    var isorgi = ["0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.intial_setup_action()
        self.view_footer.view_cornor()
        self.view_img_user.view_cornor()
        self.coll_bussi_img.delegate = self
        self.coll_bussi_img.dataSource = self
    }
    
    
    func intial_setup_action(){
        // header action
        self.view_header.label_header_title.text = "Profile"
        self.view_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_header.view_profile.isHidden = true
        self.view_header.view_sos.isHidden = true
        self.view_header.view_bel.isHidden = true
        self.view_header.view_bag.isHidden = true
        // header action
        // footer action
        self.view_footer.setup(b1: true, b2: false, b3: false)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.spshop), for: .touchUpInside)
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.spDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        // footer action
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.callSp_details()
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
    }
    
    @IBAction func action_upload_image(_ sender: Any) {
        let vc = UIStoryboard.ProfileimageuploadViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.Sp_profile_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_notifi(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.sp_bus_service_galldicarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
        let img = Servicefile.shared.sp_bus_service_galldicarray[indexPath.row] as! NSDictionary
        let imgval = img["bus_service_gall"]  as? String ?? Servicefile.sample_img
        cell.img_banner.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: imgval)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.img_banner.image = UIImage(named: "sample")
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
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_profile_edit(_ sender: Any) {
        let vc = UIStoryboard.profile_edit_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_bussi_edit(_ sender: Any) {
        let vc = UIStoryboard.Sp_profile_edit_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func action_manageaddress(_ sender: Any) {
        let vc = UIStoryboard.sp_manageaddressViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func callSp_details(){
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.sp_dash_get, method: .post, parameters:
                                                                    [   "user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
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
                                                                                let date_and_time  = Data["date_and_time"] as? String ?? ""
                                                                                let delete_status  = Data["delete_status"] as? Bool ?? false
                                                                                let profile_status  = Data["profile_status"] as? Bool ?? false
                                                                                let profile_verification_status  = Data["profile_verification_status"] as? String ?? ""
                                                                                let sp_lat  = Data["sp_lat"] as? Double ?? 0.0
                                                                                let sp_long  = Data["sp_long"] as? Double ?? 0.0
                                                                                let sp_loc  = Data["sp_loc"] as? String ?? ""
                                                                                let user_id  = Data["user_id"] as? String ?? ""
                                                                                let bus_service_gall = Data["bus_service_gall"] as! NSArray
                                                                                let bus_service_list = Data["bus_service_list"] as! NSArray
                                                                                let bus_spec_list = Data["bus_spec_list"] as! NSArray
                                                                                var serv = ""
                                                                                for itm in 0..<bus_service_list.count{
                                                                                    let datser = bus_service_list[itm] as! NSDictionary
                                                                                    let valser = datser["bus_service_list"] as? String ?? ""
                                                                                    if itm == 0 {
                                                                                        serv = valser
                                                                                    }else{
                                                                                        serv =  serv + ", " + valser
                                                                                    }
                                                                                }
                                                                                self.label_myservices.text = serv
                                                                                var spec = ""
                                                                                for itspec in 0..<bus_spec_list.count{
                                                                                    let datspec = bus_spec_list[itspec] as! NSDictionary
                                                                                    let valspec = datspec["bus_spec_list"] as? String ?? ""
                                                                                    if itspec == 0 {
                                                                                        spec = valspec
                                                                                    }else{
                                                                                        spec = spec + ", " + valspec
                                                                                    }
                                                                                }
                                                                                self.label_special.text = spec
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
                                                                                self.label_sp_bussinessname.text = bussiness_name
                                                                                Servicefile.shared.sp_date_and_time  = date_and_time
                                                                                Servicefile.shared.sp_delete_status = delete_status
                                                                                Servicefile.shared.sp_mobile_type = "IOS"
                                                                                Servicefile.shared.sp_profile_status = profile_status
                                                                                Servicefile.shared.sp_profile_verification_status = profile_verification_status
                                                                                Servicefile.shared.sp_lat = sp_lat
                                                                                Servicefile.shared.sp_loc = sp_loc
                                                                                Servicefile.shared.sp_long = sp_long
                                                                                Servicefile.shared.sp_user_id = user_id
                                                                                self.coll_bussi_img.reloadData()
                                                                                print("Details in certificate",Servicefile.shared.Sp_bus_certifdicarray)
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
