//
//  doc_app_walkin_ViewController.swift
//  Petfolio
//
//  Created by Admin on 01/09/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import JitsiMeetSDK
import WebKit
import SDWebImage

class doc_app_walkin_ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,JitsiMeetViewDelegate {
    
   // @IBOutlet weak var doc_header: petowner_header!
    
   
    @IBOutlet weak var view_new: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_missed: UIView!
    
    @IBOutlet weak var label_new: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    
    @IBOutlet weak var tblview_applist: UITableView!
    @IBOutlet weak var label_completed: UILabel!
    @IBOutlet weak var label_missed: UILabel!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popp: UIView!
    @IBOutlet weak var view_refresh: UIView!
    @IBOutlet weak var label_failedstatus: UILabel!
    
    @IBOutlet weak var view_close_btn: UIView!
    
    @IBOutlet weak var view_footer: doc_footer!
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    @IBOutlet weak var btn_back: UIButton!
    var refreshControl = UIRefreshControl()
    var appointtype = "New"
    var app_id = ""
    var tag_val = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inital_setup()
        Servicefile.shared.iswalkin = true
        Servicefile.shared.pet_appint_pay_method = ""
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        Servicefile.shared.Doc_dashlist.removeAll()
        self.label_nodata.isHidden = true
        self.view_new.view_cornor()
        self.view_missed.view_cornor()
        //self.view_footer.view_cornor()
        self.view_completed.view_cornor()
        self.view_popp.view_cornor()
        self.view_refresh.view_cornor()
        self.view_shadow.isHidden = true
        self.view_popp.isHidden = true
        self.view_close_btn.isHidden = true
        self.view_completed.layer.borderWidth = 0.5
        self.view_missed.layer.borderWidth = 0.5
        self.view_new.layer.borderWidth = 0.5
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.tblview_applist.addSubview(refreshControl)
        self.tblview_applist.delegate = self
        self.tblview_applist.dataSource = self
        self.view_new.backgroundColor = appcolor
        self.label_new.textColor = UIColor.white
        self.view_completed.backgroundColor = UIColor.white
        self.view_missed.backgroundColor = UIColor.white
        self.label_completed.textColor = appcolor
        self.label_missed.textColor = appcolor
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
        self.callcheckstatus()
        self.callnoticartcount()
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        
    }
    
    func inital_setup(){

        // header action
            
            self.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
            
        // header action
        
        self.view_footer.setup(b1: true, b2: false, b3: false)
        //self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.docshop), for: .touchUpInside)
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stoptimer()
    }
    
    func stoptimer(){
        self.timer.invalidate()
    }
    
    
    
    @objc func refresh(){
        self.callcheckstatus()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func action_refresh(_ sender: Any) {
        self.callcheckstatus()
    }
    
    @IBAction func action_close(_ sender: Any) {
        self.view_popp.isHidden = true
        self.view_shadow.isHidden = true
    }
    
    
    @IBAction func action_sidemenu(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "docsidemenuViewController") as! docsidemenuViewController
//        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.Doc_dashlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! docdashTableViewCell
        cell.selectionStyle = .none
        cell.view_pres.isHidden = true
        cell.view_online.isHidden = true
        cell.label_status.isHidden = true
        cell.label_status_val.isHidden = true
        if Servicefile.shared.appointtype == "New" {
            if Servicefile.shared.Doc_dashlist[indexPath.row].commtype == "Online" || Servicefile.shared.Doc_dashlist[indexPath.row].commtype == "Online Or Visit"{
                cell.view_online.isHidden = false
            }else{
                cell.view_online.isHidden = true
            }
            cell.image_emergnecy.isHidden = true
            cell.view_commissed.isHidden = false
            cell.view_completebtn.isHidden = false
            cell.view_cancnel.isHidden = true
            if Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.Doc_dashlist[indexPath.row].book_date_time) > Date() {
                cell.view_cancnel.isHidden = false
            } else {
               cell.view_cancnel.isHidden = true
            }
            cell.btn_complete.tag = indexPath.row
            cell.btn_cancel.tag = indexPath.row
            cell.btn_complete.addTarget(self, action: #selector(action_complete), for: .touchUpInside)
            cell.btn_cancel.addTarget(self, action: #selector(action_cancelled), for: .touchUpInside)
            cell.btn_online.addTarget(self, action: #selector(action_online), for: .touchUpInside)
            
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].Booked_at
            cell.labe_comMissed.text = "Booked on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else if Servicefile.shared.appointtype == "Completed"{
            
            cell.view_pres.isHidden = false
            
            cell.view_commissed.isHidden = false
            cell.view_completebtn.isHidden = true
            cell.view_cancnel.isHidden = true
            
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].completed_at
            cell.labe_comMissed.text = "Completion on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            cell.label_status.isHidden = false
            cell.label_status_val.isHidden = false
            if  Servicefile.shared.Doc_dashlist[indexPath.row].appoint_patient_st == "Doctor Cancelled appointment" {
                cell.label_status.isHidden = true
                cell.label_status_val.isHidden = true
            } else if  Servicefile.shared.Doc_dashlist[indexPath.row].appoint_patient_st == "Patient Not Available" {
                cell.label_status_val.text = "No show"
            } else if  Servicefile.shared.Doc_dashlist[indexPath.row].appoint_patient_st == "Patient Appointment Cancelled" {
                cell.label_status_val.text = "Not available"
            } else {
                 cell.label_status_val.text = "Not available"
            }
            cell.view_commissed.isHidden = false
            cell.view_completebtn.isHidden = true
            cell.view_cancnel.isHidden = true
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].missed_at
            cell.labe_comMissed.text = "Missed on :"
            cell.label_completedon.textColor = UIColor.red
            cell.labe_comMissed.textColor = UIColor.red
        }
        if Servicefile.shared.Doc_dashlist[indexPath.row].appoinment_status == "Emergency" {
            cell.image_emergnecy.isHidden = false
        }else{
            cell.image_emergnecy.isHidden = true
        }
        cell.btn_pres.tag = indexPath.row
        cell.btn_pres.addTarget(self, action: #selector(action_pres), for: .touchUpInside)
        cell.view_pres.view_cornor()
        cell.view_completebtn.view_cornor()
        cell.view_cancnel.view_cornor()
        cell.View_mainview.layer.borderWidth = 0.2
        cell.View_mainview.layer.borderColor = UIColor.lightGray.cgColor
        cell.label_petname.text = Servicefile.shared.Doc_dashlist[indexPath.row].pet_name
        cell.label_pettype.text = Servicefile.shared.Doc_dashlist[indexPath.row].pet_type
        cell.img_petimg.image = UIImage(named: imagelink.sample)
        cell.label_amount.text =  "₹" + Servicefile.shared.Doc_dashlist[indexPath.row].amount
        cell.label_servicename.text = Servicefile.shared.Doc_dashlist[indexPath.row].appoinment_status
        let petimage = Servicefile.shared.Doc_dashlist[indexPath.row].pet_img
        if petimage.count > 0 {
            let petdic = petimage[0] as! NSDictionary
            let petimg =  petdic["pet_img"] as? String ?? Servicefile.sample_img
            if petimg == "" {
                       cell.img_petimg.image = UIImage(named: imagelink.sample)
                   }else{
                    cell.img_petimg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                       cell.img_petimg.sd_setImage(with: Servicefile.shared.StrToURL(url: petimg)) { (image, error, cache, urls) in
                           if (error != nil) {
                               cell.img_petimg.image = UIImage(named: imagelink.sample)
                           } else {
                               cell.img_petimg.image = image
                           }
                       }
                    cell.img_petimg.contentMode = .scaleAspectFill
                   }
        }else{
            cell.img_petimg.image = UIImage(named: imagelink.sample)
        }
        cell.View_mainview.view_cornor()
        cell.img_petimg.view_cornor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Servicefile.shared.Doc_selected_app_list = Servicefile.shared.appointtype
        Servicefile.shared.appointmentindex = indexPath.row
        Servicefile.shared.pet_apoint_id = Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].Appid
        let vc = UIStoryboard.Doc_detailspage_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @objc func action_pres(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.appointmentindex = tag
        Servicefile.shared.pet_apoint_id = Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].Appid
        let vc = UIStoryboard.prescriptionViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_complete(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.appointmentindex = tag
        Servicefile.shared.pet_appint_pay_method = Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].payment_method
        let vc = UIStoryboard.Doc_prescriptionViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_online(sender : UIButton){
        let tag = sender.tag
        let alert = UIAlertController(title: "", message: "Are you sure you need to start the call", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.tag_val = tag
            self.callstart_confrence()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func callconfrence(){
        let vc = UIStoryboard.Doc_confrence_ViewController()
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func action_cancelled(sender : UIButton){
        let alert = UIAlertController(title: "", message: "Are you sure you need to cancel the Appointment", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let tag = sender.tag
            self.tag_val = tag
            self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.Doc_dashlist[tag].Appid, appointmentstatus: "cancel")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    @IBAction func action_missed(_ sender: Any) {
        Servicefile.shared.appointtype = "Missed"
        self.callapp()
    }
    
    @IBAction func action_completeappoint(_ sender: Any) {
        Servicefile.shared.appointtype = "Completed"
        self.callapp()
    }
    
    @IBAction func action_newappoint(_ sender: Any) {
        Servicefile.shared.appointtype = "New"
        self.callapp()
    }
    
    func callapp(){
        if Servicefile.shared.appointtype == "New" {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_new.backgroundColor = appcolor
            self.label_new.textColor = UIColor.white
            self.view_completed.backgroundColor = UIColor.white
            self.view_missed.backgroundColor = UIColor.white
            self.label_completed.textColor = appcolor
            self.label_missed.textColor = appcolor
            self.view_completed.layer.borderColor = appcolor.cgColor
            self.view_missed.layer.borderColor = appcolor.cgColor
            self.callnew()
        }else if Servicefile.shared.appointtype == "Completed" {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_completed.backgroundColor = appcolor
            self.label_completed.textColor = UIColor.white
            self.view_new.backgroundColor = UIColor.white
            self.view_missed.backgroundColor = UIColor.white
            self.label_new.textColor = appcolor
            self.label_missed.textColor = appcolor
            self.view_new.layer.borderColor = appcolor.cgColor
            self.view_missed.layer.borderColor = appcolor.cgColor
            self.callcom()
        }else{
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_missed.backgroundColor = appcolor
            self.label_missed.textColor = UIColor.white
            self.view_new.backgroundColor = UIColor.white
            self.label_new.textColor = appcolor
            self.label_completed.textColor = appcolor
            self.view_completed.backgroundColor = UIColor.white
            self.view_new.layer.borderColor = appcolor.cgColor
            self.view_new.backgroundColor = UIColor.white
            self.callmiss()
        }
    }
    
    @IBAction func action_logout(_ sender: Any) {
        
    }
    
    func callstart_confrence(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_start_appointment, method: .post, parameters:
            [ "_id": Servicefile.shared.Doc_dashlist[self.tag_val].Appid,
              "start_appointment_status": "In-Progress"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.selectedindex = self.tag_val
                        self.callconfrence()
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
    
    func callnew(){
        Servicefile.shared.Doc_dashlist.removeAll()
        self.tblview_applist.reloadData()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_walkin_dashboardnewapp, method: .post, parameters:
            ["doctor_id": Servicefile.shared.userid, "current_time" : Servicefile.shared.yyyyMMddHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let dataitm = Data[itm] as! NSDictionary
                            let id = dataitm["_id"] as? String ?? ""
                            let allergies = dataitm["allergies"] as? String ?? ""
                            let amount = dataitm["amount"] as? String ?? ""
                            let booking_date_time = dataitm["booking_date_time"] as? String ?? ""
                            let Booked_at = dataitm["booking_date_time"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
                            let appointment_types = dataitm["appointment_types"] as? String ?? ""
                            let comm_type = dataitm["communication_type"] as? String ?? ""
                            let appoint_patient_st = dataitm["appoint_patient_st"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let doc_business_info = dataitm["doc_business_info"] as! NSArray
                            var docimg = ""
                            //var pet_name = ""
                            if doc_business_info.count > 0 {
                                let doc_business = doc_business_info[0] as! NSDictionary
                                let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                if clinic_pic.count > 0 {
                                    let imgdata = clinic_pic[0] as! NSDictionary
                                    docimg = imgdata["clinic_pic"] as? String ?? Servicefile.sample_img
                                }
                               // pet_name = doc_business["clinic_name"] as? String ?? ""
                            }
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as? String ?? ""
                            let pet_name = petdetail["pet_name"] as? String ?? ""
                            let pet_type = petdetail["pet_type"] as? String ?? ""
                            let pet_breed = petdetail["pet_breed"] as? String ?? ""
                            let pet_img = petdetail["pet_img"] as! [Any]
                            let user_id = petdetail["user_id"] as? String ?? ""
                            let appointment_UID = dataitm["appointment_UID"] as? String ?? ""
                            let payment_method = dataitm["payment_method"] as? String ?? ""
                            Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback, In_Booked_at : Booked_at, In_completed_at : completed_at, In_missed_at : missed_at, In_appoint_patient_st: appoint_patient_st, In_commtype : comm_type, In_appointment_UID : appointment_UID, In_payment_method: payment_method))
                            
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
        Servicefile.shared.Doc_dashlist.removeAll()
        self.tblview_applist.reloadData()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_walkin_dashboardcomapp, method: .post, parameters:
            ["doctor_id": Servicefile.shared.userid, "current_time" : Servicefile.shared.yyyyMMddHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let dataitm = Data[itm] as! NSDictionary
                            let id = dataitm["_id"] as? String ?? ""
                            let allergies = dataitm["allergies"] as? String ?? ""
                            let amount = dataitm["amount"] as? String ?? ""
                            let booking_date_time = dataitm["booking_date_time"] as? String ?? ""
                            let Booked_at = dataitm["booking_date_time"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
                            let appointment_types = dataitm["appointment_types"] as? String ?? ""
                            let comm_type = dataitm["communication_type"] as? String ?? ""
                            let appoint_patient_st = dataitm["appoint_patient_st"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let doc_business_info = dataitm["doc_business_info"] as! NSArray
                            var docimg = ""
                           // var pet_name = ""
                            if doc_business_info.count > 0 {
                                let doc_business = doc_business_info[0] as! NSDictionary
                                let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                if clinic_pic.count > 0 {
                                    let imgdata = clinic_pic[0] as! NSDictionary
                                    docimg = imgdata["clinic_pic"] as? String ?? Servicefile.sample_img
                                }
                                //pet_name = doc_business["clinic_name"] as? String ?? ""
                            }
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            
                            
                            let petid = petdetail["_id"] as? String ?? ""
                            let pet_name = petdetail["pet_name"] as? String ?? ""
                            let pet_type = petdetail["pet_type"] as? String ?? ""
                            let pet_breed = petdetail["pet_breed"] as? String ?? ""
                            let pet_img = petdetail["pet_img"] as! [Any]
                            let user_id = petdetail["user_id"] as? String ?? ""
                            let appointment_UID = dataitm["appointment_UID"] as? String ?? ""
                            let payment_method = petdetail["payment_method"] as? String ?? ""
                            Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback, In_Booked_at : Booked_at, In_completed_at : completed_at, In_missed_at : missed_at, In_appoint_patient_st: appoint_patient_st, In_commtype : comm_type, In_appointment_UID : appointment_UID, In_payment_method: payment_method))
                            
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
        Servicefile.shared.Doc_dashlist.removeAll()
        self.tblview_applist.reloadData()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_walkin_dashboardmissapp, method: .post, parameters:
            ["doctor_id": Servicefile.shared.userid, "current_time" : Servicefile.shared.yyyyMMddHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let dataitm = Data[itm] as! NSDictionary
                            let id = dataitm["_id"] as? String ?? ""
                            let allergies = dataitm["allergies"] as? String ?? ""
                            let amount = dataitm["amount"] as? String ?? ""
                            let booking_date_time = dataitm["booking_date_time"] as? String ?? ""
                            let Booked_at = dataitm["booking_date_time"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
                            let appointment_types = dataitm["appointment_types"] as? String ?? ""
                            let comm_type = dataitm["communication_type"] as? String ?? ""
                            let appoint_patient_st = dataitm["appoint_patient_st"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let doc_business_info = dataitm["doc_business_info"] as! NSArray
                            var docimg = ""
                            // var pet_name = ""
                            if doc_business_info.count > 0 {
                                let doc_business = doc_business_info[0] as! NSDictionary
                                let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                if clinic_pic.count > 0 {
                                    let imgdata = clinic_pic[0] as! NSDictionary
                                    docimg = imgdata["clinic_pic"] as? String ?? Servicefile.sample_img
                                }
                                // pet_name = doc_business["clinic_name"] as? String ?? ""
                            }
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as? String ?? ""
                            let pet_name = petdetail["pet_name"] as? String ?? ""
                            let pet_type = petdetail["pet_type"] as? String ?? ""
                            let pet_breed = petdetail["pet_breed"] as? String ?? ""
                            let pet_img = petdetail["pet_img"] as! [Any]
                            let user_id = petdetail["user_id"] as? String ?? ""
                            let appointment_UID = dataitm["appointment_UID"] as? String ?? ""
                            let payment_method = petdetail["payment_method"] as? String ?? ""
                            Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time, In_userrate: user_rate, In_userfeedback: user_feedback, In_Booked_at : Booked_at, In_completed_at : completed_at, In_missed_at : missed_at, In_appoint_patient_st: appoint_patient_st, In_commtype : "", In_appointment_UID : appointment_UID, In_payment_method: payment_method))
                            
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
                       "doc_feedback" : "",
                       "appoinment_status" : "Missed",
                       "appoint_patient_st": "Doctor Cancelled appointment"]
        }
        var link = ""
        if Servicefile.shared.iswalkin {
            link =  Servicefile.Doc_walkin_complete_and_Missedapp
        }else{
            link =  Servicefile.Doc_complete_and_Missedapp
        }
        
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
                        if appointmentstatus != "cancel"{
                           
                        }else{
                            self.callDocappcancel()
                        }
                        self.callapp()
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
    
    func callcheckstatus() {
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_Dashboard_checkstatus, method: .post, parameters: ["user_id": Servicefile.shared.userid]
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let profile_status = Data["profile_status"] as? Bool ?? false
                        let calender_status = Data["calender_status"] as? Bool ?? false
                        if profile_status == false {
                            let vc = UIStoryboard.regdocViewController()
                            self.present(vc, animated: true, completion: nil)
                        }else if calender_status == false {
                            let vc = UIStoryboard.Reg_calender_ViewController()
                            self.present(vc, animated: true, completion: nil)
                        }else {
                            let profile_verification_status = Data["profile_verification_status"] as? String ?? ""
                            if profile_verification_status == "Not verified" {
                                self.view_shadow.isHidden = false
                                self.view_popp.isHidden = false
                                let Message = res["Message"] as? String ?? ""
                                self.label_failedstatus.text = Message
                            }else if profile_verification_status == "profile updated" {
                                self.view_shadow.isHidden = false
                                self.view_popp.isHidden = false
                                self.view_close_btn.isHidden = false
                                let Message = res["Message"] as? String ?? ""
                                self.label_failedstatus.text = Message
                            }else{
                                self.view_shadow.isHidden = true
                                self.view_popp.isHidden = true
                                self.call_list_shipping_address()
                                self.callapp()
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
    
    @IBAction func actionl_ogout(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        let vc = UIStoryboard.LoginViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
   
    func callDocappcancel(){
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_notification, method: .post, parameters:
           ["appointment_UID": Servicefile.shared.Doc_dashlist[self.tag_val].appointment_UID,
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "doctor_id": Servicefile.shared.userid,
             "status":"Doctor Appointment Cancelled",
             "user_id": Servicefile.shared.Doc_dashlist[self.tag_val].user_id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                    print(Error)
                    self.stopAnimatingActivityIndicator()
                    
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func call_list_shipping_address(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_shiping_address_list, method: .post, parameters:
                                                                    ["user_id":Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                                        switch (response.result) {
                                                                        case .success:
                                                                            let res = response.value as! NSDictionary
                                                                            print("success data",res)
                                                                            let Code  = res["Code"] as! Int
                                                                            if Code == 200 {
                                                                                Servicefile.shared.shipaddresslist.removeAll()
                                                                                let data = res["Data"] as! NSDictionary
                                                                                let id = data["_id"] as? String ?? ""
                                                                                if id != "" {
                                                                                    let location_city =  data["location_city"] as? String ?? ""
                                                                                    Servicefile.shared.shiplocation = location_city
                                                                                    // self.doc_header.label_location.text = Servicefile.shared.shiplocation
                                                                                }
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
    
    func callnoticartcount(){
        print("notification")
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.cartnoticount, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("notification success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let notification_count = Data["notification_count"] as! Int
                        let product_count = Data["product_count"] as! Int
                        Servicefile.shared.notifi_count = notification_count
                        Servicefile.shared.cart_count = product_count
                        //self.doc_header.checknoti()
                    }else{
                        print("status code service denied")
                    }
                    break
                case .failure(let Error):
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }
            }
        }else{
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
  
}
