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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func action_back(_ sender: Any) {
        Servicefile.shared.shipaddresslist_isedit = false
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func action_addaddress(_ sender: Any) {
        Servicefile.shared.shipaddresslist.removeAll()
        Servicefile.shared.shipaddresslist_isedit = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_vendor_shippingaddressViewController") as! pet_vendor_shippingaddressViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.shipaddresslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: editshipaddresslistTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listaddress", for: indexPath) as! editshipaddresslistTableViewCell
                
        let details = Servicefile.shared.shipaddresslist[indexPath.row] as! NSDictionary
//        "_id": "605a4b9cbaeb4c22731c9248",
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
        let fname  = details["user_first_name"] as? String ?? ""
        let lname  = details["user_last_name"] as? String ?? ""
        let flatno = details["user_flat_no"] as? String ?? "" + ", "
        let street = details["user_stree"] as? String ?? "" + ", "
        let city =  details["user_city"] as? String ?? ""
        let state =  details["user_state"] as? String ?? "" + ", "
        let pincode =  details["user_picocode"] as? String ?? ""
        let user_address_stauts =  details["user_address_stauts"] as? String ?? ""
        cell.label_name.text = fname + " " + lname
        cell.label_mobileno.text = details["user_mobile"] as? String ?? ""
        cell.label_addressline1.text = flatno
        cell.label_addressline2.text = street
        cell.label_addressline3.text = city + ", " + state + ", " + pincode
        cell.label_add_type.text = details["user_address_type"] as? String ?? ""
        cell.view_main.view_cornor()
        cell.view_add_type.view_cornor()
        cell.view_add_type.layer.borderWidth = 0.5
        cell.view_add_type.layer.borderColor = UIColor.lightGray.cgColor
        if self.isselect[indexPath.row] == "1" {
            self.add_id  = details["_id"] as? String ?? ""
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
        Servicefile.shared.shipaddresslist_index = tag
        Servicefile.shared.shipaddresslist_isedit = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_vendor_shippingaddressViewController") as! pet_vendor_shippingaddressViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func call_delete(sender: UIButton){
        let tag = sender.tag
        let details = Servicefile.shared.shipaddresslist[tag] as! NSDictionary
        self.add_id  = details["_id"] as? String ?? ""
        call_delete_shipping_address(id: self.add_id)
    }
    
    @objc func call_set_marked(sender: UIButton){
        let tag = sender.tag
        self.isselect = self.orgisselect
        self.isselect.remove(at: tag)
        self.isselect.insert("1", at: tag)
        let details = Servicefile.shared.shipaddresslist[tag] as! NSDictionary
        self.add_id  = details["_id"] as? String ?? ""
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_editshiping_address_list, method: .post, parameters:
                                                                    ["user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                Servicefile.shared.shipaddresslist.removeAll()
                                                                                let data = res["Data"] as! NSArray
                                                                                Servicefile.shared.shipaddresslist = data as! [Any]
                                                                                self.isselect.removeAll()
                                                                                for i in 0..<Servicefile.shared.shipaddresslist.count{
                                                                                    let details = Servicefile.shared.shipaddresslist[i] as! NSDictionary
                                                                                    let user_address_stauts =  details["user_address_stauts"] as? String ?? ""
                                                                                    if user_address_stauts == "Last Used" {
                                                                                        self.isselect.append("1")
                                                                                    }else{
                                                                                        self.isselect.append("0")
                                                                                    }
                                                                                    self.orgisselect.append("0")
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
    
    func call_select_shipping_address(id: String){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_mark_shiping_address_list, method: .post, parameters:
                                                                    ["user_id":Servicefile.shared.userid,
                                                                     "user_address_stauts" : "Last Used",
                                                                     "_id": id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
        
    }
  
    func call_delete_shipping_address(id: String){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_delete_shiping_address_list, method: .post, parameters:
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
            self.alert(Message: "No Intenet Please check and try again ")
        }
        
    }

}
