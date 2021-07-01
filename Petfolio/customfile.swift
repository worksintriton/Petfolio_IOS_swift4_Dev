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
    
    // login process
    
    static func LoginViewController() -> LoginViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    // login process
    
    static func vendor_orderstatus_ViewController() -> vendor_orderstatus_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_orderstatus_ViewController") as! vendor_orderstatus_ViewController
    }
    
    static func vendor_myorder_ViewController() -> vendor_myorder_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_myorder_ViewController") as! vendor_myorder_ViewController
    }
    
    static func vendor_sidemenu_ViewController() -> vendor_sidemenu_ViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "vendor_sidemenu_ViewController") as! vendor_sidemenu_ViewController
    }
    
    static func orderdetailsViewController() -> orderdetailsViewController {
        let homeStoryboard = UIStoryboard.mainStoryboard()
        return homeStoryboard.instantiateViewController(withIdentifier: "orderdetailsViewController") as! orderdetailsViewController
    }
    
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
    
    // pet_doc_appointment
}
