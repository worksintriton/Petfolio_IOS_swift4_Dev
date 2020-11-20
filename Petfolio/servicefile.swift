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
    static let slider = baseurl+"api/demoscreen/mobile/getlist"
    static let usertype = baseurl + "/api/usertype/mobile/getlist"
    static let signup = baseurl + "/api/userdetails/create"
    static let resend = baseurl + "/api/userdetails/mobile/resendotp"
    static let login = baseurl + "/api/userdetails/mobile/login"
    static let petdashboard = baseurl + "/api/userdetails/petlove/mobile/dashboard"
    static let petdetails = baseurl + "/api/petdetails/mobile/dropdownslist"
    static let addlocation = baseurl + "/api/locationdetails/create"
    static let imageupload = baseurl + "/upload"
    // sprint 1
    
    var customview = UIView()
    var backview = UIView()
    var loadlabel = UILabel()
    
    var usertype = "Pet Lover"
    var user_type_value = 1
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
    // pet dashboard
    
    var lati = 0.0
    var long = 0.0
    var selectedaddress = ""
    var selectedCity = ""
    var selectedPincode = ""
    var selectedCountry = ""
    var selectedstate = ""
    var selectedState = ""
    var appgreen = "#009675"
    
    
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
        format.dateFormat = "dd/MM/yyyy hh:mm a"
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
