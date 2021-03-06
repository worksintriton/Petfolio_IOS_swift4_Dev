//
//  sp_locationsetting_ViewController.swift
//  Petfolio
//
//  Created by Admin on 17/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import CoreLocation


class sp_locationsetting_ViewController:  UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
        
        
        @IBOutlet weak var view_setloca: UIView!
        @IBOutlet weak var view_searchopt: UIView!
        @IBOutlet weak var GMS_mapView: GMSMapView!
        
        @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
        @IBOutlet weak var textfield_search: UITextField!
        @IBOutlet weak var tbl_searchlist: UITableView!
        
        @IBOutlet weak var view_footer: doc_footer!
        
        let locationManager = CLLocationManager()
        var latitude : Double!
        var longitude : Double!
        let marker = GMSMarker()
        var searlocation = [""]
        var findtext = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.intial_setup_action()
            //self.view_home.view_cornor()
            self.view_setloca.view_cornor()
            self.view_searchopt.view_cornor()
            self.GMS_mapView.delegate = self
            self.textfield_search.delegate = self
            
            self.textfield_search.autocapitalizationType = .sentences
            self.tbl_searchlist.delegate = self
            self.tbl_searchlist.dataSource = self
            self.tbl_searchlist.isHidden = true
            self.textfield_search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        
        func intial_setup_action(){
        // header action
            self.view_subpage_header.label_header_title.text = "Pickup Location"
                self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
                self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.spDashboard), for: .touchUpInside)
                self.view_subpage_header.view_profile.isHidden = true
                self.view_subpage_header.view_sos.isHidden = true
                self.view_subpage_header.view_bel.isHidden = true
                self.view_subpage_header.view_bag.isHidden = true
            // header action
            // footer action
            self.view_footer.setup(b1: true, b2: false, b3: false)
                self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.spshop), for: .touchUpInside)
                self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.spDashboard), for: .touchUpInside)
            self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
            // footer action
        }
        
        @IBAction func action_back(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func action_get_curr_location(_ sender: Any) {
            self.tbl_searchlist.isHidden = true
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.textfield_search.resignFirstResponder()
            return true
        }
        
        override func viewWillAppear(_ animated: Bool) {
            print("location access", Servicefile.shared.locaaccess)
            if Servicefile.shared.locaaccess == "Add" {
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                }
            } else {
                
                self.latitude = Servicefile.shared.lati
                self.longitude = Servicefile.shared.long
                self.setmarker(lat: Servicefile.shared.lati,long: Servicefile.shared.long)
                self.latLong(lat: Servicefile.shared.long,long: Servicefile.shared.long)
                self.findareabylatlong()
            }
            
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            if textField == self.textfield_search {
                print("typed text",self.textfield_search.text!)
                self.findtext = self.textfield_search.text!
                if self.findtext != ""{
                    self.findareabysearch(text: self.findtext)
                }
            }
        }
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.searlocation.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! locationdetailsTableViewCell
            cell.Label_location.text = self.searlocation[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(self.searlocation[indexPath.row])
            self.tbl_searchlist.isHidden = true
            self.textfield_search.resignFirstResponder()
            self.getlatlongforaddress(Address: self.searlocation[indexPath.row])
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }
        
        @IBAction func action_setlocation(_ sender: Any) {
            if Servicefile.shared.long != 0.0 {
                let vc = UIStoryboard.sp_savelocationViewController()
                self.present(vc, animated: true, completion: nil)
            }else{
                self.alert(Message: "please select the location")
            }
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            if Servicefile.shared.locaaccess == "Add" {
                Servicefile.shared.lati = locValue.latitude
                Servicefile.shared.long = locValue.longitude
                self.setmarker(lat: locValue.latitude,long: locValue.longitude)
                self.latLong(lat: locValue.latitude,long: locValue.longitude)
                self.findareabylatlong()
            }
            
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
        
        // UpdteLocationCoordinate
        
        
        // Camera change Position this methods will call every time
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            marker.position = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
            self.tbl_searchlist.isHidden = true
            self.view.endEditing(true)
            self.latitude = position.target.latitude
            self.longitude = position.target.longitude
            Servicefile.shared.lati = self.latitude
            Servicefile.shared.long = self.longitude
            self.latLong(lat: Servicefile.shared.lati,long: Servicefile.shared.long)
            self.findareabylatlong()
            marker.title = "Area Details"
            marker.snippet = "my loc"
            marker.map = self.GMS_mapView
            let markerImage = UIImage(named: "location")!
            let markerView = UIImageView(image: markerImage)
            markerView.frame = CGRect(x: 0, y: 0, width: 22, height: 30)
            markerView.tintColor = UIColor.red
            marker.iconView = markerView
            
        }
        
        // gms move marker work
        
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
            print("You tapped at \(coordinate)")
            self.tbl_searchlist.isHidden = true
            self.view.endEditing(true)
            marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.latitude = coordinate.latitude
            self.longitude = coordinate.longitude
            Servicefile.shared.lati = self.latitude
            Servicefile.shared.long = self.longitude
            self.latLong(lat: Servicefile.shared.lati,long: Servicefile.shared.long)
            self.findareabylatlong()
            marker.title = "Area Details"
            marker.snippet = "my loc"
            marker.map = self.GMS_mapView
            let markerImage = UIImage(named: "location")!
            let markerView = UIImageView(image: markerImage)
            markerView.frame = CGRect(x: 0, y: 0, width: 22, height: 30)
            markerView.tintColor = UIColor.red
            marker.iconView = markerView
        }
        
        func latLong(lat: Double,long: Double)  {
            if Servicefile.shared.updateUserInterface(){
                let geoCoder = CLGeocoder()
                let location = CLLocation(latitude: lat , longitude: long)
                geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                    var placeMark: CLPlacemark!
                    placeMark = placemarks?[0]
                    print("placemarks",placemarks?[0] as Any)
                    if placemarks?[0] != nil {
                        if let country = placeMark.addressDictionary!["Country"] as? String {
                            Servicefile.shared.selectedCountry = country
                        }
                        if let city = placeMark.addressDictionary!["City"] as? String {
                            print("Newuserpickuplocation line 106 City :- \(city)")
                            Servicefile.shared.selectedCity = city
                        }
                        if let state = placeMark.addressDictionary!["State"] as? String{
                            print("State :- \(state)")
                            Servicefile.shared.selectedState = state
                            // Street
                        }
                        if let zip = placeMark.addressDictionary!["ZIP"] as? String{
                            print("ZIP :- \(zip)")
                            Servicefile.shared.selectedPincode = zip
                            // Location name
                        }
                        if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                            print("Location Name :- \(locationName)")
                            // Street address
                        }
                        if let thoroughfare = placeMark?.addressDictionary!["Thoroughfare"] as? NSString {
                            print("Thoroughfare :- \(thoroughfare)")
                            
                        }}
                })
                
            }
            
        }
        
        func findareabylatlong(){
            let latlng = String(self.latitude)+","+String(self.longitude)
            if Servicefile.shared.updateUserInterface() { AF.request("https://maps.googleapis.com/maps/api/geocode/json?latlng="+latlng+"&key=AIzaSyAlvAK3lZepIaApTDbDZUNfO0dBmuP6h4A", method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let data = response.value as! NSDictionary
                    let area = data["results"] as! NSArray
                    let areadetails = area[0] as! NSDictionary
                    self.textfield_search.text = areadetails["formatted_address"] as? String
                    _ = areadetails["address_components"] as! NSArray
                    Servicefile.shared.selectedaddress = self.textfield_search.text!
                    break
                case .failure(let Error):
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }
                }
            }else{
                self.alert(Message: "No Intenet Please check and try again ")
            }
        }
        
        func findareabysearch(text: String){
            //self.loader(Message: "Please Wait...")
            let area = text.replacingOccurrences(of: " ", with: "%20")
            
            if Servicefile.shared.updateUserInterface() { AF.request("https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+area+"&key=AIzaSyAlvAK3lZepIaApTDbDZUNfO0dBmuP6h4A", method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    self.searlocation.removeAll()
                    //self.dismiss(animated: true, completion: nil)
                    self.tbl_searchlist.isHidden = false
                    let data = response.value as! NSDictionary
                    //print("success data",data)
                    let desc = data["predictions"] as! NSArray
                    let descvalue = desc[0] as! NSDictionary
                    let value = descvalue["description"] as? String ?? ""
                    print("Address data",value)
                    for item in 0..<desc.count {
                        let descvalue = desc[item] as! NSDictionary
                        let value = descvalue["description"] as? String ?? ""
                        self.searlocation.append(value)
                    }
                    print("list of address",self.searlocation)
                    self.tbl_searchlist.reloadData()
                    break
                case .failure(let Error):
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }
                }
            }else{
                self.alert(Message: "No Intenet Please check and try again ")
            }
        }
        
       
        
        func getlatlongforaddress(Address: String){
            //self.loader(Message: "Please Wait...")
            self.searlocation.removeAll()
            let raddress = Address.replacingOccurrences(of: " ", with: "%20")
            if Servicefile.shared.updateUserInterface() { AF.request("https://maps.googleapis.com/maps/api/geocode/json?&address="+raddress+"&key=AIzaSyAlvAK3lZepIaApTDbDZUNfO0dBmuP6h4A", encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    //self.dismiss(animated: true, completion: nil)
                    let data = response.value as! NSDictionary
                    //print("success data",data)
                    let result = data["results"] as! NSArray
                    let gemontary = result[0] as! NSDictionary
                    let location = gemontary["geometry"] as! NSDictionary
                    let locations = location["location"] as! NSDictionary
                    let lat = locations["lat"] as! NSNumber
                    let lng = locations["lng"] as! NSNumber
                    self.latitude = Double(truncating: lat)
                    self.longitude = Double(truncating: lng)
                    Servicefile.shared.lati = self.latitude
                    Servicefile.shared.long = self.longitude
                    self.setmarker(lat: self.latitude, long: self.longitude)
                    self.latLong(lat: Servicefile.shared.lati,long: Servicefile.shared.long)
                    self.textfield_search.text = gemontary["formatted_address"] as? String
                    
                    Servicefile.shared.selectedaddress = self.textfield_search.text!
                    self.textfield_search.resignFirstResponder()
                    //print("lat and lng",locations)
                    break
                case .failure(let Error):
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }
                }
            }else{
                self.alert(Message: "No Intenet Please check and try again ")
            }
        }
        
    }
