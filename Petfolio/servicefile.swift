//  servicefile.swift
//  Petfolio
//  Created by sriram ramachandran on 16/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.

import Foundation
import Alamofire
import UIKit
import NVActivityIndicatorView
import AAMaterialSpinner

class Servicefile {
    
    static let shared = Servicefile()
    // http://15.207.51.203:3000
    // sprint 1
    static let baseurl = "http://52.25.163.13:3000" // live
    //static let baseurl = "http://54.212.108.156:3000" // Dev
    static let tokenupdate = baseurl + "/api/userdetails/mobile/update/fb_token"
    static let slider = baseurl + "/api/demoscreen/mobile/getlist"
    static let usertype = baseurl + "/api/usertype/mobile/getlist"
    static let signup = baseurl + "/api/userdetails/create"
    static let petregister = baseurl + "/api/petdetails/mobile/create"
    static let resend = baseurl + "/api/userdetails/mobile/resendotp"
    static let verifyemail = baseurl + "/api/userdetails/send/emailotp"
    static let login = baseurl + "/api/userdetails/mobile/login"
    //static let petdashboard = baseurl + "/api/userdetails/petlove/mobile/dashboard"
    static let petdashboard = baseurl + "/api/userdetails/petlove/mobile/dashboard1"
    static let petdetails = baseurl + "/api/petdetails/mobile/dropdownslist"
    static let pet_sp_filter = baseurl + "/api/service_provider/filter_price_list"
    
    static let petdetailget = baseurl + "/api/pettype/mobile/getlist"
    static let addlocation = baseurl + "/api/locationdetails/create"
    static let imageupload = baseurl + "/upload"
    static let docbusscreate = baseurl + "/api/doctordetails/create"
    static let docbussedit = baseurl + "/api/doctordetails/edit"
    
    static let docdashboardnewapp = baseurl + "/api/appointments/mobile/doc_getlist/newapp"
    static let docdashboardcomapp = baseurl + "/api/appointments/mobile/doc_getlist/comapp"
    static let docdashboardmissapp = baseurl + "/api/appointments/mobile/doc_getlist/missapp"
    
    static let SPdashboardnewapp = baseurl + "/api/sp_appointments/mobile/sp_getlist/newapp"
    static let SPdashboardcomapp = baseurl + "/api/sp_appointments/mobile/sp_getlist/comapp"
    static let SPdashboardmissapp = baseurl + "/api/sp_appointments/mobile/sp_getlist/missapp"
    
    
    static let mycalender = baseurl + "/api/new_doctortime/fetch_dates"
    static let Sp_mycalender = baseurl + "/api/sp_available_time/fetch_dates"
    
    static let mycalender_hour = baseurl + "/api/new_doctortime/get_time_Details"
    static let Sp_mycalender_hour = baseurl + "/api/sp_available_time/get_time_Details"
    
    static let Docupdatemycalender_hour = baseurl + "/api/new_doctortime/update_doc_date"
    static let SPupdatemycalender_hour = baseurl + "/api/sp_available_time/update_doc_date"
    
    static let Doc_getholdiaylist = baseurl + "/api/holiday/getlist_id"
    static let Doc_deleteholiday = baseurl + "/api/holiday/delete"
    static let Doc_createholiday = baseurl + "/api/holiday/create"
    
    static let SP_getholdiaylist = baseurl + " /api/sp_holiday/getlist_id"
    static let SP_deleteholiday = baseurl + "/api/sp_holiday/delete"
    static let SP_createholiday = baseurl + "/api/sp_holiday/create"
    
    
    static let updateprofileimage = baseurl + "/api/userdetails/mobile/update/profile"
    static let updatestatus =  baseurl + "/api/userdetails/mobile/edit"
    static let doc_fetchdocdetails  =  baseurl + "/api/doctordetails/fetch_doctor_id"
    static let petbreedid =  baseurl + "/api/breedtype/mobile/getlist_id"
    static let pet_doc_avail_time = baseurl + "/api/new_doctortime/get_doc_new1"
    static let pet_sp_avail_time =  baseurl + "/api/sp_available_time/get_sp_new"
    static let pet_dov_check_time = baseurl + "/api/appointments/check"
    static let pet_doc_createappointm = baseurl + "/api/appointments/mobile/create"
    static let pet_sp_createappointm = baseurl + "/api/sp_appointments/mobile/create"
    
