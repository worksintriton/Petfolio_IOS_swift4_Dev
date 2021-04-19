//
//  Doc_prescriptionViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 04/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Doc_prescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var tbl_medilist: UITableView!
    
    @IBOutlet weak var textview_descrip: UITextView!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var label_popup: UILabel!
    @IBOutlet weak var view_btn: UIView!
    @IBOutlet weak var view_submit: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.Doc_pres.removeAll()
        self.tbl_medilist.delegate = self
        self.tbl_medilist.dataSource = self
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.view_popup.view_cornor()
        self.view_btn.view_cornor()
         self.view_submit.view_cornor()
        self.view_submit.dropShadow()
        self.view_btn.dropShadow()
        self.textview_descrip.delegate = self
        self.textview_descrip.text = "Write here..."
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func action_submitprescription(_ sender: Any) {
        self.callpescription()
    }
    
    @IBAction func action_hidepopup(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DocdashboardViewController") as! DocdashboardViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
                           self.textview_descrip.resignFirstResponder()
                          return false
                      }
          
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textview_descrip.text == "Write here..."{
            self.textview_descrip.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
              return Servicefile.shared.Doc_pres.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Doc_pres_textfieldactionTableViewCell
                      cell.textfield_medi.text = ""
                      cell.textfield_noofdays.text = ""
                      cell.conspdays.text = ""
                      cell.selectionStyle = .none
                      cell.btn_add.addTarget(self, action: #selector(action_addtablet), for: .touchUpInside)
                                     return cell
               }else{
                  let cell =  tableView.dequeueReusableCell(withIdentifier: "pres", for: indexPath) as! Doc_pres_labelTableViewCell
                  let presdata = Servicefile.shared.Doc_pres[indexPath.row] as! NSDictionary
                  cell.label_medi.text = presdata["Tablet_name"] as? String ?? ""
                  cell.label_consp.text = presdata["consumption"] as? String ?? ""
                  cell.label_noofdays.text = presdata["Quantity"] as? String ?? ""
                                return cell
               }
       
    }
    
    @objc func action_addtablet(sender: UIButton){
        print("data in doc pres",Servicefile.shared.medi, Servicefile.shared.noofday, Servicefile.shared.consdays)
        if Servicefile.shared.noofday == "" {
            self.alert(Message: "please enter the no of days")
        }else if Servicefile.shared.medi == "" {
             self.alert(Message: "please enter the Medicine name")
        }else if Servicefile.shared.consdays == "" {
            self.alert(Message: "please enter the consuption days")
        }else{
            var B = Servicefile.shared.Doc_pres
            var arr = B
            let a = ["Quantity": Servicefile.shared.noofday,
                     "Tablet_name": Servicefile.shared.medi,
                     "consumption": Servicefile.shared.consdays] as NSDictionary
            arr.append(a)
            B = arr
            print(B)
            Servicefile.shared.Doc_pres = B
            print("uploaded data in photodicarray",Servicefile.shared.Doc_pres)
            self.tbl_medilist.reloadData()
        }
          Servicefile.shared.medi = ""
            Servicefile.shared.noofday = ""
            Servicefile.shared.consdays = ""
        
    }

    
    
    func callpescription(){
        print("data in prescription")
                 Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                self.startAnimatingActivityIndicator()
          if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_prescription_create, method: .post, parameters: ["doctor_id": Servicefile.shared.userid,
          "Date":Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
          "Doctor_Comments":"test",
          "PDF_format":"",
          "Prescription_type" :"PDF",
          "Prescription_img" : "",
          "user_id": Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].user_id,
          "Prescription_data": Servicefile.shared.Doc_pres,
          "Treatment_Done_by":"Self",
            "Appointment_ID": Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].Appid]
               , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                    switch (response.result) {
                                                    case .success:
                                                          let res = response.value as! NSDictionary
                                                          print("success data",res)
                                                          let Code  = res["Code"] as! Int
                                                          if Code == 200 {
                                                            self.callcompleteMissedappoitment()
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
    
    
    func callcompleteMissedappoitment(){
          var params = ["":""]
        params = ["_id": Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].Appid,
                        "completed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                        "appoinment_status" : "Completed"]
                   Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                  self.startAnimatingActivityIndicator()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_complete_and_Missedapp, method: .post, parameters: params
                 , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                      switch (response.result) {
                                                      case .success:
                                                            let res = response.value as! NSDictionary
                                                            print("success data",res)
                                                            let Code  = res["Code"] as! Int
                                                            if Code == 200 {
                                                               self.view_shadow.isHidden = false
                                                            self.view_popup.isHidden = false
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
      
    
}
