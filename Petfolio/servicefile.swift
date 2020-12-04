//
//  servicefile.swift
//  Petfolio
//
//  Created by sriram ramachandran on 16/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import NVActivityIndicatorView
import AAMaterialSpinner

class Servicefile {
    
    static let shared = Servicefile()
    // http://15.207.51.203:3000
    // sprint 1
    static let baseurl = "http://52.25.163.13:3000"
    static let tokenupdate = baseurl + "/api/userdetails/mobile/update/fb_token"
    static let slider = baseurl + "api/demoscreen/mobile/getlist"
    static let usertype = baseurl + "/api/usertype/mobile/getlist"
    static let signup = baseurl + "/api/userdetails/create"
    static let petregister = baseurl + "/api/petdetails/mobile/create"
    static let resend = baseurl + "/api/userdetails/mobile/resendotp"
    static let login = baseurl + "/api/userdetails/mobile/login"
    static let petdashboard = baseurl + "/api/userdetails/petlove/mobile/dashboard"
    static let petdetails = baseurl + "/api/petdetails/mobile/dropdownslist"
    static let petdetailget = baseurl + "/api/pettype/mobile/getlist"
    static let addlocation = baseurl + "/api/locationdetails/create"
    static let imageupload = baseurl + "/upload"
    static let docbusscreate = baseurl + "/api/doctordetails/create"
    static let docdashboardnewapp = baseurl + "/api/appointments/mobile/doc_getlist/newapp"
    static let docdashboardcomapp = baseurl + "/api/appointments/mobile/doc_getlist/comapp"
    static let docdashboardmissapp = baseurl + "/api/appointments/mobile/doc_getlist/missapp"
    static let mycalender = baseurl + "/api/new_doctortime/fetch_dates"
    static let mycalender_hour = baseurl + "/api/new_doctortime/get_time_Details"
    static let Docupdatemycalender_hour = baseurl + "/api/new_doctortime/update_doc_date"
    static let Doc_getholdiaylist = baseurl + "/api/holiday/getlist_id"
    static let Doc_deleteholiday = baseurl + "/api/holiday/delete"
    static let Doc_createholiday = baseurl + "/api/holiday/create"
    static let updatestatus =  baseurl + "/api/userdetails/mobile/edit"
    static let doc_fetchdocdetails  =  baseurl + "/api/doctordetails/fetch_doctor_id"
    static let petbreedid =  baseurl + "/api/breedtype/mobile/getlist_id"
    static let pet_doc_avail_time = baseurl + "/api/new_doctortime/get_doc_new"
    static let pet_dov_check_time = baseurl + "/api/appointments/check"
    static let pet_doc_createappointm = baseurl + "/api/appointments/mobile/create"
    static let plove_getlist_newapp = baseurl + "/api/appointments/mobile/plove_getlist/newapp"
    static let plove_getlist_missapp = baseurl + "/api/appointments/mobile/plove_getlist/missapp"
    static let plove_getlist_comapp = baseurl + "/api/appointments/mobile/plove_getlist/comapp"
    static let Doc_complete_and_Missedapp = baseurl + "/api/appointments/edit"
    static let Doc_Dashboard_checkstatus = baseurl + "/api/doctordetails/check_status"
    static let Doc_prescription_create = baseurl + "/api/prescription/create"
    
    // sprint 1
    var Doc_mycalender_selecteddates = [""]
    var Doc_mycalender_selectedhours = [""]
    var customview = UIView()
    var backview = UIView()
    var loadlabel = UILabel()
    var sampleimag = "http://mysalveo.com/api/uploads/images.jpeg"
    var FCMtoken = ""
    var usertype = "Pet Lover"
    var user_type_value = 1
    var usertypetitle = "Pet Lover"
    // Design value
    var viewcornorradius = 15.0
    var viewLabelcornorraius = 10.0
    // Desing Value
    var locaaccess = ""
   // userdetails
    var first_name = ""
    var last_name = ""
    var user_email = ""
    var user_phone = ""
    var date_of_reg = ""
    var user_type = ""
    var otp = ""
    var userid = ""
    var selectedindex = 0
    // userdetails
    var DemoData = [demodat]()
    var UtypeData = [Utype]()
    var utypesel = ["1"]
    var orgiutypesel = ["0"]
    
    // pet dashboard
    var petbanner = [Petdashbanner]()
    var petdoc = [Petdashdoc]()
    var petser = [Petdashservice]()
    var petprod = [Petdashproduct]()
    var pet_petlist = [petlist]()
    // pet dashboard
    
    // pet appointment params
    
