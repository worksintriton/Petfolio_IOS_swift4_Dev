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
    var sel = ["0"]
    var issel = ["0"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sel.removeAll()
        self.issel.removeAll()
        for itm in 0..<Servicefile.shared.sosnumbers.count{
            if itm == 0 {
                self.sel.append("1")
                self.issel.append("1")
            }else{
                self.sel.append("0")
                self.issel.append("0")
            }
        }
        self.tbl_calllist.delegate = self
        self.tbl_calllist.dataSource = self
        self.view_main.layer.cornerRadius = 15.0
        self.view_img.layer.cornerRadius = self.view_img.frame.width / 2
        self.img_sos.layer.cornerRadius = self.img_sos.frame.width / 2
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! sosTableViewCell
        if self.issel[indexPath.row] == "1" {
            cell.label_contact.textColor = UIColor.white
            cell.label_phno.text = Servicefile.shared.sosnumbers[indexPath.row].number
            cell.view_sos.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: "#ED3558")
        }else{
            cell.label_contact.textColor = UIColor.black
             cell.label_phno.textColor = UIColor.black
            cell.label_phno.text = Servicefile.shared.sosnumbers[indexPath.row].number
            cell.view_sos.backgroundColor = UIColor.white
        }
        cell.view_sos.layer.cornerRadius = 15.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.issel = self.sel
        self.issel.remove(at: indexPath.row)
        self.issel.insert("1", at: indexPath.row)
        self.tbl_calllist.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    @IBAction func action_call(_ sender: Any) {
        
    }
    
    
}
