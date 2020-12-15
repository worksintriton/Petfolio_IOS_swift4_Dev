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
    
    var labelmenu = ["My Appointment", "Logout"]
    var imgmenu = ["Calendar", "Exit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.labelmenu[indexPath.row] == "My Appointment"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_applist_ViewController") as! Pet_applist_ViewController
                   self.present(vc, animated: true, completion: nil)
        }else{
            UserDefaults.standard.set("", forKey: "userid")
                   UserDefaults.standard.set("", forKey: "usertype")
                   Servicefile.shared.usertype = UserDefaults.standard.string(forKey: "usertype")!
                   Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                   self.present(vc, animated: true, completion: nil)
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
               self.present(vc, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
