//
//  savelocationViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 19/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import CoreLocation

class savelocationViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var view_cityname: UIView!
    @IBOutlet weak var view_location: UIView!
    @IBOutlet weak var view_pincode: UIView!
    @IBOutlet weak var GMS_mapView: GMSMapView!
    @IBOutlet weak var view_change: UIView!
    @IBOutlet weak var view_pickname: UIView!
    @IBOutlet weak var view_saveview: UIView!
    
    @IBOutlet weak var label_locaTitle: UILabel!
    @IBOutlet weak var label_locadetail: UILabel!
    
    @IBOutlet weak var textfield_pincode: UITextField!
    @IBOutlet weak var textfield_location: UITextField!
    
    @IBOutlet weak var textfield_cityname: UITextField!
    @IBOutlet weak var textfield_pickname: UITextField!
    
    @IBOutlet weak var switch_default: UISwitch!
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    @IBOutlet weak var img_other: UIImageView!
    @IBOutlet weak var img_work: UIImageView!
    @IBOutlet weak var img_home: UIImageView!
    
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let marker = GMSMarker()
    
    var isselected = "Home"
    var defaultstatus = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.switch_default.isOn = self.defaultstatus
        self.view_change.view_cornor()
         self.view_pincode.view_cornor()
         self.view_location.view_cornor()
         self.view_cityname.view_cornor()
         self.view_pickname.view_cornor()
         self.view_saveview.view_cornor()
        self.GMS_mapView.delegate = self
        self.view_change.dropShadow()
        self.view_saveview.dropShadow()
        self.textfield_pincode.delegate = self
        self.textfield_cityname.delegate = self
        self.textfield_location.delegate = self
        self.textfield_pickname.delegate = self
        
        self.textfield_pincode.isUserInteractionEnabled = false
        self.textfield_cityname.isUserInteractionEnabled = false
        self.textfield_location.isUserInteractionEnabled = false
        
        self.textfield_pincode.text = Servicefile.shared.selectedPincode
        self.textfield_cityname.text = Servicefile.shared.selectedCity
        self.textfield_location.text = Servicefile.shared.selectedaddress
        self.label_locaTitle.text = Servicefile.shared.selectedCity
        self.label_locadetail.text = Servicefile.shared.selectedaddress
        self.textfield_pickname.addTarget(self, action: #selector(textFieldpickTyping), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    func intial_setup_action(){
        // header action
        self.view_subpage_header.label_header_title.text = "Pickup Location"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.view_sos.isHidden = true
        self.view_subpage_header.view_bel.isHidden = true
        self.view_subpage_header.view_bag.isHidden = true
        self.view_subpage_header.view_profile.isHidden = true
        // header action
    }
    
    @IBAction func action_switch(_ sender: UISwitch) {
        if sender.isOn {
            self.defaultstatus = true
        } else {
            self.defaultstatus = false
        }
    }
    
    @objc func textFieldpickTyping(textField:UITextField) {
          if self.textfield_pickname.text!.count > 24 {
             self.textfield_pickname.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvestring, textcount: 25)
              self.textfield_pickname.resignFirstResponder()
          }else{
            self.textfield_pickname.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvestring, textcount: 25)
        }
      }
      
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_pincode.resignFirstResponder()
        self.textfield_cityname.resignFirstResponder()
        self.textfield_location.resignFirstResponder()
        self.textfield_pickname.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.setmarker(lat: Servicefile.shared.lati, long: Servicefile.shared.long)
    }
    
    
    @IBAction func action_changeloca(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "locationsettingViewController") as! locationsettingViewController
              self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_home(_ sender: Any) {
        self.isselected = "Home"
        self.img_home.image = UIImage(named: "selectedRadio")
        self.img_work.image = UIImage(named: "Radio")
        self.img_other.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_other(_ sender: Any) {
        self.isselected = "Other"
        self.img_home.image = UIImage(named: "Radio")
        self.img_work.image = UIImage(named: "Radio")
        self.img_other.image = UIImage(named: "selectedRadio")
    }
    
    @IBAction func action_work(_ sender: Any) {
         self.isselected = "Work"
        self.img_home.image = UIImage(named: "Radio")
        self.img_work.image = UIImage(named: "selectedRadio")
        self.img_other.image = UIImage(named: "Radio")
    }
    
    func setmarker(lat: Double,long: Double){
           marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
           Servicefile.shared.lati = lat
           Servicefile.shared.long = long
           self.latitude = lat
           self.longitude = long
           marker.title = "Area Details"
           marker.snippet = "my loc"
           marker.map = self.GMS_mapView
           let markerImage = UIImage(named: "location")!
           let markerView = UIImageView(image: markerImage)
           markerView.frame = CGRect(x: 0, y: 0, width: 22, height: 30)
           markerView.tintColor = UIColor.red
           marker.iconView = markerView
        GMS_mapView.camera =  GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
       }
       
    
    func moveTextField(textField: UITextField, up: Bool){
               let movementDistance:CGFloat = -230
              let movementDuration: Double = 0.3
              var movement:CGFloat = 0
              if up {
                  movement = movementDistance
              } else {
                  movement = -movementDistance
              }
              UIView.beginAnimations("animateTextField", context: nil)
              UIView.setAnimationBeginsFromCurrentState(true)
              UIView.setAnimationDuration(movementDuration)
              self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
              UIView.commitAnimations()
          }
          
          func textFieldDidBeginEditing(_ textField: UITextField) {
           if self.textfield_cityname == textField || self.textfield_pickname == textField{
                self.moveTextField(textField: textField, up:true)
           }
                  
          }
          
          func textFieldDidEndEditing(_ textField: UITextField) {
          if self.textfield_cityname == textField || self.textfield_pickname == textField{
                 self.moveTextField(textField: textField, up:false)
           }
          }
    
    
    @IBAction func action_savelocation(_ sender: Any) {
             self.calladdlocation()
    }
    
    
    func calladdlocation(){
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.addlocation, method: .post, parameters:
     ["user_id": Servicefile.shared.userid,
      "location_state" : Servicefile.shared.selectedState,
        "location_country" : Servicefile.shared.selectedCountry,
        "location_city" : Servicefile.shared.selectedCity,
        "location_pin" : Servicefile.shared.selectedPincode,
        "location_address" : Servicefile.shared.selectedaddress,
        "location_lat" : Servicefile.shared.lati,
        "location_long" : Servicefile.shared.long,
        "location_title" : self.isselected,
        "location_nickname" : Servicefile.shared.checktextfield(textfield: self.textfield_pickname.text!),
        "default_status" : self.defaultstatus,
        "date_and_time" :  Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()),
        "mobile_type" : "IOS"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    let Data = res["Data"] as! NSDictionary
                                                    //        Servicefile.shared.tabbar_selectedindex = 2
                                                            let tapbar = UIStoryboard.petloverDashboardViewController()
                                                    //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                                                            self.present(tapbar, animated: true, completion: nil)
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
  
}
