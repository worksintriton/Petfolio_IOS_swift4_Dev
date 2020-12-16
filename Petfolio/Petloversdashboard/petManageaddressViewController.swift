//
//  petManageaddressViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 09/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class petManageaddressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tbl_addresslist: UITableView!
    @IBOutlet weak var label_noofsavedaddress: UILabel!
    var isclickisoption = ["0"]
    var isorgiclikcopt = ["0"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isclickisoption.removeAll()
        self.isorgiclikcopt.removeAll()
        Servicefile.shared.petuserlocaadd.removeAll()
        self.calladdressList()
        self.tbl_addresslist.delegate = self
        self.tbl_addresslist.dataSource = self
        self.label_noofsavedaddress.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.petuserlocaadd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! manageaddresslistTableViewCell
        cell.label_username.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_nickname
        cell.label_address.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_address
        cell.btn_delete.tag = indexPath.row
        cell.btn_edit.tag = indexPath.row
        cell.btn_isshowOption.tag = indexPath.row
        cell.label_locationTitle.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_title
        if self.isclickisoption[indexPath.row] == "1" {
            cell.view_option.isHidden = false
        }else{
            cell.view_option.isHidden = true
        }
        if Servicefile.shared.petuserlocaadd[indexPath.row].default_status != false {
            cell.img_default.isHidden = false
        }else{
             cell.img_default.isHidden = true
        }
        cell.btn_isshowOption.addTarget(self, action: #selector(action_optionvisible), for: .touchUpInside)
        cell.btn_edit.addTarget(self, action: #selector(action_edit), for: .touchUpInside)
          cell.btn_delete.addTarget(self, action: #selector(action_delete), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.isclickisoption = self.isorgiclikcopt
         self.tbl_addresslist.reloadData()
        self.callchangedefault(id : Servicefile.shared.petuserlocaadd[indexPath.row]._id)
    }
    
    @objc func action_optionvisible(sender : UIButton){
        let tag = sender.tag
        self.isclickisoption = self.isorgiclikcopt
        self.isclickisoption.remove(at: tag)
        self.isclickisoption.insert("1", at: tag)
        self.tbl_addresslist.reloadData()
    }
    
    @objc func action_edit(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.selectedindex = tag
        Servicefile.shared.locaaccess = "update"
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petsavelocationViewController") as! petsavelocationViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_delete(sender : UIButton){
        let tag = sender.tag
        if Servicefile.shared.petuserlocaadd[tag].default_status != false {
           print("you can't delete the default address")
        }else{
            self.calldeleteaddress(id : Servicefile.shared.petuserlocaadd[tag]._id)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func action_addnewaddress(_ sender: Any) {
        Servicefile.shared.long = 0.0
        Servicefile.shared.lati = 0.0
        Servicefile.shared.locaaccess = "Add"
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petlocationsettingViewController") as! petlocationsettingViewController
              self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func callchangedefault(id : String){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_defaultaddress, method: .post, parameters:
        ["user_id" : Servicefile.shared.userid,
            "_id": id,
            "default_status" : true], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    self.calladdressList()
                                                     self.stopAnimatingActivityIndicator()
                                                  }else{
                                                    self.stopAnimatingActivityIndicator()
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
    
    func calldeleteaddress(id : String){
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_deleteaddress, method: .post, parameters:
        ["_id": id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    self.calladdressList()
                                                     self.stopAnimatingActivityIndicator()
                                                  }else{
                                                    self.stopAnimatingActivityIndicator()
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
    
    func calladdressList(){
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_getAddresslist, method: .post, parameters:
        ["user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    self.isclickisoption.removeAll()
                                                    self.isorgiclikcopt.removeAll()
                                                    Servicefile.shared.petuserlocaadd.removeAll()
                                                    let Data = res["Data"] as! NSArray
                                                    for itm in 0..<Data.count{
                                                        let idata = Data[itm] as! NSDictionary
                                                        var _id = idata["_id"] as! String
                                                        var date_and_time = idata["date_and_time"] as! String
                                                        var default_status = idata["default_status"] as! Bool
                                                        var location_address = idata["location_address"] as! String
                                                        var location_city = idata["location_city"] as! String
                                                        var location_country = idata["location_country"] as! String
                                                        var location_lat = String(Double(idata["location_lat"] as! NSNumber))
                                                        var location_long = String(Double(idata["location_long"] as! NSNumber))
                                                        var location_nickname = idata["location_nickname"] as! String
                                                        var location_pin = idata["location_pin"] as! String
                                                        var location_state = idata["location_state"] as! String
                                                        var location_title = idata["location_title"] as! String
                                                        var user_id = idata["user_id"] as! String
                                                        self.isclickisoption.append("0")
                                                        self.isorgiclikcopt.append("0")
                                                        Servicefile.shared.petuserlocaadd.append(locationdetails.init(In_id: _id, In_date_and_time: date_and_time, In_default_status: default_status, In_location_address: location_address, In_location_city: location_city, In_location_country: location_country, In_location_lat: location_lat, In_location_long: location_long, In_location_nickname: location_nickname, In_location_pin: location_pin, In_location_state: location_state, In_location_title: location_title, In_user_id: user_id))
                                                    }
                                                    self.tbl_addresslist.reloadData()
                                                    self.label_noofsavedaddress.text = String(Servicefile.shared.petuserlocaadd.count) + " Saved address"
                                                     self.stopAnimatingActivityIndicator()
                                                  }else{
                                                    self.stopAnimatingActivityIndicator()
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
    
    func alert(Message: String){
              let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                   }))
              self.present(alert, animated: true, completion: nil)
          }
    
}
