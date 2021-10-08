//
//  vendor_sidemenu_ViewController.swift
//  Petfolio
//
//  Created by Admin on 16/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class vendor_sidemenu_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl_menulist: UITableView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    
    var labelmenu = [""]
    var imgmenu = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        if Servicefile.shared.my_ref_code != "" {
            self.labelmenu = ["Add Products","Manage Products","My orders","Notifications", "Logout", "Referral code: \(Servicefile.shared.my_ref_code)"]
            self.imgmenu = ["add","shop-1","Doc","Bell", "Exit","Referral code: \(Servicefile.shared.my_ref_code)"]
        }else{
            self.labelmenu = ["Add Products","Manage Products","My orders","Notifications", "Logout"]
            self.imgmenu = ["add","shop-1","Doc","Bell","Exit"]
        }
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.tbl_menulist.delegate = self
        self.tbl_menulist.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    /*if Servicefile.shared.my_ref_code != "" {
     self.labelmenu = ["Manage Products","My orders","Favourites","Add Products","Notifications", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
     self.imgmenu = ["shop-1","Doc","Like","add","Bell", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
 }else{
     self.labelmenu = ["Manage Products","My orders","Favourites","Add Products","Notifications", "Logout"]
     self.imgmenu = ["shop-1","Doc","Like","add","Bell","Exit"]
 }*/
    
     /*
     if Servicefile.shared.my_ref_code != "" {
     self.labelmenu = ["Customer Orders","Manage Products","Favourites","Notifications", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
     self.imgmenu = ["Doc","shop-1","Like","Bell", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
     }else{
     self.labelmenu = ["Customer Orders","Manage Products","Favourites","Notifications", "Logout"]
     self.imgmenu = ["Doc","shop-1","Like","Bell", "Exit"]
     }
     */
    
    @IBAction func action_edit(_ sender: Any) {
        let vc = UIStoryboard.vendor_profile_view_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.labelmenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! menuTableViewCell
        cell.selectionStyle = .none
        cell.Img_menu.image = UIImage(named: self.imgmenu[indexPath.row])
        cell.label_menu.text = self.labelmenu[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.labelmenu[indexPath.row] == "Manage Products" {
            let vc = UIStoryboard.vendor_manage_product_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My orders"{
            let vc = UIStoryboard.vendor_myorder_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Add Products"{
            let vc = UIStoryboard.AddproductViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Notifications"{
            let vc = UIStoryboard.pet_notification_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Logout"{
            let alert = UIAlertController(title: "Are you sure you need to logout?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.pushtologin()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
//        else{
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension vendor_sidemenu_ViewController {
    
    
}

