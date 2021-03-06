//
//  vendor_edit_profile_ViewController.swift
//  Petfolio
//
//  Created by Admin on 08/04/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import MobileCoreServices
import CoreLocation
import SDWebImage


class vendor_edit_profile_ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UITextViewDelegate, UIDocumentPickerDelegate, UIDocumentMenuDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let imagepicker = UIImagePickerController()
    var Img_uploadarea = "clinic"
    var locationaddress = ""
     
    @IBOutlet weak var view_Bus_name: UIView!
     
     @IBOutlet weak var view_submit: UIView!
     @IBOutlet weak var view_bus_email: UIView!
     @IBOutlet weak var view_busi: UIView!
     @IBOutlet weak var view_phno: UIView!
     @IBOutlet weak var view_ph_cou: UIView!
     @IBOutlet weak var view_reg: UIView!
     
     @IBOutlet weak var textfield_Bus_name: UITextField!
     @IBOutlet weak var textfield_bus_email: UITextField!
     @IBOutlet weak var textfield_business: UITextField!
     @IBOutlet weak var textfield_bus_phno: UITextField!
     @IBOutlet weak var textfield_bus_reg: UITextField!
     
    @IBOutlet weak var coll_galary_img: UICollectionView!
    @IBOutlet weak var coll_certificate: UICollectionView!
    
    @IBOutlet weak var image_photo_id: UIImageView!
    @IBOutlet weak var image_gov: UIImageView!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_btn_ok: UIView!
     @IBOutlet weak var view_photoid_btn: UIView!
     @IBOutlet weak var view_govid_btn: UIView!
     
    var selservice = ["0"]
    var selspec = ["0"]
    var added_service = [""]
    var added_spec = [""]
    var image_photo = ""
    var image_govid = ""
    var img_for = "Gall" // Photo or Gov or Certi
    var In_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.call_vendor_details()
        self.call_protocals()
        self.added_service.removeAll()
        self.added_spec.removeAll()
    }
    
    func call_protocals(){
        self.call_delegates()
        self.viewcornordadius()
        self.setimag()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? vendor_profile_view_ViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
       }
    
    func call_delegates(){
     self.view_popup.isHidden = true
     self.view_shadow.isHidden = true
     self.imagepicker.delegate = self
     self.textfield_Bus_name.delegate = self
     self.textfield_bus_email.delegate = self
     self.textfield_business.delegate = self
     self.textfield_bus_phno.delegate = self
     self.textfield_bus_reg.delegate = self
        
        self.textfield_Bus_name.autocapitalizationType = .sentences
        self.textfield_business.autocapitalizationType = .sentences
        self.textfield_bus_reg.autocapitalizationType = .sentences
        
     self.collectiondelegate()
    }
     
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func collectiondelegate(){
     self.coll_galary_img.delegate = self
     self.coll_galary_img.dataSource = self
     self.coll_certificate.delegate = self
     self.coll_certificate.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.locationManager.requestAlwaysAuthorization()
                         self.locationManager.requestWhenInUseAuthorization()
                          if CLLocationManager.locationServicesEnabled() {
                                    locationManager.delegate = self
                                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                                    locationManager.startUpdatingLocation()
                                }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                 guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//                 print("locations = \(locValue.latitude) \(locValue.longitude)")
              
              
           self.latitude = locValue.latitude
           self.longitude = locValue.longitude
        self.latLong(lat: self.latitude,long: self.longitude)
                 self.locationManager.stopUpdatingLocation()
             }
    
    func latLong(lat: Double,long: Double)  {
               if Servicefile.shared.updateUserInterface(){
                   let geoCoder = CLGeocoder()
                   let location = CLLocation(latitude: lat , longitude: long)
                   geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                       var pm: CLPlacemark!
                       pm = placemarks?[0]
                      if placemarks?[0] != nil {
                      var addressString : String = ""
                                         if pm.subLocality != nil {
                                             addressString = addressString + pm.subLocality! + ", "
                                         }
                                         if pm.thoroughfare != nil {
                                             addressString = addressString + pm.thoroughfare! + ", "
                                         }
                                         if pm.locality != nil {
                                             addressString = addressString + pm.locality! + ", "
                                         }
                                         if pm.country != nil {
                                             addressString = addressString + pm.country! + ", "
                                         }
                                         if pm.postalCode != nil {
                                             addressString = addressString + pm.postalCode! + " "
                                         }

                    self.locationaddress = addressString
                                         print(addressString)
                     }
                   })
               }
              
           }
             
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     self.view.endEditing(true)
        return true
    }
    
    func textfield_resign(){
        self.textfield_Bus_name.resignFirstResponder()
    }
    
    func viewcornordadius(){
        self.view_submit.submit_cornor()
        self.view_popup.view_cornor()
        self.view_shadow.view_cornor()
        self.view_btn_ok.view_cornor()
    }
    
    @IBAction func action_gallary_pic_upload(_ sender: Any) {
         self.img_for = "Gall"
        self.callgalaryimageprocess()
    }
    
    @IBAction func action_photo_upload(_ sender: Any) {
         self.img_for = "Photo"
        self.callgalaryprocess()
    }
    
    @IBAction func action_gov_upload(_ sender: Any) {
        
         self.img_for = "Gov"
         self.callgalaryprocess()
    }
    
    @IBAction func action_certificate_upload(_ sender: Any) {
        self.img_for = "Certi"
         self.callgalaryprocess()
    }
    
   
    
    
    @IBAction func action_submit(_ sender: Any) {
     if self.textfield_Bus_name.text == "" {
         self.alert(Message: "Please enter the business name")
     }else if self.textfield_bus_email.text == "" {
         self.alert(Message: "Please enter the business email")
     }else if self.textfield_bus_phno.text == "" {
         self.alert(Message: "Please enter the business Phone number")
     }else if self.textfield_business.text == "" {
         self.alert(Message: "Please enter the business")
     }else if self.textfield_bus_reg.text == "" {
         self.alert(Message: "Please enter the business details")
     }else if Servicefile.shared.gallerydicarray.count == 0 {
         self.alert(Message: "Please upload the Gallary image")
     }else if self.image_photo == "" {
         self.alert(Message: "Please upload the Photo ID")
     }else if self.image_govid == "" {
         self.alert(Message: "Please upload the Goverment Id")
     }else if Servicefile.shared.certifdicarray.count == 0 {
         self.alert(Message: "Please upload the certificates")
     }else{
         if self.textfield_bus_email.text != ""{
             let emailval = Servicefile.shared.checktextfield(textfield: self.textfield_bus_email.text!)
             if self.isValidEmail(emailval) != false {
                 self.callvendorreg()
             }else{
                 self.alert(Message: "Email ID is invalid")
             }
         }else{
             self.callvendorreg()
         }
     }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if coll_galary_img ==  collectionView {
             return Servicefile.shared.gallerydicarray.count
        }else {
           return Servicefile.shared.certifdicarray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if coll_galary_img == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galary", for: indexPath) as! imgidCollectionViewCell
            
            let imgdat = Servicefile.shared.gallerydicarray[indexPath.row] as! NSDictionary
                       print("clinic data in", imgdat)
            cell.Img_id.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
         cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: (imgdat["bus_service_gall"] as? String ?? Servicefile.sample_img))) { (image, error, cache, urls) in
                                      if (error != nil) {
                                          cell.Img_id.image = UIImage(named: imagelink.sample)
                                      } else {
                                          cell.Img_id.image = image
                                      }
                                  }
            cell.Img_id.contentMode = .scaleAspectFill
         cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
         cell.btn_close.tag = indexPath.row
         cell.btn_close.addTarget(self, action: #selector(action_gallrydic_close), for: .touchUpInside)
            return cell
        }else {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "certifi", for: indexPath) as! imgidCollectionViewCell
         let imgdat = Servicefile.shared.certifdicarray[indexPath.row] as! NSDictionary
         let strdat = imgdat["bus_certif"] as? String ?? Servicefile.sample_img
         print("details",self.spilit_string_data(array_string: strdat))
         if self.spilit_string_data(array_string: strdat) == "" {
            cell.Img_id.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
             cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: strdat)) { (image, error, cache, urls) in
                 if (error != nil) {
                     cell.Img_id.image = UIImage(named: Servicefile.sample_img)
                 } else {
                     cell.Img_id.image = image
                 }
             }
            cell.Img_id.contentMode = .scaleAspectFill
         }else{
             cell.Img_id.image = UIImage(named: "pdf")
         }
         cell.view_close.layer.cornerRadius = cell.view_close.frame.height / 2
         cell.btn_close.tag = indexPath.row
         cell.btn_close.addTarget(self, action: #selector(action_certificate_close), for: .touchUpInside)
                return cell
        }
    }
    
    func spilit_string_data(array_string: String)-> String{
        let str = array_string.split(separator: ".")
        if str.last == "pdf" {
            return "pdf"
        }else if str.last == "PDF" {
            return "pdf"
        }else{
            return ""
        }
    }
   
     @objc func action_gallrydic_close(sender: UIButton){
         let tag = sender.tag
         Servicefile.shared.gallerydicarray.remove(at: tag)
         self.coll_galary_img.reloadData()
     }
     @objc func action_certificate_close(sender: UIButton){
         let tag = sender.tag
         Servicefile.shared.certifdicarray.remove(at: tag)
         self.coll_certificate.reloadData()
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func setimag(){
        if self.image_photo != "" {
             self.view_photoid_btn.isHidden = false
             self.image_photo_id.isHidden = false
              self.image_photo_id.image = UIImage(named: "pdf")
        }else{
         self.view_photoid_btn.isHidden = true
             self.image_photo_id.isHidden = true
        }
        
        if self.image_govid != "" {
         self.view_govid_btn.isHidden = false
             self.image_gov.isHidden = false
             self.image_gov.image = UIImage(named: "pdf")
               }else{
                    self.image_gov.isHidden = true
                 self.view_govid_btn.isHidden = true
               }
     self.view_govid_btn.view_cornor()
     self.view_photoid_btn.view_cornor()
     self.image_gov.layer.cornerRadius = 8.0
     self.image_photo_id.layer.cornerRadius = 8.0
    }
     
     @IBAction func action_clear_govid(_ sender: Any) {
         self.image_govid = ""
         self.setimag()
     }
     
     @IBAction func action_clear_photoid(_ sender: Any) {
         self.image_photo = ""
         self.setimag()
     }
     
    func callDocprocess(){
          let types = [kUTTypePDF]
          let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
          if #available(iOS 11.0, *) {
              importMenu.allowsMultipleSelection = true
          }
          importMenu.delegate = self
          importMenu.modalPresentationStyle = .formSheet
          present(importMenu, animated: true)
    }
    
    func callgalaryimageprocess(){
        let alert = UIAlertController(title: "Profile", message: "Choose the process", preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default, handler: { action in
                  self.imagepicker.allowsEditing = false
                 self.imagepicker.sourceType = .camera
                  self.present(self.imagepicker, animated: true, completion: nil)
              }))
              alert.addAction(UIAlertAction(title: "Pick from Gallery", style: UIAlertAction.Style.default, handler: { action in
                 self.imagepicker.allowsEditing = false
                 self.imagepicker.sourceType = .photoLibrary
                  self.present(self.imagepicker, animated: true, completion: nil)
              }))
              alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { action in
                print("ok")
              }))
              self.present(alert, animated: true, completion: nil)
    }
     
     func callgalaryprocess(){
         let alert = UIAlertController(title: "Profile", message: "Choose the process", preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default, handler: { action in
             self.imagepicker.allowsEditing = false
             self.imagepicker.sourceType = .camera
             self.present(self.imagepicker, animated: true, completion: nil)
         }))
         alert.addAction(UIAlertAction(title: "Pick from Gallery", style: UIAlertAction.Style.default, handler: { action in
             self.imagepicker.allowsEditing = false
             self.imagepicker.sourceType = .photoLibrary
             self.present(self.imagepicker, animated: true, completion: nil)
         }))
         alert.addAction(UIAlertAction(title: "Pick from Document", style: UIAlertAction.Style.default, handler: { action in
             self.callDocprocess()
         }))
         alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { action in
             print("ok")
         }))
         self.present(alert, animated: true, completion: nil)
     }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
          guard let myURL = urls.first else {
              return
          }
          let filename = URL(fileURLWithPath: String(describing:urls)).lastPathComponent // print: myfile.pdf]
          self.PDFupload(dat: myURL)
