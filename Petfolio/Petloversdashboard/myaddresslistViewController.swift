//
//  myaddresslistViewController.swift
//  Petfolio
//
//  Created by Admin on 13/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class myaddresslistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl_addresslist: UITableView!
    @IBOutlet weak var label_noofsavedaddress: UILabel!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var label_alertMSG: UILabel!
    @IBOutlet weak var view_yes: UIView!
    @IBOutlet weak var view_no: UIView!
    @IBOutlet weak var label_noaddress: UILabel!
    
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    var proc_type = "edit"
    var indextag = 0
    
    var isclickisoption = ["0"]
    var isorgiclikcopt = ["0"]
    
    var isselect = [""]
    var orgisselect = [""]
    var add_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.intial_setup_action()
        self.view_popup.view_cornor()
        self.label_noaddress.isHidden = true
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        Servicefile.shared.shipaddresslist_isedit = false
        self.isselect.removeAll()
        self.orgisselect.removeAll()
        self.tbl_addresslist.register(UINib(nibName: "editshipaddresslistTableViewCell", bundle: nil), forCellReuseIdentifier: "listaddress")
        // Do any additional setup after loading the view.
        self.tbl_addresslist.delegate = self
        self.tbl_addresslist.dataSource = self
        
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "My Addresses"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: false, b2: false, b3: true, b4: false, b5: false)
    // footer action
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.call_list_shipping_address()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func action_back(_ sender: Any) {
        Servicefile.shared.shipaddresslist_isedit = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func back(){
        Servicefile.shared.shipaddresslist_isedit = false
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_addaddress(_ sender: Any) {
        Servicefile.shared.shipaddresslist.removeAll()
        Servicefile.shared.shipaddresslist_isedit = false
        let vc = UIStoryboard.myaddress_create_address_ViewController()
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
        cell.selectionStyle = .none
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
        //
        self.view_shadow.isHidden = false
        self.view_popup.isHidden = false
         self.label_alertMSG.text = "Are you sure you want to change the edit Address"
         self.proc_type = "edit"
        //
       
    }
    
    @objc func call_delete(sender: UIButton){
        //
        self.view_shadow.isHidden = false
        self.view_popup.isHidden = false
         self.label_alertMSG.text = "Are you sure you want to change the edit Address"
         self.proc_type = "delete"
        //
        let tag = sender.tag
        Servicefile.shared.shipaddresslist_index = tag
    }
    
    @IBAction func action_yes(_ sender: Any) {
        if self.proc_type == "default" {
            self.view_shadow.isHidden = true
            self.view_popup.isHidden = true
            self.isselect = self.orgisselect
            self.isselect.remove(at: Servicefile.shared.shipaddresslist_index)
            self.isselect.insert("1", at: Servicefile.shared.shipaddresslist_index)
            let details = Servicefile.shared.shipaddresslist[Servicefile.shared.shipaddresslist_index] as! NSDictionary
            self.add_id  = details["_id"] as? String ?? ""
            self.tbl_addresslist.reloadData()
            self.call_select_shipping_address(id: self.add_id)
            //self.callchangedefault(id : Servicefile.shared.petuserlocaadd[self.indextag]._id)
        }else if self.proc_type == "edit" {
            self.view_shadow.isHidden = true
            self.view_popup.isHidden = true
            Servicefile.shared.shipaddresslist_isedit = true
            let vc = UIStoryboard.myaddress_create_address_ViewController()
            self.present(vc, animated: true, completion: nil)
        }else{
            let details = Servicefile.shared.shipaddresslist[Servicefile.shared.shipaddresslist_index] as! NSDictionary
            self.add_id  = details["_id"] as? String ?? ""
            call_delete_shipping_address(id: self.add_id)
        }
    }
    
    @IBAction func action_no(_ sender: Any) {
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
    }
    
    @objc func call_set_marked(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.shipaddresslist_index = tag
        self.view_shadow.isHidden = false
        self.view_popup.isHidden = false
         self.label_alertMSG.text = "Are you sure you want to change to default Address"
         self.proc_type = "default"
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
                                                                                self.label_noofsavedaddress.text = String(Servicefile.shared.shipaddresslist.count) + " saved address"
                                                                                if  Servicefile.shared.shipaddresslist.count > 0 {
                                                                                    self.label_noaddress.isHidden = true
                                                                                    self.label_noofsavedaddress.isHidden = false
                                                                                }else{
                                                                                    self.label_noaddress.isHidden = false
                                                                                    self.label_noofsavedaddress.isHidden = true
                                                                                    }
                                                                               
                                                                                self.tbl_addresslist.reloadData()
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
                                                                               
                                                                                self.call_list_shipping_address()
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
                                                                                self.call_list_shipping_address()
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
