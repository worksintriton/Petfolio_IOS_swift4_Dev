//
//  Sp_dash_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 22/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Sp_dash_ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var view_new: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_missed: UIView!
    @IBOutlet weak var view_footer: UIView!
    
    @IBOutlet weak var label_new: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    
    @IBOutlet weak var tblview_applist: UITableView!
    @IBOutlet weak var label_completed: UILabel!
    @IBOutlet weak var label_missed: UILabel!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_refresh: UIView!
    @IBOutlet weak var label_failedstatus: UILabel!
    
    
    
    var appointtype = "New"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.label_nodata.isHidden = true
        
        self.view_new.layer.cornerRadius = 9.0
        self.view_missed.layer.cornerRadius = 9.0
        self.view_footer.layer.cornerRadius = 15.0
        self.view_completed.layer.cornerRadius = 9.0
         self.view_popup.layer.cornerRadius = 9.0
         self.view_refresh.layer.cornerRadius = 9.0
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.view_completed.layer.borderWidth = 0.5
        self.view_missed.layer.borderWidth = 0.5
        self.view_new.layer.borderWidth = 0.5
        let appgree = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appgree.cgColor
        self.view_missed.layer.borderColor = appgree.cgColor
        
        self.tblview_applist.delegate = self
        self.tblview_applist.dataSource = self
        // Do any additional setup after loading the view.
        self.callcheckstatus()
    }
    
    
    @IBAction func action_refresh(_ sender: Any) {
        self.callcheckstatus()
    }
    
    
    @IBAction func action_sidemenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sp_side_menuViewController") as! sp_side_menuViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.Doc_dashlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! docdashTableViewCell
        
        if self.appointtype == "New" {
            cell.image_emergnecy.isHidden = true
            cell.view_commissed.isHidden = true
            cell.btn_complete.tag = indexPath.row
             cell.btn_cancel.tag = indexPath.row
            cell.btn_complete.addTarget(self, action: #selector(action_complete), for: .touchUpInside)
            cell.btn_cancel.addTarget(self, action: #selector(action_cancelled), for: .touchUpInside)
            if Servicefile.shared.Doc_dashlist[indexPath.row].appoinment_status == "Emergency" {
                cell.image_emergnecy.isHidden = false
            }else{
                cell.image_emergnecy.isHidden = true
            }
        }else if self.appointtype == "Complete"{
             cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].book_date_time
            cell.labe_comMissed.text = "Completion on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].book_date_time
             cell.labe_comMissed.text = "Missed on :"
            cell.label_completedon.textColor = UIColor.red
             cell.labe_comMissed.textColor = UIColor.red
        }
        
        cell.view_completebtn.layer.cornerRadius = 10.0
        cell.view_cancnel.layer.cornerRadius = 10.0
        cell.View_mainview.layer.borderWidth = 0.2
        cell.View_mainview.layer.borderColor = UIColor.lightGray.cgColor
        cell.label_petname.text = Servicefile.shared.Doc_dashlist[indexPath.row].pet_name
        cell.label_pettype.text = Servicefile.shared.Doc_dashlist[indexPath.row].pet_type
        cell.img_petimg.image = UIImage(named: "sample")
        cell.label_amount.text =  "₹" + Servicefile.shared.Doc_dashlist[indexPath.row].amount
        
        if Servicefile.shared.Doc_dashlist[indexPath.row].pet_img == "" {
              cell.img_petimg.image = UIImage(named: "sample")
        }else{
              cell.img_petimg.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.Doc_dashlist[indexPath.row].pet_img)) { (image, error, cache, urls) in
                        if (error != nil) {
                            cell.img_petimg.image = UIImage(named: "sample")
                        } else {
                            cell.img_petimg.image = image
                        }
                    }
        }

        return cell
    }
    
    @objc func action_complete(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.appointmentindex = tag
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_prescriptionViewController") as! Doc_prescriptionViewController
               self.present(vc, animated: true, completion: nil)
    }
    @objc func action_cancelled(sender : UIButton){
        let tag = sender.tag
        self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.Doc_dashlist[tag].Appid, appointmentstatus: "cancel")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    

    @IBAction func action_missed(_ sender: Any) {
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_missed.backgroundColor = appcolor
        self.label_missed.textColor = UIColor.white
        self.view_new.backgroundColor = UIColor.white
        self.label_new.textColor = appcolor
        self.label_completed.textColor = appcolor
        self.view_completed.backgroundColor = UIColor.white
        self.view_new.layer.borderColor = appcolor.cgColor
        self.view_new.backgroundColor = UIColor.white
        self.appointtype = "Missed"
        //self.callmiss()
        
    }
    @IBAction func action_completeappoint(_ sender: Any) {
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.backgroundColor = appcolor
        self.label_completed.textColor = UIColor.white
        self.view_new.backgroundColor = UIColor.white
        self.view_missed.backgroundColor = UIColor.white
        self.label_new.textColor = appcolor
        self.label_missed.textColor = appcolor
        self.view_new.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
        self.appointtype = "Complete"
        //self.callcom()
       
    }
    @IBAction func action_newappoint(_ sender: Any) {
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_new.backgroundColor = appcolor
        self.label_new.textColor = UIColor.white
        self.view_completed.backgroundColor = UIColor.white
        self.view_missed.backgroundColor = UIColor.white
        self.label_completed.textColor = appcolor
        self.label_missed.textColor = appcolor
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
        self.appointtype = "New"
        //self.callnew()
        
    }
    
    @IBAction func action_logout(_ sender: Any) {
        
    }
    func callnew(){
         Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.docdashboardnewapp, method: .post, parameters:
        ["doctor_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                     Servicefile.shared.Doc_dashlist.removeAll()
                                                                                                             let Data = res["Data"] as! NSArray
                                                                                                             for itm in 0..<Data.count{
                                                                                                                 let dataitm = Data[itm] as! NSDictionary
                                                                                                                 let id = dataitm["_id"] as! String
                                                                                                                 let allergies = dataitm["allergies"] as! String
                                                                                                                 let amount = dataitm["amount"] as! String
                                                                                                                 let booking_date_time = dataitm["booking_date_time"] as! String
                                                                                                                 let appointment_types = dataitm["appointment_types"] as! String
                                                                                                                 let user_rate = dataitm["user_rate"] as! String
                                                                                                                 let user_feedback = dataitm["user_feedback"] as! String
                                                                                                                 
                                                                                                                 let doc_business_info = dataitm["doc_business_info"] as! NSArray
                                                                                                                 var docimg = ""
                                                                                                                 var pet_name = ""
                                                                                                                 if doc_business_info.count > 0 {
                                                                                                                     let doc_business = doc_business_info[0] as! NSDictionary
                                                                                                                     let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                                                                                                     if clinic_pic.count > 0 {
                                                                                                                         let imgdata = clinic_pic[0] as! NSDictionary
                                                                                                                         docimg = imgdata["clinic_pic"] as! String
                                                                                                                     }
                                                                                                                      pet_name = doc_business["clinic_name"] as! String
                                                                                                                 }
                                                                                                                 let petdetail = dataitm["pet_id"] as! NSDictionary
                                                                                                                 let petid = petdetail["_id"] as! String
                                                                                                                 let pet_type = petdetail["pet_name"] as! String
                                                                                                                 let pet_breed = petdetail["pet_breed"] as! String
                                                                                                                 let pet_img = petdetail["pet_img"] as! String
                                                                                                                 let user_id = petdetail["user_id"] as! String
                                                                                                                 Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback))
                                                                                                               
                                                                                                             }
                                                                                                             if Servicefile.shared.Doc_dashlist.count > 0 {
                                                                                                                 self.label_nodata.isHidden = true
                                                                                                             }else{
                                                                                                                  self.label_nodata.isHidden = false
                                                                                                             }
                                                    self.tblview_applist.reloadData()
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
    func callcom(){
            Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
           self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.docdashboardcomapp, method: .post, parameters:
           ["doctor_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                               switch (response.result) {
                                               case .success:
                                                     let res = response.value as! NSDictionary
                                                     print("success data",res)
                                                     let Code  = res["Code"] as! Int
                                                     if Code == 200 {
                                                        Servicefile.shared.Doc_dashlist.removeAll()
                                                                                                                 let Data = res["Data"] as! NSArray
                                                                                                                 for itm in 0..<Data.count{
                                                                                                                     let dataitm = Data[itm] as! NSDictionary
                                                                                                                     let id = dataitm["_id"] as! String
                                                                                                                     let allergies = dataitm["allergies"] as! String
                                                                                                                     let amount = dataitm["amount"] as! String
                                                                                                                     let booking_date_time = dataitm["booking_date_time"] as! String
                                                                                                                     let appointment_types = dataitm["appointment_types"] as! String
                                                                                                                     let user_rate = dataitm["user_rate"] as! String
                                                                                                                     let user_feedback = dataitm["user_feedback"] as! String
                                                                                                                     
                                                                                                                     let doc_business_info = dataitm["doc_business_info"] as! NSArray
                                                                                                                     var docimg = ""
                                                                                                                     var pet_name = ""
                                                                                                                     if doc_business_info.count > 0 {
                                                                                                                         let doc_business = doc_business_info[0] as! NSDictionary
                                                                                                                         let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                                                                                                         if clinic_pic.count > 0 {
                                                                                                                             let imgdata = clinic_pic[0] as! NSDictionary
                                                                                                                             docimg = imgdata["clinic_pic"] as! String
                                                                                                                         }
                                                                                                                          pet_name = doc_business["clinic_name"] as! String
                                                                                                                     }
                                                                                                                     let petdetail = dataitm["pet_id"] as! NSDictionary
                                                                                                                     let petid = petdetail["_id"] as! String
                                                                                                                     let pet_type = petdetail["pet_name"] as! String
                                                                                                                     let pet_breed = petdetail["pet_breed"] as! String
                                                                                                                     let pet_img = petdetail["pet_img"] as! String
                                                                                                                     let user_id = petdetail["user_id"] as! String
                                                                                                                     Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback))
                                                                                                                   
                                                                                                                 }
                                                                                                                 if Servicefile.shared.Doc_dashlist.count > 0 {
                                                                                                                     self.label_nodata.isHidden = true
                                                                                                                 }else{
                                                                                                                      self.label_nodata.isHidden = false
                                                                                                                 }
                                                        self.tblview_applist.reloadData()
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
    func callmiss(){
               Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
              self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.docdashboardmissapp, method: .post, parameters:
              ["doctor_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                  switch (response.result) {
                                                  case .success:
                                                        let res = response.value as! NSDictionary
                                                        print("success data",res)
                                                        let Code  = res["Code"] as! Int
                                                        if Code == 200 {
                                                            Servicefile.shared.Doc_dashlist.removeAll()
                                                                                                                     let Data = res["Data"] as! NSArray
                                                                                                                     for itm in 0..<Data.count{
                                                                                                                         let dataitm = Data[itm] as! NSDictionary
                                                                                                                         let id = dataitm["_id"] as! String
                                                                                                                         let allergies = dataitm["allergies"] as! String
                                                                                                                         let amount = dataitm["amount"] as! String
                                                                                                                         let booking_date_time = dataitm["booking_date_time"] as! String
                                                                                                                         let appointment_types = dataitm["appointment_types"] as! String
                                                                                                                         let user_rate = dataitm["user_rate"] as! String
                                                                                                                         let user_feedback = dataitm["user_feedback"] as! String
                                                                                                                         
                                                                                                                         let doc_business_info = dataitm["doc_business_info"] as! NSArray
                                                                                                                         var docimg = ""
                                                                                                                         var pet_name = ""
                                                                                                                         if doc_business_info.count > 0 {
                                                                                                                             let doc_business = doc_business_info[0] as! NSDictionary
                                                                                                                             let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                                                                                                             if clinic_pic.count > 0 {
                                                                                                                                 let imgdata = clinic_pic[0] as! NSDictionary
                                                                                                                                 docimg = imgdata["clinic_pic"] as! String
                                                                                                                             }
                                                                                                                              pet_name = doc_business["clinic_name"] as! String
                                                                                                                         }
                                                                                                                         let petdetail = dataitm["pet_id"] as! NSDictionary
                                                                                                                         let petid = petdetail["_id"] as! String
                                                                                                                         let pet_type = petdetail["pet_name"] as! String
                                                                                                                         let pet_breed = petdetail["pet_breed"] as! String
                                                                                                                         let pet_img = petdetail["pet_img"] as! String
                                                                                                                         let user_id = petdetail["user_id"] as! String
                                                                                                                         Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback))
                                                                                                                       
                                                                                                                     }
                                                                                                                     if Servicefile.shared.Doc_dashlist.count > 0 {
                                                                                                                         self.label_nodata.isHidden = true
                                                                                                                     }else{
                                                                                                                          self.label_nodata.isHidden = false
                                                                                                                     }
                                                            self.tblview_applist.reloadData()
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
    
    func callcompleteMissedappoitment(Appointmentid: String, appointmentstatus: String){
        
        var params = ["":""]
        if appointmentstatus != "cancel"{
            params = ["_id": Appointmentid,
                      "completed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                      "appoinment_status" : "Completed"]
        }else{
            params = [ "_id": Appointmentid,
                       "missed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                       "appoinment_status" : "Missed"]
        }
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
                                                             
                                                            
                                                            self.callnew()
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
    
    func callcheckstatus(){
             Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
    self.startAnimatingActivityIndicator()
      if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.sp_regi_status, method: .post, parameters: ["user_id": Servicefile.shared.userid]
           , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                           let Data = res["Data"] as! NSDictionary
                                                        let profile_status = Data["profile_status"] as! Bool
                                                        print("profile_status",profile_status)
                                                        if profile_status == false {
                                                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SP_Reg_ViewController") as! SP_Reg_ViewController
                                                                   self.present(vc, animated: true, completion: nil)
                                                        }else {
                                                             let profile_verification_status = Data["profile_verification_status"] as! String
                                                            if profile_verification_status == "Not verified" {
                                                                self.view_shadow.isHidden = false
                                                                self.view_popup.isHidden = false
                                                                let Message = res["Message"] as! String
                                                                self.label_failedstatus.text = Message
                                                            }else{
                                                                self.view_shadow.isHidden = true
                                                                self.view_popup.isHidden = true
                                                            }
                                                        }
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
           let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
           self.present(alert, animated: true, completion: nil)
       }
    
    @IBAction func actionl_ogout(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        Servicefile.shared.usertype = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
           self.present(vc, animated: true, completion: nil)
       }
}