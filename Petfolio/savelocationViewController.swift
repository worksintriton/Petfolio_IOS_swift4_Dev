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
    
    
    @IBOutlet weak var img_other: UIImageView!
    @IBOutlet weak var img_work: UIImageView!
    @IBOutlet weak var img_home: UIImageView!
    
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let marker = GMSMarker()
    
    var isselected = "Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view_change.layer.cornerRadius = 9.0
         self.view_pincode.layer.cornerRadius = 9.0
         self.view_location.layer.cornerRadius = 9.0
         self.view_cityname.layer.cornerRadius = 9.0
         self.view_pickname.layer.cornerRadius = 9.0
         self.view_saveview.layer.cornerRadius = 15.0
        self.GMS_mapView.delegate = self
        
        self.textfield_pincode.delegate = self
        self.textfield_cityname.delegate = self
        self.textfield_location.delegate = self
        self.textfield_pickname.delegate = self
       
        // Do any additional setup after loading the view.
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

}
