//
//  sp_side_menuViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class sp_side_menuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_menulist: UITableView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
     var labelmenu = [""]
       var imgmenu = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Servicefile.shared.my_ref_code != "" {
            self.labelmenu = ["Favorities","Notification","My Orders","My Appointment","My Coupons","Medical History","Payment Details","Settings", "Logout", "Referal: \(Servicefile.shared.my_ref_code)"]
            self.imgmenu = ["Like","Bell","Doc","Calendar","Discount","Medical History","PaymentDetails","Setting", "Exit","Referal: \(Servicefile.shared.my_ref_code)"]
        }else{
            self.labelmenu = ["Favorities","Notification","My Orders","My Appointment","My Coupons","Medical History","Payment Details","Settings", "Logout"]
            self.imgmenu = ["Like","Bell","Doc","Calendar","Discount","Medical History","PaymentDetails","Setting", "Exit"]
        }
        
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.tbl_menulist.delegate = self
        self.tbl_menulist.dataSource = self
        // Do any additional setup after loading the view.
    }
    
       @IBAction func action_edit(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_profile_ViewController") as! Sp_profile_ViewController
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
        if self.labelmenu[indexPath.row] == "My calender" {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_mycalender_ViewController") as! Sp_mycalender_ViewController
        self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Orders" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "sp_myorder_ViewController") as! sp_myorder_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Manage Services" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_profile_edit_ViewController") as! Sp_profile_edit_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Notification"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
            self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "Logout"{
            UserDefaults.standard.set("", forKey: "userid")
                   UserDefaults.standard.set("", forKey: "usertype")
                   Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
                   Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                   self.present(vc, animated: true, completion: nil)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

   
}



