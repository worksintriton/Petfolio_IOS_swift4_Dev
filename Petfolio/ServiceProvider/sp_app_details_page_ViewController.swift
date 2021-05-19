//
//  sp_app_details_page_ViewController.swift
//  Petfolio
//
//  Created by Admin on 09/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class sp_app_details_page_ViewController: UIViewController  {
    
    
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
    
    @IBOutlet weak var view_header: petowner_otherpage_header!
    @IBOutlet weak var label_vaccinated: UILabel!
    @IBOutlet weak var label_age: UILabel!
    @IBOutlet weak var label_weight: UILabel!
    @IBOutlet weak var label_color: UILabel!
    @IBOutlet weak var label_gender: UILabel!
    @IBOutlet weak var label_breed: UILabel!
    @IBOutlet weak var label_petType: UILabel!
    @IBOutlet weak var label_petname_details: UILabel!
    
    @IBOutlet weak var view_complete_cancel: UIView!
    
    @IBOutlet weak var view_footer: doc_footer!
    
    @IBOutlet weak var label_holder_servie_name: UILabel!
    @IBOutlet weak var label_holder_cost: UILabel!
    @IBOutlet weak var label_vacindate: UILabel!
    @IBOutlet weak var view_vacc_date: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intial_setup_action()
        self.image_holder_name.view_cornor()
        self.image_pet_img.view_cornor()
        self.view_footer.view_cornor()
        self.view_cancel.view_cornor()
        self.view_complete.view_cornor()
        self.call_getdetails()
        self.view_confrence.isHidden = true
        self.image_holder_name.image = UIImage(named: "sample")
        if Servicefile.shared.SP_selected_app_list == "New" {
            self.view_complete_cancel.isHidden = false
        }else if Servicefile.shared.SP_selected_app_list == "Complete" {
            self.view_complete_cancel.isHidden = true
        }else{
            self.view_complete_cancel.isHidden = true
        }
        self.view_address.isHidden = true
        self.view_address_details.isHidden = true
       
    }
    
    func intial_setup_action(){
    // header action
        self.view_header.label_header_title.text = "My Appointment"
        self.view_header.label_header_title.textColor = .white
        self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_header.view_profile.isHidden = true
        self.view_header.view_sos.isHidden = true
        self.view_header.view_bel.isHidden = true
        self.view_header.view_bag.isHidden = true
    // header action
    // footer action
        self.view_footer.setup(b1: false, b2: true, b3: false)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.spshop), for: .touchUpInside)
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.spDashboard), for: .touchUpInside)
    // footer action
    }
   
    
    
    @IBAction func action_profile(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_profile_ViewController") as! Sp_profile_ViewController
                         self.present(vc, animated: true, completion: nil)
       }
       
       @IBAction func action_notifi(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
                  self.present(vc, animated: true, completion: nil)
       }
    
    @IBAction func action_Start_confrence(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you need to start te call", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.callstart_confrence()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
                if let firstVC = presentingViewController as? Sp_dash_ViewController {
                          DispatchQueue.main.async {
                           firstVC.viewWillAppear(true)
                          }
                      }
           }
    
    func callstart_confrence(){
           self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_start_appointment, method: .post, parameters:
               [ "_id": Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].Appid,
                 "start_appointment_status": "In-Progress"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                   switch (response.result) {
                   case .success:
                       let res = response.value as! NSDictionary
                       print("success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                           Servicefile.shared.selectedindex = Servicefile.shared.appointmentindex
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
    
    func callconfrence(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_confrence_ViewController") as! Doc_confrence_ViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func action_home(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_dash_ViewController") as! Sp_dash_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_completeappoint(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you need to complete the Appointment", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].Appid, appointmentstatus: "complete")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func action_cancelappoint(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you need to cancel the Appointment", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].Appid, appointmentstatus: "cancel")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
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
                             self.dismiss(animated: true, completion: nil)
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.SP_fetch_appointment_id, method: .post, parameters:
            ["apppointment_id": Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].Appid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data = res["Data"] as! NSDictionary
                        
                        self.label_orderdate.text = data["booking_date_time"] as? String ?? ""
                        let comm_type = data["communication_type"] as? String ?? ""
                        if comm_type == "Online" || comm_type == "Online Or Visit"{
                            self.view_confrence.isHidden = false
                        }else{
                            self.view_confrence.isHidden = true
                        }
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
                        self.label_age.text = String(pet_id["pet_age"] as? Int ?? 0)
                        self.label_weight.text = String(pet_id["pet_weight"] as? Int ?? 0)
                        self.label_color.text = pet_id["pet_color"] as? String ?? ""
                        self.label_gender.text = pet_id["pet_gender"] as? String ?? ""
                        self.label_breed.text = pet_id["pet_breed"] as? String ?? ""
                        self.label_petType.text = pet_id["pet_type"] as? String ?? ""
                        self.label_petname_details.text =  pet_id["pet_name"] as? String ?? ""
                        let petimage = pet_id["pet_img"] as? String ?? ""
                        self.image_pet_img.sd_setImage(with: Servicefile.shared.StrToURL(url: petimage)) { (image, error, cache, urls) in
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
                        self.label_holder_servie_name.isHidden = false
                        let service_name = data["service_name"] as? String ?? ""
                        self.label_holder_servie_name.text = service_name
                        let amt = data["service_amount"] as? String ?? ""
                        self.label_holder_cost.text = "₹ " + amt
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
    
   
    
    func callspappcancel(){
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_notification, method: .post, parameters:
           ["appointment_UID": Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].appointment_UID,
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "sp_id": Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].sp_id,
             "status":"Doctor Appointment Cancelled",
             "user_id": Servicefile.shared.SP_Das_petdetails[Servicefile.shared.appointmentindex].user_id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
