//
//  Doc_addholidayViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 24/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Doc_addholidayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_holidaylist: UITableView!
    @IBOutlet weak var view_datepicker: UIView!
    @IBOutlet weak var datepick_date: UIDatePicker!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var view_submit: UIView!
    @IBOutlet weak var view_date: UIView!
    
    var doc_selholiday = [""]
    var docselholidayid = [""]
    var seldate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callholidaylist()
        self.view_submit.view_cornor()
        self.view_submit.dropShadow()
        self.view_date.view_cornor()
        self.view_date.dropShadow()
        self.doc_selholiday.removeAll()
        self.tbl_holidaylist.delegate = self
        self.tbl_holidaylist.dataSource = self
        self.view_datepicker.isHidden = true
        self.datepick_date.datePickerMode = .date
        if #available(iOS 13.4, *) {
            self.datepick_date.preferredDatePickerStyle = .wheels
         } else {
                  
        }
        self.datepick_date.minimumDate = Date()
        self.datepick_date.addTarget(self, action: #selector(dateChange(_:)), for: .valueChanged)
    }
    
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
             let senderdate = sender.date
           let format = DateFormatter()
          format.dateFormat = "dd-MM-yyyy"
          let Date = format.string(from: senderdate)
        self.seldate = Date
    }
      
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? mycalenderViewController {
            DispatchQueue.main.async {
                firstVC.viewWillAppear(true)
            }
        }
    }
    
    @IBAction func action_showdate(_ sender: Any) {
         self.view_datepicker.isHidden = false
    }
    
    @IBAction func action_selectdate(_ sender: Any) {
        self.lbl_date.text = self.seldate
        self.view_datepicker.isHidden = true
    }
    
    @IBAction func action_submit(_ sender: Any) {
        self.callcreateholiday()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doc_selholiday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! holidaysTableViewCell
        cell.lab_title.text = self.doc_selholiday[indexPath.row]
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(act_deleteholiday), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func act_deleteholiday(sender: UIButton){
        let btntag = sender.tag
        self.calldelete(del_val: self.docselholidayid[btntag])
    }
    
    func calldelete(del_val: String){
        print("data in delete",del_val)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_deleteholiday, method: .post, parameters:
     ["_id": del_val], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    self.callholidaylist()
                                                     self.stopAnimatingActivityIndicator()
                                                  }else{
                                                    self.stopAnimatingActivityIndicator()
                                                    print("status code service denied")
                                                    let Message  = res["Message"] as? String ?? ""
                                                    self.alert(Message: Message)
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
   

    func callholidaylist() {
        self.startAnimatingActivityIndicator()
               if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_getholdiaylist, method: .post, parameters:
                ["user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                            self.doc_selholiday.removeAll()
                                                            self.docselholidayid.removeAll()
                                                          let data  = res["Data"] as! NSArray
                                                            for itm in 0..<data.count{
                                                                let itdata = data[itm] as! NSDictionary
                                                                let id = itdata["_id"] as? String ?? ""
                                                                let date = itdata["Date"] as? String ?? ""
                                                                self.doc_selholiday.append(date)
                                                                self.docselholidayid.append(id)
                                                            }
                                                            self.tbl_holidaylist.reloadData()
                                                            self.stopAnimatingActivityIndicator()
                                                         }else{
                                                           self.stopAnimatingActivityIndicator()
                                                            let Message  = res["Message"] as? String ?? ""
                                                            self.alert(Message: Message)
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
    
    func callcreateholiday() {
        self.startAnimatingActivityIndicator()
               if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_createholiday, method: .post, parameters:
                ["user_id" : Servicefile.shared.userid,
                 "Date" : Servicefile.shared.checktextfield(textfield: self.lbl_date.text!)], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                            self.callholidaylist()
                                                            self.stopAnimatingActivityIndicator()
                                                         }else{
                                                           self.stopAnimatingActivityIndicator()
                                                           print("status code service denied")
                                                            let Message  = res["Message"] as? String ?? ""
                                                            self.alert(Message: Message)
                                                         }
                                                       break
                                                   case .failure(let Error):
                                                       self.stopAnimatingActivityIndicator()
                                                       print("Can't Connect to Server / TimeOut",Error)
                                                       break
                                                   }
                                      }
               } else{
                   self.stopAnimatingActivityIndicator()
                   self.alert(Message: "No Intenet Please check and try again ")
               }
    }
}
