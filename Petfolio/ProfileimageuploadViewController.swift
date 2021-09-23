//
//  ProfileimageuploadViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 02/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import SDWebImage
import ImageCropper

class ProfileimageuploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagepicker = UIImagePickerController()
    var imageval = ""
    
    @IBOutlet weak var view_continue: UIView!
    @IBOutlet weak var image_profile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.view_continue.view_cornor()
        self.imagepicker.delegate = self
        self.setimage(strimg: Servicefile.shared.userimage)
        self.image_profile.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.image_profile.dropShadow()
    }
    
    func setimage(strimg : String) {
        if strimg == "" {
            self.image_profile.image = UIImage(named: imagelink.sample)
        }else{
            self.image_profile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            self.image_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: strimg)) { (image, error, cache, urls) in
                if (error != nil) {
                    self.image_profile.image = UIImage(named: imagelink.sample)
                } else {
                    self.image_profile.image = image
                }
            }
        }
        self.image_profile.contentMode = .scaleAspectFill
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if Servicefile.shared.user_type == "1"{
            if let firstVC = presentingViewController as? petprofileViewController {
                DispatchQueue.main.async {
                    firstVC.viewWillAppear(true)
                }
            }
        }else if Servicefile.shared.user_type == "4"{
            if let firstVC = presentingViewController as? Doc_profiledetails_ViewController {
                DispatchQueue.main.async {
                    firstVC.viewWillAppear(true)
                }
            }
        }else if Servicefile.shared.user_type == "2"{
            if let firstVC = presentingViewController as? Sp_profile_ViewController {
                DispatchQueue.main.async {
                    firstVC.viewWillAppear(true)
                }
            }
        }
        
    }
    
    
    @IBAction func action_uploadimage(_ sender: Any) {
        self.callupdateimage()
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_gallary_pic_upload(_ sender: Any) {
        self.callgalaryprocess()
    }
    
    func callgalaryprocess(){
        let alert = UIAlertController(title: "Profile", message: "Choose the process", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default, handler: { action in
            self.imagepicker.allowsEditing = true
            self.imagepicker.sourceType = .camera
            self.present(self.imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Pick from Gallery", style: UIAlertAction.Style.default, handler: { action in
            self.imagepicker.allowsEditing = true
            self.imagepicker.sourceType = .photoLibrary
            self.present(self.imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { action in
            print("ok")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //let reimage = Toucan(image: pickedImg).resize(CGSize(width: 800, height: 300), fitMode: Toucan.Resize.FitMode.crop).image
            let convertimg = pickedImg.resized(withPercentage: CGFloat(Servicefile.shared.imagequantity))
            let data = pickedImg.jpegData(compressionQuality: 0.9)
            let size = Servicefile.shared.converttosize(size: 2)
            print("Image size",data!.count,"size value",size)
            if data!.count > size {
                self.alert(Message: "Please Select the image Less that 2MB")
            }else{
                self.upload(imagedata: convertimg!)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func upload(imagedata: UIImage) {
        self.startAnimatingActivityIndicator()
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
                        self.imageval = Data
                        self.image_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: self.imageval)) { (image, error, cache, urls) in
                            if (error != nil) {
                                self.image_profile.image = UIImage(named: imagelink.sample)
                            } else {
                                self.image_profile.image = image
                            }
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
    
    func callupdateimage(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.updateprofileimage, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid,
             "profile_img" : self.imageval], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("Email success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.userimage = self.imageval
                        UserDefaults.standard.set(Servicefile.shared.userimage, forKey: "user_image")
                        self.dismiss(animated: true, completion: nil)
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
        } else {
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
  
}
