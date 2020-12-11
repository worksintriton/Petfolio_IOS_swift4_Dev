//
//  peteditandadduploadimgViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 10/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Toucan
import MobileCoreServices
import Alamofire
import SDWebImage

class peteditandadduploadimgViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imag_petimag: UIImageView!
    @IBOutlet weak var view_continue: UIView!
     let imagepicker = UIImagePickerController()
    var uploadimage = "http://mysalveo.com/api/uploads/images.jpeg"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagepicker.delegate = self
        self.setimage(strimg: self.uploadimage)
        // Do any additional setup after loading the view.
    }
    
    func setimage(strimg : String){
        self.imag_petimag.sd_setImage(with: Servicefile.shared.StrToURL(url: strimg)) { (image, error, cache, urls) in
            if (error != nil) {
                self.imag_petimag.image = UIImage(named: "sample")
            } else {
                self.imag_petimag.image = image
            }
        }
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
                          self.uploadimage = Data
                         self.setimage(strimg: self.uploadimage)
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
       
    
    @IBAction func action_imagupload(_ sender: Any) {
        self.callgalaryprocess()
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
    
    
    @IBAction func action_continue(_ sender: Any) {
        self.calluploadimg()
    }
    
    @IBAction func action_skip(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func calluploadimg(){
           self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_updateimage, method: .post, parameters:
        ["_id": Servicefile.shared.petid ,
         "pet_img": self.uploadimage], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                               switch (response.result) {
                                               case .success:
                                                     let res = response.value as! NSDictionary
                                                     print("success data",res)
                                                     let Code  = res["Code"] as! Int
                                                     if Code == 200 {
                                                       let Data = res["Data"] as! NSDictionary
                                                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
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
       func alert(Message: String){
           let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
           self.present(alert, animated: true, completion: nil)
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
