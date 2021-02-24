//
//  pet_sp_CreateApp_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import MobileCoreServices
import SDWebImage
import Razorpay
import SafariServices
import WebKit

class pet_sp_CreateApp_ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate , RazorpayPaymentCompletionProtocol, RazorpayPaymentCompletionProtocolWithData {

    @IBOutlet weak var textfield_selectpettype: UITextField!
    @IBOutlet weak var textfield_petname: UITextField!
    @IBOutlet weak var textview_descrip: UITextView!
    @IBOutlet weak var view_change: UIView!
    @IBOutlet weak var textfield_petbreed: UITextField!
    @IBOutlet weak var textfield_pettype: UITextField!
    @IBOutlet weak var textfield_petage: UITextField!
    
    @IBOutlet weak var view_pickupload: UIView!
    @IBOutlet weak var textfield_weight: UITextField!
    @IBOutlet weak var textfield_color: UITextField!
    
    
    @IBOutlet weak var image_petcurrent: UIImageView!
    @IBOutlet weak var view_discription: UIView!
    @IBOutlet weak var view_choose: UIView!
    @IBOutlet weak var view_petalergy: UIView!
    @IBOutlet weak var view_petbreed: UIView!
    @IBOutlet weak var view_pattype: UIView!
    @IBOutlet weak var view_petname: UIView!
    @IBOutlet weak var view_selectpet: UIView!
    
    @IBOutlet weak var tblview_petdetail: UITableView!
    @IBOutlet weak var tblview_pettype: UITableView!
    @IBOutlet weak var tblview_petbreed: UITableView!
    
    @IBOutlet weak var View_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_btn: UIView!
    
    @IBOutlet weak var label_service_title: UITextField!
    
    
    var Pet_breed = [""]
    var pet_type = [""]
    var petid = [""]
    let imagepicker = UIImagePickerController()
    var petimage = ""
    
    var razorpay: RazorpayCheckout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.View_shadow.isHidden = true
        self.view_popup.isHidden = true
         self.view_popup.view_cornor()
        self.view_btn.view_cornor()
        Servicefile.shared.pet_apoint_doc_attched.removeAll()
        self.imagepicker.delegate = self
        self.tblview_petdetail.delegate = self
        self.tblview_petdetail.dataSource = self
        self.tblview_pettype.delegate = self
        self.tblview_pettype.dataSource = self
        self.tblview_petbreed.delegate = self
        self.tblview_petbreed.dataSource = self
        self.view_change.view_cornor()
        self.view_change.dropShadow()
        self.view_selectpet.view_cornor()
        self.view_pattype.view_cornor()
        self.view_petname.view_cornor()
        self.view_petbreed.view_cornor()
        self.view_petalergy.view_cornor()
        self.view_discription.view_cornor()
        
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = true
        self.tblview_petdetail.isHidden = true
        let apgreen = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.tblview_petbreed.layer.borderColor = apgreen.cgColor
        self.tblview_pettype.layer.borderColor = apgreen.cgColor
        self.tblview_petdetail.layer.borderColor = apgreen.cgColor
        self.tblview_petbreed.layer.borderWidth = 0.2
        self.tblview_pettype.layer.borderWidth = 0.2
        self.tblview_petdetail.layer.borderWidth = 0.2
        
