//
//  Pet_sidemenu_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 02/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class Pet_sidemenu_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl_menulist: UITableView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    
    var labelmenu = [""]
    var imgmenu = [""]
    
    /*if Servicefile.shared.my_ref_code != "" {
     self.labelmenu = ["Favorites","My Orders","My Appointment","My Coupons","Medical History","Payment Details","Notifications", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
     self.imgmenu = ["Like","Doc","Calendar","Discount","Medical History","PaymentDetails","Bell", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
 }else{
     self.labelmenu = ["Favorites","My Orders","My Appointment","My Coupons","Medical History","Payment Details","Notifications", "Logout"]
     self.imgmenu = ["Like","Doc","Calendar","Discount","Medical History","PaymentDetails","Bell", "Exit"]
 }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        if Servicefile.shared.my_ref_code != "" {
            self.labelmenu = ["Favorites","My Orders","My Appointment","My Coupons","Notifications","SOS", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
            self.imgmenu = ["Like","Doc","Calendar","Discount","Bell","SOS", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
        }else{
            self.labelmenu = ["Favorites","My Orders","My Appointment","My Coupons","Notifications","SOS", "Logout"]
            self.imgmenu = ["Like","Doc","Calendar","Discount","Bell","SOS", "Exit"]
        }
        
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        // self.label_phono.text = Servicefile.shared.user_phone
        
        self.tbl_menulist.delegate = self
        self.tbl_menulist.dataSource = self
        // Do any additional setup after loading the view.
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
//    pet_paymentdetails_ViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.labelmenu[indexPath.row] == "My Appointment"{
            let vc = UIStoryboard.Pet_applist_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Orders"{
            let vc = UIStoryboard.Petlover_myorder_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Coupons"{
            let vc = UIStoryboard.mycouponViewController()
            self.present(vc, animated: true, completion: nil)
        }
//        else if self.labelmenu[indexPath.row] == "Payment Details"{
//            self.dismiss(animated: true, completion: nil)
////            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_paymentdetails_ViewController") as! pet_paymentdetails_ViewController
////            self.present(vc, animated: true, completion: nil)
//        }
        
        else if self.labelmenu[indexPath.row] == "Notifications"{
            let vc = UIStoryboard.pet_notification_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Favorites"{
            let vc = UIStoryboard.pet_sidemenu_favlist_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "SOS"{
            let vc = UIStoryboard.SOSViewController()
            self.present(vc, animated: true, completion: nil)
        }
//        else if self.labelmenu[indexPath.row] == "Medical History"{
//            let vc = UIStoryboard.pet_medical_history_ViewController()
//            self.present(vc, animated: true, completion: nil)
//        }
        else if self.labelmenu[indexPath.row] == "Logout"{
            let alert = UIAlertController(title: "Are you sure you need to logout", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.pushtologin()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
          
        }
//        else{
//                self.dismiss(animated: true, completion: nil)
//            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile_edit(_ sender: Any) {
        let vc = UIStoryboard.profile_edit_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
