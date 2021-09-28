//
//  pet_vendor_editshiplistViewController.swift
//  Petfolio
//
//  Created by Admin on 03/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_vendor_editshiplistViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview_list_address: UITableView!
    
    @IBOutlet weak var view_selectaddress: UIView!
    
    var isselect = [""]
    var orgisselect = [""]
    var add_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        Servicefile.shared.petuserlocaadd.removeAll()
        Servicefile.shared.shipaddresslist_isedit = false
        self.view_selectaddress.view_cornor()
        self.isselect.removeAll()
        self.orgisselect.removeAll()
        self.tableview_list_address.register(UINib(nibName: "editshipaddresslistTableViewCell", bundle: nil), forCellReuseIdentifier: "listaddress")
        // Do any additional setup after loading the view.
        self.tableview_list_address.delegate = self
        self.tableview_list_address.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.call_list_shipping_address()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? pet_vendor_shippingaddressconfrimViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
       }
    
  
    
    @IBAction func action_back(_ sender: Any) {
        Servicefile.shared.shipaddresslist_isedit = false
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_addaddress(_ sender: Any) {
        Servicefile.shared.long = 0.0
        Servicefile.shared.lati = 0.0
        Servicefile.shared.locaaccess = "Add"
        Servicefile.shared.ishiping = "ship"
        let vc = UIStoryboard.pet_vendor_shipingaddlocationViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.petuserlocaadd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: editshipaddresslistTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listaddress", for: indexPath) as! editshipaddresslistTableViewCell
                
//        "_id": "605a4b9cbaeb4c22731c9248",Servicefile.shared.petuserlocaadd[indexPath.row].location_title
//                "user_id": "604081d12c2b43125f8cb840",
//                "user_first_name": "SandySan",
//                "user_last_name": "Kumar",
//                "user_flat_no": "225/1,",
//                "user_stree": "Duraiswamy Nagar Main Road",
//                "user_landmark": "Mariyamman Kovil near By",
//                "user_picocode": "636009",
//                "user_state": "TamilNadu",
//                "user_city": "Salem",
//                "user_mobile": "948773536",
//                "user_alter_mobile": "9443135306",
//                "user_address_stauts": "Last Used",
//                "user_address_type": "Home",
//                "user_display_date": "24-03-2021",
//                "updatedAt": "2021-03-23T20:19:20.031Z",
//                "createdAt": "2021-03-23T20:12:12.991Z",
//                "__v": 0
        //self.selectedid = details["_id"] as? String ?? ""
        
        cell.label_name.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_nickname
        cell.label_mobileno.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_title
        cell.label_addressline1.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_city
        cell.label_addressline2.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_state + ", " + Servicefile.shared.petuserlocaadd[indexPath.row].location_country
        cell.label_addressline3.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_address
        cell.label_add_type.text = Servicefile.shared.petuserlocaadd[indexPath.row].location_title
        cell.view_main.view_cornor()
        cell.view_add_type.view_cornor()
        cell.view_add_type.layer.borderWidth = 0.5
        cell.view_add_type.layer.borderColor = UIColor.lightGray.cgColor
        if  self.isselect[indexPath.row] == "1" {
            self.add_id  = Servicefile.shared.petuserlocaadd[indexPath.row]._id
            cell.image_isselect.setimage(name: imagelink.selectedRadio)
        }else{
            cell.image_isselect.setimage(name: imagelink.Radio)
        }
        cell.selectionStyle = .none
        cell.btn_isselect.tag = indexPath.row
        cell.btn_isselect.addTarget(self, action: #selector(call_set_marked), for: .touchUpInside)
        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(call_edit), for: .touchUpInside)
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(call_delete), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @objc func call_edit(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.selectedindex = tag
        Servicefile.shared.islocationget = true
        Servicefile.shared.locaaccess = "update"
        Servicefile.shared.selectedCountry = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_country
        Servicefile.shared.selectedState = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_state
        Servicefile.shared.selectedPincode = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_pin
        Servicefile.shared.selectedCity = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_city
        Servicefile.shared.selectedaddress = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_address
        Servicefile.shared.lati = Double(Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_lat)!
        Servicefile.shared.long = Double(Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_long)!
        Servicefile.shared.selectedaddress = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_address
         Servicefile.shared.selectedpickname = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].location_nickname
         Servicefile.shared.selecteddefaultstatus = Servicefile.shared.petuserlocaadd[Servicefile.shared.selectedindex].default_status
        let vc = UIStoryboard.pet_vendor_shipingaddlocationViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func call_delete(sender: UIButton){
        let tag = sender.tag
        print("defaulst address status",Servicefile.shared.petuserlocaadd[tag].default_status)
        if Servicefile.shared.petuserlocaadd[tag].default_status == false {
            self.add_id  = Servicefile.shared.petuserlocaadd[tag]._id
            let alert = UIAlertController(title: "Are you sure need to delete the address", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.call_delete_shipping_address(id: self.add_id)
            }))
            self.present(alert, animated: true, completion: nil)
           
        }else{
            self.alert(Message: "Default address can't be deleted")
        }
       
    }
    
    @objc func call_set_marked(sender: UIButton){
        let tag = sender.tag
        self.isselect = self.orgisselect
        self.isselect.remove(at: tag)
        self.isselect.insert("1", at: tag)
        self.tableview_list_address.reloadData()
    }
    
    @IBAction func action_cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_select_theaddress(_ sender: Any) {
        Servicefile.shared.shipaddresslist.removeAll()
        self.call_select_shipping_address(id: self.add_id )
    }
    
    func call_list_shipping_address(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_getAddresslist, method: .post, parameters:
                                                                    ["user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                               
                                                                                Servicefile.shared.petuserlocaadd.removeAll()
                                                                                let Data = res["Data"] as! NSArray
                                                                                self.isselect.removeAll()
                                                                                for itm in 0..<Data.count{
                                                                                    let idata = Data[itm] as! NSDictionary
                                                                                    let _id = idata["_id"] as? String ?? ""
                                                                                    let date_and_time = idata["date_and_time"] as? String ?? ""
                                                                                    let default_status = idata["default_status"] as? Bool ?? false
                                                                                    let location_address = idata["location_address"] as? String ?? ""
                                                                                    let location_city = idata["location_city"] as? String ?? ""
                                                                                    let location_country = idata["location_country"] as? String ?? ""
                                                                                    let location_lat = String(Double(truncating: idata["location_lat"] as? NSNumber ?? 0.0))
                                                                                    let location_long = String(Double(truncating: idata["location_long"] as? NSNumber ?? 0.0))
                                                                                    let location_nickname = idata["location_nickname"] as? String ?? ""
                                                                                    let location_pin = idata["location_pin"] as? String ?? ""
                                                                                    let location_state = idata["location_state"] as? String ?? ""
                                                                                    let location_title = idata["location_title"] as? String ?? ""
                                                                                    let user_id = idata["user_id"] as? String ?? ""
                                                                                    if default_status {
                                                                                        self.isselect.append("1")
                                                                                    }else{
                                                                                        self.isselect.append("0")
                                                                                    }
                                                                                    self.orgisselect.append("0")
                                                                                   
                                                                                    Servicefile.shared.petuserlocaadd.append(locationdetails.init(In_id: _id, In_date_and_time: date_and_time, In_default_status: default_status, In_location_address: location_address, In_location_city: location_city, In_location_country: location_country, In_location_lat: location_lat, In_location_long: location_long, In_location_nickname: location_nickname, In_location_pin: location_pin, In_location_state: location_state, In_location_title: location_title, In_user_id: user_id))
                                                                                }
                                                                                
                                                                                self.tableview_list_address.reloadData()
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }else{
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }
                                                                            break
                                                                        case .failure(let _):
                                                                            self.stopAnimatingActivityIndicator()
                                                                            
                                                                            break
                                                                        }
                                                                     }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
        
    }
    
    func call_select_shipping_address(id: String){
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
                                                                                Servicefile.shared.shipaddresslist.removeAll()
                                                                                self.dismiss(animated: true, completion: nil)
                                                                            }else{
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }
                                                                            break
                                                                        case .failure(let _):
                                                                            self.stopAnimatingActivityIndicator()
                                                                            
                                                                            break
                                                                        }
                                                                     }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
        
    }
  
    func call_delete_shipping_address(id: String){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_deleteaddress, method: .post, parameters:
                                                                    ["_id": id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                Servicefile.shared.shipaddresslist.removeAll()
                                                                                self.dismiss(animated: true, completion: nil)
                                                                            }else{
                                                                                self.stopAnimatingActivityIndicator()
                                                                            }
                                                                            break
                                                                        case .failure(let _):
                                                                            self.stopAnimatingActivityIndicator()
                                                                            
                                                                            break
                                                                        }
                                                                     }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
        
    }

}
