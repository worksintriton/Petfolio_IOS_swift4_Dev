//
//  Pet_applist_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 02/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import JitsiMeetSDK
import WebKit

class Pet_applist_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JitsiMeetViewDelegate {
    
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
    @IBOutlet weak var view_home: UIView!
    
    var appointtype = "current"
    var indextag = 0
    
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view_home.view_cornor()
        self.view_footer.view_cornor()
        self.view_popup.view_cornor()
        self.view_yes.layer.cornerRadius = self.view_yes.frame.height / 2
        self.view_no.layer.cornerRadius = self.view_yes.frame.height / 2
        self.tbl_applist.delegate = self
        self.tbl_applist.dataSource = self
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.label_nodata.text = "No new appointments"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view_current.view_cornor()
        self.view_cancelled.view_cornor()
        self.view_completed.view_cornor()
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
    
    @IBAction func action_care(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_searchlist_DRViewController") as! Pet_searchlist_DRViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_petservice(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_dashfooter_servicelist_ViewController") as! pet_dashfooter_servicelist_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_home(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
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
        cell.view_addview.isHidden = true
        cell.view_online.isHidden = true
        cell.label_status.isHidden = true
        cell.label_status_val.isHidden = true
        cell.view_pres.isHidden = true
        cell.view_pres.view_cornor()
        cell.selectionStyle = .none
        cell.selectionStyle = .none
        if self.appointtype == "current" {
            if Servicefile.shared.pet_applist_do_sp[indexPath.row].communication_type != "Visit" {
                cell.view_online.isHidden = false
            }else{
                cell.view_online.isHidden = true
            }
            cell.view_addview.isHidden = true
            cell.view_commissed.isHidden = false
            cell.view_completebtn.isHidden = true
            cell.view_cancnel.isHidden = true
            if Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.pet_applist_do_sp[indexPath.row].appointment_time) > Date() {
                cell.view_cancnel.isHidden = false
            } else {
               cell.view_cancnel.isHidden = true
            }
            cell.btn_complete.tag = indexPath.row
            cell.btn_cancel.tag = indexPath.row
            cell.btn_cancel.addTarget(self, action: #selector(action_cancelled), for: .touchUpInside)
            cell.label_completedon.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].Booked_at
            cell.labe_comMissed.text = "Booked for :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            if Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name != "" {
                cell.btn_online.addTarget(self, action: #selector(action_online), for: .touchUpInside)
            }else{
                cell.view_online.isHidden = true
            }
            
        }else if self.appointtype == "Complete"{
            if Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name != "" {
                cell.view_pres.isHidden = false
                if Servicefile.shared.pet_applist_do_sp[indexPath.row].userrate == "0" || Servicefile.shared.pet_applist_do_sp[indexPath.row].userfeed == ""{
                    cell.view_addview.isHidden = false
                } else {
                    cell.view_addview.isHidden = true
                }
            }else{
                cell.view_pres.isHidden = true
                if Servicefile.shared.pet_applist_do_sp[indexPath.row].userrate == "0" || Servicefile.shared.pet_applist_do_sp[indexPath.row].userfeed == ""{
                                   cell.view_addview.isHidden = false
                               } else {
                                   cell.view_addview.isHidden = true
                               }
            }
            cell.view_addview.view_cornor()
            cell.btn_addreview.tag = indexPath.row
            cell.btn_addreview.addTarget(self, action: #selector(action_addreview), for: .touchUpInside)
            //cell.view_pres.isHidden = false
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
            cell.label_status.isHidden = false
            cell.label_status_val.isHidden = false
            if Servicefile.shared.pet_applist_do_sp[indexPath.row].appoint_patient_st == "Doctor Cancelled appointment" {
                cell.label_status_val.text = "Not available"
            } else if Servicefile.shared.pet_applist_do_sp[indexPath.row].appoint_patient_st == "Patient Not Available" {
                cell.label_status_val.text = "Not available"
            } else if Servicefile.shared.pet_applist_do_sp[indexPath.row].appoint_patient_st == "Petowner Cancelled appointment" {
                cell.label_status.isHidden = true
                cell.label_status_val.isHidden = true
            } else {
                cell.label_status_val.text = "No show"
            }
            
        }
        cell.label_servicename.text =  Servicefile.shared.pet_applist_do_sp[indexPath.row].appointment_for
        if Servicefile.shared.pet_applist_do_sp[indexPath.row].appointment_type == "Emergency" {
            cell.image_emergnecy.isHidden = false
        }else{
            cell.image_emergnecy.isHidden = true
        }
        cell.btn_pres.tag = indexPath.row
        cell.btn_pres.addTarget(self, action: #selector(action_pres), for: .touchUpInside)
        cell.view_completebtn.view_cornor()
        cell.view_cancnel.view_cornor()
        cell.View_mainview.layer.borderWidth = 0.2
        cell.View_mainview.layer.borderColor = UIColor.lightGray.cgColor
        if Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name != "" {
            cell.label_petname.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name
            cell.label_servicer_title.text = "Doctor Name"
            cell.label_pettype.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].doctor_name
        }else{
            cell.label_petname.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].service_provider_name
            cell.label_servicer_title.text = "Service Name"
            cell.label_pettype.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].Service_name
        }
        cell.label_type_pet.text = Servicefile.shared.pet_applist_do_sp[indexPath.row].pet_name
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
    
    @objc func action_online(sender : UIButton){
        let tag = sender.tag
        if Servicefile.shared.pet_applist_do_sp[tag].start_appointment_status == "In-Progress" {
            Servicefile.shared.selectedindex = tag
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_confrence_ViewController") as! Pet_confrence_ViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            self.alert(Message: "Doctor is yet to start the Appointment please wait for the doctor to initiate the Appointment")
        }
    }
    
    @IBAction func action_notification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_pres(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.pet_apoint_id = Servicefile.shared.pet_applist_do_sp[tag]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pdfViewController") as! pdfViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_addreview(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.pet_apoint_id = Servicefile.shared.pet_applist_do_sp[tag]._id
        Servicefile.shared.selectedindex = tag
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewRateViewController") as! ReviewRateViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_cancelled(sender : UIButton){
        let tag = sender.tag
        self.indextag = tag
        self.view_shadow.isHidden = false
        self.view_popup.isHidden = false
    }
    
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        print("confrence terminated")
        self.dismiss(animated: true, completion: nil)
    }
    
    func conferenceJoined(_ data: [AnyHashable : Any]!) {
        print("meeting started ")
    }
    
    func conferenceWillJoin(_ data: [AnyHashable : Any]!) {
        print("person will be joining soon please wait")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if Servicefile.shared.pet_applist_do_sp[indexPath.row].clinic_name != "" {
        Servicefile.shared.pet_selected_app_list = self.appointtype
        Servicefile.shared.selectedindex = indexPath.row
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_app_details_ViewController") as! Pet_app_details_ViewController
        self.present(vc, animated: true, completion: nil)
        // }
    }
    
    @IBAction func action_confrim(_ sender: Any) {
        self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.pet_applist_do_sp[indextag]._id, type:  Servicefile.shared.pet_applist_do_sp[indextag].appointment_for)
        //print("appointment Booked time",Servicefile.shared.pet_applist_do_sp[indextag].appointment_time)
        
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
        self.label_nodata.text = "No Missed appointments"
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
        self.label_nodata.text = "No Completed appointments"
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
        self.label_nodata.text = "No New appointments"
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
            ["user_id": Servicefile.shared.userid, "current_time" : Servicefile.shared.yyyyMMddHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                            let Booked_at = dataitm["Booked_at"] as? String ?? ""
                            let Booking_Id = dataitm["Booking_Id"] as? String ?? ""
                            let Service_name = dataitm["Service_name"] as? String ?? ""
                            let _id = dataitm["_id"] as? String ?? ""
                            let appointment_for = dataitm["appointment_for"] as? String ?? ""
                            let appointment_time = dataitm["appointment_time"] as? String ?? ""
                            let appointment_type = dataitm["appointment_type"] as? String ?? ""
                            let appoint_patient_st = dataitm["appoint_patient_st"] as? String ?? ""
                            let communication_type = dataitm["communication_type"] as? String ?? ""
                            let start_appointment_status = dataitm["start_appointment_status"] as? String ?? ""
                            let clinic_name = dataitm["clinic_name"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let cost  = dataitm["cost"] as? String ?? ""
                            let createdAt = dataitm["createdAt"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
                            let pet_name = dataitm["pet_name"] as? String ?? ""
                            let pet_type = dataitm["pet_type"] as? String ?? ""
                            let photo = dataitm["photo"] as? String ?? Servicefile.sample_img
                            let service_cost = dataitm["service_cost"] as? String ?? ""
                            let service_provider_name = dataitm["service_provider_name"] as? String ?? ""
                            let status = dataitm["status"] as? String ?? ""
                            let type  = dataitm["type"] as? String ?? ""
                            let updatedAt = dataitm["updatedAt"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let doctor_name = dataitm["doctor_name"] as? String ?? ""
                            let doctor_id = dataitm["doctor_id"] as? String ?? ""
                            let sp_id = dataitm["sp_id"] as? String ?? ""
                            Servicefile.shared.pet_applist_do_sp.append(pet_applist_doc_sp.init(IN_Booked_at: Booked_at, IN_Booking_Id: Booking_Id, IN_Service_name: Service_name, IN__id: _id, IN_appointment_for: appointment_for, IN_appointment_time: appointment_time, IN_appointment_type: appointment_type, IN_clinic_name: clinic_name, IN_completed_at: completed_at, IN_cost: cost, IN_createdAt: createdAt, IN_missed_at: missed_at, IN_pet_name: pet_name, IN_pet_type: pet_type, IN_photo: photo, IN_service_cost: service_cost, IN_service_provider_name: service_provider_name, IN_status: status, IN_type: type, IN_updatedAt: updatedAt,In_userrate: user_rate, In_userfeed: user_feedback, In_communication_type: communication_type, In_start_appointment_status: start_appointment_status, In_appoint_patient_st : appoint_patient_st,In_doctor_name : doctor_name, In_doctor_id : doctor_id, In_sp_id : sp_id))
                            
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
                  "appoinment_status" : "Missed",
                  "doc_feedback" : "",
                  "appoint_patient_st": "Patient Appointment Cancelled"]
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
                        if type == "SP" {
                                    self.callspappcancel()
                               }else{
                                    self.callDocappcancel()
                                         
                               }
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
            ["user_id": Servicefile.shared.userid, "current_time" : Servicefile.shared.yyyyMMddHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                            let Booked_at = dataitm["Booked_at"] as? String ?? ""
                            let Booking_Id = dataitm["Booking_Id"] as? String ?? ""
                            let Service_name = dataitm["Service_name"] as? String ?? ""
                            let _id = dataitm["_id"] as? String ?? ""
                            let appointment_for = dataitm["appointment_for"] as? String ?? ""
                            let appointment_time = dataitm["appointment_time"] as? String ?? ""
                            let appointment_type = dataitm["appointment_type"] as? String ?? ""
                            let appoint_patient_st = dataitm["appoint_patient_st"] as? String ?? ""
                            let communication_type = dataitm["communication_type"] as? String ?? ""
                            let start_appointment_status = dataitm["start_appointment_status"] as? String ?? ""
                            let clinic_name = dataitm["clinic_name"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let cost  = dataitm["cost"] as? String ?? ""
                            let createdAt = dataitm["createdAt"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
                            let pet_name = dataitm["pet_name"] as? String ?? ""
                            let pet_type = dataitm["pet_type"] as? String ?? ""
                            let photo = dataitm["photo"] as? String ?? Servicefile.sample_img
                            let service_cost = dataitm["service_cost"] as? String ?? ""
                            let service_provider_name = dataitm["service_provider_name"] as? String ?? ""
                            let status = dataitm["status"] as? String ?? ""
                            let type  = dataitm["type"] as? String ?? ""
                            let updatedAt = dataitm["updatedAt"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let doctor_name = dataitm["doctor_name"] as? String ?? ""
                            let doctor_id = dataitm["doctor_id"] as? String ?? ""
                            let sp_id = dataitm["sp_id"] as? String ?? ""
                            Servicefile.shared.pet_applist_do_sp.append(pet_applist_doc_sp.init(IN_Booked_at: Booked_at, IN_Booking_Id: Booking_Id, IN_Service_name: Service_name, IN__id: _id, IN_appointment_for: appointment_for, IN_appointment_time: appointment_time, IN_appointment_type: appointment_type, IN_clinic_name: clinic_name, IN_completed_at: completed_at, IN_cost: cost, IN_createdAt: createdAt, IN_missed_at: missed_at, IN_pet_name: pet_name, IN_pet_type: pet_type, IN_photo: photo, IN_service_cost: service_cost, IN_service_provider_name: service_provider_name, IN_status: status, IN_type: type, IN_updatedAt: updatedAt,In_userrate: user_rate, In_userfeed: user_feedback, In_communication_type: communication_type, In_start_appointment_status: start_appointment_status, In_appoint_patient_st : appoint_patient_st,In_doctor_name : doctor_name, In_doctor_id : doctor_id, In_sp_id : sp_id))
                            
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
            ["user_id": Servicefile.shared.userid, "current_time" : Servicefile.shared.yyyyMMddHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.pet_applist_do_sp.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count {
                            let dataitm = Data[itm] as! NSDictionary
                            let Booked_at = dataitm["Booked_at"] as? String ?? ""
                            let Booking_Id = dataitm["Booking_Id"] as? String ?? ""
                            let Service_name = dataitm["Service_name"] as? String ?? ""
                            let _id = dataitm["_id"] as? String ?? ""
                            let appointment_for = dataitm["appointment_for"] as? String ?? ""
                            let appointment_time = dataitm["appointment_time"] as? String ?? ""
                            let appoint_patient_st = dataitm["appoint_patient_st"] as? String ?? ""
                            let appointment_type = dataitm["appointment_type"] as? String ?? ""
                            let communication_type = dataitm["communication_type"] as? String ?? ""
                            let start_appointment_status = dataitm["start_appointment_status"] as? String ?? ""
                            let clinic_name = dataitm["clinic_name"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let cost  = dataitm["cost"] as? String ?? ""
                            let createdAt = dataitm["createdAt"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
                            let pet_name = dataitm["pet_name"] as? String ?? ""
                            let pet_type = dataitm["pet_type"] as? String ?? ""
                            let photo = dataitm["photo"] as? String ?? Servicefile.sample_img
                            let service_cost = dataitm["service_cost"] as? String ?? ""
                            let service_provider_name = dataitm["service_provider_name"] as? String ?? ""
                            let status = dataitm["status"] as? String ?? ""
                            let type  = dataitm["type"] as? String ?? ""
                            let updatedAt = dataitm["updatedAt"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let doctor_name = dataitm["doctor_name"] as? String ?? ""
                            let doctor_id = dataitm["doctor_id"] as? String ?? ""
                            let sp_id = dataitm["sp_id"] as? String ?? ""
                            Servicefile.shared.pet_applist_do_sp.append(pet_applist_doc_sp.init(IN_Booked_at: Booked_at, IN_Booking_Id: Booking_Id, IN_Service_name: Service_name, IN__id: _id, IN_appointment_for: appointment_for, IN_appointment_time: appointment_time, IN_appointment_type: appointment_type, IN_clinic_name: clinic_name, IN_completed_at: completed_at, IN_cost: cost, IN_createdAt: createdAt, IN_missed_at: missed_at, IN_pet_name: pet_name, IN_pet_type: pet_type, IN_photo: photo, IN_service_cost: service_cost, IN_service_provider_name: service_provider_name, IN_status: status, IN_type: type, IN_updatedAt: updatedAt,In_userrate: user_rate, In_userfeed: user_feedback, In_communication_type: communication_type, In_start_appointment_status: start_appointment_status, In_appoint_patient_st : appoint_patient_st,In_doctor_name : doctor_name, In_doctor_id : doctor_id, In_sp_id : sp_id))
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
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func callDocappcancel(){
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_notification, method: .post, parameters:
            ["appointment_UID": Servicefile.shared.pet_applist_do_sp[indextag].Booking_Id,
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "doctor_id":  Servicefile.shared.pet_applist_do_sp[indextag].doctor_id,
             "status":"Patient Appointment Cancelled",
             "user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
    
    
    func callspappcancel(){
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_notification, method: .post, parameters:
            ["appointment_UID": Servicefile.shared.pet_applist_do_sp[indextag].Booking_Id,
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "sp_id": Servicefile.shared.pet_applist_do_sp[indextag].sp_id,
             "status":"Patient Appointment Cancelled",
             "user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