            var pet_apoint_doctor_id = ""
            var pet_apoint_booking_date = ""
            var pet_apoint_booking_time = ""
            var pet_apoint_booking_date_time = ""
            var pet_apoint_communication_type = ""
            var pet_apoint_video_id = ""
            var pet_apoint_user_id = ""
            var pet_apoint_pet_id = ""
            var pet_apoint_problem_info = ""
            var pet_apoint_doc_attched = [Any]()
            var Pet_Appointment_petimg = [Any]()
            var pet_apoint_doc_feedback = ""
            var pet_apoint_doc_rate = ""
            var pet_apoint_user_feedback = ""
            var pet_apoint_user_rate = ""
            var pet_apoint_display_date = ""
            var pet_apoint_server_date_time = ""
            var pet_apoint_payment_id = ""
            var pet_apoint_payment_method = ""
            var pet_apoint_appointment_types = ""
            var pet_apoint_allergies = ""
            var pet_apoint_amount = ""
    
    // pet appointment params
    
    var lati = 0.0
    var long = 0.0
    var selectedaddress = ""
    var selectedCity = ""
    var selectedPincode = ""
    var selectedCountry = ""
    var selectedstate = ""
    var selectedState = ""
    var appgreen = "#009675"
    var applightgreen = "#F4FAF9"
    var edudicarray = [Any]()
    var expdicarray = [Any]()
    var specdicarray = [Any]()
    var pethandicarray = [Any]()
     var photodicarray = [Any]()
    var Doc_pres = [Any]()
     var govdicarray = [Any]()
     var certifdicarray = [Any]()
    var clinicdicarray = [Any]()
     var docMycalHourdicarray = [Any]()
   
    // Doctor
    var Doc_dashlist = [doc_Dash_petdetails]()
    // Doctor
    // prescription
    var medi = ""
    var noofday = ""
    var consdays = ""
    var appointmentindex = 0
    // prescription
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func updateUserInterface()-> Bool {
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
        return  Network.reachability.isReachable
    }
    
    func StrToURL(url: String)-> URL{
        let str = url
        let urldat = str
        let data = urldat.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: data)
        return url!
    }
    
    func roundingtime(date: Date) -> Date{
        let calendar = Calendar.current
        let rightNow = date
        let interval = 5
        let nextDiff = interval - calendar.component(.minute, from: rightNow) % interval
        let nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: rightNow) ?? date
        return nextDate
    }
    
    func ddmmyyyyHHmmssstringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy hh:mm a"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func DDMMMstringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd MMM"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func hhmmastringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func yyyyMMddstringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func ddmmyyyystringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func DDMMMDateformat(date: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "dd MMM"
        let nextDate = format.date(from: date)
        return nextDate!
    }
    
    func hhmmaDateformat(date: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        let nextDate = format.date(from: date)
        return nextDate!
    }
    
    func yyyyMMddDateformat(date: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let nextDate = format.date(from: date)
        return nextDate!
    }
   
    
    func yyyyMMddhhmmaDateformat(date: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm a"
        let nextDate = format.date(from: date)
        return nextDate!
    }
    
    func yyyyMMddhhmmastringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm a"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func ddMMyyyystringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func ddMMyyyyhhmmastringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy hh:mm a"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func uploadddmmhhmmastringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "ddMMHHmmss"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func ddmmhhmmastringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "dd MMM hh:mm a"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func ddmmhhmmaDateformat(date: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "dd MMM hh:mm a"
        let nextDate = format.date(from: date)
        return nextDate!
    }
    
    func incrhourwithmins(date: Date)-> Date{
        let incdate = date.addingTimeInterval(60 * 60)
        return incdate
    }
    
    func checkdatediffer(ddMMM: String, hhmmain: String, ddMMMout: String,hhmmaout: String)->Int{
        let startdatetime = ddMMM + " " + hhmmain
        let enddatetime = ddMMMout + " " + hhmmaout
        let start = Servicefile.shared.ddmmhhmmaDateformat(date: startdatetime)
        let end = Servicefile.shared.ddmmhhmmaDateformat(date: enddatetime)
        let differ = end.timeIntervalSince(start)
        let ti = NSInteger(differ)
        let day = (ti / 86400)
        return day
    }
    func checkhourdiffer(ddMMM: String, hhmmain: String, ddMMMout: String,hhmmaout: String)->Int{
        let startdatetime = ddMMM + " " + hhmmain
        let enddatetime = ddMMMout + " " + hhmmaout
        let start = Servicefile.shared.ddmmhhmmaDateformat(date: startdatetime)
        let end = Servicefile.shared.ddmmhhmmaDateformat(date: enddatetime)
        let differ = end.timeIntervalSince(start)
        let ti = NSInteger(differ)
        let hours = ti / 3600
        //            let minutes = (ti - hours * 3600) / 60
        return hours
    }
    
    func checkcurrhourdiffer(date : Date)->Int{
        let start = Date()
        let end = date
        let differ = end.timeIntervalSince(start)
        let ti = NSInteger(differ)
        let hours = ti / 3600
        let minutes = (ti - hours * 3600) / 60
        return minutes
    }
    
    func issamedate(ddMMM: String, hhmmain: String, ddMMMout: String,hhmmaout: String)->Bool{
        let startdatetime = ddMMM + " " + hhmmain
        let enddatetime = ddMMMout + " " + hhmmaout
        let start = Servicefile.shared.ddmmhhmmaDateformat(date: startdatetime)
        let end = Servicefile.shared.ddmmhhmmaDateformat(date: enddatetime)
        if start == end{
            return true
        }else{
            return false
        }
        
    }
    
}

