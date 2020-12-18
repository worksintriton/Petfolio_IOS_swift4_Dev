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
    @IBOutlet weak var view_spec: UIView!
    @IBOutlet weak var view_submit: UIView!
    
    @IBOutlet weak var textfield_Bus_name: UITextField!
    @IBOutlet weak var textfield_servicename: UITextField!
    @IBOutlet weak var textfield_spec: UITextField!
    
    @IBOutlet weak var coll_service: UICollectionView!
    @IBOutlet weak var coll_special: UICollectionView!
    @IBOutlet weak var coll_galary_img: UICollectionView!
    @IBOutlet weak var coll_certificate: UICollectionView!
    @IBOutlet weak var image_photo_id: UIImageView!
    @IBOutlet weak var image_gov: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_protocals()
        
    }
    
    func call_protocals(){
        self.call_delegates()
        self.viewcornordadius()
    }
    
    func call_delegates(){
        self.imagepicker.delegate = self
        self.collectiondelegate()
    }
    
    func collectiondelegate(){
        
        self.coll_service.delegate = self
        self.coll_service.dataSource = self
        
        self.coll_special.delegate = self
        self.coll_special.dataSource = self
        
        self.coll_galary_img.delegate = self
        self.coll_galary_img.dataSource = self
        
        self.coll_certificate.delegate = self
        self.coll_certificate.dataSource = self
    }
    
    func viewcornordadius(){
        self.view_submit.submit_cornor()
        self.view_spec.view_cornor()
        self.view_Service_Btn_add.view_cornor()
        self.view_spec.view_cornor()
    }
    
    @IBAction func action_gallary_pic_upload(_ sender: Any) {
        
    }
    
    @IBAction func action_photo_upload(_ sender: Any) {
        
    }
    
    @IBAction func action_gov_upload(_ sender: Any) {
        
    }
    
    @IBAction func action_certificate_upload(_ sender: Any) {
        
    }
    
    @IBAction func action_submit(_ sender: Any) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
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
                           if self.Img_uploadarea == "clinic" {
                              
                           }
                           
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
                             print("Uploaded file url:",Data)
                           
                           if self.Img_uploadarea == "certif" {
                               var B = Servicefile.shared.certifdicarray
                               var arr = B
                               let a = ["certificate_pic":Data] as NSDictionary
                               arr.append(a)
                               B = arr
                               print(B)
                               Servicefile.shared.certifdicarray = B
                               print("uploaded data in certifi",Servicefile.shared.certifdicarray)
                           }
                           if self.Img_uploadarea == "gov" {
                               var B = Servicefile.shared.govdicarray
                               var arr = B
                               let a = ["govt_id_pic":Data] as NSDictionary
                               arr.append(a)
                               B = arr
                               print(B)
                               Servicefile.shared.govdicarray = B
                               print("uploaded data in govt_id_pic",Servicefile.shared.govdicarray)
                           }
                           if self.Img_uploadarea == "photo" {
                               var B = Servicefile.shared.photodicarray
                               var arr = B
                               let a = ["photo_id_pic":Data] as NSDictionary
                               arr.append(a)
                               B = arr
                               print(B)
                               Servicefile.shared.photodicarray = B
                               print("uploaded data in photodicarray",Servicefile.shared.photodicarray)
                           }
                           
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
    
   }
 
