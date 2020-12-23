//
//  SP_Reg_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 18/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import MobileCoreServices
import CoreLocation

class SP_Reg_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UITextViewDelegate, UIDocumentPickerDelegate, UIDocumentMenuDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let imagepicker = UIImagePickerController()
    var Img_uploadarea = "clinic"
    
    @IBOutlet weak var view_Bus_name: UIView!
    @IBOutlet weak var view_addservice: UIView!
    @IBOutlet weak var view_Service_Btn_add: UIView!
    @IBOutlet weak var view_submit: UIView!
    
    @IBOutlet weak var textfield_Bus_name: UITextField!
    @IBOutlet weak var textfield_servicename: UITextField!
    @IBOutlet weak var textfield_spec: UITextField!
    
    @IBOutlet weak var coll_selservice: UICollectionView!
    @IBOutlet weak var coll_service: UICollectionView!
    @IBOutlet weak var coll_galary_img: UICollectionView!
    @IBOutlet weak var coll_certificate: UICollectionView!
    @IBOutlet weak var coll_speclist: UICollectionView!
    @IBOutlet weak var coll_selspec: UICollectionView!
    
    @IBOutlet weak var image_photo_id: UIImageView!
    @IBOutlet weak var image_gov: UIImageView!
    
    var selservice = ["0"]
    var selspec = ["0"]
    var added_service = [""]
    var added_spec = [""]
    var image_photo = ""
    var image_govid = ""
    var img_for = "Gall" // Photo or Gov or Certi
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_protocals()
        self.callSP_Ser_Spec_get()
        self.added_service.removeAll()
        self.added_spec.removeAll()
    }
    
    func call_protocals(){
        self.call_delegates()
        self.viewcornordadius()
        self.setimag()
    }
    
    func call_delegates(){
        self.imagepicker.delegate = self
        self.textfield_servicename.delegate = self
        self.textfield_Bus_name.delegate = self
        self.textfield_spec.delegate = self
        self.collectiondelegate()
    }
    
    func collectiondelegate(){
        
        self.coll_service.delegate = self
        self.coll_service.dataSource = self
        
        self.coll_galary_img.delegate = self
        self.coll_galary_img.dataSource = self
        
        self.coll_certificate.delegate = self
        self.coll_certificate.dataSource = self
        
        self.coll_selservice.delegate = self
        self.coll_selservice.dataSource = self
        
        self.coll_selspec.delegate = self
        self.coll_selspec.dataSource = self
        
        self.coll_speclist.delegate = self
        self.coll_speclist.dataSource = self
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_resign()
        return true
    }
    
    func textfield_resign(){
        self.textfield_spec.resignFirstResponder()
        self.textfield_Bus_name.resignFirstResponder()
        self.textfield_servicename.resignFirstResponder()
    }
    
    func viewcornordadius(){
        self.view_submit.submit_cornor()
        self.view_Service_Btn_add.view_cornor()
    }
    
    @IBAction func action_gallary_pic_upload(_ sender: Any) {
         self.img_for = "Gall"
        self.callgalaryprocess()
    }
    
    @IBAction func action_photo_upload(_ sender: Any) {
         self.img_for = "Photo"
        self.callDocprocess()
    }
    
    @IBAction func action_gov_upload(_ sender: Any) {
        
         self.img_for = "Gov"
         self.callDocprocess()
    }
    
    @IBAction func action_certificate_upload(_ sender: Any) {
        self.img_for = "Certi"
         self.callDocprocess()
    }
    
    @IBAction func action_add_servicename(_ sender: Any) {
        if self.textfield_servicename.text != "" {
            self.added_service.append(self.textfield_servicename.text!)
        }else{
             self.alert(Message: "Please enter the service")
        }
        self.coll_selservice.reloadData()
        self.textfield_servicename.text = ""
    }
    
    
    @IBAction func action_add_spec(_ sender: Any) {
        if self.textfield_spec.text != "" {
                   self.added_spec.append(self.textfield_spec.text!)
        }else {
            self.alert(Message: "Please enter the specialization")
        }
         self.coll_selspec.reloadData()
         self.textfield_spec.text = ""
    }
    
    
    
    @IBAction func action_submit(_ sender: Any) {
        Servicefile.shared.speclistdicarray.removeAll()
        Servicefile.shared.servicelistdicarray.removeAll()
        for itm in 0..<self.selservice.count {
            if self.selservice[itm] == "1" {
                var ser = Servicefile.shared.servicelistdicarray
                       var serarr = ser
                       let a = ["bus_service_list": Servicefile.shared.servicelist[itm]] as NSDictionary
                       serarr.append(a)
                       ser = serarr
                       print(ser)
                       Servicefile.shared.servicelistdicarray = ser
                      
            }
        }
        for itm in 0..<self.added_service.count {
                var ser = Servicefile.shared.servicelistdicarray
                       var serarr = ser
                let a = ["bus_service_list": self.added_service[itm]] as NSDictionary
                       serarr.append(a)
                       ser = serarr
                       print(ser)
                       Servicefile.shared.servicelistdicarray = ser
                      // print("uploaded data in servicelistdicarray",Servicefile.shared.servicelistdicarray)
        }
        for itm in 0..<self.selspec.count {
            if self.selspec[itm] == "1" {
                var spec = Servicefile.shared.speclistdicarray
                var arr = spec
                let ar = ["bus_spec_list": Servicefile.shared.speclist[itm]] as NSDictionary
                arr.append(ar)
                spec = arr
                print(spec)
                Servicefile.shared.speclistdicarray = spec
            }
        }
        
        for itm in 0..<self.added_spec.count {
                       var spec = Servicefile.shared.speclistdicarray
                       var arr = spec
                       let ar = ["bus_spec_list": added_spec[itm]] as NSDictionary
                       arr.append(ar)
                       spec = arr
                       print(spec)
                       Servicefile.shared.speclistdicarray = spec
                       //print("uploaded data in speclistdicarray",Servicefile.shared.speclistdicarray)
               }
        
        if self.textfield_Bus_name.text == "" {
            self.alert(Message: "Please enter the business name")
        }else if Servicefile.shared.servicelistdicarray.count == 0 {
            self.alert(Message: "Please select service")
        }else if Servicefile.shared.speclistdicarray.count == 0 {
              self.alert(Message: "Please select Specialization")
        }else if Servicefile.shared.gallerydicarray.count == 0 {
             self.alert(Message: "Please upload the Gallary image")
        }else if self.image_photo == "" {
             self.alert(Message: "Please upload the Photo ID")
        }else if self.image_govid == "" {
             self.alert(Message: "Please upload the Goverment Id")
        }else if Servicefile.shared.certifdicarray.count == 0 {
             self.alert(Message: "Please upload the certificates")
        }else{
            self.callDocspec()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if coll_galary_img ==  collectionView {
             return Servicefile.shared.gallerydicarray.count
        }else if coll_certificate == collectionView {
           return Servicefile.shared.certifdicarray.count
        }else if coll_speclist == collectionView{
            return Servicefile.shared.speclist.count
        }else if coll_service == collectionView{
            return Servicefile.shared.servicelist.count
        }else if coll_selservice == collectionView{
           return self.added_service.count
        }else{
            return self.added_spec.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if coll_galary_img == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galary", for: indexPath) as! imgidCollectionViewCell
            
            let imgdat = Servicefile.shared.gallerydicarray[indexPath.row] as! NSDictionary
                       print("clinic data in", imgdat)
                       cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: (imgdat["bus_service_gall"] as! String))) { (image, error, cache, urls) in
                                      if (error != nil) {
                                          cell.Img_id.image = UIImage(named: "sample")
                                      } else {
                                          cell.Img_id.image = image
                                      }
                                  }
            cell.Img_id.layer.cornerRadius = 10.0
            return cell
        }else if coll_certificate == collectionView{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "certifi", for: indexPath) as! imgidCollectionViewCell
            
             cell.Img_id.image = UIImage(named: "sample")
                return cell
        }else if coll_service == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "service", for: indexPath) as! checkupCollectionViewCell
            cell.title.text = Servicefile.shared.servicelist[indexPath.row]
            
            if self.selservice[indexPath.row] != "0" {
                cell.img_check.image = UIImage(named: " checkbox-1")
            } else{
                cell.img_check.image = UIImage(named: " checkbox")
            }
            return cell
        }  else if coll_speclist == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spec", for: indexPath) as! checkupCollectionViewCell
            cell.title.text = Servicefile.shared.speclist[indexPath.row]
             
            if self.selspec[indexPath.row] != "0" {
                           cell.img_check.image = UIImage(named: " checkbox-1")
                                  } else{
                                      cell.img_check.image = UIImage(named: " checkbox")
                                  }
                      return cell
        } else if coll_selservice == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "servcell", for: indexPath) as! selectedCollectionViewCell
            cell.label_title.text = self.added_service[indexPath.row]
            cell.btn_close.tag = indexPath.row
            cell.btn_close.addTarget(self, action: #selector(sel_serli), for: .touchUpInside)
                                return cell
        } else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "speccell", for: indexPath) as! selectedCollectionViewCell
            cell.label_title.text = self.added_spec[indexPath.row]
            cell.btn_close.tag = indexPath.row
            cell.btn_close.addTarget(self, action: #selector(sel_spec), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func sel_serli(sender: UIButton){
        let tag = sender.tag
        self.added_service.remove(at: tag)
        self.coll_selservice.reloadData()
        
    }
    
    @objc func sel_spec(sender: UIButton){
        let tag = sender.tag
        self.added_service.remove(at: tag)
         self.coll_selspec.reloadData()
        
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if coll_service == collectionView {
            self.selservice.append("0")
            if self.selservice[indexPath.row] == "1" {
                self.selservice.remove(at: indexPath.row)
                self.selservice.insert("0", at: indexPath.row)
            }else{
                self.selservice.remove(at: indexPath.row)
                self.selservice.insert("1", at: indexPath.row)
            }
        }else if coll_speclist == collectionView {
            
            if self.selspec[indexPath.row] == "1" {
                self.selspec.remove(at: indexPath.row)
                self.selspec.insert("0", at: indexPath.row)
            }else{
                self.selspec.remove(at: indexPath.row)
                self.selspec.insert("1", at: indexPath.row)
            }
        }
        self.coll_speclist.reloadData()
        self.coll_service.reloadData()
    }
    
    func setimag(){
        if self.image_photo != "" {
             self.image_photo_id.isHidden = false
              self.image_photo_id.image = UIImage(named: "sample")
        }else{
             self.image_photo_id.isHidden = true
        }
        
        if self.image_govid != "" {
             self.image_gov.isHidden = false
             self.image_gov.image = UIImage(named: "sample")
               }else{
                    self.image_gov.isHidden = true
               }
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
    
    func callgalaryprocess(){
        let alert = UIAlertController(title: "Profile", message: "Choose the process", preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default, handler: { action in
                  self.imagepicker.allowsEditing = false
                 self.imagepicker.sourceType = .camera
                  self.present(self.imagepicker, animated: true, completion: nil)
              }))
              alert.addAction(UIAlertAction(title: "Pick from Gallary", style: UIAlertAction.Style.default, handler: { action in
                 self.imagepicker.allowsEditing = false
                 self.imagepicker.sourceType = .photoLibrary
                  self.present(self.imagepicker, animated: true, completion: nil)
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
          print("import result : \(myURL)","name of file ",filename)
      }


      public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
          documentPicker.delegate = self
          documentPicker.present(documentPicker, animated: true, completion: nil)
      }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
              if let pickedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                  let reimage = Toucan(image: pickedImg).resize(CGSize(width: 100, height: 100), fitMode: Toucan.Resize.FitMode.crop).image
               self.upload(imagedata: reimage!)
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
                           let Data = res["Data"] as! String
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
                              let Data = res["Data"] as! String
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
    func alert(Message: String){
                let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                     }))
                self.present(alert, animated: true, completion: nil)
            }
    
    func callDocspec(){
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.sp_register, method: .post, parameters:
        ["user_id": Servicefile.shared.userid,
         "bus_user_name": Servicefile.shared.first_name,
         "bus_user_email": Servicefile.shared.user_email,
         "profile_status": true,
         "profile_verification_status":"Not verified",
         "bussiness_name":self.textfield_Bus_name.text!,
         "bus_user_phone": Servicefile.shared.user_phone,
         "bus_service_list": Servicefile.shared.servicelistdicarray,
         "bus_spec_list": Servicefile.shared.speclistdicarray,
         "bus_service_gall": Servicefile.shared.gallerydicarray,
         "bus_profile": self.image_photo,
         "bus_proof": self.image_govid,
         "bus_certif": Servicefile.shared.certifdicarray,
         "date_and_time": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
         "mobile_type" : "IOS"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    let Data = res["Data"] as! NSDictionary
                                                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_dash_ViewController") as! Sp_dash_ViewController
                                                    self.present(vc, animated: true, completion: nil)
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
    
    func callSP_Ser_Spec_get(){
              self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() {
        AF.request(Servicefile.sp_dropdown, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
        switch (response.result) {
        case .success:
            let resp = response.value as! NSDictionary
            print("display data",resp)
            let Code  = resp["Code"] as! Int
            if Code == 200 {
                let Data = resp["Data"] as! NSDictionary
                let service_list = Data["service_list"] as! NSArray
                let Specialization = Data["Specialization"] as! NSArray
                self.selservice.removeAll()
                 self.selspec.removeAll()
                Servicefile.shared.servicelist.removeAll()
                for itm in 0..<service_list.count{
                    let ditm = service_list[itm] as! NSDictionary
                    let listitm = ditm["service_list"] as! String
                    Servicefile.shared.servicelist.append(listitm)
                    self.selservice.append("0")
                }
                Servicefile.shared.speclist.removeAll()
                for itm in 0..<Specialization.count{
                    let ditm = Specialization[itm] as! NSDictionary
                    let listitm = ditm["Specialization"] as! String
                    Servicefile.shared.speclist.append(listitm)
                     self.selspec.append("0")
                }
                self.coll_speclist.reloadData()
                self.coll_service.reloadData()
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
        }        }
    }else{
                  self.stopAnimatingActivityIndicator()
                  self.alert(Message: "No Intenet Please check and try again ")
              }
          }
    
   }
 