struct demodat{
    var img_path : String
    init(IV_Model_Image : String) {
        self.img_path = IV_Model_Image
    }
}

struct Utype{
    var _id : String
    var user_type_img : String
    var user_type_title : String
    var user_type_value : Int
    init(UID : String, Utypeimg: String, Utypetitle: String, utypevalue: Int) {
        self._id = UID
        self.user_type_img = Utypeimg
        self.user_type_title = Utypetitle
        self.user_type_value = utypevalue
    }
}

struct Petdashservice{
    var _id : String
    var background_color : String
    var service_icon : String
    var service_title : String
    init(UID : String, background_color: String, service_icon: String, service_title: String) {
        self._id = UID
        self.background_color = background_color
        self.service_icon = service_icon
        self.service_title = service_title
    }
}


struct Petdashproduct{
    var _id : String
    var product_fav_status : Bool
    var product_offer_status : Bool
    var product_offer_value : Int
    var product_prices : Int
    var product_rate : String
    var product_title : String
    var products_img : String
    var review_count : Int
    init(UID : String, product_fav_status: Bool, product_offer_status: Bool, product_offer_value: Int, product_prices: Int, product_rate: String, product_title: String, products_img: String, review_count: Int) {
        self._id = UID
        self.product_fav_status = product_fav_status
        self.product_offer_status = product_offer_status
        self.product_offer_value = product_offer_value
        self.product_prices = product_prices
        self.product_rate = product_rate
        self.product_title = product_title
        self.products_img = products_img
        self.review_count = review_count
        
    }
}


struct Petdashdoc{
    var _id : String
    var doctor_img : String
    var doctor_name : String
    var review_count : Int
     var star_count : Int
    init(UID : String, doctor_img: String, doctor_name: String, review_count: Int, star_count: Int) {
        self._id = UID
        self.doctor_img = doctor_img
        self.doctor_name = doctor_name
        self.review_count = review_count
        self.star_count = star_count
    }
}

struct Petdashbanner{
    var _id : String
    var img_path : String
    var title : String
    init(UID : String, img_path: String, title: String) {
        self._id = UID
        self.img_path = img_path
        self.title = title
    }
    
   
}
struct educat{
   var education : String
   var year : String
   init(ieducation : String, iyear: String) {
       self.education = ieducation
       self.year = iyear
   }
}

struct petlist{
   var default_status : Bool
   var last_vaccination_date : String
    var pet_age : Int
    var pet_breed : String
    var pet_color : String
    var pet_gender : String
    var pet_img : String
    var pet_name : String
    var pet_type : String
    var pet_weight : Int
    var user_id : String
    var vaccinated : Bool
    var id : String
   init(in_default_status : Bool, in_last_vaccination_date : String, in_pet_age : Int,
    in_pet_breed : String, in_pet_color : String, in_pet_gender : String, in_pet_img : String,
    in_pet_name : String, in_pet_type : String, in_pet_weight : Int, in_user_id : String, in_vaccinated : Bool, in_id : String) {
    self.default_status = in_default_status
    self.last_vaccination_date = in_last_vaccination_date
    self.pet_age = in_pet_age
    self.pet_breed = in_pet_breed
    self.pet_color = in_pet_color
    self.pet_gender = in_pet_gender
    self.pet_img = in_pet_img
    self.pet_name = in_pet_name
    self.pet_type = in_pet_type
    self.pet_weight = in_pet_weight
    self.user_id = in_user_id
    self.vaccinated = in_vaccinated
    self.id = in_id
   }
}

struct doc_Dash_petdetails{
    var Appid : String
    var allergies : String
    var amount : String
    var appoinment_status : String
    var doc_attched : String
    var pet_id : String
    var pet_breed : String
    var pet_img : String
    var pet_name : String
    var user_id : String
    var pet_type : String
    var book_date_time : String
   init(in_Appid : String, In_allergies : String, In_amount : String, In_appointment_types : String,
   In_doc_attched : String, In_pet_id : String, In_pet_breed : String, In_pet_img : String,
   In_pet_name : String, In_user_id : String, In_pet_type: String, In_book_date_time: String) {
    self.Appid = in_Appid
    self.allergies = In_allergies
    self.amount = In_amount
    self.appoinment_status = In_appointment_types
    self.doc_attched = In_doc_attched
    self.pet_id = In_pet_id
    self.pet_breed = In_pet_breed
    self.pet_img = In_pet_img
    self.pet_name = In_pet_name
    self.user_id = In_user_id
    self.pet_type = In_pet_type
    self.book_date_time = In_book_date_time
   }
}

  
