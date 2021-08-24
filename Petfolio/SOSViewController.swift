//
//  SOSViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 14/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class SOSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var view_img: UIView!
    @IBOutlet weak var img_sos: UIImageView!
    @IBOutlet weak var tbl_calllist: UITableView!
    @IBOutlet weak var view_call: UIView!
    
    var sel = ["0"]
    var issel = ["0"]
    var isedit = ["0"]
    var phono = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        
        self.tbl_calllist.register(UINib(nibName: "soscallTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.sel.removeAll()
        self.issel.removeAll()
//        for itm in 0..<Servicefile.shared.sosnumbers.count{
//            if itm == 0 {
//                self.issel.append("1")
//                self.phono = Servicefile.shared.sosnumbers[itm].number
//            }else{
//                self.issel.append("0")
//            }
//            self.sel.append("0")
//        }
        Servicefile.shared.sosnumbers.removeAll()
        self.sel.removeAll()
        self.issel.removeAll()
        self.isedit.removeAll()
        self.tbl_calllist.delegate = self
        self.tbl_calllist.dataSource = self
        self.view_main.view_cornor()
        self.view_img.dropShadow()
        self.view_img.layer.cornerRadius = self.view_img.frame.width / 2
        self.img_sos.layer.cornerRadius = self.img_sos.frame.width / 2
        self.view_call.view_cornor()
        self.view_call.dropShadow()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.issel = sel
        self.isedit = sel
        self.call_sos_list()
    }
    
    @IBAction func action_close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.sosnumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! soscallTableViewCell
        if self.issel[indexPath.row] == "1" {
            cell.label_name.textColor = UIColor.white
            cell.label_phone.textColor = UIColor.white
            cell.label_name.text = Servicefile.shared.sosnumbers[indexPath.row].title
            cell.label_phone.text = Servicefile.shared.sosnumbers[indexPath.row].number
            cell.view_main.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: "#ED3558")
            cell.selectionStyle = .none
        }else{
            cell.label_name.textColor = UIColor.black
            cell.label_phone.textColor = UIColor.black
            cell.label_name.text = Servicefile.shared.sosnumbers[indexPath.row].title
            cell.label_phone.text = Servicefile.shared.sosnumbers[indexPath.row].number
            cell.view_main.backgroundColor = UIColor.white
            cell.selectionStyle = .none
        }
        if self.isedit[indexPath.row] == "1" {
            cell.view_edit.isHidden = false
        }else{
            cell.view_edit.isHidden = true
        }
        if Servicefile.shared.sosnumbers[indexPath.row].Edit_status {
            cell.view_menu.isHidden = false
        }else{
            cell.view_menu.isHidden = true
        }
        cell.view_main.dropShadow()
        cell.view_main.view_cornor()
        cell.view_edit.dropShadow()
        cell.view_edit.view_cornor()
        cell.btn_menu.tag = indexPath.row
        cell.btn_menu.addTarget(self, action: #selector(viewmenu), for: .touchUpInside)
        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(edit_action), for: .touchUpInside)
        return cell
    }
    
    @objc func edit_action(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.sosselect = tag
        let vc = UIStoryboard.editsosViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func viewmenu(sender: UIButton) {
        let tag = sender.tag
        self.isedit = self.sel
        self.isedit.remove(at: tag)
        self.isedit.insert("1", at: tag)
        self.tbl_calllist.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.issel = self.sel
        self.isedit = self.sel
        self.issel.remove(at: indexPath.row)
        self.issel.insert("1", at: indexPath.row)
        self.phono = Servicefile.shared.sosnumbers[indexPath.row].number
        self.tbl_calllist.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func action_call(_ sender: Any) {
        let url = URL(string: "tel://\(phono)")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func call_sos_list(){
        self.issel.removeAll()
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.pet_sos_list, method: .post,
                       parameters: ["user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                        switch (response.result) {
                        case .success:
                            let res = response.value as! NSDictionary
                            print("success data",res)
                            let Code  = res["Code"] as! Int
                            if Code == 200 {
                                Servicefile.shared.sosnumbers.removeAll()
                                let Data = res["Data"] as! NSArray
                                for i in 0..<Data.count{
                                    let dval = Data[i] as! NSDictionary
                                    let Edit_status = dval["Edit_status"] as? Bool ?? false
                                    let _id = dval["_id"] as? Int ?? 0
                                    let name = dval["name"] as? String ?? ""
                                    let phone = dval["phone"] as? String ?? ""
                                    if i == 0 {
                                        self.phono = phone
                                        self.issel.append("1")
                                    }else{
                                        self.issel.append("0")
                                    }
                                    self.sel.append("0")
                                    self.isedit.append("0")
                                    Servicefile.shared.sosnumbers.append(sosnumber.init(i_number: phone, I_title: name, I_id: _id, I_Edit_status: Edit_status))
                                }
                                self.tbl_calllist.reloadData()
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
