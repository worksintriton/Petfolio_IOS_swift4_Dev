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
    
    // login process
    
    static func SHCircleBarControll() -> SHCircleBarControll {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "pettabbarViewController") as! SHCircleBarControll
    }
    
    // pet_doc_appointment
    
    static func searchhealthlistViewController() -> searchhealthlistViewController {
        let homeStoryboard = UIStoryboard.petDocappStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "searchhealthlistViewController") as! searchhealthlistViewController
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