    // static let plove_getlist_newapp = baseurl + "/api/appointments/mobile/plove_getlist/newapp"
    // static let plove_getlist_missapp = baseurl + "/api/appointments/mobile/plove_getlist/missapp"
    // static let plove_getlist_comapp = baseurl + "/api/appointments/mobile/plove_getlist/comapp"
    
    static let plove_getlist_newapp = baseurl + "/api/appointments/mobile/plove_getlist/newapp1"
    static let plove_getlist_missapp = baseurl + "/api/appointments/mobile/plove_getlist/missapp1"
    static let plove_getlist_comapp = baseurl + "/api/appointments/mobile/plove_getlist/comapp1"
    static let Doc_complete_and_Missedapp = baseurl + "/api/appointments/edit"
    static let SP_complete_and_Missedapp = baseurl + "/api/sp_appointments/edit"
    static let Doc_Dashboard_checkstatus = baseurl + "/api/doctordetails/check_status"
    static let Doc_prescription_create = baseurl + "/api/prescription/create"
    static let view_prescription_create = baseurl + "/api/prescription/fetch_by_appointment_id"
    static let pet_getAddresslist = baseurl + "/api/locationdetails/mobile/getlist_id"
    static let pet_updateaddress =  baseurl + "/api/locationdetails/edit"
    static let pet_defaultaddress =  baseurl + "/api/locationdetails/default/edit"
    static let pet_deleteaddress =  baseurl + "/api/locationdetails/delete"
    static let pet_deletedetails =  baseurl + "/api/petdetails/delete"
    static let pet_updateimage =  baseurl + "/api/petdetails/edit"
    static let pet_search = baseurl + "/api/doctordetails/text_search"
    
    static let filter = baseurl + "/api/doctordetails/filter_doctor"
    static let SP_filter = baseurl + "/api/doctordetails/filter_doctor"
    static let sp_dropdown = baseurl + "/api/service_provider/sp_dropdown"
    static let sp_register = baseurl + "/api/service_provider/create"
    static let sp_regi_status = baseurl + "/api/service_provider/check_status"
    static let sp_dash_get = baseurl + "/api/service_provider/getlist_id"
    static let sp_Profile_edit = baseurl + "/api/service_provider/edit"
    static let pet_service_cat = baseurl + "/api/service_provider/mobile/service_cat"
    static let update_profile = baseurl + "/api/userdetails/mobile/update/profile"
    static let DOc_get_details = baseurl + "/api/doctordetails/fetch_doctor_user_id"
    static let pet_servicedetails = baseurl + "/api/service_provider/mobile/servicedetails"
    static let pet_sp_service_details = baseurl + "/api/service_provider/mobile/sp_fetch_by_id"
    static let pet_review_update = baseurl + "/api/appointments/reviews/update"
    
    static let doc_start_appointment = baseurl + "/api/appointments/edit"
    static let doc_cancel_appointment = baseurl + "/api/appointments/edit"
    
    static let Doc_fetch_appointment_id = baseurl + "/api/appointments/mobile/fetch_appointment_id"
    static let SP_fetch_appointment_id = baseurl + "/api/sp_appointments/mobile/fetch_appointment_id"
    
    
    
    // Signup page
    var email_status = false
    var signupemail = ""
    var email_status_label = "Verify email"
    // Signup page
    
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
    var userimage = ""
    var selectedindex = 0
    // userdetails
    var DemoData = [demodat]()
    var UtypeData = [Utype]()
    var utypesel = ["1"]
    var orgiutypesel = ["0"]
    
