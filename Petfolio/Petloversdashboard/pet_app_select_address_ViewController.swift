//
//  doc_select_address_ViewController.swift
//  Petfolio
//
//  Created by Admin on 13/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_app_select_address_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview_list_address: UITableView!
    
    @IBOutlet weak var view_useaddress: UIView!
    @IBOutlet weak var view_main: UIView!
    var isselect = [""]
    var orgisselect = [""]
    var add_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.view_main.view_cornor()
        self.view_useaddress.view_cornor()
        Servicefile.shared.petuserlocaadd.removeAll()
        self.tableview_list_address.register(UINib(nibName: "pet_app_addresslist_TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableview_list_address.delegate = self
        self.tableview_list_address.dataSource = self
        call_list_shipping_address()
    }
    
    @IBAction func action_use_address(_ sender: Any) {
        Servicefile.shared.pet_apoint_location_id = self.add_id
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.petuserlocaadd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: pet_app_addresslist_TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! pet_app_addresslist_TableViewCell
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
//        cell.btn_edit.tag = indexPath.row
//        cell.btn_edit.addTarget(self, action: #selector(call_edit), for: .touchUpInside)
//        cell.btn_delete.tag = indexPath.row
//        cell.btn_delete.addTarget(self, action: #selector(call_delete), for: .touchUpInside)
        return cell
    }
    
    @objc func call_set_marked(sender: UIButton){
        let tag = sender.tag
        self.isselect = self.orgisselect
        self.isselect.remove(at: tag)
        self.isselect.insert("1", at: tag)
        self.tableview_list_address.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
        
    }

}
