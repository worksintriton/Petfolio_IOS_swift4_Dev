//
//  pet_dashfooter_servicelist_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 06/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class pet_dashfooter_servicelist_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet weak var coll_servicelist: UICollectionView!
    @IBOutlet weak var view_header: petowner_header!
    @IBOutlet weak var view_footer: petowner_footerview!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
        if Servicefile.shared.pet_servicecat.count == 0 {
            self.call_service_cat()
        }
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.coll_servicelist.addSubview(refreshControl) // not required when using UITableViewController
        self.coll_servicelist.delegate = self
        self.coll_servicelist.dataSource = self
        self.callnoticartcount()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.call_service_cat()
        self.refreshControl.endRefreshing()
    }
    
    func intial_setup_action(){
        // header action
        self.view_header.btn_sidemenu.addTarget(self, action: #selector(sidemenu), for: .touchUpInside)
        //        self.view_header.btn_profile.addTarget(self, action: #selector(profile), for: .touchUpInside)
        self.view_header.label_location.text = Servicefile.shared.pet_header_city
        self.view_header.image_button2.image = UIImage(named: imagelink.image_bag)
        self.view_header.image_profile.image = UIImage(named: imagelink.image_bel)
        self.view_header.btn_button2.addTarget(self, action: #selector(action_cart), for: .touchUpInside)
        self.view_header.btn_profile.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_header.label_location.text = Servicefile.shared.pet_header_city
        self.view_header.btn_location.addTarget(self, action: #selector(manageaddress), for: .touchUpInside)
        // header action
        // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        //        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: false, b2: true, b3: false, b4: false, b5: false)
        // footer action
    }
    
    func callnoticartcount(){
        print("notification")
        Servicefile.shared.notifi_count = 0
        Servicefile.shared.cart_count = 0
        self.view_header.checknoti()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.cartnoticount, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("notification success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let notification_count = Data["notification_count"] as! Int
                        let product_count = Data["product_count"] as! Int
                        Servicefile.shared.notifi_count = notification_count
                        Servicefile.shared.cart_count = product_count
                        self.view_header.checknoti()
                    }else{
                        print("status code service denied")
                    }
                    break
                case .failure(let Error):
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }
            }
        }else{
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        let vc = UIStoryboard.Pet_sidemenu_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func action_home(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
        let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    @IBAction func action_cares(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
        let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_notifi(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_shop(_ sender: Any) {
        //  Servicefile.shared.tabbar_selectedindex = 3
        let tapbar = UIStoryboard.pet_sp_shop_dashboard_ViewController() // shop
        //   tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.pet_servicecat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! servicecat_CollectionViewCell
            cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
            cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
            cell.imag_cat.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.imag_cat.image = UIImage(named: imagelink.sample)
                } else {
                    cell.imag_cat.image = image
                }
            }
            
            cell.imag_cat.contentMode = .scaleAspectFill
            cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            
            
            return cell
        }else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scell", for: indexPath) as! servicedashfooterCollectionViewCell
            cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
            cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
            cell.imag_cat.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.imag_cat.image = UIImage(named: imagelink.sample)
                } else {
                    cell.imag_cat.image = image
                }
            }
            cell.imag_cat.contentMode = .scaleAspectFill
            cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            return cell
        }else if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! servicecat_CollectionViewCell
            cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
            cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
            cell.imag_cat.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.imag_cat.image = UIImage(named: imagelink.sample)
                } else {
                    cell.imag_cat.image = image
                }
            }
            cell.imag_cat.contentMode = .scaleAspectFill
            cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scell", for: indexPath) as! servicedashfooterCollectionViewCell
            cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
            cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
            cell.imag_cat.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.imag_cat.image = UIImage(named: imagelink.sample)
                } else {
                    cell.imag_cat.image = image
                }
            }
            cell.imag_cat.contentMode = .scaleAspectFill
            cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.05 , height:   collectionView.frame.size.height / 2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.service_id = Servicefile.shared.pet_servicecat[indexPath.row]._id
        Servicefile.shared.service_index = indexPath.row
        let vc = UIStoryboard.pet_servicelist_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func call_service_cat(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_service_cat, method: .post, parameters: ["user_id": Servicefile.shared.userid]
                                                                 , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                    switch (response.result) {
                                                                    case .success:
                                                                        let res = response.value as! NSDictionary
                                                                        print("success data",res)
                                                                        let Code  = res["Code"] as! Int
                                                                        if Code == 200 {
                                                                            Servicefile.shared.pet_servicecat.removeAll()
                                                                            let Data = res["Data"] as! NSArray
                                                                            for itm in 0..<Data.count {
                                                                                let itm_val = Data[itm] as! NSDictionary
                                                                                let _id = itm_val["_id"] as? String ?? ""
                                                                                let image = itm_val["image"] as? String ?? Servicefile.sample_img
                                                                                let sub_title = itm_val["sub_title"] as? String ?? ""
                                                                                let title = itm_val["title"] as? String ?? ""
                                                                                Servicefile.shared.pet_servicecat.append(service_cat.init(I_id: _id, Iimage: image, Isub_title: sub_title, Ititle: title))
                                                                            }
                                                                            self.coll_servicelist.reloadData()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    
    
}
