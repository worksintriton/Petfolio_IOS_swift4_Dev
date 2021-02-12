//
//  Pet_app_details_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 01/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Pet_app_details_ViewController: UIViewController {
    
    
    @IBOutlet weak var image_holder_name: UIImageView!
    @IBOutlet weak var label_holder_name: UILabel!
    @IBOutlet weak var view_complete: UIView!
    @IBOutlet weak var view_cancel: UIView!
    @IBOutlet weak var view_confrence: UIView!
    @IBOutlet weak var image_pet_img: UIImageView!
    
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
    @IBOutlet weak var view_footer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image_holder_name.layer.cornerRadius = 15.0
        self.image_pet_img.layer.cornerRadius = 15.0
        self.view_footer.layer.cornerRadius = 15.0
        self.view_cancel.view_cornor()
        self.view_complete.view_cornor()
        self.view_cancel.dropShadow()
        self.view_complete.dropShadow()
        self.view_confrence.isHidden = true
        self.view_complete.isHidden = true
         self.view_cancel.isHidden = true
        self.label_Holder_service_name.isHidden = true
        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].clinic_name != "" {
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
            } else {
                self.view_complete_cancel.isHidden = true
                self.view_confrence.isHidden = true
            }
            
        }else{
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
        
    }
    
    @IBAction func action_start_confrence(_ sender: Any) {
        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].start_appointment_status == "In-Progress" {
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_home(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
        self.present(vc, animated: true, completion: nil)
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
            link =  Servicefile.SP_complete_and_Missedapp
        }else{
            link =  Servicefile.Doc_complete_and_Missedapp
        }
        
        var params = ["":""]
        params = ["_id": Appointmentid,
                  "missed_at" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                  "appoinment_status" : "Missed",
                  "appoint_patient_st": "Petowner Cancelled appointment"]
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
    
    func alert(Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
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
                            self.label_orderdate.text = data["booking_date_time"] as? String
                            let comm_type = data["communication_type"] as? String
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
                            self.label_order_id.text = data["payment_id"] as? String
                            self.label_payment_method.text = data["payment_method"] as? String
                            self.label_ordercost.text = data["amount"] as? String
                            
                            let pet_id = data["pet_id"] as! NSDictionary
                            let last_vaccination_date = pet_id["last_vaccination_date"] as! String
                            if Int(truncating: pet_id["vaccinated"] as! NSNumber) == 1 {
                                self.label_vaccinated.text = "Yes"
                                self.label_vacindate.text = last_vaccination_date
                            }else{
                                self.label_vaccinated.text = "No"
                                self.view_vacc_date.isHidden = true
                            }
                            self.label_age.text = String(pet_id["pet_age"] as! Int)
                            self.label_weight.text = String(pet_id["pet_weight"] as! Int)
                            self.label_color.text = pet_id["pet_color"] as? String
                            self.label_gender.text = pet_id["pet_gender"] as? String
                            self.label_breed.text = pet_id["pet_breed"] as? String
                            self.label_petType.text = pet_id["pet_type"] as? String
                            self.label_petname_details.text =  pet_id["pet_name"] as? String
                            let petimage = pet_id["pet_img"] as? String
                            self.image_pet_img.sd_setImage(with: Servicefile.shared.StrToURL(url: petimage!)) { (image, error, cache, urls) in
                                if (error != nil) {
                                    self.image_pet_img.image = UIImage(named: "sample")
                                } else {
                                    self.image_pet_img.image = image
                                }
                            }
                            let user_id = data["user_id"] as! NSDictionary
                            let firstname = user_id["first_name"] as? String
                            let lastname = user_id["last_name"] as? String
                            let userimage = user_id["profile_img"] as? String
                            self.label_holder_name.text = firstname! + " " + lastname!
                            //self.label_holder_servie_name.isHidden = true
                            let amt = data["amount"] as! String
                            let doc_business_info = data["doc_business_info"] as! NSArray
                            let doc_busi = doc_business_info[0] as! NSDictionary
                            let clinic_loc  = doc_busi["clinic_loc"] as! String
                            self.label_Holder_cost.text = "₹ " + amt
                            self.label_address_details.text = clinic_loc
                            if userimage == "" {
                                self.image_holder_name.image = UIImage(named: "sample")
                            } else {
                                self.image_holder_name.sd_setImage(with: Servicefile.shared.StrToURL(url: userimage!)) { (image, error, cache, urls) in
                                    if (error != nil) {
                                        self.image_holder_name.image = UIImage(named: "sample")
                                    } else {
                                        self.image_holder_name.image = image
                                    }
                                }
                            }
                        }else{
                            self.label_orderdate.text = data["booking_date_time"] as? String
                            self.view_confrence.isHidden = true
                            self.label_order_id.text = data["payment_id"] as? String
                            self.label_payment_method.text = data["payment_method"] as? String
                            self.label_ordercost.text = data["service_amount"] as? String
                            
                            let pet_id = data["pet_id"] as! NSDictionary
                            let last_vaccination_date = pet_id["last_vaccination_date"] as! String
                            if Int(truncating: pet_id["vaccinated"] as! NSNumber) == 1 {
                                self.label_vaccinated.text = "Yes"
                                self.label_vacindate.text = last_vaccination_date
                            }else{
                                self.label_vaccinated.text = "No"
                                self.view_vacc_date.isHidden = true
                            }
                            self.label_age.text = String(pet_id["pet_age"] as! Int)
                            self.label_weight.text = String(pet_id["pet_weight"] as! Int)
                            self.label_color.text = pet_id["pet_color"] as? String
                            self.label_gender.text = pet_id["pet_gender"] as? String
                            self.label_breed.text = pet_id["pet_breed"] as? String
                            self.label_petType.text = pet_id["pet_type"] as? String
                            self.label_petname_details.text =  pet_id["pet_name"] as? String
                            let petimage = pet_id["pet_img"] as? String
                            self.image_pet_img.sd_setImage(with: Servicefile.shared.StrToURL(url: petimage!)) { (image, error, cache, urls) in
                                if (error != nil) {
                                    self.image_pet_img.image = UIImage(named: "sample")
                                } else {
                                    self.image_pet_img.image = image
                                }
                            }
                            let user_id = data["user_id"] as! NSDictionary
                            let firstname = user_id["first_name"] as? String
                            let lastname = user_id["last_name"] as? String
                            let userimage = user_id["profile_img"] as? String
                            self.label_holder_name.text = firstname! + " " + lastname!
                            self.label_Holder_service_name.isHidden = false
                            self.label_Holder_service_name.text = data["service_name"] as! String
                            let amt = data["service_amount"] as! String
                            let sp_business_info = data["sp_business_info"] as! NSArray
                            let sp_business = sp_business_info[0] as! NSDictionary
                            let sp_loc  = sp_business["sp_loc"] as! String
                            self.label_Holder_cost.text = "₹ " + amt
                            self.label_address_details.text = sp_loc
                            if userimage == "" {
                                self.image_holder_name.image = UIImage(named: "sample")
                            } else {
                                self.image_holder_name.sd_setImage(with: Servicefile.shared.StrToURL(url: userimage!)) { (image, error, cache, urls) in
                                    if (error != nil) {
                                        self.image_holder_name.image = UIImage(named: "sample")
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

