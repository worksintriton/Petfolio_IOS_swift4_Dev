//
//  pet_notification_ViewController.swift
//  Petfolio
//
//  Created by Admin on 08/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_notification_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var view_header: header_title!
    @IBOutlet weak var tbl_notifi_list: UITableView!
    
    var selcted = ["0"]
    var orginal = ["0"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.tbl_notifi_list.delegate = self
        self.tbl_notifi_list.dataSource = self
        Servicefile.shared.notif_list.removeAll()
        self.selcted.removeAll()
        self.orginal.removeAll()
        self.callnotification()
        // Do any additional setup after loading the view.
    }
    
    func intial_setup_action(){
    // header action
        self.view_header.label_title.text = "Notifcation"
        self.view_header.label_title.textColor = .white
        self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
    // header action
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.notif_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.selcted[indexPath.row] == "1" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! notification_TableViewCell
            cell.selectionStyle = .none
            cell.view_main.view_cornor()
            cell.view_main.dropShadow()
            if Servicefile.shared.notif_list[indexPath.row].notify_img != "" {
                cell.image_noti.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.notif_list[indexPath.row].notify_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_noti.image = UIImage(named: "logo")
                    } else {
                        cell.image_noti.image = image
                    }
                }
            }else{
                cell.image_noti.image = UIImage(named: "logo")
            }
            cell.label_description.text = Servicefile.shared.notif_list[indexPath.row].notify_descri
            cell.label_title.text = Servicefile.shared.notif_list[indexPath.row].notify_title
            cell.label_date.text = Servicefile.shared.notif_list[indexPath.row].date_and_time
            return cell
        }else{
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! notification_TableViewCell
            cell.selectionStyle = .none
            cell.view_main.view_cornor()
            cell.view_main.dropShadow()
            if Servicefile.shared.notif_list[indexPath.row].notify_img != "" {
                cell.image_noti.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.notif_list[indexPath.row].notify_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_noti.image = UIImage(named: "logo")
                    } else {
                        cell.image_noti.image = image
                    }
                }
            }else{
                cell.image_noti.image = UIImage(named: "logo")
            }
            cell.label_description.text = Servicefile.shared.notif_list[indexPath.row].notify_descri
            cell.label_title.text = Servicefile.shared.notif_list[indexPath.row].notify_title
            cell.label_date.text = Servicefile.shared.notif_list[indexPath.row].date_and_time
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selcted[indexPath.row] == "1" {
            self.selcted = self.orginal
        }else{
            self.selcted = self.orginal
            self.selcted.remove(at: indexPath.row)
            self.selcted.insert("1", at: indexPath.row)
            
        }
        self.tbl_notifi_list.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selcted[indexPath.row] == "1" {
            return 150
        }else{
            return 120
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        
    }
    
    @IBAction func action_profile(_ sender: Any) {
        
    }
    
    @IBAction func action_home(_ sender: Any) {
        
    }
    
    @IBAction func action_shop(_ sender: Any) {
        
    }
    
    
    @IBAction func action_pet_service(_ sender: Any) {
        
    }
    
    @IBAction func action_pet_care(_ sender: Any) {
        
    }
    
    @IBAction func action_market(_ sender: Any) {
        
    }
    
    
    
    func callnotification(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.notification, method: .post, parameters:
            ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.notif_list.removeAll()
                        self.selcted.removeAll()
                        self.orginal.removeAll()
                        let Dat = res["Data"] as! NSArray
                        for item in 0..<Dat.count{
                            self.selcted.append("0")
                            self.orginal.append("0")
                            let notilist = Dat[item] as! NSDictionary
                            let _id = notilist["_id"] as? String ?? ""
                            let user_id = notilist["user_id"] as? String ?? ""
                            let notify_title = notilist["notify_title"] as? String ?? ""
                            let notify_descri = notilist["notify_descri"] as? String ?? ""
                            let notify_img = notilist["notify_img"] as? String ?? Servicefile.sample_img
                            let notify_time = notilist["notify_time"] as? String ?? ""
                            let date_and_time = notilist["date_and_time"] as? String ?? ""
                            Servicefile.shared.notif_list.append(notificationlist.init(I_id: _id, Iuser_id: user_id, Inotify_title: notify_title, Inotify_descri: notify_descri, Inotify_img: notify_img, Inotify_time: notify_time, Idate_and_time: date_and_time))
                        }
                        self.tbl_notifi_list.reloadData()
                        self.stopAnimatingActivityIndicator()
                    }else{
                        Servicefile.shared.notif_list.removeAll()
                        self.tbl_notifi_list.reloadData()
                        self.stopAnimatingActivityIndicator()
                        let Messages = res["Message"] as? String ?? ""
                        self.alert(Message: Messages)
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
   
    
    
}
