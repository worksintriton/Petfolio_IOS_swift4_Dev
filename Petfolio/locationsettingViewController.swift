//
//  locationsettingViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 19/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import CoreLocation

class locationsettingViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate { 

    
    @IBOutlet weak var view_setloca: UIView!
    @IBOutlet weak var view_searchopt: UIView!
    @IBOutlet weak var view_footer: UIView!
    @IBOutlet weak var GMS_mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_setloca.layer.cornerRadius = 9.0
        self.view_searchopt.layer.cornerRadius = 9.0
        self.view_footer.layer.cornerRadius = 9.0
        self.GMS_mapView.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         if CLLocationManager.locationServicesEnabled() {
                   locationManager.delegate = self
                   locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                   locationManager.startUpdatingLocation()
               }
    }
    
    @IBAction func action_setlocation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "savelocationViewController") as! savelocationViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(locValue.latitude) \(locValue.longitude)")
           self.setmarker(lat: locValue.latitude,long: locValue.longitude)
           self.locationManager.stopUpdatingLocation()
       }
       
    func setmarker(lat: Double,long: Double){
        GMS_mapView.camera =  GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
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
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
           print("You tapped at \(coordinate)")
           marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
           self.latitude = coordinate.latitude
           self.longitude = coordinate.longitude
        Servicefile.shared.lati = self.latitude
        Servicefile.shared.long = self.longitude
        marker.title = "Area Details"
        marker.snippet = "my loc"
        marker.map = self.GMS_mapView
        let markerImage = UIImage(named: "location")!
        let markerView = UIImageView(image: markerImage)
        markerView.frame = CGRect(x: 0, y: 0, width: 22, height: 30)
        markerView.tintColor = UIColor.red
        marker.iconView = markerView
       }
}
