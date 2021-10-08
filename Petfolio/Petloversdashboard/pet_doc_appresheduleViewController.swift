//
//  pet_doc_appresheduleViewController.swift
//  Petfolio
//
//  Created by Admin on 07/10/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire

class pet_doc_appresheduleViewController: UIViewController , FSCalendarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var calender_cal: FSCalendar!
    @IBOutlet weak var coll_seltime: UICollectionView!
    @IBOutlet weak var View_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_movetoapp: UIView!
    @IBOutlet weak var label_pop_status: UILabel!
    
    var seldate = ""
    var listtime = [""]
    var bookstatus = [""]
    var seltime = [""]
    var selectedtime = ""
    
    @IBOutlet weak var view_continue: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        Servicefile.shared.pet_apoint_booking_time = ""
        Servicefile.shared.pet_apoint_booking_date = ""
        self.view_continue.isHidden = true
        self.listtime.removeAll()
        self.seltime.removeAll()
        self.view_continue.view_cornor()
        self.view_popup.view_cornor()
        self.view_movetoapp.view_cornor()
        self.View_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.seldate = Servicefile.shared.ddMMyyyystringformat(date: Date())
        self.coll_seltime.delegate = self
        self.coll_seltime.dataSource = self
        self.calender_cal.delegate = self
        self.callgetdatedetails()
        self.calender_cal.scope = .week
    }
    
    
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_afterappBooked(_ sender: Any) {
        let vc = UIStoryboard.Pet_applist_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listtime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_app_selectdoctordateCollectionViewCell
        cell.label_time.text = self.listtime[indexPath.row]
        if self.bookstatus[indexPath.row] == "1" {
            if self.seltime[indexPath.row] == "1"{
                cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.applightgreen)
            }else{
                cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.applightgreen)
                cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            }
        }else{
            cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
            cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.black)
        }
        cell.view_time.view_cornor()
        return cell
    }
    
    
    @IBAction func action_bookappoint(_ sender: Any) {
        if Servicefile.shared.pet_apoint_booking_time != "" {
            self.callsubmit()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.bookstatus[indexPath.row] == "1" {
            self.callcheckdatedetails(index: indexPath.row)
            
        }else{
            self.alert(Message: "The chosen slot is not available")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70 , height:  28)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let nextstrDate = formatter.string(from: date)
        let currstrdate = formatter.string(from: Date())
        let nextDate = formatter.date(from: nextstrDate)
        let currdate = formatter.date(from: currstrdate)
        if currdate! > nextDate! {
            return false
        } else {
            let selectdate = date
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy"
            let selddate =  Calendar.current.date(byAdding: .day, value: 0, to: selectdate)
            let nextDate = format.string(from: selddate!)
            print("selected date",nextDate)
            self.seldate = nextDate
            self.view_continue.isHidden = true
            Servicefile.shared.pet_apoint_booking_time = ""
            self.callgetdatedetails()
            return true
        }
        
    }
    
    
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        let strCurrentDate = dateFormatter2.string(from: yourDate!)
        return formatter.date(from: strCurrentDate)!
    }
    
    
    
    
    func callgetdatedetails(){
        let dateval = Calendar.current.date( byAdding: .hour, value: 1, to: Date())
        self.startAnimatingActivityIndicator()
        self.listtime.removeAll()
        self.seltime.removeAll()
        self.bookstatus.removeAll()
        self.coll_seltime.reloadData()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_avail_time, method: .post, parameters:
            ["user_id":Servicefile.shared.pet_apoint_doctor_id,
             "Date": self.seldate,
             "cur_date": Servicefile.shared.ddmmyyyystringformat(date: dateval!),
             "cur_time": Servicefile.shared.hhmmastringformat(date: dateval!),
             "current_time": Servicefile.shared.yyyyMMddHHmmssstringformat(date: dateval!)], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let datadic = Data[itm] as! NSDictionary
                            let timedic = datadic["Times"] as! NSArray
                            for timitm in 0..<timedic.count{
                                let timitmdic = timedic[timitm] as! NSDictionary
                                let timval = timitmdic["time"]  as? NSString ?? ""
                                let bookstatus = timitmdic["book_status"]  as? Bool ?? false
                                if bookstatus ==  true {
                                    self.bookstatus.append("1")
                                }else{
                                    self.bookstatus.append("0")
                                }
                                self.listtime.append(timval as String)
                                if timitm == 0 {
                                    self.seltime.append("0")
                                    self.selectedtime = ""
                                }else{
                                    self.seltime.append("0")
                                }
                            }
                        }
                        self.coll_seltime.reloadData()
                        self.stopAnimatingActivityIndicator()
                    }else{
                        self.stopAnimatingActivityIndicator()
                        print("status code service denied")
                        let Message = res["Message"] as? String ?? ""
                        self.alert(Message: Message)
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
    
    func callcheckdatedetails(index: Int){
        self.startAnimatingActivityIndicator()
        Servicefile.shared.pet_apoint_booking_time = ""
        self.view_continue.isHidden = true
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_dov_check_time, method: .post, parameters:
            ["doctor_id":Servicefile.shared.pet_apoint_doctor_id,
             "Booking_Date":self.seldate,"Booking_Time": self.listtime[index]], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success check status data",res)
                    let Code  = res["Code"] as! Int
                    Servicefile.shared.pet_apoint_booking_time = ""
                    if Code == 200 {
                        self.seltime.removeAll()
                        for _ in 0..<self.listtime.count{
                            self.seltime.append("0")
                        }
                        self.seltime.remove(at: index)
                        self.seltime.insert("1", at: index)
                        Servicefile.shared.pet_apoint_booking_date = self.seldate
                        Servicefile.shared.pet_apoint_booking_time = self.listtime[index]
                        self.view_continue.isHidden = false
                        self.coll_seltime.reloadData()
                        self.stopAnimatingActivityIndicator()
                    }else{
                        self.stopAnimatingActivityIndicator()
                        print("status code service denied")
                        let Message = res["Message"] as? String ?? ""
                        self.alert(Message: Message)
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
    
//    func callsubmitdatedetails(){
//        self.startAnimatingActivityIndicator()
//        self.view_continue.isHidden = true
//        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_app_reshedule, method: .post, parameters:
//             ["_id": Servicefile.shared.Doc_details_app_id,
//             "already_booked_date" : Servicefile.shared.doc_details_date,
//             "reschedule_date"  : Servicefile.shared.pet_apoint_booking_date + " " + Servicefile.shared.pet_apoint_booking_time,
//             "booking_date": Servicefile.shared.pet_apoint_booking_date,
//             "booking_time": Servicefile.shared.pet_apoint_booking_time], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
//                switch (response.result) {
//                case .success:
//                    let res = response.value as! NSDictionary
//                    print("success check status data",res)
//                    let Code  = res["Code"] as! Int
//                    Servicefile.shared.pet_apoint_booking_time = ""
//                    if Code == 200 {
//                        self.View_shadow.isHidden = false
//                        self.view_popup.isHidden = false
//                        self.stopAnimatingActivityIndicator()
//                    }else{
//                        self.stopAnimatingActivityIndicator()
//                        print("status code service denied")
//                        let Message = res["Message"] as? String ?? ""
//                        self.alert(Message: Message)
//                    }
//                    break
//                case .failure(let Error):
//                    self.stopAnimatingActivityIndicator()
//                    print("Can't Connect to Server / TimeOut",Error)
//                    break
//                }
//            }
//        }else{
//            self.stopAnimatingActivityIndicator()
//            self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
//        }
//    }
    
    func callsubmit(){
        
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_createappointm, method: .post, parameters:
            [ "doctor_id":  Servicefile.shared.pet_apoint_doctor_id,
              "booking_date": Servicefile.shared.pet_apoint_booking_date,
              "booking_time": Servicefile.shared.pet_apoint_booking_time,
              "booking_date_time" : Servicefile.shared.pet_apoint_booking_date_time,
              "communication_type": Servicefile.shared.pet_apoint_communication_type,
              "video_id":  Servicefile.shared.pet_apoint_video_id,
              "user_id": Servicefile.shared.userid,
              "pet_id" : Servicefile.shared.pet_apoint_pet_id,
              "current_img":Servicefile.shared.petlistimg,
              "problem_info": Servicefile.shared.pet_apoint_problem_info,
              "doc_attched": Servicefile.shared.pet_apoint_doc_attched ,
              "doc_feedback":  Servicefile.shared.pet_apoint_doc_feedback,
              "doc_rate": Servicefile.shared.pet_apoint_doc_rate,
              "user_feedback" : Servicefile.shared.pet_apoint_user_feedback,
              "user_rate" : Servicefile.shared.pet_apoint_user_rate,
              "display_date" : Servicefile.shared.pet_apoint_display_date,
              "server_date_time" : Servicefile.shared.pet_apoint_server_date_time ,
              "payment_id" : Servicefile.shared.pet_apoint_payment_id ,
              "payment_method" : Servicefile.shared.Doc_paymentmethod,
              "appointment_types" : Servicefile.shared.pet_apoint_appointment_types,
              "allergies" : Servicefile.shared.pet_apoint_allergies,
              "amount" : Servicefile.shared.Doc_totalprice,
              "mobile_type" : "IOS",
              "service_name" : "",
              "service_amount": "",
              "location_id": Servicefile.shared.pet_apoint_location_id,
              "visit_type": Servicefile.shared.pet_apoint_visit_type,
              "health_issue_title":Servicefile.shared.healthissue,
              "discount_price" : Servicefile.shared.Doc_coupondiscountprice,
              "original_price" : Servicefile.shared.Doc_originalprice,
              "total_price" : Servicefile.shared.Doc_totalprice,
              "coupon_status" : Servicefile.shared.Doc_couponstatus,
              "coupon_code" : Servicefile.shared.Doc_couponcode], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.appointtype = "New"
                        let Message = res["Message"] as? String ?? ""
                        self.label_pop_status.text = Message
                        self.View_shadow.isHidden = false
                        self.view_popup.isHidden = false
                        Servicefile.shared.Doc_paymentmethod = ""
                        Servicefile.shared.Doc_couponcode = ""
                        Servicefile.shared.Doc_couponstatus = ""
                        Servicefile.shared.Doc_coupondiscountprice = 0
                        Servicefile.shared.Doc_originalprice = 0
                        Servicefile.shared.Doc_totalprice = 0
                        self.stopAnimatingActivityIndicator()
                    }else{
                        self.stopAnimatingActivityIndicator()
                        print("status code service denied")
                        
                        let Message = res["Message"] as? String ?? ""
                        let alert = UIAlertController(title: Message, message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            self.callgetdatedetails()
                        }))
                        self.present(alert, animated: true, completion: nil)
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
    
}
