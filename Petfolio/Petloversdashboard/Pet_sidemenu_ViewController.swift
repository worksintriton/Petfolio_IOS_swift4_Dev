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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Servicefile.shared.my_ref_code != "" {
            self.labelmenu = ["Favorities","My Orders","My Appointment","My Coupons","Medical History","Payment Details","Notification", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
            self.imgmenu = ["Like","Doc","Calendar","Discount","Medical History","PaymentDetails","Bell", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
        }else{
            self.labelmenu = ["Favorities","My Orders","My Appointment","My Coupons","Medical History","Payment Details","Notification", "Logout"]
            self.imgmenu = ["Like","Doc","Calendar","Discount","Medical History","PaymentDetails","Bell", "Exit"]
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_applist_ViewController") as! Pet_applist_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Orders"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Petlover_myorder_ViewController") as! Petlover_myorder_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Payment Details"{
            self.dismiss(animated: true, completion: nil)
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_paymentdetails_ViewController") as! pet_paymentdetails_ViewController
//            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Notification"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Favorities"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_sidemenu_favlist_ViewController") as! pet_sidemenu_favlist_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Medical History"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_medical_history_ViewController") as! pet_medical_history_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Logout"{
            let alert = UIAlertController(title: "Are you sure you need to logout", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.pushtologin()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
          
        }else{
                self.dismiss(animated: true, completion: nil)
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile_edit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile_edit_ViewController") as! profile_edit_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
