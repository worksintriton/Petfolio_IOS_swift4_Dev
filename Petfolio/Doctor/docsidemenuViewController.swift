//
//  docsidemenuViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

import SDWebImage

class docsidemenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_menulist: UITableView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
//    var labelmenu = ["My calender", "Logout"]
//    var imgmenu = ["Calendar", "Exit"]
    
    var labelmenu = [""]
    var imgmenu = [""]
    /*if Servicefile.shared.my_ref_code != "" {
     self.labelmenu = ["My Appointment","Walk-in Appointments","My Calendar","Manage Service","My Orders","Favourites","Payment Details","Notifications", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
     self.imgmenu = ["Calendar","walkin","calender-menu","suitcase","Doc","Like","PaymentDetails","Bell", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
     self.tbl_menulist.reloadData()
 }else{
     self.labelmenu = ["My Appointment","Walk-in Appointments","My Calendar","Manage Service","My Orders","Favourites","Payment Details","Notifications", "Logout"]
     self.imgmenu = ["Calendar","walkin","calender-menu","suitcase","Doc","Like","PaymentDetails","Bell", "Exit"]
     self.tbl_menulist.reloadData()
 }*/
//  self.labelmenu = ["Favourites","My Orders","My Appointment","My Coupons","Medical History","Payment Details","Notifications", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
//    self.imgmenu = ["Like","Doc","Calendar","Discount","Medical History","PaymentDetails","Bell", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.tbl_menulist.delegate = self
        self.tbl_menulist.dataSource = self
        if Servicefile.shared.my_ref_code != "" {
            self.labelmenu = ["My Appointments","Walk-in Appointments","My Calendar","Manage Services","My Orders","My Coupons","Favourites","Notifications", "Logout", "Referral code: \(Servicefile.shared.my_ref_code)"]
            self.imgmenu = ["Calendar","walkin","calender-menu","suitcase","Doc","Discount","Like","Bell", "Exit","Referral code: \(Servicefile.shared.my_ref_code)"]
            self.tbl_menulist.reloadData()
        }else{
            self.labelmenu = ["My Appointments","Walk-in Appointments","My Calendar","Manage Services","My Orders","My Coupons","Favourites","Notifications", "Logout"]
            self.imgmenu = ["Calendar","walkin","calender-menu","suitcase","Doc","Discount","Like","Bell", "Exit"]
            self.tbl_menulist.reloadData()
        }
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        
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
    
    @IBAction func action_dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_edit_profile(_ sender: Any) {
        let vc = UIStoryboard.profile_edit_ViewController()
        self.present(vc, animated: true, completion: nil)
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
    
    //doc_myorderdetails_ViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.labelmenu[indexPath.row] == "My Calendar" {
            let vc = UIStoryboard.mycalenderViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Appointments" {
            Servicefile.shared.appointtype = "New"
            let vc = UIStoryboard.DocdashboardViewController()
            self.present(vc, animated: true, completion: nil)
            Servicefile.shared.appointtype = "New"
        }else if self.labelmenu[indexPath.row] == "Walk-in Appointments" {
            let vc = UIStoryboard.doc_app_walkin_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Orders" {
            Servicefile.shared.ordertype = "New"
            let vc = UIStoryboard.doc_myorderdetails_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Favourites"{
            let vc = UIStoryboard.doc_favlist_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Notifications"{
            let vc = UIStoryboard.pet_notification_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Payment Details"{
            self.dismiss(animated: true, completion: nil)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "doc_paymentdetilsViewController") as! doc_paymentdetilsViewController
//            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Coupons"{
            let vc = UIStoryboard.mycouponViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Manage Services" {
            let vc = UIStoryboard.Doc_profiledetails_ViewController()
            self.present(vc, animated: true, completion: nil)
                }else if self.labelmenu[indexPath.row] == "Logout"{
                    let alert = UIAlertController(title: "Are you sure you need to logout?", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                        self.pushtologin()
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
        }
//                else{
//                self.dismiss(animated: true, completion: nil)
//            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    @IBAction func action_view_profile(_ sender: Any) {
        let vc = UIStoryboard.Doc_profiledetails_ViewController()
    }
    
}
