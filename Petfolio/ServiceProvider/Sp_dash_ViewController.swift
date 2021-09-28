//
//  Sp_dash_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 22/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class Sp_dash_ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var view_new: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_missed: UIView!
    
    @IBOutlet weak var label_new: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    
    @IBOutlet weak var tblview_applist: UITableView!
    @IBOutlet weak var label_completed: UILabel!
    @IBOutlet weak var label_missed: UILabel!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_refresh: UIView!
    @IBOutlet weak var label_failedstatus: UILabel!
    
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var view_popalert: UIView!
    @IBOutlet weak var label_popalert_details: UILabel!
    @IBOutlet weak var view_btn_yes: UIView!
    @IBOutlet weak var view_btn_no: UIView!
    
    var refreshControl = UIRefreshControl()
    var indextag = 0
    var statussel = ""
    var timer = Timer()
    
    @IBOutlet weak var sp_header: petowner_header!
//    var appointtype = "New"
    override func viewDidLoad() {
        super.viewDidLoad()
//        CacheManager.shared.clearCache()
//        Servicefile.shared.getuserdata()
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        self.view_footer.backgroundColor = UIColor.clear
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.inital_setup()
        self.label_nodata.isHidden = true
        self.view_popalert.isHidden = true
        self.view_popalert.view_cornor()
        self.view_btn_yes.view_cornor()
        self.view_btn_no.view_cornor()
        self.view_new.view_cornor()
        self.view_missed.view_cornor()
        self.view_footer.view_cornor()
        self.view_completed.view_cornor()
        self.view_popup.view_cornor()
        self.view_refresh.view_cornor()
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.view_completed.layer.borderWidth = 0.5
        self.view_missed.layer.borderWidth = 0.5
        self.view_new.layer.borderWidth = 0.5
        let appgree = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appgree.cgColor
        self.view_missed.layer.borderColor = appgree.cgColor
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.tblview_applist.refreshControl = refreshControl
        self.tblview_applist.delegate = self
        self.tblview_applist.dataSource = self
       
        self.view_new.backgroundColor = appgree
        self.label_new.textColor = UIColor.white
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
//        if Servicefile.shared.userid != "" {
//            self.checkapp()
//        }else{
//
//        }
        //self.checkapp()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.stoptimer()
    }
    
    func stoptimer(){
        self.timer.invalidate()
    }
    
    func inital_setup(){
        self.sp_header.btn_sidemenu.addTarget(self, action: #selector(self.sidemenu_process), for: .touchUpInside)
//        var img = Servicefile.shared.userimage
//        if img != "" {
//            img = Servicefile.shared.userimage
//        }else{
//            img = Servicefile.sample_img
//        }
//        self.sp_header.image_profile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//        self.sp_header.image_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: img)) { (image, error, cache, urls) in
//            if (error != nil) {
//                self.sp_header.image_profile.image = UIImage(named: imagelink.sample)
//            } else {
//                self.sp_header.image_profile.image = image
//            }
//        }
        self.sp_header.btn_location.addTarget(self, action: #selector(self.spmanageaddress), for: .touchUpInside)
        
        self.sp_header.label_location.text = Servicefile.shared.shiplocation
//        self.sp_header.image_profile.layer.cornerRadius = self.sp_header.image_profile.frame.height / 2
//        self.sp_header.btn_profile.addTarget(self, action: #selector(self.spprofile), for: .touchUpInside)
//
//        self.sp_header.btn_button2.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        
        
        self.sp_header.btn_button2.addTarget(self, action: #selector(spcartpage), for: .touchUpInside)
        self.sp_header.image_button2.image = UIImage(named: imagelink.image_bag)
        self.sp_header.image_profile.image = UIImage(named: imagelink.image_bel)
        self.sp_header.btn_profile.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        
        self.view_footer.setup(b1: true, b2: false, b3: false)
        //self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.spshop), for: .touchUpInside)
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.spDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
    }
    
    @objc func sidemenu_process(){
        self.stoptimer()
        let vc = UIStoryboard.sp_side_menuViewController()
        self.present(vc, animated: true, completion: nil)
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
                        self.sp_header.checknoti()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    @objc func refresh(){
            self.callcheckstatus()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func action_profile(_ sender: Any) {
        self.stoptimer()
        let vc = UIStoryboard.Sp_profile_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_notifi(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_refresh(_ sender: Any) {
        self.callcheckstatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callcheckstatus()
    }
    
    @IBAction func action_sidemenu(_ sender: Any) {
        let vc = UIStoryboard.sp_side_menuViewController()
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
        if Servicefile.shared.appointtype == "New" {
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
            cell.selectionStyle = .none
        }else if Servicefile.shared.appointtype == "Completed"{
            cell.selectionStyle = .none
            cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].completed_at
            cell.labe_comMissed.text = "Completed on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            cell.selectionStyle = .none
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
        
        cell.view_completebtn.view_cornor()
        cell.view_cancnel.view_cornor()
        cell.View_mainview.layer.borderWidth = 0.2
        cell.View_mainview.layer.borderColor = UIColor.lightGray.cgColor
        cell.label_petname.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_name
        cell.label_pettype.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_type
        cell.img_petimg.image = UIImage(named: imagelink.sample)
        cell.label_amount.text =  "INR " + Servicefile.shared.SP_Das_petdetails[indexPath.row].amount
        cell.label_servicename.text = Servicefile.shared.SP_Das_petdetails[indexPath.row].sername
        
        if Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_img.count > 0 {
        let petdic = Servicefile.shared.SP_Das_petdetails[indexPath.row].pet_img[0] as! NSDictionary
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
        }
        }else{
            cell.img_petimg.image = UIImage(named: imagelink.sample)
        }
           
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.stoptimer()
        Servicefile.shared.SP_selected_app_list = Servicefile.shared.appointtype
        Servicefile.shared.appointmentindex = indexPath.row
        Servicefile.shared.pet_apoint_id = Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].Appid
        let vc = UIStoryboard.sp_app_details_page_ViewController()
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
        Servicefile.shared.appointtype = "Missed"
        self.checkapp()
    }
    @IBAction func action_completeappoint(_ sender: Any) {
        Servicefile.shared.appointtype = "Completed"
        self.checkapp()
    }
    @IBAction func action_newappoint(_ sender: Any) {
        Servicefile.shared.appointtype = "New"
        self.checkapp()
    }
    
    func checkapp(){
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
    
    func callnew(){
        self.label_nodata.text = "No new appointments"
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
                            let id = dataitm["_id"] as? String ?? ""
                            let amount = dataitm["service_amount"] as? String ?? ""
                            let service_name = dataitm["service_name"] as? String ?? ""
                            let booking_date_time = dataitm["booking_date_time"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as? String ?? ""
                            let pet_name = petdetail["pet_name"] as? String ?? ""
                            let pet_type = petdetail["pet_type"] as? String ?? ""
                            let pet_breed = petdetail["pet_breed"] as? String ?? ""
                            let pet_img = petdetail["pet_img"] as! [Any]
                            let user_id = petdetail["user_id"] as? String ?? ""
                            let sp_id = dataitm["sp_id"] as? String ?? ""
                            let appointment_UID = dataitm["appointment_UID"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    
    func callcom(){
        self.label_nodata.text = "No completed appointments"
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
                            let id = dataitm["_id"] as? String ?? ""
                            let amount = dataitm["service_amount"] as? String ?? ""
                            let service_name = dataitm["service_name"] as? String ?? ""
                            let booking_date_time = dataitm["booking_date_time"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as? String ?? ""
                            let pet_name = petdetail["pet_name"] as? String ?? ""
                            let pet_type = petdetail["pet_type"] as? String ?? ""
                            let pet_breed = petdetail["pet_breed"] as? String ?? ""
                            let pet_img = petdetail["pet_img"] as! [Any]
                            let user_id = petdetail["user_id"] as? String ?? ""
                            let sp_id = dataitm["sp_id"] as? String ?? ""
                            let appointment_UID = dataitm["appointment_UID"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func callmiss(){
        self.label_nodata.text = "No missed appointments"
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
                            let id = dataitm["_id"] as? String ?? ""
                            let amount = dataitm["service_amount"] as? String ?? ""
                            let service_name = dataitm["service_name"] as? String ?? ""
                            let booking_date_time = dataitm["booking_date_time"] as? String ?? ""
                            let user_rate = dataitm["user_rate"] as? String ?? ""
                            let user_feedback = dataitm["user_feedback"] as? String ?? ""
                            let petdetail = dataitm["pet_id"] as! NSDictionary
                            let petid = petdetail["_id"] as? String ?? ""
                            let pet_name = petdetail["pet_name"] as? String ?? ""
                            let pet_type = petdetail["pet_type"] as? String ?? ""
                            let pet_breed = petdetail["pet_breed"] as? String ?? ""
                            let pet_img = petdetail["pet_img"] as! [Any]
                            let user_id = petdetail["user_id"] as? String ?? ""
                            let sp_id = dataitm["sp_id"] as? String ?? ""
                            let appointment_UID = dataitm["appointment_UID"] as? String ?? ""
                            let completed_at = dataitm["completed_at"] as? String ?? ""
                            let missed_at = dataitm["missed_at"] as? String ?? ""
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
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
                        
                        self.checkapp()
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
    }
    
    func callcheckstatus(){
        self.callnoticartcount()
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
                        let profile_status = Data["profile_status"] as? Bool ?? false
                        let calender_status = Data["calender_status"] as? Bool ?? false
                        print("profile_status",profile_status)
                        self.call_list_shipping_address()
                        if profile_status == false {
                            let vc = UIStoryboard.SP_Reg_ViewController()
                            self.present(vc, animated: true, completion: nil)
                        }else if calender_status == false {
                            let vc = UIStoryboard.Sp_reg_calender_ViewController()
                            self.present(vc, animated: true, completion: nil)
                        }else {
                            let profile_verification_status = Data["profile_verification_status"]  as? String ?? ""
                            if profile_verification_status == "Not verified" {
                                self.view_shadow.isHidden = false
                                self.view_popup.isHidden = false
                                let Message = res["Message"] as? String ?? ""
                                self.label_failedstatus.text = Message
                            }else{
                                self.call_list_shipping_address()
                                self.view_shadow.isHidden = true
                                self.view_popup.isHidden = true
                                self.checkapp()
                               
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
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
                case .failure(let _):
                    self.stopAnimatingActivityIndicator()
                    
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
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
                                                                                    self.sp_header.label_location.text = Servicefile.shared.shiplocation
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
            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
        }
        
    }
}

extension UIViewController {
    @objc func spsidemenu(sender : UIButton){
        let vc = UIStoryboard.sp_side_menuViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func spmanageaddress(sender : UIButton){
        let vc = UIStoryboard.sp_manageaddressViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func spcartpage(sender : UIButton){
        let vc = UIStoryboard.sp_vendorcartpage_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    /// act as dashboard
    @objc func spshop(sender : UIButton){
        let vc = UIStoryboard.Sp_dash_ViewController()
        self.present(vc, animated: true, completion: nil)
        
    }
    
    /// act as shop
    @objc func spDashboard(sender : UIButton){
        let vc = UIStoryboard.sp_shop_dashboard_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func spprofile(sender : UIButton){
        let vc = UIStoryboard.Sp_profile_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