        self.tblview_petbreed.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.tblview_pettype.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.tblview_petdetail.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        
        self.callpetdetailget()
        self.textfield_color.delegate = self
        self.textfield_weight.delegate = self
        self.textfield_petage.delegate = self
        self.textfield_petname.delegate = self
        self.textview_descrip.delegate = self
        self.textfield_pettype.delegate = self
        self.textfield_petbreed.delegate = self
        self.textfield_selectpettype.delegate = self
        self.textview_descrip.delegate = self
        self.textview_descrip.text = "Add comment here.."
        self.textview_descrip.textColor == UIColor.lightGray
        self.label_service_title.text = Servicefile.shared.service_id_title
        self.petimage = Servicefile.shared.sampleimag
        self.setuploadimg()
    }
    
   @IBAction func action_sos(_ sender: Any) {
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
             self.present(vc, animated: true, completion: nil)
         }
   
    @IBAction func action_afterappBooked(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_applist_ViewController") as! Pet_applist_ViewController
           self.present(vc, animated: true, completion: nil)
       }
       
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     if self.textview_descrip.text!.count > 149 {
        self.textview_descrip.resignFirstResponder()
               }else{
                   self.textview_descrip.text = textView.text
        
               }
        if(text == "\n") {
                   textview_descrip.resignFirstResponder()
                   return false
               }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_petname.resignFirstResponder()
        self.textfield_color.resignFirstResponder()
        self.textfield_petage.resignFirstResponder()
        self.textfield_weight.resignFirstResponder()
        return true
    }
    
    func textViewShouldReturn(_ textField: UITextField) -> Bool {
        self.textview_descrip.resignFirstResponder()
        return true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func setuploadimg(){
        if self.petimage == "" {
            self.image_petcurrent.image = UIImage(named: "sample")
        }else{
            self.image_petcurrent.sd_setImage(with: Servicefile.shared.StrToURL(url: petimage)) { (image, error, cache, urls) in
                       if (error != nil) {
                           self.image_petcurrent.image = UIImage(named: "sample")
                       } else {
                           self.image_petcurrent.image = image
                       }
                   }
                   self.image_petcurrent.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        }
       
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tblview_petdetail == tableView{
            return Servicefile.shared.pet_petlist.count + 1
        } else if self.tblview_pettype == tableView {
            return self.pet_type.count
        }else  {
            return self.Pet_breed.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.tblview_petdetail == tableView {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "petlistcell", for: indexPath)
            if Servicefile.shared.pet_petlist.count != indexPath.row{
                cell.textLabel?.text = Servicefile.shared.pet_petlist[indexPath.row].pet_name
                Servicefile.shared.pet_apoint_pet_id = Servicefile.shared.pet_petlist[indexPath.row].id
            }else{
                  cell.textLabel?.text = "Select pet name"
            }
            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                   return cell
        } else if self.tblview_pettype == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ptype", for: indexPath)
            cell.textLabel?.text = self.pet_type[indexPath.row]
            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Pbreed", for: indexPath)
            cell.textLabel?.text = self.Pet_breed[indexPath.row]
            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            return cell
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = true
         self.tblview_petdetail.isHidden = true
        if self.tblview_petdetail ==  tableView {
            self.ispetnameselect(index: indexPath.row)
        }
        else if self.tblview_petbreed ==  tableView {
            self.textfield_petbreed.text! = self.Pet_breed[indexPath.row]
        } else {
             self.textfield_pettype.text! = self.pet_type[indexPath.row]
            self.callpetbreedbyid(petid: self.petid[indexPath.row])
        }
    }
    
    func ispetnameselect(index: Int){
        print(Servicefile.shared.pet_petlist.count,index)
        if Servicefile.shared.pet_petlist.count != index {
            Servicefile.shared.pet_apoint_pet_id = Servicefile.shared.pet_petlist[index].id
            self.textfield_selectpettype.text! = Servicefile.shared.pet_petlist[index].pet_name
            self.textfield_petname.text = Servicefile.shared.pet_petlist[index].pet_name
            self.textfield_pettype.text = Servicefile.shared.pet_petlist[index].pet_type
            self.textfield_petbreed.text = Servicefile.shared.pet_petlist[index].pet_breed
            self.textfield_petage.text = String(Servicefile.shared.pet_petlist[index].pet_age)
            self.textfield_weight.text = String(Servicefile.shared.pet_petlist[index].pet_weight)
            self.textfield_color.text = String(Servicefile.shared.pet_petlist[index].pet_color)
            self.textfield_petname.isUserInteractionEnabled = false
            self.textfield_petage.isUserInteractionEnabled = false
            self.textfield_weight.isUserInteractionEnabled = false
            self.textfield_color.isUserInteractionEnabled = false
            self.petimage = Servicefile.shared.pet_petlist[index].pet_img
            self.view_pickupload.isHidden = true
        }else{
            self.view_pickupload.isHidden = false
            self.textfield_selectpettype.text! = ""
            self.textfield_petname.text = ""
            self.textfield_pettype.text = ""
            self.textfield_petbreed.text = ""
            self.textfield_petage.text = ""
            self.textfield_weight.text = ""
            self.textfield_color.text = ""
            self.textfield_petname.isUserInteractionEnabled = true
            self.textfield_petage.isUserInteractionEnabled = true
            self.textfield_weight.isUserInteractionEnabled = true
            self.textfield_color.isUserInteractionEnabled = true
            self.petimage = ""
        }
        self.setuploadimg()
    }
    
    @IBAction func action_change(_ sender: Any) {
        self.checkappointdetails()
    }
    
    
    @IBAction func action_selectpet(_ sender: Any) {
        self.tblview_petdetail.isHidden = false
               self.tblview_petbreed.isHidden = true
               self.tblview_pettype.isHidden = true
               print("hide the data in pet details")
    }
    
   
    
    @IBAction func action_droppettype(_ sender: Any) {
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = false
        self.tblview_petdetail.isHidden = true
        
    }
    
    @IBAction func action_droppetbreed(_ sender: Any) {
        self.tblview_petbreed.isHidden = false
        self.tblview_pettype.isHidden = true
        self.tblview_petdetail.isHidden = true
    }
    
    
    
    @IBAction func action_addimage(_ sender: Any) {
        if Servicefile.shared.Pet_Appointment_petimg.count < 1 {
                    self.callgalaryprocess()
               }else{
                   self.alert(Message: "You can upload 3 File")
               }
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
                        let Data = res["Data"] as? String ?? ""
                       print("Uploaded file url:",Data)
                        Servicefile.shared.pet_apoint_doc_attched.removeAll()
                        var B = Servicefile.shared.pet_apoint_doc_attched
                            var arr = B
                            let a = ["file":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                             print(B)
                             Servicefile.shared.pet_apoint_doc_attched = B
                            print("uploaded data in clinic",Servicefile.shared.pet_apoint_doc_attched)
                        self.petimage = Data
                        self.setuploadimg()
                        self.stopAnimatingActivityIndicator()
                    }else{
                        self.stopAnimatingActivityIndicator()
                       let Message  = res["Message"] as? String ?? ""
                        self.alert(Message: Message)
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
    
    func checkappointdetails(){
        if self.textfield_petname.text == "" {
            self.alert(Message: "please enter the petname")
        }else if self.textfield_pettype.text == "" {
             self.alert(Message: "please select the pet type")
        }else if self.textfield_petbreed.text == "" {
             self.alert(Message: "please select the pet breed")
        }else if self.textfield_petage.text == "" {
             self.alert(Message: "please enter the pet age")
        }else if self.textfield_color.text == "" {
             self.alert(Message: "please enter the pet color")
        }else if self.textfield_weight.text == "" {
             self.alert(Message: "please enter the pet weight")
        }else if self.textview_descrip.text == "" {
             self.alert(Message: "please enter the description")
        }else if self.textview_descrip.text == "Add comment here.." {
             self.alert(Message: "please enter the description")
        }else if self.petimage == ""{
             self.alert(Message: "please upload the")
        }else{
            print("details for complettion")
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy"
            let tformat = DateFormatter()
            tformat.dateFormat = "hh:mm a"
            var booking_date = format.string(from: date)
            var booking_time = tformat.string(from: date)
            Servicefile.shared.pet_apoint_problem_info = self.textview_descrip.text!
            Servicefile.shared.pet_apoint_doc_feedback = ""
            Servicefile.shared.pet_apoint_doc_rate = 0
            Servicefile.shared.pet_apoint_user_feedback = ""
            Servicefile.shared.pet_apoint_user_rate = 0.0
             let hhmmformat = Servicefile.shared.ddMMyyyyhhmmadateformat(date: Servicefile.shared.pet_apoint_booking_date + " " + Servicefile.shared.pet_apoint_booking_time)
                       let stringformat = Servicefile.shared.yyyyMMddHHmmssstringformat(date: hhmmformat)
                       Servicefile.shared.pet_apoint_display_date = stringformat
            Servicefile.shared.pet_apoint_server_date_time = ""
            Servicefile.shared.pet_apoint_payment_id = ""
            Servicefile.shared.pet_apoint_payment_method = "Online"
            Servicefile.shared.pet_apoint_appointment_types = Servicefile.shared.pet_apoint_appointment_types
            Servicefile.shared.pet_apoint_amount = Servicefile.shared.service_id_amount
            if self.textfield_selectpettype.text != ""{
                print("old pet ",Servicefile.shared.pet_apoint_pet_id)
                self.showPaymentForm()
            }else{
                self.calladdpetdetails()
            }
        }
    }
    
   func callsubmit(){
             self.startAnimatingActivityIndicator()
         if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_createappointm, method: .post, parameters:
            ["sp_id" : Servicefile.shared.sp_user_id,
             "booking_date" :  Servicefile.shared.pet_apoint_booking_date,
             "booking_time" : Servicefile.shared.pet_apoint_booking_time,
             "booking_date_time" : Servicefile.shared.pet_apoint_booking_date + " " + Servicefile.shared.pet_apoint_booking_time,
             "user_id" : Servicefile.shared.userid,
             "pet_id" : Servicefile.shared.pet_apoint_pet_id,
             "additional_info" : Servicefile.shared.pet_apoint_problem_info,
             "sp_attched" : [],
             "sp_feedback" : "",
             "sp_rate" : "",
             "user_feedback" : "",
             "user_rate" : "0",
             "display_date" : Servicefile.shared.pet_apoint_display_date,
             "server_date_time" : "",
             "payment_id" : Servicefile.shared.pet_apoint_payment_id,
             "payment_method" : "Online",
             "service_name" : Servicefile.shared.service_id_title,
             "service_amount" : Servicefile.shared.service_id_amount,
             "service_time" : Servicefile.shared.service_id_time,
             "completed_at" : "",
             "missed_at" : "",
             "mobile_type" : "IOS"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                 switch (response.result) {
                                                 case .success:
                                                       let res = response.value as! NSDictionary
                                                       print("success data",res)
                                                       let Code  = res["Code"] as! Int
                                                       if Code == 200 {
                                                          self.View_shadow.isHidden = false
                                                          self.view_popup.isHidden = false
                                                          self.stopAnimatingActivityIndicator()
                                                       }else{
                                                         self.stopAnimatingActivityIndicator()
                                                         print("status code service denied")
                                                           let Message = res["Message"] as? String ?? ""
                                                          self.alert(Message: Message)
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
      
      func calladdpetdetails(){
             self.startAnimatingActivityIndicator()
         if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petregister, method: .post, parameters:
             ["user_id" : Servicefile.shared.userid,
              "pet_img" : self.petimage,
              "pet_name" : Servicefile.shared.checktextfield(textfield: self.textfield_petname.text!) ,
             "pet_type" : Servicefile.shared.checktextfield(textfield: self.textfield_pettype.text!),
             "pet_breed" : Servicefile.shared.checktextfield(textfield: self.textfield_petbreed.text!),
             "pet_color" : self.textfield_color.text!,
             "pet_weight" : Servicefile.shared.checkInttextfield(strtoInt: self.textfield_weight.text!),
             "pet_age" : Servicefile.shared.checkInttextfield(strtoInt: self.textfield_petage.text!),
             "vaccinated" : false,
             "last_vaccination_date" : "",
             "default_status" : true,
             "date_and_time" : Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                 switch (response.result) {
                                                 case .success:
                                                       let res = response.value as! NSDictionary
                                                       print("success data",res)
                                                       let Code  = res["Code"] as! Int
                                                       if Code == 200 {
                                                         let Data = res["Data"] as! NSDictionary
                                                          let id = Data["_id"] as? String ?? ""
                                                          Servicefile.shared.pet_apoint_pet_id = id
                                                          self.showPaymentForm()
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
           let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func callpetdetailget(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.petdetailget, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let Pet_type = Data["usertypedata"] as! NSArray
                        self.pet_type.removeAll()
                        self.petid.removeAll()
                        self.Pet_breed.removeAll()
                        for item in 0..<Pet_type.count{
                            let pb = Pet_type[item] as! NSDictionary
                            let pbv = pb["pet_type_title"] as? String ?? ""
                            if pbv != "" {
                                self.pet_type.append(pbv)
                            }
                        }
                        for item in 0..<Pet_type.count{
                            let pb = Pet_type[item] as! NSDictionary
                            let pbv = pb["_id"] as? String ?? ""
                            if pbv != "" {
                            self.petid.append(pbv)
                            }
                        }
                        self.tblview_pettype.reloadData()
                        self.tblview_petbreed.reloadData()
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
    
    
    
    func callpetbreedbyid(petid: String){
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petbreedid, method: .post, parameters:
     ["pet_type_id" : petid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                     self.textfield_petbreed.text = ""
                                                     let Pet_breed = res["Data"] as! NSArray
                                                                 self.Pet_breed.removeAll()
                                                                  for item in 0..<Pet_breed.count{
                                                                      let pb = Pet_breed[item] as! NSDictionary
                                                                      let pbv = pb["pet_breed"] as? String ?? ""
                                                                    if pbv != "" {
                                                                        self.Pet_breed.append(pbv)
                                                                    }  
                                                                  }
                                                                  self.tblview_petbreed.reloadData()
                                                                   self.stopAnimatingActivityIndicator()
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
    
    func showPaymentForm(){
           if Servicefile.shared.pet_apoint_amount == 0 {
               Servicefile.shared.pet_apoint_amount = 0
           }
        let data = Double(Servicefile.shared.pet_apoint_amount) * Double(100)
           print("value changed",data)
           self.razorpay = RazorpayCheckout.initWithKey("rzp_test_zioohqmxDjJJtd", andDelegate: self)
                   let options: [String:Any] = [
                       "amount": data, //This is in currency subunits. 100 = 100 paise= INR 1.
                               "currency": "INR",//We support more that 92 international currencies.
                               "description": "some some",
                               "image": "http://52.25.163.13:3000/api/uploads/template.png",
                               "name": "sriram",
                               "prefill": [
                                   "contact": Servicefile.shared.user_phone,
                                   "email": Servicefile.shared.user_email
                               ],
                               "theme": [
                                   "color": "#F37254"
                               ]
                           ]

                   if let rzp = self.razorpay {
                             // rzp.open(options)
                       rzp.open(options,displayController:self)
                          } else {
                              print("Unable to initialize")
                          }
           }
           
           func onPaymentError(_ code: Int32, description str: String) {
                   print("Payment failed with code")
            self.callpaymentfail()
              }
              
              func onPaymentSuccess(_ payment_id: String) {
                    print("Payment Success payment")
                Servicefile.shared.pet_apoint_payment_id = payment_id
                 self.callsubmit()
              }
           
           func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
                  print("error: ", code)
                 
              }
              
              func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
                  print("success: ", payment_id)
                  
              }
    
    func moveTextField(textview: UITextView, up: Bool){
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
    
       
       
       func textViewDidBeginEditing(_ textView: UITextView) {
           if self.textview_descrip == textView  {
            if textView.text == "Add comment here.." {
                textView.text = ""
                if textView.textColor == UIColor.lightGray {
                                         textView.text = nil
                                         textView.textColor = UIColor.black
                                     }
            }
            self.moveTextField(textview: textView, up:true)
           
           }
          
       }
       
       func textViewDidEndEditing(_ textView: UITextView) {
           if self.textview_descrip == textView{
            self.moveTextField(textview: textView, up:false)
           }
       }
    
    func callpaymentfail(){
           if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_notification, method: .post, parameters:
               ["appointment_UID": "",
                "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
                "sp_id":Servicefile.shared.sp_user_id,
                "status":"Payment Failed",
                "user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                   switch (response.result) {
                   case .success:
                       let res = response.value as! NSDictionary
                       print("success data",res)
                       let Code  = res["Code"] as! Int
                       if Code == 200 {
                       }else{
                       }
                       break
                   case .failure(let Error):
                       self.stopAnimatingActivityIndicator()
                       break
                   }
               }
           }else{
               self.stopAnimatingActivityIndicator()
               self.alert(Message: "No Intenet Please check and try again ")
           }
       }

}
