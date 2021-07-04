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

class peteditandadduploadimgViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var imag_petimag: UIImageView!
    @IBOutlet weak var view_continue: UIView!
     let imagepicker = UIImagePickerController()
    
    @IBOutlet weak var coll_img_list: UICollectionView!
    var uploadimage = Servicefile.sample_img
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_continue.view_cornor()
        self.coll_img_list.delegate = self
        self.coll_img_list.dataSource = self
        self.imagepicker.delegate = self
        self.imag_petimag.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
         
        self.checkimagecontent(intval: Servicefile.shared.pet_index)
        
    }
    
    func checkimagecontent(intval : Int){
        Servicefile.shared.petlistimg = Servicefile.shared.pet_petlist
        print("data in edit pet image",Servicefile.shared.petlistimg)
        let petimage = Servicefile.shared.petlistimg
            if petimage.count > 0 {
                let petdic = petimage[intval] as! NSDictionary
                let petimg =  petdic["pet_img"] as? String ?? Servicefile.sample_img
                if petimg == "" {
                    self.setimage(strimg: petimg)
            }else{
                    self.setimage(strimg: petimg)
            }
        }else{
            Servicefile.shared.petlistimg = [Any]()
               self.imag_petimag.image = UIImage(named: "sample")
        }
        self.imag_petimag.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return Servicefile.shared.petlistimg.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as!  imgidCollectionViewCell
          let petimg = Servicefile.shared.petlistimg[indexPath.row] as! NSDictionary
          let imgstr = petimg["pet_img"] as? String ?? Servicefile.sample_img
          cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: imgstr)) { (image, error, cache, urls) in
              if (error != nil) {
                  cell.Img_id.image = UIImage(named: "sample")
              } else {
                  cell.Img_id.image = image
              }
          }
        cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.view_close.layer.cornerRadius = cell.view_close.frame.height /  2
          cell.btn_close.tag = indexPath.row
          cell.btn_close.addTarget(self, action: #selector(action_buttonclose), for: .touchUpInside)
          return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.checkimagecontent(intval: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 120 , height:  120)
    }
      
      @objc func action_buttonclose(sender : UIButton) {
          let tag = sender.tag
          Servicefile.shared.petlistimg.remove(at: tag)
          self.coll_img_list.reloadData()
        self.checkimagecontent(intval: Servicefile.shared.petlistimg.count-1)
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
                  //let reimage = Toucan(image: pickedImg).resize(CGSize(width: 100, height: 100), fitMode: Toucan.Resize.FitMode.crop).image
               self.upload(imagedata: pickedImg)
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
                          self.uploadimage = Data
                        var B = Servicefile.shared.petlistimg
                        var arr = B
                        let a = ["pet_img":Data] as NSDictionary
                        arr.append(a)
                        B = arr
                        print(B)
                        Servicefile.shared.petlistimg = B
                        self.coll_img_list.reloadData()
                        self.checkimagecontent(intval: Servicefile.shared.petlistimg.count-1)
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func calluploadimg(){
           self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_updateimage, method: .post, parameters:
        ["_id": Servicefile.shared.petid ,
         "pet_img": Servicefile.shared.petlistimg], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
      

}
