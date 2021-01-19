//
//  Pet_applist_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 02/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Pet_applist_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var view_current: UIView!
       @IBOutlet weak var view_completed: UIView!
       @IBOutlet weak var view_cancelled: UIView!
    @IBOutlet weak var tbl_applist: UITableView!
    @IBOutlet weak var label_current: UILabel!
    @IBOutlet weak var label_complete: UILabel!
    @IBOutlet weak var label_cancelled: UILabel!
    
    @IBOutlet weak var view_footer: UIView!
    @IBOutlet weak var label_nodata: UILabel!
   
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_yes: UIView!
    @IBOutlet weak var view_no: UIView!
    
    var appointtype = "current"
    var indextag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_footer.layer.cornerRadius = 15.0
        self.view_popup.layer.cornerRadius = 10.0
        self.view_yes.layer.cornerRadius = self.view_yes.frame.height / 2
        self.view_no.layer.cornerRadius = self.view_yes.frame.height / 2
        self.tbl_applist.delegate = self
        self.tbl_applist.dataSource = self
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view_current.layer.cornerRadius = 10.0
        self.view_cancelled.layer.cornerRadius = 10.0
        self.view_completed.layer.cornerRadius = 10.0
        self.view_current.layer.borderWidth = 0.5
        self.view_cancelled.layer.borderWidth = 0.5
        self.view_completed.layer.borderWidth = 0.5
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_cancelled.layer.borderColor = appcolor.cgColor
        self.view_current.backgroundColor = appcolor
        self.label_current.textColor = UIColor.white
        self.view_completed.backgroundColor = UIColor.white
        self.view_cancelled.backgroundColor = UIColor.white
        self.label_complete.textColor = appcolor
        self.label_cancelled.textColor = appcolor
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_cancelled.layer.borderColor = appcolor.cgColor
        self.appointtype = "current"
        self.callnew()
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.pet_applist_do_sp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! docdashTableViewCell
        cell.view_pres.isHidden = true
        if self.appointtype == "current" {
            cell.view_commissed.isHidden = false
            cell.view_completebtn.isHidden = true
            cell.view_cancnel.isHidden = false
            cell.btn_complete.tag = indexPath.row
             cell.btn_cancel.tag = indexPath.row
            cell.btn_cancel.addTarget(self, action: #selector(action_cancelled), for: .touchUpInside)
            cell.label_completedon.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].Booked_at
            cell.labe_comMissed.text = "Booked on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else if self.appointtype == "Complete"{
            if Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name != "" {
                 cell.view_pres.isHidden = false
            }else{
                 cell.view_pres.isHidden = true
            }
             cell.view_pres.isHidden = false
             cell.view_commissed.isHidden = false
            cell.view_cancnel.isHidden = true
            cell.view_completebtn.isHidden = true
            cell.label_completedon.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].Booked_at
            cell.labe_comMissed.text = "Completion on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            cell.view_cancnel.isHidden = true
            cell.view_completebtn.isHidden = true
            cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].Booked_at
             cell.labe_comMissed.text = "Cancelled on :"
            cell.label_completedon.textColor = UIColor.red
             cell.labe_comMissed.textColor = UIColor.red
        }
        cell.label_servicename.text = "Appointment Type : " + Servicefile.shared.pet_applist_do_sp[indexPath.row].appointment_for
        if Servicefile.shared.pet_applist_do_sp[indexPath.row].appointment_type == "Emergency" {
            cell.image_emergnecy.isHidden = false
        }else{
            cell.image_emergnecy.isHidden = true
        }
        cell.btn_pres.tag = indexPath.row
        cell.btn_pres.addTarget(self, action: #selector(action_pres), for: .touchUpInside)
        cell.view_completebtn.layer.cornerRadius = 10.0
        cell.view_cancnel.layer.cornerRadius = 10.0
        cell.View_mainview.layer.borderWidth = 0.2
        cell.View_mainview.layer.borderColor = UIColor.lightGray.cgColor
        if Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name != "" {
             cell.label_petname.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name
        }else{
             cell.label_petname.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].service_provider_name
        }
       
            cell.label_pettype.text = "Pet name : " + Servicefile.shared.pet_applist_do_sp[indexPath.row].pet_name
        cell.img_petimg.image = UIImage(named: "sample")
        cell.label_amount.text =  "₹" + Servicefile.shared.pet_applist_do_sp[indexPath.row].cost
        if Servicefile.shared.pet_applist_do_sp[indexPath.row].photo == "" {
              cell.img_petimg.image = UIImage(named: "sample")
        }else{
              cell.img_petimg.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_applist_do_sp[indexPath.row].photo)) { (image, error, cache, urls) in
                        if (error != nil) {
                            cell.img_petimg.image = UIImage(named: "sample")
                        } else {
                            cell.img_petimg.image = image
                        }
                    }
        }

        return cell
    }
    
    @objc func action_pres(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.pet_apoint_id = Servicefile.shared.pet_applist_do_sp[tag]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "viewprescriptionViewController") as! viewprescriptionViewController
        self.present(vc, animated: true, completion: nil)
       }
    
    @objc func action_cancelled(sender : UIButton){
        let tag = sender.tag
        self.indextag = tag
        self.view_shadow.isHidden = false
        self.view_popup.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name != "" {
             if self.appointtype == "Complete" {
                       if Servicefile.shared.Doc_dashlist[indexPath.row].user_rate == "" || Servicefile.shared.Doc_dashlist[indexPath.row].user_feedback == "" {
                           Servicefile.shared.pet_apoint_id = Servicefile.shared.Doc_dashlist[indexPath.row].Appid
                                      let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewRateViewController") as! ReviewRateViewController
                                                               self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func action_confrim(_ sender: Any) {
        self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.pet_applist_do_sp[indextag]._id, type:  Servicefile.shared.pet_applist_do_sp[indextag].appointment_for)
    }
    
    @IBAction func action_no(_ sender: Any) {
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
    }
    
    @IBAction func action_backaction(_ sender: Any) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
                          self.present(vc, animated: true, completion: nil)
       }

    @IBAction func action_cancelled(_ sender: Any) {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_cancelled.backgroundColor = appcolor
            self.label_cancelled.textColor = UIColor.white
            self.view_current.backgroundColor = UIColor.white
            self.label_current.textColor = appcolor
            self.label_complete.textColor = appcolor
            self.view_completed.backgroundColor = UIColor.white
            self.view_current.layer.borderColor = appcolor.cgColor
            self.view_current.backgroundColor = UIColor.white
            self.appointtype = "cancelled"
            self.callmiss()
            
        }
        @IBAction func action_completeappoint(_ sender: Any) {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_completed.backgroundColor = appcolor
            self.label_complete.textColor = UIColor.white
            self.view_current.backgroundColor = UIColor.white
            self.view_cancelled.backgroundColor = UIColor.white
            self.label_current.textColor = appcolor
            self.label_cancelled.textColor = appcolor
            self.view_current.layer.borderColor = appcolor.cgColor
            self.view_cancelled.layer.borderColor = appcolor.cgColor
            self.appointtype = "Complete"
            self.callcom()
           
        }
        @IBAction func action_currentappoint(_ sender: Any) {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_current.backgroundColor = appcolor
            self.label_current.textColor = UIColor.white
            self.view_completed.backgroundColor = UIColor.white
            self.view_cancelled.backgroundColor = UIColor.white
            self.label_complete.textColor = appcolor
            self.label_cancelled.textColor = appcolor
            self.view_completed.layer.borderColor = appcolor.cgColor
            self.view_cancelled.layer.borderColor = appcolor.cgColor
            self.appointtype = "current"
            self.callnew()
            
        }
        
        @IBAction func action_logout(_ sender: Any) {
            
        }
    
        func callnew(){
             Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
            self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.plove_getlist_newapp, method: .post, parameters:
            ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                           Servicefile.shared.pet_applist_do_sp.removeAll()
                                                          let Data = res["Data"] as! NSArray
                                                          for itm in 0..<Data.count{
                                                              let dataitm = Data[itm] as! NSDictionary
                                                              let Booked_at = dataitm["Booked_at"] as! String
                                                            let Booking_Id = dataitm["Booking_Id"] as! String
                                                            let Service_name = dataitm["Service_name"] as! String
                                                            let _id = dataitm["_id"] as! String
                                                            let appointment_for = dataitm["appointment_for"] as! String
                                                            let appointment_time = dataitm["appointment_time"] as! String
                                                            let appointment_type = dataitm["appointment_type"] as! String
                                                            let clinic_name = dataitm["clinic_name"] as! String
                                                            let completed_at = dataitm["completed_at"] as! String
                                                            let cost  = dataitm["cost"] as! String
                                                            let createdAt = dataitm["createdAt"] as! String
                                                            let missed_at = dataitm["missed_at"] as! String
                                                            let pet_name = dataitm["pet_name"] as! String
                                                            let pet_type = dataitm["pet_type"] as! String
                                                            let photo = dataitm["photo"] as! String
                                                            let service_cost = dataitm["service_cost"] as! String
                                                            let service_provider_name = dataitm["service_provider_name"] as! String
                                                            let status = dataitm["status"] as! String
                                                            let type  = dataitm["type"] as! String
                                                            let updatedAt = dataitm["updatedAt"] as! String
                                                            
                                                            Servicefile.shared.pet_applist_do_sp.append(pet_applist_doc_sp.init(IN_Booked_at: Booked_at, IN_Booking_Id: Booking_Id, IN_Service_name: Service_name, IN__id: _id, IN_appointment_for: appointment_for, IN_appointment_time: appointment_time, IN_appointment_type: appointment_type, IN_clinic_name: clinic_name, IN_completed_at: completed_at, IN_cost: cost, IN_createdAt: createdAt, IN_missed_at: missed_at, IN_pet_name: pet_name, IN_pet_type: pet_type, IN_photo: photo, IN_service_cost: service_cost, IN_service_provider_name: service_provider_name, IN_status: status, IN_type: type, IN_updatedAt: updatedAt))
                                                            
                                                          }
                                                          if Servicefile.shared.pet_applist_do_sp.count > 0 {
                                                              self.label_nodata.isHidden = true
                                                          }else{
                                                               self.label_nodata.isHidden = false
                                                          }
                                                          self.tbl_applist.reloadData()
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
    
    func callcompleteMissedappoitment(Appointmentid: String, type: String){
        var link = ""
        if type == "SP" {
             link =  Servicefile.SP_complete_and_Missedapp
        }else{
            link =  Servicefile.Doc_complete_and_Missedapp
        }
      
           var params = ["":""]
               params = ["_id": Appointmentid,
                          "missed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                          "appoinment_status" : "Missed"]
                    Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                   self.startAnimatingActivityIndicator()
             if Servicefile.shared.updateUserInterface() { AF.request(link, method: .post, parameters: params
                  , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                       switch (response.result) {
                                                       case .success:
                                                             let res = response.value as! NSDictionary
                                                             print("success data",res)
                                                             let Code  = res["Code"] as! Int
                                                             if Code == 200 {
                                                                
                                                               self.view_shadow.isHidden = true
                                                               self.view_popup.isHidden = true
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
    
        func callcom(){
                Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
               self.startAnimatingActivityIndicator()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.plove_getlist_comapp, method: .post, parameters:
               ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                              Servicefile.shared.pet_applist_do_sp.removeAll()
                                                             let Data = res["Data"] as! NSArray
                                                             for itm in 0..<Data.count{
                                                                 let dataitm = Data[itm] as! NSDictionary
                                                                 let Booked_at = dataitm["Booked_at"] as! String
                                                               let Booking_Id = dataitm["Booking_Id"] as! String
                                                               let Service_name = dataitm["Service_name"] as! String
                                                               let _id = dataitm["_id"] as! String
                                                               let appointment_for = dataitm["appointment_for"] as! String
                                                               let appointment_time = dataitm["appointment_time"] as! String
                                                               let appointment_type = dataitm["appointment_type"] as! String
                                                               let clinic_name = dataitm["clinic_name"] as! String
                                                               let completed_at = dataitm["completed_at"] as! String
                                                               let cost  = dataitm["cost"] as! String
                                                               let createdAt = dataitm["createdAt"] as! String
                                                               let missed_at = dataitm["missed_at"] as! String
                                                               let pet_name = dataitm["pet_name"] as! String
                                                               let pet_type = dataitm["pet_type"] as! String
                                                               let photo = dataitm["photo"] as! String
                                                               let service_cost = dataitm["service_cost"] as! String
                                                               let service_provider_name = dataitm["service_provider_name"] as! String
                                                               let status = dataitm["status"] as! String
                                                               let type  = dataitm["type"] as! String
                                                               let updatedAt = dataitm["updatedAt"] as! String
                                                               
                                                               Servicefile.shared.pet_applist_do_sp.append(pet_applist_doc_sp.init(IN_Booked_at: Booked_at, IN_Booking_Id: Booking_Id, IN_Service_name: Service_name, IN__id: _id, IN_appointment_for: appointment_for, IN_appointment_time: appointment_time, IN_appointment_type: appointment_type, IN_clinic_name: clinic_name, IN_completed_at: completed_at, IN_cost: cost, IN_createdAt: createdAt, IN_missed_at: missed_at, IN_pet_name: pet_name, IN_pet_type: pet_type, IN_photo: photo, IN_service_cost: service_cost, IN_service_provider_name: service_provider_name, IN_status: status, IN_type: type, IN_updatedAt: updatedAt))
                                                               
                                                             }
                                                             if  Servicefile.shared.pet_applist_do_sp.count > 0 {
                                                                 self.label_nodata.isHidden = true
                                                             }else{
                                                                  self.label_nodata.isHidden = false
                                                             }
                                                             self.tbl_applist.reloadData()
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
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.plove_getlist_missapp, method: .post, parameters:
                  ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                      switch (response.result) {
                                                      case .success:
                                                            let res = response.value as! NSDictionary
                                                            print("success data",res)
                                                            let Code  = res["Code"] as! Int
                                                            if Code == 200 {
                                                                 Servicefile.shared.pet_applist_do_sp.removeAll()
                                                                let Data = res["Data"] as! NSArray
                                                                for itm in 0..<Data.count{
                                                                    let dataitm = Data[itm] as! NSDictionary
                                                                    let Booked_at = dataitm["Booked_at"] as! String
                                                                  let Booking_Id = dataitm["Booking_Id"] as! String
                                                                  let Service_name = dataitm["Service_name"] as! String
                                                                  let _id = dataitm["_id"] as! String
                                                                  let appointment_for = dataitm["appointment_for"] as! String
                                                                  let appointment_time = dataitm["appointment_time"] as! String
                                                                  let appointment_type = dataitm["appointment_type"] as! String
                                                                  let clinic_name = dataitm["clinic_name"] as! String
                                                                  let completed_at = dataitm["completed_at"] as! String
                                                                  let cost  = dataitm["cost"] as! String
                                                                  let createdAt = dataitm["createdAt"] as! String
                                                                  let missed_at = dataitm["missed_at"] as! String
                                                                  let pet_name = dataitm["pet_name"] as! String
                                                                  let pet_type = dataitm["pet_type"] as! String
                                                                  let photo = dataitm["photo"] as! String
                                                                  let service_cost = dataitm["service_cost"] as! String
                                                                  let service_provider_name = dataitm["service_provider_name"] as! String
                                                                  let status = dataitm["status"] as! String
                                                                  let type  = dataitm["type"] as! String
                                                                  let updatedAt = dataitm["updatedAt"] as! String
                                                                  
                                                                  Servicefile.shared.pet_applist_do_sp.append(pet_applist_doc_sp.init(IN_Booked_at: Booked_at, IN_Booking_Id: Booking_Id, IN_Service_name: Service_name, IN__id: _id, IN_appointment_for: appointment_for, IN_appointment_time: appointment_time, IN_appointment_type: appointment_type, IN_clinic_name: clinic_name, IN_completed_at: completed_at, IN_cost: cost, IN_createdAt: createdAt, IN_missed_at: missed_at, IN_pet_name: pet_name, IN_pet_type: pet_type, IN_photo: photo, IN_service_cost: service_cost, IN_service_provider_name: service_provider_name, IN_status: status, IN_type: type, IN_updatedAt: updatedAt))
                                                                  
                                                                }
                                                                if Servicefile.shared.pet_applist_do_sp.count > 0 {
                                                                    self.label_nodata.isHidden = true
                                                                }else{
                                                                     self.label_nodata.isHidden = false
                                                                }
                                                                self.tbl_applist.reloadData()
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
        

}
