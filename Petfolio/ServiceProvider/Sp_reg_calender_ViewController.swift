//
//  Sp_reg_calender_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 07/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Sp_reg_calender_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tbl_availdays: UITableView!
    @IBOutlet weak var view_next: UIView!
    
    var availday = ["Monday"]
    var isavailday = ["0"]
    var isedit = ["0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.Doc_mycalender_selectedhours.removeAll()
        Servicefile.shared.docMycalHourdicarray.removeAll()
        self.availday.removeAll()
        self.isedit.removeAll()
        self.isavailday.removeAll()
        self.tbl_availdays.delegate = self
        self.tbl_availdays.dataSource = self
        self.view_next.view_cornor()
        self.view_next.isHidden = true
        self.view_next.dropShadow()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callmycalender()
    }
    
    
    @IBAction func action_next(_ sender: Any) {
        Servicefile.shared.Doc_mycalender_selecteddates.removeAll()
        for itme in 0..<isavailday.count{
            let data = isavailday[itme]
            if data == "1"{
                Servicefile.shared.Doc_mycalender_selecteddates.append(self.availday[itme])
            }
        }
        print("Doc_mycalender data to pass",Servicefile.shared.Doc_mycalender_selecteddates)
       if Servicefile.shared.Doc_mycalender_selecteddates.count > 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "sp_reg_calender_hour_ViewController") as! sp_reg_calender_hour_ViewController
                   self.present(vc, animated: true, completion: nil)
       }else {
        self.alert(Message: "Please select the week days")
        }
    }
    
    @IBAction func sction_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func action_holida(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_addholidayViewController") as! Doc_addholidayViewController
               self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Mycal_edit_availdayTableViewCell
        if self.isavailday[indexPath.row] != "0" {
        cell.img_check.image = UIImage(named: " checkbox-1")
               } else{
                   cell.img_check.image = UIImage(named: " checkbox")
               }
        cell.label_weekday.text! = self.availday[indexPath.row]
        if self.isedit[indexPath.row] == "1" {
            cell.view_edit.isHidden = true
        } else {
            cell.view_edit.isHidden = false
        }
        cell.btn_availcheck.tag = indexPath.row
        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(action_btnedit), for: .touchUpInside)
        cell.btn_availcheck.addTarget(self, action: #selector(action_availcheck), for: .touchUpInside)
        return cell
    }
    
   
    
    @objc func action_btnedit(sender : UIButton){
        Servicefile.shared.Doc_mycalender_selecteddates.removeAll()
        let btntag = sender.tag
        Servicefile.shared.Doc_mycalender_selecteddates.append(self.availday[btntag])
        print("Doc_mycalender data to pass",Servicefile.shared.Doc_mycalender_selecteddates)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sp_reg_calender_hour_ViewController") as! sp_reg_calender_hour_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_availcheck(sender : UIButton){
        let btntag = sender.tag
        if self.isavailday[btntag] == "0" {
            self.isavailday.remove(at: btntag)
            self.isavailday.insert("1", at: btntag)
            self.view_next.isHidden = false
        }else{
            self.isavailday.remove(at: btntag)
            self.isavailday.insert("0", at: btntag)
        }
        
        self.tbl_availdays.reloadData()
    }

    @IBAction func action_backaction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
       func callmycalender(){
        self.availday.removeAll()
        self.isedit.removeAll()
        self.isavailday.removeAll()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
       print("user type",Servicefile.shared.userid)
               self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Sp_mycalender, method: .post, parameters:
            ["user_id": Servicefile.shared.userid,
             "sp_name": Servicefile.shared.first_name,
                  "types" : 1 ], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                           let Data = res["Data"] as! NSArray
                                                            for itm in 0..<Data.count{
                                                                let itdata = Data[itm] as! NSDictionary
                                                                let title = itdata["Title"] as? String ?? ""
                                                                let status = itdata["Status"] as? Bool ?? false
//                                                                if false checkbok should allow to click check box else
//                                                                show edit box
                                                                var isstatus = "0"
                                                                if status != false {
                                                                      isstatus = "0"
                                                                }else{
                                                                     isstatus = "1"
                                                                }
                                                                self.availday.append(title)
                                                                self.isedit.append(isstatus)
                                                                self.isavailday.append("0")
                                                            }
                                                            self.tbl_availdays.reloadData()
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
