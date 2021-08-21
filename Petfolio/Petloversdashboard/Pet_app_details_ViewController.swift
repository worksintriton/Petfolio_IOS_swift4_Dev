//
//  Pet_app_details_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 01/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class Pet_app_details_ViewController: UIViewController {
    
    
    @IBOutlet weak var image_holder_name: UIImageView!
    @IBOutlet weak var label_holder_name: UILabel!
    @IBOutlet weak var view_complete: UIView!
    @IBOutlet weak var view_cancel: UIView!
    @IBOutlet weak var view_confrence: UIView!
    @IBOutlet weak var image_pet_img: UIImageView!
    
    @IBOutlet weak var label_visittype: UILabel!
    @IBOutlet weak var image_emergency: UIImageView!
    @IBOutlet weak var view_address_details: UIView!
    @IBOutlet weak var label_address_details: UILabel!
    @IBOutlet weak var view_address: UIView!
    
    @IBOutlet weak var label_orderdate: UILabel!
    @IBOutlet weak var label_order_id: UILabel!
    @IBOutlet weak var label_payment_method: UILabel!
    @IBOutlet weak var label_ordercost: UILabel!
    
    @IBOutlet weak var label_vaccinated: UILabel!
    @IBOutlet weak var label_age: UILabel!
    @IBOutlet weak var label_weight: UILabel!
    @IBOutlet weak var label_color: UILabel!
    @IBOutlet weak var label_gender: UILabel!
    @IBOutlet weak var label_breed: UILabel!
    @IBOutlet weak var label_petType: UILabel!
    @IBOutlet weak var label_petname_details: UILabel!
    @IBOutlet weak var view_complete_cancel: UIView!
    @IBOutlet weak var label_Holder_service_name: UILabel!
    @IBOutlet weak var label_Holder_cost: UILabel!
    @IBOutlet weak var label_vacindate: UILabel!
    @IBOutlet weak var view_vacc_date: UIView!
    
    @IBOutlet weak var label_pethandle: UILabel!
    @IBOutlet weak var view_footer: petowner_footerview!
    
    @IBOutlet weak var view_reshedule: UIView!
    @IBOutlet weak var view_btn_shedule: UIView!
    
    @IBOutlet weak var view_prescription: UIView!
    @IBOutlet weak var view_main_prescrip: UIView!
    @IBOutlet weak var view_home_address: UIView!
    @IBOutlet weak var view_data_home_address: UIView!
    @IBOutlet weak var label_home_address_details: UILabel!
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    
    @IBOutlet weak var label_app_bookAndTime: UILabel!
    
    
    
    @IBOutlet weak var label_alergies: UILabel!
    
    @IBOutlet weak var label_pet_comments: UILabel!
    
    @IBOutlet weak var label_diagnosis: UILabel!
    
    @IBOutlet weak var label_sub_diagnosis: UILabel!
    
    @IBOutlet weak var view_diagnosis: UIView!
    @IBOutlet weak var view_subdiagnosis: UIView!
    @IBOutlet weak var view_doc_comm_header: UIView!
    @IBOutlet weak var view_doc_comm: UIView!
    @IBOutlet weak var label_doc_comm: UILabel!
    @IBOutlet weak var view_alergies: UIView!
    @IBOutlet weak var view_comments: UIView!
    @IBOutlet weak var view_pethandledetails: UIView!
    @IBOutlet weak var view_pethandle: UIView!
    @IBOutlet weak var view_visittype: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.view_diagnosis.isHidden = true
        self.view_subdiagnosis.isHidden = true
        self.view_doc_comm_header.isHidden = true
        self.view_doc_comm.isHidden = true
        self.view_alergies.isHidden = true
        self.view_comments.isHidden = true
        self.image_emergency.isHidden = true
        self.view_main_prescrip.isHidden = true
        //self.view_home.view_cornor()
        self.view_prescription.view_cornor()
        self.intial_setup_action()
        self.image_holder_name.view_cornor()
        self.image_pet_img.view_cornor()
        self.view_cancel.view_cornor()
        self.view_complete.view_cornor()
        self.view_cancel.dropShadow()
        self.view_complete.dropShadow()
        self.view_btn_shedule.view_cornor()
        self.view_reshedule.isHidden = true
        self.view_confrence.isHidden = true
        self.view_complete.isHidden = true
         self.view_cancel.isHidden = true
        self.label_Holder_service_name.isHidden = true
        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].clinic_name != "" {
            self.view_alergies.isHidden = false
            self.view_comments.isHidden = false
            if Servicefile.shared.pet_selected_app_list == "current" {
                self.view_complete_cancel.isHidden = true
                //self.view_complete.isHidden = true
                self.view_confrence.isHidden = false
                if Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].appointment_time) > Date() {
                    self.view_complete_cancel.isHidden = false
                     self.view_cancel.isHidden = false
                } else {
                    self.view_complete_cancel.isHidden  = true
                     self.view_cancel.isHidden = true
                }
            } else if Servicefile.shared.pet_selected_app_list == "Complete" {
                self.view_complete_cancel.isHidden = true
                self.view_confrence.isHidden = true
                self.view_diagnosis.isHidden = false
                self.view_subdiagnosis.isHidden = false
                self.view_doc_comm_header.isHidden = false
                self.view_doc_comm.isHidden = false
            } else {
                self.view_complete_cancel.isHidden = true
                self.view_confrence.isHidden = true
            }
            
        }else{
            self.view_pethandledetails.isHidden = true
            self.view_pethandle.isHidden = true
            self.view_visittype.isHidden = true
            self.view_home_address.isHidden = true
            self.view_data_home_address.isHidden = true
            if Servicefile.shared.pet_selected_app_list == "current" {
                self.view_complete_cancel.isHidden  = true
                if Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].appointment_time) > Date() {
                    self.view_complete_cancel.isHidden = false
                     self.view_cancel.isHidden = false
                } else {
                    self.view_complete_cancel.isHidden  = true
                     self.view_cancel.isHidden = true
                }
            } else if Servicefile.shared.pet_selected_app_list == "Complete" {
                self.view_complete_cancel.isHidden = true
            } else {
                self.view_complete_cancel.isHidden = true
            }
            
        }
        self.call_getdetails()
        print("pet image")
    }
    
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "My Appointment"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: true, b2: false, b3: false, b4: true)
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: true, b2: false, b3: false, b4: false, b5: false)
    // footer action
    }
    
    @IBAction func action_reshedule(_ sender: Any) {
        let vc = UIStoryboard.pet_app_details_doc_calender_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_prescription(_ sender: Any) {
        let vc = UIStoryboard.prescriptionViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_start_confrence(_ sender: Any) {
        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].start_appointment_status == "In-Progress" {
            let vc = UIStoryboard.Pet_confrence_ViewController()
            self.present(vc, animated: true, completion: nil)
        } else {
            self.alert(Message: "Doctor is yet to start the Appointment please wait for the doctor to initiate the Appointment")
        }
    }
    
    @IBAction func action_notification(_ sender: Any) {
        let vc = UIStoryboard.pet_notification_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = UIStoryboard.petprofileViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_home(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_cancelappoint(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you need to cancel the Appointment", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex]._id, appointmentstatus: "cancel")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func callcompleteMissedappoitment(Appointmentid: String, appointmentstatus: String){
        var link = ""
        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].clinic_name != "" {
            link =  Servicefile.Doc_complete_and_Missedapp
        }else{
            link =  Servicefile.SP_complete_and_Missedapp
        }
        
        var params = ["":""]
        params = ["_id": Appointmentid,
                  "missed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                  "appoinment_status" : "Missed",
                  "doc_feedback" : "",
                  "appoint_patient_st": "Patient Appointment Cancelled"]
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        print(link,params)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(link, method: .post, parameters: params
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("cancel appointment success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].clinic_name != "" {
                            self.callDocappcancel()
                        }else{
                            self.callspappcancel()
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
    
   
    
    func call_getdetails(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        var urllink = ""
        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].clinic_name != "" {
            urllink = Servicefile.Doc_fetch_appointment_id
        }else{
            urllink = Servicefile.SP_fetch_appointment_id
        }
        if Servicefile.shared.updateUserInterface() { AF.request(urllink, method: .post, parameters:
            ["apppointment_id": Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex]._id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data = res["Data"] as! NSDictionary
                        self.view_confrence.isHidden = true
                        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].clinic_name != "" {
                           
                            Servicefile.shared.pet_apoint_id = data["_id"] as? String ?? ""
                            Servicefile.shared.Doc_details_app_id = data["_id"] as? String ?? ""
                            self.label_app_bookAndTime.text = data["booking_date_time"] as? String ?? ""
                            self.label_orderdate.text = data["booking_date_time"] as? String ?? ""
                            Servicefile.shared.doc_details_date = self.label_orderdate.text!
                            let comm_type = data["communication_type"] as? String ?? ""
                            if comm_type == "Online" || comm_type == "Online Or Visit"{
                                if Servicefile.shared.pet_selected_app_list == "current" {
                                    self.view_complete_cancel.isHidden = false
                                    //self.view_complete.isHidden = true
                                    self.view_confrence.isHidden = false
                                    if Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].appointment_time) > Date() {
                                        self.view_complete_cancel.isHidden = false
                                         self.view_cancel.isHidden = false
                                    } else {
                                        self.view_complete_cancel.isHidden  = true
                                         self.view_cancel.isHidden = true
                                    }
                                } else if Servicefile.shared.pet_selected_app_list == "Complete" {
                                    self.view_complete_cancel.isHidden = true
                                    self.view_confrence.isHidden = true
                                    
                                } else {
                                    self.view_complete_cancel.isHidden = true
                                    self.view_confrence.isHidden = true
                                }
                                
                            }else{
                                self.view_confrence.isHidden = true
                            }
                            self.label_order_id.text = data["payment_id"] as? String ?? ""
                            self.label_payment_method.text = data["payment_method"] as? String ?? ""
                            self.label_ordercost.text = data["amount"] as? String ?? ""
                            
                            let pet_id = data["pet_id"] as! NSDictionary
                            let last_vaccination_date = pet_id["last_vaccination_date"] as? String ?? ""
                            if Int(truncating: pet_id["vaccinated"] as? NSNumber ?? 0) == 1 {
                                self.label_vaccinated.text = "Yes"
                                self.label_vacindate.text = last_vaccination_date
                            }else{
                                self.label_vaccinated.text = "No"
                                self.view_vacc_date.isHidden = true
                            }
                            self.label_age.text = pet_id["pet_age"] as? String ?? "0"
                            self.label_weight.text = String(pet_id["pet_weight"] as? Int ?? 0)
                            self.label_color.text = pet_id["pet_color"] as? String ?? ""
                            self.label_gender.text = pet_id["pet_gender"] as? String ?? ""
                            self.label_breed.text = pet_id["pet_breed"] as? String ?? ""
                            self.label_petType.text = pet_id["pet_type"] as? String ?? ""
                            self.label_petname_details.text =  pet_id["pet_name"] as? String ?? ""
                            
                            self.view_reshedule.isHidden = true
                            let appointment_types = data["appointment_types"] as? String ?? ""
                            if appointment_types == "Emergency" {
                                self.image_emergency.isHidden = false
                            }else{
                                self.image_emergency.isHidden = true
                            }
                            let visit_type = data["visit_type"] as? String ?? ""
                            
                            if visit_type == "Home"  {
                                self.label_visittype.text =  visit_type
                                self.view_home_address.isHidden = false
                                self.view_data_home_address.isHidden = false
                                let visit_type_data = res["Address"] as! NSDictionary
                                 let location = visit_type_data["location_address"] as? String ?? ""
                                self.label_home_address_details.text = location
                            }else{
                                self.label_visittype.text =  "Online"
                                self.view_home_address.isHidden = true
                                self.view_data_home_address.isHidden = true
                            }
                            let appoinment_status = data["appoinment_status"] as? String ?? ""
                            if appoinment_status == "Incomplete" {
                                let reshedule_status = data["reshedule_status"] as? String ?? ""
                                if reshedule_status == "" {
                                    self.view_reshedule.isHidden = false
                                }else{
                                    self.view_reshedule.isHidden = true
                                }
                            }
                            
                            self.view_main_prescrip.isHidden = true
                            if appoinment_status == "Completed" {
                                self.view_main_prescrip.isHidden = false
                            }else{
                                self.view_main_prescrip.isHidden = true
                            }
                          
                            
                            //self.label_holder_servie_name.isHidden = true
                            let amt = data["amount"] as? String ?? ""
                            let doc_business_info = data["doc_business_info"] as! NSArray
                            let doc_busi = doc_business_info[0] as! NSDictionary
                            let clinic_loc  = doc_busi["clinic_loc"] as? String ?? ""
                            let doctor_id = data["doctor_id"] as! NSDictionary
                           
                            let firstname = doctor_id["first_name"] as? String ?? ""
                            let lastname = doctor_id["last_name"] as? String ?? ""
                            let userimage = doctor_id["profile_img"] as? String ?? ""
                            self.label_holder_name.text = firstname + " " + lastname
                            let pet_handle = doc_busi["pet_handled"] as! NSArray
                            var petha = ""
                            for i in 0..<pet_handle.count{
                                let pethan = pet_handle[i] as! NSDictionary
                                let val = pethan["pet_handled"] as? String ?? ""
                                if i == 0 {
                                    if i == pet_handle.count-1 {
                                        petha = val + "."
                                    }else{
                                        petha = val + ", "
                                    }
                                    
                                }else  if i == pet_handle.count-1 {
                                    petha = petha + val + "."
                                }else{
                                    petha = petha + ", " + val
                                }
                                
                            }
                            let petimage = pet_id["pet_img"] as! NSArray
                            if petimage.count > 0 {
                                let petdic = petimage[0] as! NSDictionary
                                let petimg =  petdic["pet_img"] as? String ?? Servicefile.sample_img
                                self.image_pet_img.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                                self.image_pet_img.sd_setImage(with: Servicefile.shared.StrToURL(url: petimg)) { (image, error, cache, urls) in
                                    if (error != nil) {
                                        self.image_pet_img.image = UIImage(named: imagelink.sample)
                                    } else {
                                        self.image_pet_img.image = image
                                    }
                                }
                            }else{
                                self.image_pet_img.image = UIImage(named: imagelink.sample)
                            }
                            self.label_pethandle.text = petha
                            self.label_pethandle.sizeToFit()
                            let _id  = doctor_id["_id"] as? String ?? ""
                            let problem_info = data["problem_info"] as? String ?? ""
                            self.label_pet_comments.text = problem_info
                            let allergies = data["allergies"] as? String ?? ""
                            self.label_alergies.text = allergies
                            let diagnosis = data["diagnosis"] as? String ?? ""
                            self.label_diagnosis.text = diagnosis
                            let sub_diagnosis = data["sub_diagnosis"] as? String ?? ""
                            self.label_sub_diagnosis.text = sub_diagnosis
                            let prescription_details = data["doctor_comment"] as? String ?? ""
                            self.label_doc_comm.text = prescription_details
                            self.label_doc_comm.sizeToFit()
                            Servicefile.shared.doc_detail_id = _id
                            self.label_Holder_cost.text = "₹ " + amt
                            self.label_address_details.text = clinic_loc
                            if userimage == "" {
                                self.image_holder_name.image = UIImage(named: imagelink.sample)
                            } else {
                                self.image_holder_name.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                                self.image_holder_name.sd_setImage(with: Servicefile.shared.StrToURL(url: userimage)) { (image, error, cache, urls) in
                                    if (error != nil) {
                                        self.image_holder_name.image = UIImage(named: imagelink.sample)
                                    } else {
                                        self.image_holder_name.image = image
                                    }
                                }
                            }
                        }else{
                            self.view_diagnosis.isHidden = true
                            self.view_subdiagnosis.isHidden = true
                            self.view_doc_comm_header.isHidden = true
                            self.view_doc_comm.isHidden = true
                            self.label_app_bookAndTime.text = data["booking_date_time"] as? String ?? ""
                            self.label_orderdate.text = data["booking_date_time"] as? String ?? ""
                            self.view_confrence.isHidden = true
                            self.label_order_id.text = data["payment_id"] as? String ?? ""
                            self.label_payment_method.text = data["payment_method"] as? String ?? ""
                            self.label_ordercost.text = data["service_amount"] as? String ?? ""
                            
                            let pet_id = data["pet_id"] as! NSDictionary
                            let last_vaccination_date = pet_id["last_vaccination_date"] as? String ?? ""
                            if Int(truncating: pet_id["vaccinated"] as? NSNumber ?? 0) == 1 {
                                self.label_vaccinated.text = "Yes"
                                self.label_vacindate.text = last_vaccination_date
                            }else{
                                self.label_vaccinated.text = "No"
                                self.view_vacc_date.isHidden = true
                            }
                            self.label_age.text = pet_id["pet_age"] as? String ?? "0"
                            self.label_weight.text = String(pet_id["pet_weight"] as? Int ?? 0)
                            self.label_color.text = pet_id["pet_color"] as? String ?? ""
                            self.label_gender.text = pet_id["pet_gender"] as? String ?? ""
                            self.label_breed.text = pet_id["pet_breed"] as? String ?? ""
                            self.label_petType.text = pet_id["pet_type"] as? String ?? ""
                            self.label_petname_details.text =  pet_id["pet_name"] as? String ?? ""
                            let petimage = pet_id["pet_img"] as! NSArray
                            if petimage.count > 0 {
                                let petdic = petimage[0] as! NSDictionary
                                let petimg =  petdic["pet_img"] as? String ?? Servicefile.sample_img
                                self.image_pet_img.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                                self.image_pet_img.sd_setImage(with: Servicefile.shared.StrToURL(url: petimg)) { (image, error, cache, urls) in
                                    if (error != nil) {
                                        self.image_pet_img.image = UIImage(named: imagelink.sample)
                                    } else {
                                        self.image_pet_img.image = image
                                    }
                                }
                            }else{
                                self.image_pet_img.image = UIImage(named: imagelink.sample)
                            }
                            let user_id = data["user_id"] as! NSDictionary
                            let firstname = user_id["first_name"] as? String ?? ""
                            let lastname = user_id["last_name"] as? String ?? ""
                            let userimage = user_id["profile_img"] as? String ?? Servicefile.sample_img
                            self.label_holder_name.text = firstname + " " + lastname
                            self.label_Holder_service_name.isHidden = false
                            self.label_Holder_service_name.text = data["service_name"] as? String ?? ""
                            let amt = data["service_amount"] as? String ?? ""
                            let sp_business_info = data["sp_business_info"] as! NSArray
                            let sp_business = sp_business_info[0] as! NSDictionary
                            let sp_loc  = sp_business["sp_loc"] as? String ?? ""
                            self.label_Holder_cost.text = "₹ " + amt
                            self.label_address_details.text = sp_loc
                            if userimage == "" {
                                self.image_holder_name.image = UIImage(named: imagelink.sample)
                            } else {
                                self.image_holder_name.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                                self.image_holder_name.sd_setImage(with: Servicefile.shared.StrToURL(url: userimage)) { (image, error, cache, urls) in
                                    if (error != nil) {
                                        self.image_holder_name.image = UIImage(named: imagelink.sample)
                                    } else {
                                        self.image_holder_name.image = image
                                    }
                                }
                            }
                        }
                       
                        if Servicefile.shared.pet_selected_app_list == "current" {
                            self.view_complete_cancel.isHidden  = true
                            if Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].appointment_time) > Date() {
                                self.view_complete_cancel.isHidden = false
                                 self.view_cancel.isHidden = false
                            } else {
                                self.view_complete_cancel.isHidden  = true
                                 self.view_cancel.isHidden = true
                            }
                        } else if Servicefile.shared.pet_selected_app_list == "Complete" {
                            self.view_complete_cancel.isHidden = true
                        } else {
                            self.view_complete_cancel.isHidden = true
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
    
    func callDocappcancel(){
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_notification, method: .post, parameters:
            ["appointment_UID": Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].Booking_Id,
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "doctor_id":  Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].doctor_id,
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
        self.dismiss(animated: true, completion: nil)
    }
    
    /// used for get the details from this function
    func callspappcancel(){
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_notification, method: .post, parameters:
            ["appointment_UID": Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].Booking_Id,
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "sp_id": Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].sp_id,
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
        self.dismiss(animated: true, completion: nil)
    }
    
}

