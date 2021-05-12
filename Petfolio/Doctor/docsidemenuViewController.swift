//
//  docsidemenuViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class docsidemenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_menulist: UITableView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
//    var labelmenu = ["My calender", "Logout"]
//    var imgmenu = ["Calendar", "Exit"]
    
    var labelmenu = ["My Appointment","My calender","Manage Services","My Orders","Favourities","My Coupons","Settings", "Logout"]
    var imgmenu = ["Calendar", "calender-menu", "manage", "myOrder", "Like", "Discount", "Setting", "Exit"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        
        self.tbl_menulist.delegate = self
        self.tbl_menulist.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_edit_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile_edit_ViewController") as! profile_edit_ViewController
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
        if self.labelmenu[indexPath.row] == "My calender" {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mycalenderViewController") as! mycalenderViewController
        self.present(vc, animated: true, completion: nil)
        }else if self.labelmenu[indexPath.row] == "My Orders" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "doc_myorderdetails_ViewController") as! doc_myorderdetails_ViewController
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

    @IBAction func action_view_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_profiledetails_ViewController") as! Doc_profiledetails_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
