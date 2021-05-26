//
//  Doc_detailspage_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 01/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class Doc_detailspage_ViewController: UIViewController {
    
    
    @IBOutlet weak var image_holder_name: UIImageView!
    @IBOutlet weak var label_holder_name: UILabel!
    @IBOutlet weak var view_complete: UIView!
    @IBOutlet weak var view_cancel: UIView!
    @IBOutlet weak var view_confrence: UIView!
    @IBOutlet weak var image_pet_img: UIImageView!
    
    @IBOutlet weak var view_address_details: UIView!
    @IBOutlet weak var label_address_details: UILabel!
    @IBOutlet weak var view_address: UIView!
    @IBOutlet weak var label_home_address_details: UILabel!
    
    @IBOutlet weak var label_pet_handle: UILabel!
    @IBOutlet weak var label_orderdate: UILabel!
    @IBOutlet weak var label_order_id: UILabel!
    @IBOutlet weak var label_payment_method: UILabel!
    @IBOutlet weak var label_ordercost: UILabel!
    
    @IBOutlet weak var view_main_prescrip: UIView!
    @IBOutlet weak var view_prescription: UIView!
    @IBOutlet weak var label_vaccinated: UILabel!
    @IBOutlet weak var label_age: UILabel!
    @IBOutlet weak var label_weight: UILabel!
    @IBOutlet weak var label_color: UILabel!
    @IBOutlet weak var label_gender: UILabel!
    @IBOutlet weak var label_breed: UILabel!
    @IBOutlet weak var label_petType: UILabel!
    @IBOutlet weak var label_petname_details: UILabel!
    
    @IBOutlet weak var label_pethandle: UILabel!
    @IBOutlet weak var view_complete_cancel: UIView!
    
    @IBOutlet weak var view_emergency: UIView!
    @IBOutlet weak var label_holder_servie_name: UILabel!
    @IBOutlet weak var label_holder_cost: UILabel!
    @IBOutlet weak var label_vacindate: UILabel!
    @IBOutlet weak var view_vacc_date: UIView!
    
    @IBOutlet weak var label_app_bookAndTime: UILabel!
    @IBOutlet weak var label_visittype: UILabel!
    @IBOutlet weak var view_header: petowner_otherpage_header!
    @IBOutlet weak var view_home_address: UIView!
    @IBOutlet weak var view_data_home_address: UIView!
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var view_home_dotted_line: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_emergency.isHidden = true
        self.view_main_prescrip.isHidden = true
        self.view_prescription.view_cornor()
        self.intial_setup_action()
        self.image_holder_name.view_cornor()
        self.image_pet_img.view_cornor()
        self.view_footer.view_cornor()
        self.view_cancel.view_cornor()
        self.view_complete.view_cornor()
        self.call_getdetails()
        self.image_holder_name.image = UIImage(named: "sample")
        if Servicefile.shared.Doc_selected_app_list == "New" {
            self.view_complete_cancel.isHidden = false
            self.view_confrence.isHidden = false
        }else if Servicefile.shared.Doc_selected_app_list == "Complete" {
            self.view_complete_cancel.isHidden = true
            self.view_confrence.isHidden = true
        }else{
            self.view_complete_cancel.isHidden = true
            self.view_confrence.isHidden = true
        }
        self.view_address.isHidden = true
        self.view_address_details.isHidden = true
        self.view_home_address.isHidden = true
        self.view_data_home_address.isHidden = true
       
    }
    
    
    func intial_setup_action(){
    // header action
        self.view_header.label_header_title.text = "My Appointment"
        self.view_header.label_header_title.textColor = .white
        self.view_header.btn_back.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_header.view_profile.isHidden = true
        self.view_header.view_sos.isHidden = true
        self.view_header.view_bel.isHidden = true
        self.view_header.view_bag.isHidden = true
    // header action
    // footer action
        self.view_footer.setup(b1: false, b2: false, b3: false)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.docshop), for: .touchUpInside)
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
    // footer action
    }
    
    @IBAction func action_notific(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_profiledetails_ViewController") as! Doc_profiledetails_ViewController
               self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_prescrption(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pdfViewController") as! pdfViewController
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
    
    func callstart_confrence(){
           self.startAnimatingActivityIndicator()
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_start_appointment, method: .post, parameters:
               [ "_id": Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].Appid,
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DocdashboardViewController") as! DocdashboardViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_completeappoint(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_prescriptionViewController") as! Doc_prescriptionViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_cancelappoint(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you need to cancel the Appointment", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.callcompleteMissedappoitment(Appointmentid: Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].Appid, appointmentstatus: "cancel")
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_complete_and_Missedapp, method: .post, parameters: params
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.dismiss(animated: true, completion: nil)
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Doc_fetch_appointment_id, method: .post, parameters:
            ["apppointment_id": Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].Appid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data = res["Data"] as! NSDictionary
                        Servicefile.shared.pet_apoint_id = data["_id"] as? String ?? ""
                       
                        self.label_orderdate.text = data["booking_date_time"] as? String ?? ""
                        self.label_app_bookAndTime.text = data["booking_date_time"] as? String ?? ""
                        let comm_type = data["communication_type"] as? String ?? ""
                        let appoinment_status = data["appoinment_status"] as? String ?? ""
                        if appoinment_status == "Incomplete" {
                            if comm_type == "Online" || comm_type == "Online Or Visit"{
                                self.view_confrence.isHidden = false
                            }else{
                                self.view_confrence.isHidden = true
                            }
                        }else{
                            self.view_confrence.isHidden = true
                        }
                        self.view_main_prescrip.isHidden = true
                        if appoinment_status == "Completed" {
                            self.view_main_prescrip.isHidden = false
                        }else{
                            self.view_main_prescrip.isHidden = true
                        }
                        
                        self.view_emergency.isHidden = true
                        let appointment_types = data["appointment_types"] as? String ?? ""
                        if appointment_types == "Emergency" {
                            self.view_emergency.isHidden = false
                        }else{
                            self.view_emergency.isHidden = true
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
                        let petimage = pet_id["pet_img"] as! [Any]
                        if petimage.count > 0 {
                            let petdic = petimage[0] as! NSDictionary
                            let petimg =  petdic["pet_img"] as? String ?? Servicefile.sample_img
                            self.image_pet_img.sd_setImage(with: Servicefile.shared.StrToURL(url: petimg)) { (image, error, cache, urls) in
                                if (error != nil) {
                                    self.image_pet_img.image = UIImage(named: "sample")
                                } else {
                                    self.image_pet_img.image = image
                                }
                            }
                        }else{
                            self.image_pet_img.image = UIImage(named: "sample")
                        }
                        let user_id = data["user_id"] as! NSDictionary
                        let firstname = user_id["first_name"] as? String
                        let lastname = user_id["last_name"] as? String
                        let userimage = user_id["profile_img"] as? String
                        self.label_holder_name.text = firstname! + " " + lastname!
                        self.label_holder_servie_name.isHidden = true
                        let amt = data["amount"] as? String ?? "0"
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
                       
                        self.view_address.isHidden = false
                        self.view_address_details.isHidden = false
                        let doc_business_info = data["doc_business_info"] as! NSArray
                        if doc_business_info.count > 0 {
                            let doc_info = doc_business_info[0] as! NSDictionary
                            self.label_address_details.text = doc_info["clinic_loc"] as? String ?? ""
                            let pet_handle = doc_info["pet_handled"] as! NSArray
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
                            self.label_pethandle.text = petha
                            self.label_pethandle.sizeToFit()
                        }
                      
                        let visit_type = data["visit_type"] as? String ?? ""
                       
                        if visit_type == "Home"  {
                            self.label_visittype.text =  visit_type
                            self.view_home_address.isHidden = false
                            self.view_home_dotted_line.isHidden = false
                            self.view_data_home_address.isHidden = false
                            let visit_type_data = res["Address"] as! NSDictionary
                             let location = visit_type_data["location_address"] as? String ?? ""
                            self.label_home_address_details.text = location
                        }else{
                            self.label_visittype.text =  "Online"
                            self.view_home_address.isHidden = true
                            self.view_data_home_address.isHidden = true
                            self.view_home_dotted_line.isHidden = true
                        }
                        
                        
                        //                        {
                        //                            "__v" = 0;
                        //                            "_id" = 60178c21e356d41de1763dcb;
                        //                            allergies = "my allergies ";
                        //                            amount = 100;
                        //                            "appoinment_status" = Incomplete;
                        //                            "appoint_patient_st" = "";
                        //                            "appointment_UID" = "PET-1612155937129";
                        //                            "appointment_types" = Normal;
                        //                            "booking_date" = "05-02-2021";
                        //                            "booking_date_time" = "05-02-2021   05:45 PM";
                        //                            "booking_time" = "05:45 PM";
                        //                            "communication_type" = Online;
                        //                            "completed_at" = "";
                        //                            createdAt = "2021-02-01T05:05:37.140Z";
                        //                            "delete_status" = 0;
                        //                            "display_date" = "2021-02-05 17:45:00";
                        //                            "doc_attched" =         (
                        //                            );
                        //                            "doc_business_info" =         (
                        //                                            {
                        //                                    "__v" = 0;
                        //                                    "_id" = 6012a13858b31a2ec49bcd84;
                        //                                    "calender_status" = 1;
                        //                                    "certificate_pic" =                 (
                        //                                                            {
                        //                                            "certificate_pic" = "http://52.25.163.13:3000/api/uploads/6012a063365f442a8a41093428-01-2021 05:00 pmsigned_death_D-2020_33-16454-000254.pdf";
                        //                                        }
                        //                                    );
                        //                                    "clinic_lat" = "12.9831927";
                        //                                    "clinic_loc" = "k. k. nagar";
                        //                                    "clinic_long" = "80.22360810000001";
                        //                                    "clinic_name" = "zz clinic";
                        //                                    "clinic_pic" =                 (
                        //                                                            {
                        //                                            "clinic_pic" = "http://52.25.163.13:3000/api/uploads/6012a063365f442a8a41093428-01-2021 05:00 pmIMG-20210128-WA0019.jpg";
                        //                                        }
                        //                                    );
                        //                                    comments = 0;
                        //                                    "communication_type" = "Online Or Visit";
                        //                                    "consultancy_fees" = 1000;
                        //                                    createdAt = "2021-01-28T11:34:16.281Z";
                        //                                    "date_and_time" = "28/01/2021 05:04:15";
                        //                                    "delete_status" = 0;
                        //                                    "dr_name" = sangeetha;
                        //                                    "dr_title" = Dr;
                        //                                    "education_details" =                 (
                        //                                                            {
                        //                                            education = mmbs;
                        //                                            year = 2020;
                        //                                        }
                        //                                    );
                        //                                    "experience_details" =                 (
                        //                                                            {
                        //                                            company = dddd;
                        //                                            from = 2020;
                        //                                            to = 2021;
                        //                                        }
                        //                                    );
                        //                                    "govt_id_pic" =                 (
                        //                                                            {
                        //                                            "govt_id_pic" = "http://52.25.163.13:3000/api/uploads/6012a063365f442a8a41093428-01-2021 05:00 pmsigned_death_D-2020_33-16454-000254.pdf";
                        //                                        }
                        //                                    );
                        //                                    "live_by" = "Super Admin";
                        //                                    "live_status" = Live;
                        //                                    "mobile_type" = Android;
                        //                                    "pet_handled" =                 (
                        //                                                            {
                        //                                            "pet_handled" = Dog;
                        //                                        },
                        //                                                            {
                        //                                            "pet_handled" = Rabbit;
                        //                                        },
                        //                                                            {
                        //                                            "pet_handled" = Cat;
                        //                                        },
                        //                                                            {
                        //                                            "pet_handled" = "Guinea pig";
                        //                                        }
                        //                                    );
                        //                                    "photo_id_pic" =                 (
                        //                                                            {
                        //                                            "photo_id_pic" = "http://52.25.163.13:3000/api/uploads/6012a063365f442a8a41093428-01-2021 05:00 pmsigned_death_D-2020_33-16454-000254.pdf";
                        //                                        }
                        //                                    );
                        //                                    "profile_status" = 1;
                        //                                    "profile_verification_status" = Verified;
                        //                                    rating = 0;
                        //                                    specialization =                 (
                        //                                                            {
                        //                                            specialization = Surgeon;
                        //                                        },
                        //                                                            {
                        //                                            specialization = "Family Physician";
                        //                                        },
                        //                                                            {
                        //                                            specialization = "Testing Spef";
                        //                                        },
                        //                                                            {
                        //                                            specialization = "Internal Medicine Physician";
                        //                                        }
                        //                                    );
                        //                                    updatedAt = "2021-01-29T12:13:48.665Z";
                        //                                    "user_id" = 6012a063365f442a8a410934;
                        //                                }
                        //                            );
                        //                            "doc_feedback" = "";
                        //                            "doc_rate" = 0;
                        //                            "doctor_id" =         {
                        //                                "__v" = 0;
                        //                                "_id" = 6012a063365f442a8a410934;
                        //                                createdAt = "2021-01-28T11:30:43.847Z";
                        //                                "date_of_reg" = "28/01/2021 05:00 pm";
                        //                                "delete_status" = 0;
                        //                                "device_id" = "";
                        //                                "device_type" = "";
                        //                                "fb_token" = "c9lZr5q-GkNbjCdwqhj0EQ:APA91bHF4hZEC9MiDzfNVzNJC8tusRihPF9ro-uJkID98eDE8WF3kVNKD0duyp49gvEQn_VROQlSq2RPriaWYTQz8ULCAK__i3n8z7mkxudXiCQ3cFa9j4cUyak2sBaFgPwMfvCCB7ah";
                        //                                "first_name" = sangeetha;
                        //                                "last_name" = Doctor;
                        //                                "mobile_type" = Android;
                        //                                otp = 123456;
                        //                                "profile_img" = "";
                        //                                updatedAt = "2021-02-01T08:59:28.276Z";
                        //                                "user_email" = "sangeetha.saravanan99@gmail.com";
                        //                                "user_email_verification" = 1;
                        //                                "user_phone" = 9003237222;
                        //                                "user_status" = complete;
                        //                                "user_type" = 4;
                        //                            };
                        //                            "end_appointment_status" = "Not End";
                        //                            "missed_at" = "";
                        //                            "mobile_type" = IOS;
                        //                            "msg_id" = "Meeting_id/60178c21e356d41de1763dcb";
                        //                            "payment_id" = "pay_GWBiAazUINHvim";
                        //                            "payment_method" = "";
                        //                            "pet_id" =         {
                        //                                "__v" = 0;
                        //                                "_id" = 6013f65f4ebff97aa7aa87c1;
                        //                                createdAt = "2021-01-29T11:49:51.117Z";
                        //                                "date_and_time" = "29-01-2021 05:19 PM";
                        //                                "default_status" = 1;
                        //                                "delete_status" = 0;
                        //                                "last_vaccination_date" = "";
                        //                                "pet_age" = 0;
                        //                                "pet_breed" = "Indian Pariah";
                        //                                "pet_color" = "";
                        //                                "pet_gender" = "";
                        //                                "pet_img" = "http://54.212.108.156:3000/api/uploads/6007f3d63168bf7a725435a02901171936";
                        //                                "pet_name" = qwerty;
                        //                                "pet_type" = Dog;
                        //                                "pet_weight" = 0;
                        //                                updatedAt = "2021-01-29T11:49:51.117Z";
                        //                                "user_id" = 6007f3d63168bf7a725435a0;
                        //                                vaccinated = 0;
                        //                            };
                        //                            "prescription_details" = "";
                        //                            "problem_info" = Details;
                        //                            "server_date_time" = "";
                        //                            "start_appointment_status" = "In-Progress";
                        //                            updatedAt = "2021-02-01T07:01:26.002Z";
                        //                            "user_feedback" = "";
                        //                            "user_id" =         {
                        //                                "__v" = 0;
                        //                                "_id" = 6007f3d63168bf7a725435a0;
                        //                                createdAt = "2021-01-20T09:11:50.901Z";
                        //                                "date_of_reg" = "20-01-2021 02:41 PM";
                        //                                "delete_status" = 0;
                        //                                "device_id" = "";
                        //                                "device_type" = "";
                        //                                "fb_token" = "c9lZr5q-GkNbjCdwqhj0EQ:APA91bHF4hZEC9MiDzfNVzNJC8tusRihPF9ro-uJkID98eDE8WF3kVNKD0duyp49gvEQn_VROQlSq2RPriaWYTQz8ULCAK__i3n8z7mkxudXiCQ3cFa9j4cUyak2sBaFgPwMfvCCB7ah";
                        //                                "first_name" = Sangeethaa;
                        //                                "last_name" = "pet owner IOS";
                        //                                "mobile_type" = IOS;
                        //                                otp = 123456;
                        //                                "profile_img" = "";
                        //                                updatedAt = "2021-02-01T13:07:16.614Z";
                        //                                "user_email" = "Sangeetha.arulsaravanan99@gmail.com";
                        //                                "user_email_verification" = 0;
                        //                                "user_phone" = 9003525711;
                        //                                "user_status" = complete;
                        //                                "user_type" = 1;
                        //                            };
                        //                            "user_rate" = 0;
                        //                            "vaccination_details" = "";
                        //                            "video_id" = "https://meet.jit.si/60178c21e356d41de1763dcb";
                        //                        }
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
              ["appointment_UID": Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].appointment_UID,
                "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                "doctor_id": Servicefile.shared.userid,
                "status":"Doctor Appointment Cancelled",
                "user_id": Servicefile.shared.Doc_dashlist[Servicefile.shared.appointmentindex].user_id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
            self.dismiss(animated: true, completion: nil)
       }
    
}