    // pet dashboard
    var petid = ""
    var petbanner = [Petdashbanner]()
    var petdoc = [Petdashdoc]()
    var petser = [Petdashservice]()
    var petprod = [Petdashproduct]()
    var Petpuppylove = [Petdashpuppylove]()
    var pet_petlist = [petlist]()
    var petuserlocaadd = [locationdetails]()
    var pet_SP_service_details = [SP_service_details]()
    // pet dashboard
    // pet service
    var pet_servicecat = [service_cat]()
    //pet service
    // seemore
    var moredocd = [moredoc]()
    var specd = [spec]()
    var sosnumbers = [sosnumber]()
    // see more
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
    var pet_apoint_servicename = ""
    var sear_Docapp_id = ""
    var pet_dash_lati = 0.0
    var pet_dash_long = 0.0
    var pet_dash_address = ""
    var pet_apoint_id = ""
    // pet appointment params
    var pet_index = 0
    var pet_status = ""
    var lati = 0.0
    var long = 0.0
    var selectedpickname = ""
    var selectedaddress = ""
    var selectedCity = ""
    var selectedPincode = ""
    var selectedCountry = ""
    var selectedstate = ""
    var selectedState = ""
    var appgreen = "#56B9A4"
    var applightgreen = "#F4FAF9"
    var lightgray = "#cfd0d1"
    var black = "#080808"
    
    var selrate = 0
    var selspec = ""
    var orgspecialza = [""]
    var isspecialza = [""]
    
    var edudicarray = [Any]()
    var expdicarray = [Any]()
    var specdicarray = [Any]()
    var pethandicarray = [Any]()
    var photodicarray = [Any]()
    var Doc_pres = [Any]()
    var govdicarray = [Any]()
    var certifdicarray = [Any]()
    var clinicdicarray = [Any]()
    var gallerydicarray = [Any]()
    var docMycalHourdicarray = [Any]()
    
    var checkemailvalid = "signup" // pet // doctor // sp / vendor
     var pet_selected_app_list = ""
    // Doctor
    var Doc_selected_app_list = ""
    var Doc_dashlist = [doc_Dash_petdetails]()
    // Doctor
    var SP_filter_price = [sppricelist]()
    var SP_Das_petdetails = [SP_Dash_petdetails]()
    var pet_applist_do_sp = [pet_applist_doc_sp]()
    // prescription
    var medi = ""
    var noofday = ""
    var consdays = ""
    var appointmentindex = 0
    // prescription
    // sp filter
    var Count_value_end = 0
    var Count_value_start = 0
    var distance = 0
    var review_count = 0
    // sp filter
    // sp drop down
    
    var speclist = [""]
    var servicelist = [""]
    var selectedservice = [""]
    var selectedamount = [""]
    var sertime = [""]
    var seramt = [""]
    var servicelistdicarray = [Any]()
    var speclistdicarray = [Any]()
    // sp drop down
    var communication_type = ""
    var consultancy_fees = ""
    var DOC_edudicarray = [Any]()
    var DOC_expdicarray = [Any]()
    var DOC_specdicarray = [Any]()
    var DOC_pethandicarray = [Any]()
    var DOC_clinicdicarray = [Any]()
    var DOC_certifdicarray = [Any]()
    var DOC_govdicarray = [Any]()
    var DOC_photodicarray = [Any]()
    // DOc update
    var Doc_id = ""
    var Doc_bus_certifdicarray = [Any]()
    var Doc_bus_profile = ""
    var Doc_bus_proof = ""
    var Doc_bus_service_galldicarray = [Any]()
    var Doc_bus_service_list = [Any]()
    var Doc_bus_spec_list = [Any]()
    var Doc_bus_user_email = ""
    var Doc_bus_user_name = ""
    var Doc_bus_user_phone = ""
    var Doc_bussiness_name = ""
    var Doc_date_and_time  = ""
    var Doc_delete_status = true
    var Doc_mobile_type = ""
    var Doc_profile_status = true;
    var Doc_profile_verification_status = "";
    var Doc_lat = 0.0
    var Doc_loc = ""
    var Doc_long = 0.0
    var Doc_user_id = ""
    // doc update
    // sp update
    var sp_id = ""
    var Sp_bus_certifdicarray = [Any]()
    var sp_bus_profile = ""
    var sp_bus_proof = ""
    var sp_bus_service_galldicarray = [Any]()
    var sp_bus_service_list = [Any]()
    var sp_bus_spec_list = [Any]()
    var sp_bus_user_email = ""
    var sp_bus_user_name = ""
    var sp_bus_user_phone = ""
    var sp_bussiness_name = ""
    var sp_date_and_time  = ""
    var sp_delete_status = true
    var sp_mobile_type = ""
    var sp_profile_status = true;
    var sp_profile_verification_status = "";
    var sp_distance = ""
    var Sp_comments = ""
    var Sp_rating = ""
    var sp_lat = 0.0
    var sp_loc = ""
    var sp_long = 0.0
    var sp_user_id = ""
    // sp update
    
