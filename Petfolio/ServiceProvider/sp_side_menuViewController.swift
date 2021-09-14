//
//  sp_side_menuViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class sp_side_menuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

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
            self.labelmenu = ["My Appointments","My Calender","My Orders","Favorites","Notifications", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
            self.imgmenu = ["Doc","Calendar","Doc","Like","Bell", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
            self.tbl_menulist.reloadData()
        }else{
            self.labelmenu = ["My Appointments","My Calender","My Orders","Favorites","Notifications", "Logout"]
            self.imgmenu = ["Doc","Calendar","Doc","Like","Bell", "Exit"]
            self.tbl_menulist.reloadData()
        }
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.tbl_menulist.delegate = self
        self.tbl_menulist.dataSource = self
        // Do any additional setup after loading the view.
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
    
       @IBAction func action_edit(_ sender: Any) {
        let vc = UIStoryboard.Sp_profile_ViewController()
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
        cell.Img_menu.image = UIImage(named: self.imgmenu[indexPath.row])
        cell.label_menu.text = self.labelmenu[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.labelmenu[indexPath.row] == "My Calender" {
            let vc = UIStoryboard.Sp_mycalender_ViewController()
        self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Appointments" {
            let vc = UIStoryboard.Sp_dash_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Favorites" {
            let vc = UIStoryboard.sp_favlist_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Orders" {
            let vc = UIStoryboard.sp_myorder_ViewController()
            self.present(vc, animated: true, completion: nil)
        }
//        else if self.labelmenu[indexPath.row] == "Manage Services" {
//            let vc = UIStoryboard.Sp_profile_edit_ViewController()
//            self.present(vc, animated: true, completion: nil)
//        }
        else if self.labelmenu[indexPath.row] == "Notifications"{
            let vc = UIStoryboard.pet_notification_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Logout"{
            let alert = UIAlertController(title: "Are you sure you need to logout?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.pushtologin()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
//        else{
//            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

   
}