//          print("import result : \(myURL)","name of file ",filename)
      }


      public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
          documentPicker.delegate = self
          documentPicker.present(documentPicker, animated: true, completion: nil)
      }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
              if let pickedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                  //let reimage = Toucan(image: pickedImg).resize(CGSize(width: 100, height: 100), fitMode: Toucan.Resize.FitMode.crop).image
                let convertimg = pickedImg.resized(withPercentage: CGFloat(Servicefile.shared.imagequantity))
                self.upload(imagedata: convertimg!)
              }
                dismiss(animated: true, completion: nil)
          }
       
       func upload(imagedata: UIImage) {
            print("Upload started")
               print("before uploaded data in clinic",Servicefile.shared.clinicdicarray)
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data"
           ]
           AF.upload(
               multipartFormData: { multipartFormData in
                  if let imageData = imagedata.jpegData(compressionQuality: 0.5) {
                   multipartFormData.append(imageData, withName: "sampleFile", fileName: Servicefile.shared.userid +  Servicefile.shared.uploadddmmhhmmastringformat(date: Date()), mimeType: "image/png")
                   }
           },
               to: Servicefile.imageupload, method: .post , headers: headers)
               .responseJSON { resp in
                   switch (resp.result) {
                   case .success:
                       let res = resp.value as! NSDictionary
                       print("success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                         let Data = res["Data"] as? String ?? Servicefile.sample_img
                          print("Uploaded file url:",Data)
                           if self.img_for == "Gall" {
                            var B = Servicefile.shared.gallerydicarray
                              var arr = B
                              let a = ["bus_service_gall":Data] as NSDictionary
                              arr.append(a)
                              B = arr
                              print(B)
                              Servicefile.shared.gallerydicarray = B
                              print("uploaded data in certifi",Servicefile.shared.gallerydicarray)
                           }
                        if self.img_for == "Certi" {
                            var B = Servicefile.shared.certifdicarray
                            var arr = B
                            let a = ["bus_certif":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.certifdicarray = B
                            print("uploaded data in certifi",Servicefile.shared.certifdicarray)
                        }
                         
                        if self.img_for == "Gov" {
                         self.image_govid = Data
                        }
                         
                        if self.img_for == "Photo" {
                         self.image_photo = Data
                        }
                         
                         self.coll_certificate.reloadData()
                       self.setimag()
                           self.stopAnimatingActivityIndicator()
                        self.coll_galary_img.reloadData()
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
           }
       
       
      
       func PDFupload(dat: URL) {
               print("Upload started")
              let headers: HTTPHeaders = [
                  "Content-type": "multipart/form-data"
              ]
              AF.upload(
                  multipartFormData: { multipartFormData in
                   let pdfData = try! Data(contentsOf: dat as URL)
                   let data : Data = pdfData
                   multipartFormData.append(data as Data, withName: "sampleFile", fileName: Servicefile.shared.userid+"certificate.pdf", mimeType: "application/pdf")
              },
                  to: Servicefile.imageupload, method: .post , headers: headers)
                  .responseJSON { resp in
                      switch (resp.result) {
                      case .success:
                          let res = resp.value as! NSDictionary
                          print("success data",res)
                          let Code  = res["Code"] as! Int
                          if Code == 200 {
                             let Data = res["Data"] as? String ?? Servicefile.sample_img
                             print("Uploaded file url:",Data, self.img_for)
                          
                           if self.img_for == "Certi" {
                               var B = Servicefile.shared.certifdicarray
                               var arr = B
                               let a = ["bus_certif":Data] as NSDictionary
                               arr.append(a)
                               B = arr
                               print(B)
                               Servicefile.shared.certifdicarray = B
                               print("uploaded data in certifi",Servicefile.shared.certifdicarray)
                           }
                            
                           if self.img_for == "Gov" {
                            self.image_govid = Data
                           }
                            
                           if self.img_for == "Photo" {
                            self.image_photo = Data
                           }
                            
                            self.setimag()
                            self.coll_certificate.reloadData()
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
              }
   
    
    func callvendorreg(){
     print("details in vendor registration",Servicefile.shared.gallerydicarray,Servicefile.shared.certifdicarray,self.image_photo,self.image_govid)
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Vendor_edit_reg, method: .post, parameters:
                                                                ["_id" : self.In_id,
            "user_id": Servicefile.shared.userid,
                 "user_name" : Servicefile.shared.first_name,
                 "user_email": Servicefile.shared.user_email,
                 "bussiness_name" : Servicefile.shared.checktextfield(textfield: self.textfield_Bus_name.text!),
                 "bussiness_email" : Servicefile.shared.checktextfield(textfield: self.textfield_bus_email.text!),
                 "bussiness" : Servicefile.shared.checktextfield(textfield: self.textfield_business.text!),
                 "bussiness_phone": Servicefile.shared.checktextfield(textfield: self.textfield_bus_phno.text!),
                 "business_reg" : Servicefile.shared.checktextfield(textfield: self.textfield_bus_reg.text!),
                 "bussiness_gallery" : Servicefile.shared.gallerydicarray,
                 "photo_id_proof" : self.image_photo,
                 "govt_id_proof":  self.image_govid,
                 "certifi" : Servicefile.shared.certifdicarray,
                 "date_and_time" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                 "mobile_type" : "IOS",
                 "profile_status": true,
                 "profile_verification_status" : "Not Verified",
                 "bussiness_loc" : self.locationaddress,
                 "bussiness_lat" : self.latitude!,
                 "bussiness_long" : self.longitude!,
                 "delete_status" : false], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    //let Data = res["Data"] as! NSDictionary
                                                    //self.callupdatestatus()
                                                    self.view_popup.isHidden = false
                                                    self.view_shadow.isHidden = false
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
    
    func callupdatestatus(){
                self.startAnimatingActivityIndicator()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.updatestatus, method: .post, parameters:
             ["user_id" : Servicefile.shared.userid,
               "user_status": "complete"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                    switch (response.result) {
                                                    case .success:
                                                          let res = response.value as! NSDictionary
                                                          print("success data",res)
                                                          let Code  = res["Code"] as! Int
                                                          if Code == 200 {
                                                             self.view_popup.isHidden = false
                                                             self.view_shadow.isHidden = false
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
        }
    }
    
    @IBAction func action_register_success(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func call_vendor_details(){
     Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
      Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
           self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_getlistid, method: .post, parameters:
        [   "user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                               switch (response.result) {
                                               case .success:
                                                     let res = response.value as! NSDictionary
                                                     print("success data",res)
                                                     let Code  = res["Code"] as! Int
                                                     if Code == 200 {
                                                        let Data = res["Data"] as! NSDictionary
                                                        let id =  Data["_id"] as? String ?? ""
                                                        self.In_id = id
                                                        let business_reg =  Data["business_reg"] as? String ?? ""
                                                        let bussiness =  Data["bussiness"] as? String ?? ""
                                                        let bus_service_gall = Data["bussiness_gallery"] as! NSArray
                                                        Servicefile.shared.vendor_gallary_img = bus_service_gall as! [Any]
                                                        let bussiness_lat = Data["bussiness_lat"] as? String ?? ""
                                                        let bussiness_long = Data["bussiness_long"] as? String ?? ""
                                                        let bussiness_loc = Data["bussiness_loc"] as? String ?? ""
                                                        let bus_certif = Data["certifi"] as! NSArray
                                                        let date_and_time = Data["date_and_time"] as? String ?? ""
                                                        let delete_status = Data["delete_status"] as? String ?? ""
                                                        let govt_id_proof = Data["govt_id_proof"] as? String ?? ""
                                                        let mobile_type = Data["mobile_type"] as? String ?? ""
                                                        let photo_id_proof = Data["photo_id_proof"] as? String ?? ""
                                                        let profile_status = Data["profile_status"] as? String ?? ""
                                                        let profile_verification_status = Data["profile_verification_status"] as? String ?? ""
                                                        let user_email = Data["user_email"] as? String ?? ""
                                                        let user_id = Data["user_id"] as? String ?? ""
                                                        let user_name = Data["user_name"] as? String ?? ""
                                                        
                                                        Servicefile.shared.first_name = Data["bussiness_name"] as? String ?? ""
                                                        Servicefile.shared.user_email = Data["bussiness_email"] as? String ?? ""
                                                        self.textfield_Bus_name.text = Data["bussiness_name"] as? String ?? ""
                                                        self.textfield_bus_email.text = Data["bussiness_email"] as? String ?? ""
                                                        self.textfield_business.text = Data["bussiness"] as? String ?? ""
                                                        self.textfield_bus_phno.text = Data["bussiness_phone"] as? String ?? ""
                                                        self.textfield_bus_reg.text = Data["business_reg"] as? String ?? ""
                                                        Servicefile.shared.gallerydicarray =  bus_service_gall as! [Any]
                                                        self.image_photo =  Data["photo_id_proof"] as? String ?? ""
                                                        self.image_govid =  Data["govt_id_proof"] as? String ?? ""
                                                        Servicefile.shared.certifdicarray = bus_certif as! [Any]
                                                        self.coll_certificate.reloadData()
                                                        self.coll_galary_img.reloadData()
                                                        self.setimag()
//                                                        self.label_bussiness.text = Data["bussiness"] as? String ?? ""
//                                                        self.label_business_email.text =  Data["bussiness_email"] as? String ?? ""
//                                                        self.label_business_phone.text = Data["bussiness_phone"] as? String ?? ""
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