    var service_id = ""
    var service_index = 0
    var service_sp_id = ""
    var ser_detail_id = ""
    var service_id_count = 0
    var service_id_image_path = ""
    var service_id_title = ""
    var service_id_amount = ""
    var service_id_time = ""
    var service_prov_buss_info = [Any]()
    
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
    
    func yyyyMMddHHmmssstringformat(date: Date) -> String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nextDate = format.string(from: date)
        return nextDate
    }
    
    func yyyyMMddHHmmssDateformat(date: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nextDate = format.date(from: date)
        return nextDate!
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
    
    func ddMMyyyyhhmmadateformat(date: String) -> Date{
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy hh:mm a"
        let nextDate = format.date(from: date)
        return nextDate!
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

//
//struct Petdashproduct{
//    var _id : String
//    var product_fav_status : Bool
//    var product_offer_status : Bool
//    var product_offer_value : Int
//    var product_prices : Int
//    var product_rate : String
//    var product_title : String
//    var products_img : String
//    var review_count : Int
//    init(UID : String, product_fav_status: Bool, product_offer_status: Bool, product_offer_value: Int, product_prices: Int, product_rate: String, product_title: String, products_img: String, review_count: Int) {
//        self._id = UID
//        self.product_fav_status = product_fav_status
//        self.product_offer_status = product_offer_status
//        self.product_offer_value = product_offer_value
//        self.product_prices = product_prices
//        self.product_rate = product_rate
//        self.product_title = product_title
//        self.products_img = products_img
//        self.review_count = review_count
//
//    }
//}

struct Petdashproduct{
    var _id : String
    var delete_status : Bool
    var show_status : Bool
    var img_index : Int
    var product_title : String
    var products_img : String
    
    init(I_id : String,
         Idelete_status : Bool,
         Ishow_status : Bool,
         Iimg_index : Int,
         Iproduct_title : String,
         Iproducts_img : String) {
        self._id = I_id
        self.delete_status = Idelete_status
        self.show_status = Ishow_status
        self.img_index = Iimg_index
        self.products_img = Iproducts_img
        self.product_title  = Iproduct_title
    }
}

struct Petdashpuppylove{
    var _id : String
    var delete_status : Bool
    var show_status : Bool
    var img_index : Int
    var product_title : String
    var products_img : String
    
    init(I_id : String,
         Idelete_status : Bool,
         Ishow_status : Bool,
         Iimg_index : Int,
         Iproduct_title : String,
         Iproducts_img : String) {
        self._id = I_id
        self.delete_status = Idelete_status
        self.show_status = Ishow_status
        self.img_index = Iimg_index
        self.products_img = Iproducts_img
        self.product_title  = Iproduct_title
    }
}



struct Petdashdoc{
    var _id : String
    var doctor_img : String
    var doctor_name : String
    var review_count : Int
    var star_count : Int
    var spec : String
    var distance : String
    init(UID : String, doctor_img: String, doctor_name: String, review_count: Int, star_count: Int, ispec : String, idistance : String) {
        self._id = UID
        self.doctor_img = doctor_img
        self.doctor_name = doctor_name
        self.review_count = review_count
        self.star_count = star_count
        self.spec = ispec
        self.distance =  idistance
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
    var appoint_patient_st : String
    var doc_attched : String
    var pet_id : String
    var pet_breed : String
    var pet_img : String
    var pet_name : String
    var user_id : String
    var pet_type : String
    var book_date_time : String
    var user_rate : String
    var user_feedback : String
    var Booked_at : String
    var completed_at : String
    var missed_at : String
    var commtype : String
    init(in_Appid : String, In_allergies : String, In_amount : String, In_appointment_types : String,
         In_doc_attched : String, In_pet_id : String, In_pet_breed : String, In_pet_img : String,
         In_pet_name : String, In_user_id : String, In_pet_type: String, In_book_date_time: String, In_userrate: String, In_userfeedback: String, In_Booked_at : String, In_completed_at : String, In_missed_at : String, In_appoint_patient_st : String, In_commtype : String) {
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
        self.user_rate = In_userrate
        self.user_feedback = In_userfeedback
        self.Booked_at = In_Booked_at
        self.completed_at = In_completed_at
        self.missed_at = In_missed_at
        self.appoint_patient_st = In_appoint_patient_st
        self.commtype = In_commtype
    }
}

struct SP_Dash_petdetails{
    var Appid : String
    var amount : String
    var sername: String
    var appoinment_status : String
    var pet_id : String
    var pet_breed : String
    var pet_img : String
    var pet_name : String
    var user_id : String
    var pet_type : String
    var book_date_time : String
    var user_rate : String
    var user_feedback : String
    init(in_Appid : String, In_amount : String, In_appointment_types : String,
         In_pet_id : String, In_pet_breed : String, In_pet_img : String,
         In_pet_name : String, In_user_id : String, In_pet_type: String, In_book_date_time: String, In_userrate: String, In_userfeedback: String, In_servicename: String) {
        self.Appid = in_Appid
        self.amount = In_amount
        self.appoinment_status = In_appointment_types
        self.pet_id = In_pet_id
        self.pet_breed = In_pet_breed
        self.pet_img = In_pet_img
        self.pet_name = In_pet_name
        self.user_id = In_user_id
        self.pet_type = In_pet_type
        self.book_date_time = In_book_date_time
        self.user_rate = In_userrate
        self.user_feedback = In_userfeedback
        self.sername = In_servicename
    }
}

struct locationdetails{
    var _id : String
    var date_and_time : String
    var default_status : Bool
    var location_address : String
    var location_city : String
    var location_country : String
    var location_lat : String
    var location_long : String
    var location_nickname : String
    var location_pin : String
    var location_state : String
    var location_title : String
    var user_id : String
    init(In_id : String
        , In_date_and_time : String
        , In_default_status : Bool
        , In_location_address : String
        , In_location_city : String
        , In_location_country : String
        , In_location_lat : String
        , In_location_long : String
        , In_location_nickname : String
        , In_location_pin : String
        , In_location_state : String
        , In_location_title : String
        , In_user_id : String) {
        self._id = In_id
        self.date_and_time = In_date_and_time
        self.default_status = In_default_status
        self.location_address = In_location_address
        self.location_city = In_location_city
        self.location_country = In_location_country
        self.location_lat = In_location_lat
        self.location_long = In_location_long
        self.location_nickname = In_location_nickname
        self.location_pin = In_location_pin
        self.location_state = In_location_state
        self.location_title = In_location_title
        self.user_id = In_user_id
    }
    
}


struct moredoc{
    var _id : String
    var clinic_loc : String
    var clinic_name : String
    var communication_type : String
    var distance : String
    var doctor_img : String
    var doctor_name : String
    var dr_title : String
    var review_count : String
    var star_count : String
    var user_id : String
    var specialization : [spec]
    var amount : String
    init(I_id : String
        , I_clinic_loc : String
        , I_clinic_name : String
        , I_communication_type : String
        , I_distance : String
        , I_doctor_img : String
        , I_doctor_name : String
        , I_dr_title : String
        , I_review_count : String
        , I_star_count : String
        , I_user_id : String
        , I_specialization : [spec], in_amount: String) {
        self._id = I_id
        self.clinic_loc = I_clinic_loc
        self.clinic_name = I_clinic_name
        self.communication_type = I_communication_type
        self.distance = I_distance
        self.doctor_img = I_doctor_img
        self.doctor_name = I_doctor_name
        self.dr_title = I_dr_title
        self.review_count = I_review_count
        self.star_count = I_star_count
        self.user_id = I_user_id
        self.specialization = I_specialization
        self.amount = in_amount
    }
}

struct spec {
    var sepcial : String
    init(i_spec: String) {
        self.sepcial = i_spec
    }
}

struct sosnumber {
    var number : String
    init(i_number: String) {
        self.number = i_number
    }
}

struct sppricelist {
    var Display_text : String
    var Count_value_start : Int
    var Count_value_end : Int
    init(IDisplay_text : String, ICount_value_start : Int, ICount_value_end : Int) {
        self.Display_text = IDisplay_text
        self.Count_value_start = ICount_value_start
        self.Count_value_end = ICount_value_end
    }
}

struct service_cat {
    var _id : String
    var image : String
    var sub_title : String
    var title : String
    init( I_id : String, Iimage : String, Isub_title : String, Ititle : String) {
        self._id = I_id
        self.image = Iimage
        self.sub_title = Isub_title
        self.title = Ititle
    }
}

struct SP_service_details{
    var _id : String
    var comments_count : Int
    var distance : Double
    var image : String
    var rating_count :  Int
    var service_offer : Int
    var service_place : String
    var service_price : Int
    var service_provider_name : String
    init( I_id : String, Icomments_count : Int, Idistance : Double, Iimage : String,
          Irating_count :  Int, Iservice_offer : Int, Iservice_place : String, Iservice_price : Int,
          Iservice_provider_name : String) {
        self._id = I_id
        self.comments_count = Icomments_count
        self.distance = Idistance
        self.image = Iimage
        self.rating_count = Irating_count
        self.service_offer = Iservice_offer
        self.service_place = Iservice_place
        self.service_price = Iservice_price
        self.service_provider_name = Iservice_provider_name
    }
}

struct  pet_applist_doc_sp {
    var Booked_at : String
    var Booking_Id : String
    var Service_name : String
    var _id : String
    var appointment_for : String
    var appointment_time : String
    var appointment_type : String
    var communication_type : String
    var clinic_name : String
    var completed_at : String
    var cost : String
    var createdAt : String
    var missed_at : String
    var pet_name : String
    var pet_type : String
    var photo : String
    var service_cost : String
    var service_provider_name : String
    var status : String
    var type : String
    var updatedAt : String
    var userrate: String
    var userfeed : String
    var start_appointment_status : String
    var appoint_patient_st : String
    init(IN_Booked_at : String, IN_Booking_Id : String, IN_Service_name : String, IN__id : String, IN_appointment_for : String
        , IN_appointment_time : String, IN_appointment_type : String, IN_clinic_name : String, IN_completed_at : String
        , IN_cost : String, IN_createdAt : String, IN_missed_at : String, IN_pet_name : String, IN_pet_type : String
        , IN_photo : String, IN_service_cost : String, IN_service_provider_name : String, IN_status : String
        , IN_type : String, IN_updatedAt : String,In_userrate: String, In_userfeed: String, In_communication_type: String, In_start_appointment_status : String, In_appoint_patient_st : String) {
        self.Booked_at = IN_Booked_at
        self.Booking_Id = IN_Booking_Id
        self.Service_name = IN_Service_name
        self._id = IN__id
        self.appointment_for = IN_appointment_for
        self.appointment_time = IN_appointment_time
        self.appointment_type = IN_appointment_type
        self.communication_type = In_communication_type
        self.clinic_name = IN_clinic_name
        self.completed_at = IN_completed_at
        self.cost = IN_cost
        self.createdAt = IN_createdAt
        self.missed_at = IN_missed_at
        self.pet_name = IN_pet_name
        self.pet_type = IN_pet_type
        self.photo = IN_photo
        self.service_cost = IN_service_cost
        self.service_provider_name = IN_service_provider_name
        self.status = IN_status
        self.type = IN_type
        self.updatedAt = IN_updatedAt
        self.userrate = In_userrate
        self.userfeed = In_userfeed
        self.start_appointment_status = In_start_appointment_status
        self.appoint_patient_st = In_appoint_patient_st
    }
}



