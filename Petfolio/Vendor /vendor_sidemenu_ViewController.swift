//
//  vendor_sidemenu_ViewController.swift
//  Petfolio
//
//  Created by Admin on 16/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

import Alamofire

class vendor_sidemenu_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl_menulist: UITableView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
     var labelmenu = ["Customer  Orders","Manage Product","My Orders","Favourities","My Coupons","Report","Settings", "Logout"]
       var imgmenu = ["myOrder", "shop-1", "myOrder", "Like", "Discount","Report", "Setting", "Exit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.tbl_menulist.delegate = self
        self.tbl_menulist.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
       @IBAction func action_edit(_ sender: Any) {
//           let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_profile_ViewController") as! Sp_profile_ViewController
//                  self.present(vc, animated: true, completion: nil)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.labelmenu[indexPath.row] == "Manage Product" {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "vendor_manage_product_ViewController") as! vendor_manage_product_ViewController
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
        return 55
    }

   
}

extension vendor_sidemenu_ViewController {
    
   
}

