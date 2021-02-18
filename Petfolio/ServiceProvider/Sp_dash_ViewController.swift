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
    
    @IBOutlet weak var view_popalert: UIView!
    @IBOutlet weak var label_popalert_details: UILabel!
    @IBOutlet weak var view_btn_yes: UIView!
    @IBOutlet weak var view_btn_no: UIView!
    
    var indextag = 0
    var statussel = ""
    
    var appointtype = "New"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label_nodata.isHidden = true
        self.view_popalert.isHidden = true
        self.view_popalert.layer.cornerRadius = 10.0
        self.view_btn_yes.layer.cornerRadius = 10.0
        self.view_btn_no.layer.cornerRadius = 10.0
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
        
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_profile_ViewController") as! Sp_profile_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_notifi(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_refresh(_ sender: Any) {
        self.callcheckstatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        return Servicefile.shared.SP_Das_petdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! docdashTableViewCell
        cell.image_emergnecy.isHidden = true
        cell.view_commissed.isHidden = false
        cell.view_completebtn.isHidden = true
        cell.view_cancnel.isHidden = true
        cell.label_status.isHidden = true
        cell.label_status_val.isHidden = true
        if self.appointtype == "New" {
            cell.view_completebtn.isHidden = false
            cell.btn_complete.tag = indexPath.row
            cell.btn_cancel.tag = indexPath.row
            cell.btn_complete.addTarget(self, action: #selector(action_complete), for: .touchUpInside)
            cell.btn_cancel.addTarget(self, action: #selector(action_cancelled), for: .touchUpInside)
            cell.label_completedon.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].book_date_time
            //            if Servicefile.shared.Doc_dashlist[indexPath.row].appoinment_status == "Emergency" {
            //                cell.image_emergnecy.isHidden = false
            //            }else{
            //                cell.image_emergnecy.isHidden = true
            
            //            }
            if Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.SP_Das_petdetails[indexPath.row].book_date_time) > Date() {
                cell.view_cancnel.isHidden = false
            } else {
                cell.view_cancnel.isHidden = true
            }
        }else if self.appointtype == "Complete"{
            cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].completed_at
            cell.labe_comMissed.text = "Completion on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            cell.label_status.isHidden = true
            cell.label_status_val.isHidden = true
