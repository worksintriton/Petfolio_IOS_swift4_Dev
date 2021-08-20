//
//  customfile.swift
//  Petfolio
//
//  Created by Admin on 29/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
   
    
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func petDocappStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "petdocapp", bundle: nil)
    }
    
    static func petspappStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "petspapp", bundle: nil)
    }
    
    static func vendorStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "vendor", bundle: nil)
    }
    
    static func serviceStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "service", bundle: nil)
    }
    
    // login process
    
    static func LoginViewController() -> LoginViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    static func petManageaddressViewController() -> petManageaddressViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petManageaddressViewController") as! petManageaddressViewController
    }
    
    
    
    static func SignOTPViewController() -> SignOTPViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "SignOTPViewController") as! SignOTPViewController
    }
    
    
    static func doc_myorder_detailspage_ViewController() -> doc_myorder_detailspage_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_myorder_detailspage_ViewController") as! doc_myorder_detailspage_ViewController
    }
    
    
    
    
    
    
    static func sp_locationsetting_ViewController() -> sp_locationsetting_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_locationsetting_ViewController") as! sp_locationsetting_ViewController
    }
    
    
    
    static func emailsignupViewController() -> emailsignupViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "emailsignupViewController") as! emailsignupViewController
    }
    
    
    
    static func loginotpViewController() -> loginotpViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "loginotpViewController") as! loginotpViewController
    }
    
    
    
    static func petloverEditandAddViewController() -> petloverEditandAddViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petloverEditandAddViewController") as! petloverEditandAddViewController
    }
    
    static func pet_vendor_locationpickup_ViewController() -> pet_vendor_locationpickup_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_locationpickup_ViewController") as! pet_vendor_locationpickup_ViewController
    }
    
    
    
    static func pet_other_information_ViewController() -> pet_other_information_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_other_information_ViewController") as! pet_other_information_ViewController
    }
    
    static func sp_productdeals_ViewController() -> sp_productdeals_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_productdeals_ViewController") as! sp_productdeals_ViewController
    }
    
    
    static func sp_shop_shippingaddressViewController() -> sp_shop_shippingaddressViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_shop_shippingaddressViewController") as! sp_shop_shippingaddressViewController
    }
    
    
    static func sp_savelocationViewController() -> sp_savelocationViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_savelocationViewController") as! sp_savelocationViewController
    }
    
    
    
    static func pet_medical_history_ViewController() -> pet_medical_history_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_medical_history_ViewController") as! pet_medical_history_ViewController
    }
    
    static func regdocViewController() -> regdocViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "regdocViewController") as! regdocViewController
    }
    
    static func REGPetLoverViewController() -> REGPetLoverViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "REGPetLoverViewController") as! REGPetLoverViewController
    }
    
    static func sp_todaydeals_ViewController() -> sp_todaydeals_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_todaydeals_ViewController") as! sp_todaydeals_ViewController
    }
    
    
    
    
    static func sp_productdetailspage_ViewController() -> sp_productdetailspage_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_productdetailspage_ViewController") as! sp_productdetailspage_ViewController
    }
    
    
    
    
    static func sp_vendorcartpage_ViewController() -> sp_vendorcartpage_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_vendorcartpage_ViewController") as! sp_vendorcartpage_ViewController
    }
    
    
    
    
    static func sp_manageaddressViewController() -> sp_manageaddressViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_manageaddressViewController") as! sp_manageaddressViewController
    }
    
  
    
    
    static func pet_notification_ViewController() -> pet_notification_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
    }
    
    static func sp_shop_search_ViewController() -> sp_shop_search_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_shop_search_ViewController") as! sp_shop_search_ViewController
    }
    
    
    
    static func pet_edit_otherinfo_ViewController() -> pet_edit_otherinfo_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_edit_otherinfo_ViewController") as! pet_edit_otherinfo_ViewController
    }
    
    
    static func myaddress_create_address_ViewController() -> myaddress_create_address_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "myaddress_create_address_ViewController") as! myaddress_create_address_ViewController
    }
    
    
    static func peteditandadduploadimgViewController() -> peteditandadduploadimgViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "peteditandadduploadimgViewController") as! peteditandadduploadimgViewController
    }
    
    
    
    
    static func getpetViewController() -> getpetViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "getpetViewController") as! getpetViewController
    }
    
    
    
    
    static func savelocationViewController() -> savelocationViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "savelocationViewController") as! savelocationViewController
    }
    
    
    
    static func SOSViewController() -> SOSViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
    }
    
    static func profile_edit_ViewController() -> profile_edit_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "profile_edit_ViewController") as! profile_edit_ViewController
    }
    
    static func pet_vendor_shipingaddlocationViewController() -> pet_vendor_shipingaddlocationViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_shipingaddlocationViewController") as! pet_vendor_shipingaddlocationViewController
    }
    
    
   
    
    
    
    static func petprofileViewController() -> petprofileViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
    }
    
    static func vendorcartpageViewController() -> vendorcartpageViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendorcartpageViewController") as! vendorcartpageViewController
    }
    
    static func Pet_sidemenu_ViewController() -> Pet_sidemenu_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Pet_sidemenu_ViewController") as! Pet_sidemenu_ViewController
    }
    
    static func pet_app_select_address_ViewController() -> pet_app_select_address_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_app_select_address_ViewController") as! pet_app_select_address_ViewController
    }
    
    
    
    static func locationsettingViewController() -> locationsettingViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "locationsettingViewController") as! locationsettingViewController
    }
    
    
    
    static func pet_vendor_orderdetails_ViewController() -> pet_vendor_orderdetails_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_orderdetails_ViewController") as! pet_vendor_orderdetails_ViewController
    }
    
    
    
    static func ProductdealsViewController() -> ProductdealsViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "ProductdealsViewController") as! ProductdealsViewController
    }
    
    static func orderlist_cancel_ViewController() -> orderlist_cancel_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "orderlist_cancel_ViewController") as! orderlist_cancel_ViewController
    }
    
    static func pet_vendor_shippingaddressconfrimViewController() -> pet_vendor_shippingaddressconfrimViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_shippingaddressconfrimViewController") as! pet_vendor_shippingaddressconfrimViewController
    }
    
    
    
    static func ProfileimageuploadViewController() -> ProfileimageuploadViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "ProfileimageuploadViewController") as! ProfileimageuploadViewController
    }
    
    
    static func productdetailsViewController() -> productdetailsViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "productdetailsViewController") as! productdetailsViewController
    }
    
    
    static func PetfilterpageViewController() -> PetfilterpageViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "PetfilterpageViewController") as! PetfilterpageViewController
    }
    
    
    
    static func petimageUploadViewController() -> petimageUploadViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petimageUploadViewController") as! petimageUploadViewController
    }
    
    
    
    
    static func petlocationsettingViewController() -> petlocationsettingViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petlocationsettingViewController") as! petlocationsettingViewController
    }
    
    
    
    static func petsavelocationViewController() -> petsavelocationViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petsavelocationViewController") as! petsavelocationViewController
    }
    
    
    
    static func Petlover_myorder_ViewController() -> Petlover_myorder_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Petlover_myorder_ViewController") as! Petlover_myorder_ViewController
    }
    
    
    static func pet_sidemenu_favlist_ViewController() -> pet_sidemenu_favlist_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_sidemenu_favlist_ViewController") as! pet_sidemenu_favlist_ViewController
    }
    
    
    
    
    
    static func pet_vendor_trackorderViewController() -> pet_vendor_trackorderViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_trackorderViewController") as! pet_vendor_trackorderViewController
    }
    
    
    
    
    static func pet_vendor_editshiplistViewController() -> pet_vendor_editshiplistViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_editshiplistViewController") as! pet_vendor_editshiplistViewController
    }
    
    
    
    static func todaysdealseemoreViewController() -> todaysdealseemoreViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "todaysdealseemoreViewController") as! todaysdealseemoreViewController
    }
    
    
    
    static func pet_vendor_total_sortbyViewController() -> pet_vendor_total_sortbyViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_total_sortbyViewController") as! pet_vendor_total_sortbyViewController
    }
    
    
    static func pet_vendor_shop_search_ViewController() -> pet_vendor_shop_search_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_vendor_shop_search_ViewController") as! pet_vendor_shop_search_ViewController
    }
    
    
    
    
    static func Reg_calender_ViewController() -> Reg_calender_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Reg_calender_ViewController") as! Reg_calender_ViewController
    }
    
    
    
    static func doc_manageaddress_ViewController() -> doc_manageaddress_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_manageaddress_ViewController") as! doc_manageaddress_ViewController
    }
    
    static func doc_vendorcartpageViewController() -> doc_vendorcartpageViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_vendorcartpageViewController") as! doc_vendorcartpageViewController
    }
    
    static func DocdashboardViewController() -> DocdashboardViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "DocdashboardViewController") as! DocdashboardViewController
    }
    
    static func diagnosiViewController() -> diagnosiViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "diagnosiViewController") as! diagnosiViewController
    }
    
    static func subdiagnosisViewController() -> subdiagnosisViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "subdiagnosisViewController") as! subdiagnosisViewController
    }
    
    static func editsosViewController() -> editsosViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "editsosViewController") as! editsosViewController
    }
    
    
    
    
    static func doc_shop_dashboardViewController() -> doc_shop_dashboardViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_shop_dashboardViewController") as! doc_shop_dashboardViewController
    }
    
    static func Doc_new_setlocation_ViewController() -> Doc_new_setlocation_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_new_setlocation_ViewController") as! Doc_new_setlocation_ViewController
    }
    
    static func mycalenderViewController() -> mycalenderViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "mycalenderViewController") as! mycalenderViewController
    }
    
    static func mycal_hoursViewController() -> mycal_hoursViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "mycal_hoursViewController") as! mycal_hoursViewController
    }
    
    static func doc_myorderdetails_ViewController() -> doc_myorderdetails_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_myorderdetails_ViewController") as! doc_myorderdetails_ViewController
    }
    
    static func doc_shop_shipaddress_ViewController() -> doc_shop_shipaddress_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_shop_shipaddress_ViewController") as! doc_shop_shipaddress_ViewController
    }
    
    
    static func docsavelocationViewController() -> docsavelocationViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "docsavelocationViewController") as! docsavelocationViewController
    }
    
    static func doclocationsettingViewController() -> doclocationsettingViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doclocationsettingViewController") as! doclocationsettingViewController
    }
    
    static func doc_favlist_ViewController() -> doc_favlist_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_favlist_ViewController") as! doc_favlist_ViewController
    }
    
    static func doc_myorder_track_ViewController() -> doc_myorder_track_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_myorder_track_ViewController") as! doc_myorder_track_ViewController
    }
    
    static func doc_order_cancel_ViewController() -> doc_order_cancel_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_order_cancel_ViewController") as! doc_order_cancel_ViewController
    }
    
    
    static func Doc_addholidayViewController() -> Doc_addholidayViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_addholidayViewController") as! Doc_addholidayViewController
    }
    
    static func doc_preview_prescription_ViewController() -> doc_preview_prescription_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_preview_prescription_ViewController") as! doc_preview_prescription_ViewController
    }
    
    static func reg_cal_hour_ViewController() -> reg_cal_hour_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "reg_cal_hour_ViewController") as! reg_cal_hour_ViewController
    }
    
    static func Doc_update_details_ViewController() -> Doc_update_details_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_update_details_ViewController") as! Doc_update_details_ViewController
    }
    
    static func doc_shop_search_ViewController() -> doc_shop_search_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_shop_search_ViewController") as! doc_shop_search_ViewController
    }
    
    
    
    static func Doc_productdetails_ViewController() -> Doc_productdetails_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_productdetails_ViewController") as! Doc_productdetails_ViewController
    }
    
    static func doc_todaysdealseemoreViewController() -> doc_todaysdealseemoreViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_todaysdealseemoreViewController") as! doc_todaysdealseemoreViewController
    }
    
    static func doc_ProductdealsViewController() -> doc_ProductdealsViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_ProductdealsViewController") as! doc_ProductdealsViewController
    }
    
    static func vendorfilterViewController() -> vendorfilterViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendorfilterViewController") as! vendorfilterViewController
    }
    
    static func doc_editshippingaddressViewController() -> doc_editshippingaddressViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "doc_editshippingaddressViewController") as! doc_editshippingaddressViewController
    }
    
    
    
    // login process
    
    static func SHCircleBarControll() -> SHCircleBarControll {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pettabbarViewController") as! SHCircleBarControll
    }
    
    // bottom pages
    static func petloverDashboardViewController() -> petloverDashboardViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
    }
    
    static func Pet_searchlist_DRViewController() -> Pet_searchlist_DRViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Pet_searchlist_DRViewController") as! Pet_searchlist_DRViewController
    }
    
    static func pet_sp_shop_dashboard_ViewController() -> pet_sp_shop_dashboard_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_sp_shop_dashboard_ViewController") as! pet_sp_shop_dashboard_ViewController
    }
    
    static func pet_dashfooter_servicelist_ViewController() -> pet_dashfooter_servicelist_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_dashfooter_servicelist_ViewController") as! pet_dashfooter_servicelist_ViewController
    }
    
    static func comunityViewController() -> comunityViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "comunityViewController") as! comunityViewController
    }
    
    // doctor
    
    static func Doc_detailspage_ViewController() -> Doc_detailspage_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_detailspage_ViewController") as! Doc_detailspage_ViewController
    }
    
    static func Doc_prescriptionViewController() -> Doc_prescriptionViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_prescriptionViewController") as! Doc_prescriptionViewController
    }
    
    static func Doc_profiledetails_ViewController() -> Doc_profiledetails_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_profiledetails_ViewController") as! Doc_profiledetails_ViewController
    }
    
    
    
    static func Doc_confrence_ViewController() -> Doc_confrence_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Doc_confrence_ViewController") as! Doc_confrence_ViewController
    }
    
    static func docsidemenuViewController() -> docsidemenuViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "docsidemenuViewController") as! docsidemenuViewController
    }
    
    
    
    
    
    
    // doctor
    

     // pet care

     // shop

     // service
    // bottom pages
    
    
    // pet_doc_appointment
    
    static func searchhealthlistViewController() -> searchhealthlistViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "searchhealthlistViewController") as! searchhealthlistViewController
    }
    
    static func pet_doc_search_payoptionViewController() -> pet_doc_search_payoptionViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_doc_search_payoptionViewController") as! pet_doc_search_payoptionViewController
    }
    
    
    
    
    static func searchpetappdetailViewController() -> searchpetappdetailViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "searchpetappdetailViewController") as! searchpetappdetailViewController
    }
    
    
    
    static func searchpetloverappointmentViewController() -> searchpetloverappointmentViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "searchpetloverappointmentViewController") as! searchpetloverappointmentViewController
    }
    
    static func SearchtoclinicdetailViewController() -> SearchtoclinicdetailViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "SearchtoclinicdetailViewController") as! SearchtoclinicdetailViewController
    }
    
    static func searchcalenderdetailsViewController() -> searchcalenderdetailsViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "searchcalenderdetailsViewController") as! searchcalenderdetailsViewController
    }
    
    
    static func pethealthissueViewController() -> pethealthissueViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pethealthissueViewController") as! pethealthissueViewController
    }
    
    static func petlov_DocselectViewController() -> petlov_DocselectViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petlov_DocselectViewController") as! petlov_DocselectViewController
    }
    
    static func petdoccalenderViewController() -> petdoccalenderViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petdoccalenderViewController") as! petdoccalenderViewController
    }
    
    static func apppetdetailsViewController() -> apppetdetailsViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "apppetdetailsViewController") as! apppetdetailsViewController
    }
    
    static func petloverAppointmentAddViewController() -> petloverAppointmentAddViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "petloverAppointmentAddViewController") as! petloverAppointmentAddViewController
    }
    
    static func Pet_app_details_ViewController() -> Pet_app_details_ViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Pet_app_details_ViewController") as! Pet_app_details_ViewController
    }
    
    static func pet_app_details_doc_calender_ViewController() -> pet_app_details_doc_calender_ViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_app_details_doc_calender_ViewController") as! pet_app_details_doc_calender_ViewController
    }
    
    
    
    // pet_doc_appointment
    
    
    //  doctor Appointment list and other process related with appointment
    
    static func Pet_applist_ViewController() -> Pet_applist_ViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Pet_applist_ViewController") as! Pet_applist_ViewController
    }
    
    static func pet_doc_paymentmethodViewController() -> pet_doc_paymentmethodViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_doc_paymentmethodViewController") as! pet_doc_paymentmethodViewController
    }
    
    
    
    static func ReviewRateViewController() -> ReviewRateViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "ReviewRateViewController") as! ReviewRateViewController
    }
    
    static func Pet_confrence_ViewController() -> Pet_confrence_ViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Pet_confrence_ViewController") as! Pet_confrence_ViewController
    }
    
    static func pdfViewController() -> pdfViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pdfViewController") as! pdfViewController
    }
    
    static func prescriptionViewController() -> prescriptionViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "prescriptionViewController") as! prescriptionViewController
    }
    
    // doctor Appointment list and other process related with appointment
    
    //  Sp Appointment list and other process related with appointment
    
    
    static func pet_sp_filer_ViewController() -> pet_sp_filer_ViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_sp_filer_ViewController") as! pet_sp_filer_ViewController
    }
    
    static func pet_sp_service_details_ViewController() -> pet_sp_service_details_ViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_sp_service_details_ViewController") as! pet_sp_service_details_ViewController
    }
    
    static func pet_servicelist_ViewController() -> pet_servicelist_ViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_servicelist_ViewController") as! pet_servicelist_ViewController
    }
    
    static func pet_service_appointmentViewController() -> pet_service_appointmentViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_service_appointmentViewController") as! pet_service_appointmentViewController
    }
    
    static func pet_sp_calender_ViewController() -> pet_sp_calender_ViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_sp_calender_ViewController") as! pet_sp_calender_ViewController
    }
    
    static func pet_sp_app_payment_ViewController() -> pet_sp_app_payment_ViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_sp_app_payment_ViewController") as! pet_sp_app_payment_ViewController
    }
    
    
    static func pet_sp_CreateApp_ViewController() -> pet_sp_CreateApp_ViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pet_sp_CreateApp_ViewController") as! pet_sp_CreateApp_ViewController
    }
    
    static func sppetselectdetailsViewController() -> sppetselectdetailsViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sppetselectdetailsViewController") as! sppetselectdetailsViewController
    }
    
    static func sphealthissueViewController() -> sphealthissueViewController {
        let homeStoryboard = UIStoryboard.petspappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sphealthissueViewController") as! sphealthissueViewController
    }
    
   
    
    
    
    //  Sp Appointment list and other process related with appointment
    
    // vendor storyboard
    
    static func vendor_profile_view_ViewController() -> vendor_profile_view_ViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_profile_view_ViewController") as! vendor_profile_view_ViewController
    }
    
    static func vendor_edit_profile_ViewController() -> vendor_edit_profile_ViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_edit_profile_ViewController") as! vendor_edit_profile_ViewController
    }
    
    static func Vendor_reg_ViewController() -> Vendor_reg_ViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Vendor_reg_ViewController") as! Vendor_reg_ViewController
    }
    
    static func vendor_myorder_ViewController() -> vendor_myorder_ViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_myorder_ViewController") as! vendor_myorder_ViewController
    }
    
    static func vendor_manage_product_ViewController() -> vendor_manage_product_ViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_manage_product_ViewController") as! vendor_manage_product_ViewController
    }
    
    static func vendor_sidemenu_ViewController() -> vendor_sidemenu_ViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_sidemenu_ViewController") as! vendor_sidemenu_ViewController
    }
    
    static func dealupdateViewController() -> dealupdateViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "dealupdateViewController") as! dealupdateViewController
    }
    
    static func AddproductViewController() -> AddproductViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "AddproductViewController") as! AddproductViewController
    }
    
    static func addnewprodViewController() -> addnewprodViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "addnewprodViewController") as! addnewprodViewController
    }
    
    static func vendor_orderstatus_ViewController() -> vendor_orderstatus_ViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_orderstatus_ViewController") as! vendor_orderstatus_ViewController
    
    }
    
    static func vendorTrackorderViewController() -> vendorTrackorderViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendorTrackorderViewController") as! vendorTrackorderViewController
    
    }
    
    static func orderdetailsViewController() -> orderdetailsViewController {
        let homeStoryboard = UIStoryboard.vendorStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "orderdetailsViewController") as! orderdetailsViewController
    
    }
    
    // vendor storyboard
    
    // service provider storyboard
    
    
    static func Sp_reg_calender_ViewController() -> Sp_reg_calender_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Sp_reg_calender_ViewController") as! Sp_reg_calender_ViewController
    
    }
    
    static func sp_reg_calender_hour_ViewController() -> sp_reg_calender_hour_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_reg_calender_hour_ViewController") as! sp_reg_calender_hour_ViewController
    
    }
    
    static func SP_Reg_ViewController() -> SP_Reg_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "SP_Reg_ViewController") as! SP_Reg_ViewController
    
    }
    
    static func Sp_profile_ViewController() -> Sp_profile_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Sp_profile_ViewController") as! Sp_profile_ViewController
    
    }
    
    static func sp_side_menuViewController() -> sp_side_menuViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_side_menuViewController") as! sp_side_menuViewController
    
    }
    
    static func Sp_dash_ViewController() -> Sp_dash_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Sp_dash_ViewController") as! Sp_dash_ViewController
    }
    
    static func sp_app_details_page_ViewController() -> sp_app_details_page_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_app_details_page_ViewController") as! sp_app_details_page_ViewController
    }
    
    static func Sp_calender_hour_ViewController() -> Sp_calender_hour_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Sp_calender_hour_ViewController") as! Sp_calender_hour_ViewController
    }
    
    static func Sp_mycalender_ViewController() -> Sp_mycalender_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Sp_mycalender_ViewController") as! Sp_mycalender_ViewController
    }
    
    static func SP_mycal_addholiday_ViewController() -> SP_mycal_addholiday_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "SP_mycal_addholiday_ViewController") as! SP_mycal_addholiday_ViewController
    }
    
    static func Sp_profile_edit_ViewController() -> Sp_profile_edit_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "Sp_profile_edit_ViewController") as! Sp_profile_edit_ViewController
    }
    
    
    static func sp_favlist_ViewController() -> sp_favlist_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_favlist_ViewController") as! sp_favlist_ViewController
    }
    
    static func sp_shop_dashboard_ViewController() -> sp_shop_dashboard_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_shop_dashboard_ViewController") as! sp_shop_dashboard_ViewController
    }
    
    
    
    static func sp_orderlist_cancel_ViewController() -> sp_orderlist_cancel_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_orderlist_cancel_ViewController") as! sp_orderlist_cancel_ViewController
    }
    
    static func sp_cancelorder_ViewController() -> sp_cancelorder_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_cancelorder_ViewController") as! sp_cancelorder_ViewController
    }
    
    static func sp_editshippingaddress_ViewController() -> sp_editshippingaddress_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_editshippingaddress_ViewController") as! sp_editshippingaddress_ViewController
    }
    
    static func sp_myorder_ViewController() -> sp_myorder_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_myorder_ViewController") as! sp_myorder_ViewController
    }
    
    static func sp_myorderdetailspage_ViewController() -> sp_myorderdetailspage_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_myorderdetailspage_ViewController") as! sp_myorderdetailspage_ViewController
    }
    
    static func sp_myordertrack_ViewController() -> sp_myordertrack_ViewController {
        let homeStoryboard = UIStoryboard.serviceStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "sp_myordertrack_ViewController") as! sp_myordertrack_ViewController
    }
    
    // service provider storyboard
    
}
