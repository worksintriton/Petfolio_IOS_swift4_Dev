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
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var label_alertMSG: UILabel!
    @IBOutlet weak var view_yes: UIView!
    @IBOutlet weak var view_no: UIView!
    @IBOutlet weak var view_footer: UIView!
    
    var proc_type = "edit"
    var indextag = 0
    
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
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.view_popup.layer.cornerRadius = 10.0
        self.view_footer.layer.cornerRadius = 10.0
        self.view_yes.layer.cornerRadius = 10.0
        self.view_no.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action_care(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_searchlist_DRViewController") as! Pet_searchlist_DRViewController
           self.present(vc, animated: true, completion: nil)
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
        self.indextag = indexPath.row
        self.tbl_addresslist.reloadData()
        if Servicefile.shared.petuserlocaadd[self.indextag].default_status != false {
                       self.view_shadow.isHidden = true
                       self.view_popup.isHidden = true
                   }else{
                       self.view_shadow.isHidden = false
                       self.view_popup.isHidden = false
                        self.label_alertMSG.text = "Are you sure you want to change the location as default Address"
                        self.proc_type = "default"
                   }
        
    }
    
    @IBAction func action_yes(_ sender: Any) {
        if self.proc_type == "default" {
            self.view_shadow.isHidden = true
            self.view_popup.isHidden = true
            self.callchangedefault(id : Servicefile.shared.petuserlocaadd[self.indextag]._id)
        }else if self.proc_type == "edit" {
            self.view_shadow.isHidden = true
            self.view_popup.isHidden = true
            self.isclickisoption = self.isorgiclikcopt
            Servicefile.shared.locaaccess = "update"
            Servicefile.shared.selectedPincode = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_pin
            Servicefile.shared.selectedCity = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_city
            Servicefile.shared.selectedaddress = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_address
            Servicefile.shared.lati = Double(Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_lat)!
            Servicefile.shared.long = Double(Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_long)!
            Servicefile.shared.selectedaddress = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_address
             Servicefile.shared.selectedpickname = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_nickname
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "petsavelocationViewController") as! petsavelocationViewController
            self.present(vc, animated: true, completion: nil)
        }else{
            if Servicefile.shared.petuserlocaadd[indextag].default_status != false {
                self.view_shadow.isHidden = true
                self.view_popup.isHidden = true
            }else{
                self.calldeleteaddress(id : Servicefile.shared.petuserlocaadd[self.indextag]._id)
            }
        }
    }
    
    @IBAction func action_no(_ sender: Any) {
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
    }
    
    @objc func action_optionvisible(sender : UIButton){
        let tag = sender.tag
        self.isclickisoption = self.isorgiclikcopt
        self.isclickisoption.remove(at: tag)
        self.isclickisoption.insert("1", at: tag)
        self.tbl_addresslist.reloadData()
    }
    
    @objc func action_edit(sender : UIButton){
        self.proc_type = "edit"
        let tag = sender.tag
        Servicefile.shared.selectedindex = tag
        self.view_shadow.isHidden = false
        self.view_popup.isHidden = false
        self.label_alertMSG.text = "Are you sure you want to update this Address"
    }
    
    @objc func action_delete(sender : UIButton){
        self.proc_type = "delete"
        let tag = sender.tag
        self.indextag = tag
        Servicefile.shared.selectedindex = tag
        self.label_alertMSG.text = "Are you sure you want to delete this Address"
        if Servicefile.shared.petuserlocaadd[tag].default_status != false {
            self.view_shadow.isHidden = true
            self.view_popup.isHidden = true
            self.alert(Message: "Default location can't be deleted")
        }else{
            self.view_shadow.isHidden = false
            self.view_popup.isHidden = false
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
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? petprofileViewController {
            DispatchQueue.main.async {
                firstVC.viewWillAppear(true)
            }
        }
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
                        self.view_shadow.isHidden = true
                        self.view_popup.isHidden = true
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
                            let _id = idata["_id"] as! String
                            let date_and_time = idata["date_and_time"] as! String
                            let default_status = idata["default_status"] as! Bool
                            let location_address = idata["location_address"] as! String
                            let location_city = idata["location_city"] as! String
                            let location_country = idata["location_country"] as! String
                            let location_lat = String(Double(idata["location_lat"] as! NSNumber))
                            let location_long = String(Double(idata["location_long"] as! NSNumber))
                            let location_nickname = idata["location_nickname"] as! String
                            let location_pin = idata["location_pin"] as! String
                            let location_state = idata["location_state"] as! String
                            let location_title = idata["location_title"] as! String
                            let user_id = idata["user_id"] as! String
                            self.isclickisoption.append("0")
                            self.isorgiclikcopt.append("0")
                            Servicefile.shared.petuserlocaadd.append(locationdetails.init(In_id: _id, In_date_and_time: date_and_time, In_default_status: default_status, In_location_address: location_address, In_location_city: location_city, In_location_country: location_country, In_location_lat: location_lat, In_location_long: location_long, In_location_nickname: location_nickname, In_location_pin: location_pin, In_location_state: location_state, In_location_title: location_title, In_user_id: user_id))
                        }
                        self.tbl_addresslist.reloadData()
                        self.label_noofsavedaddress.text = String(Servicefile.shared.petuserlocaadd.count) + "  Saved address"
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
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