//            if  Servicefile.shared.SP_Das_petdetails[indexPath.row].appoint_patient_st == "Doctor Cancelled appointment" {
//                cell.label_status.isHidden = true
//                cell.label_status_val.isHidden = true
//            } else if  Servicefile.shared.SP_Das_petdetails[indexPath.row].appoint_patient_st == "Patient Not Available" {
//                cell.label_status_val.text = "No show"
//            } else if  Servicefile.shared.SP_Das_petdetails[indexPath.row].appoint_patient_st == "Petowner Cancelled appointment" {
//                cell.label_status_val.text = "Not available"
//            } else {
//                cell.label_status_val.text = "Not available"
//            }
            cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].missed_at
            cell.labe_comMissed.text = "Missed on :"
            cell.label_completedon.textColor = UIColor.red
            cell.labe_comMissed.textColor = UIColor.red
        }
        
        cell.view_completebtn.layer.cornerRadius = 10.0
        cell.view_cancnel.layer.cornerRadius = 10.0
        cell.View_mainview.layer.borderWidth = 0.2
        cell.View_mainview.layer.borderColor = UIColor.lightGray.cgColor
        cell.label_petname.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_name
        cell.label_pettype.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_type
        cell.img_petimg.image = UIImage(named: "sample")
        cell.label_amount.text =  "₹" + Servicefile.shared.SP_Das_petdetails[indexPath.row].amount
        cell.label_servicename.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].sername
        if Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_img == "" {
            cell.img_petimg.image = UIImage(named: "sample")
        }else{
            cell.img_petimg.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_petimg.image = UIImage(named: "sample")
                } else {
                    cell.img_petimg.image = image
                }
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Servicefile.shared.Doc_selected_app_list = self.appointtype
        Servicefile.shared.appointmentindex = indexPath.row
        Servicefile.shared.pet_apoint_id = Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].Appid
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "sp_app_details_page_ViewController") as! sp_app_details_page_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_complete(sender : UIButton){
        let tag = sender.tag
        self.indextag = tag
        self.label_popalert_details.text = "Are you sure you want to complete this appointment"
        self.statussel = "completed"
        self.view_shadow.isHidden = false
        self.view_popalert.isHidden = false
        
    }
    @objc func action_cancelled(sender : UIButton){
        let tag = sender.tag
        self.indextag = tag
        self.statussel = "cancel"
        self.label_popalert_details.text = "Are you sure you want to cancel this appointment"
        self.view_shadow.isHidden = false
        self.view_popalert.isHidden = false
        
    }
    
    
    @IBAction func action_pop_yes(_ sender: Any) {
        if self.statussel != "cancel"{
            
            self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.SP_Das_petdetails[self.indextag].Appid, appointmentstatus: "completed")
        }else{
            
            self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.SP_Das_petdetails[self.indextag].Appid, appointmentstatus: "cancel")
        }
        self.view_shadow.isHidden = true
        self.view_popalert.isHidden = true
    }
    
    @IBAction func action_pop_no(_ sender: Any) {
        self.view_shadow.isHidden = true
        self.view_popalert.isHidden = true
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
        self.callmiss()
        
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
        self.callcom()
        
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
        self.callnew()
        
    }
    
    @IBAction func action_logout(_ sender: Any) {
        
    }
    
    func callnew(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.SPdashboardnewapp, method: .post, parameters:
            ["sp_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.SP_Das_petdetails.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let dataitm = Data[itm] as! NSDictionary
                            let id = dataitm["_id"] as! String
                            let amount = dataitm["service_amount"] as! String
                            let service_name = dataitm["service_name"] as! String
                            let booking_date_time = dataitm["booking_date_time"] as! String
                            let user_rate = dataitm["user_rate"] as! String
                            let user_feedback = dataitm["user_feedback"] as! String
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as! String
                            let pet_name = petdetail["pet_name"] as! String
                            let pet_type = petdetail["pet_type"] as! String
                            let pet_breed = petdetail["pet_breed"] as! String
                            let pet_img = petdetail["pet_img"] as! String
                            let user_id = petdetail["user_id"] as! String
                            let sp_id = dataitm["sp_id"] as! String
                            let appointment_UID = dataitm["appointment_UID"] as! String
                            let completed_at = dataitm["completed_at"] as! String
                            let missed_at = dataitm["missed_at"] as! String
                           let appoint_patient_st = ""
                           // let appoint_patient_st = dataitm["appoint_patient_st"] as! String
                            Servicefile.shared.SP_Das_petdetails.append(SP_Dash_petdetails.init(in_Appid: id, In_amount: amount, In_appointment_types: "", In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback, In_servicename: service_name, In_sp_id : sp_id, In_appointment_UID: appointment_UID, In_completed_at : completed_at, In_missed_at : missed_at, In_appoint_patient_st : appoint_patient_st))
                            
                            
                        }
                        if Servicefile.shared.SP_Das_petdetails.count > 0 {
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.SPdashboardcomapp, method: .post, parameters:
            ["sp_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.SP_Das_petdetails.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let dataitm = Data[itm] as! NSDictionary
                            let id = dataitm["_id"] as! String
                            let amount = dataitm["service_amount"] as! String
                            let service_name = dataitm["service_name"] as! String
                            let booking_date_time = dataitm["booking_date_time"] as! String
                            let user_rate = dataitm["user_rate"] as! String
                            let user_feedback = dataitm["user_feedback"] as! String
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as! String
                            let pet_name = petdetail["pet_name"] as! String
                            let pet_type = petdetail["pet_type"] as! String
                            let pet_breed = petdetail["pet_breed"] as! String
                            let pet_img = petdetail["pet_img"] as! String
                            let user_id = petdetail["user_id"] as! String
                            let sp_id = dataitm["sp_id"] as! String
                            let appointment_UID = dataitm["appointment_UID"] as! String
                            let completed_at = dataitm["completed_at"] as! String
                            let missed_at = dataitm["missed_at"] as! String
                            //let appoint_patient_st = dataitm["appoint_patient_st"] as! String
                            let appoint_patient_st = ""
                            Servicefile.shared.SP_Das_petdetails.append(SP_Dash_petdetails.init(in_Appid: id, In_amount: amount, In_appointment_types: "", In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback, In_servicename: service_name, In_sp_id : sp_id, In_appointment_UID: appointment_UID, In_completed_at : completed_at, In_missed_at : missed_at, In_appoint_patient_st : appoint_patient_st))
                            
                            
                        }
                        if Servicefile.shared.SP_Das_petdetails.count > 0 {
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.SPdashboardmissapp, method: .post, parameters:
            ["sp_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.SP_Das_petdetails.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let dataitm = Data[itm] as! NSDictionary
                            let id = dataitm["_id"] as! String
                            let amount = dataitm["service_amount"] as! String
                            let service_name = dataitm["service_name"] as! String
                            let booking_date_time = dataitm["booking_date_time"] as! String
                            let user_rate = dataitm["user_rate"] as! String
                            let user_feedback = dataitm["user_feedback"] as! String
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as! String
                            let pet_name = petdetail["pet_name"] as! String
                            let pet_type = petdetail["pet_type"] as! String
                            let pet_breed = petdetail["pet_breed"] as! String
                            let pet_img = petdetail["pet_img"] as! String
                            let user_id = petdetail["user_id"] as! String
                            let sp_id = dataitm["sp_id"] as! String
                            let appointment_UID = dataitm["appointment_UID"] as! String
                            let completed_at = dataitm["completed_at"] as! String
                            let missed_at = dataitm["missed_at"] as! String
                           // let appoint_patient_st = dataitm["appoint_patient_st"] as! String
                           let appoint_patient_st = ""
                            Servicefile.shared.SP_Das_petdetails.append(SP_Dash_petdetails.init(in_Appid: id, In_amount: amount, In_appointment_types: "", In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback, In_servicename: service_name, In_sp_id : sp_id, In_appointment_UID: appointment_UID, In_completed_at : completed_at, In_missed_at : missed_at, In_appoint_patient_st : appoint_patient_st))
                            
                            // appointment_UID
                            
                        }
                        if Servicefile.shared.SP_Das_petdetails.count > 0 {
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.SP_complete_and_Missedapp, method: .post, parameters: params
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        if appointmentstatus != "cancel"{
                            
                        }else{
                            self.callspappcancel()
                        }
                        
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
                        let calender_status = Data["calender_status"] as! Bool
                        print("profile_status",profile_status)
                        if profile_status == false {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SP_Reg_ViewController") as! SP_Reg_ViewController
                            self.present(vc, animated: true, completion: nil)
                        }else if calender_status == false {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_reg_calender_ViewController") as! Sp_reg_calender_ViewController
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
                                self.callnew()
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
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionl_ogout(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func callspappcancel(){
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_notification, method: .post, parameters:
            ["appointment_UID": Servicefile.shared.SP_Das_petdetails[self.indextag].appointment_UID,
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "sp_id": Servicefile.shared.SP_Das_petdetails[self.indextag].sp_id,
             "status":"Doctor Appointment Cancelled",
             "user_id": Servicefile.shared.SP_Das_petdetails[self.indextag].user_id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        
                    }else{
                    }
                    break
                case .failure(let Error):
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
