//
//  searchpetloverappointmentViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 15/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import MobileCoreServices
import SDWebImage

class searchpetloverappointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var textfield_selectpettype: UITextField!
    @IBOutlet weak var textfield_petname: UITextField!
    @IBOutlet weak var radio_emergency: UIImageView!
    @IBOutlet weak var radio_normal: UIImageView!
    @IBOutlet weak var textview_descrip: UITextView!
    @IBOutlet weak var view_change: UIView!
    @IBOutlet weak var textfield_petbreed: UITextField!
    @IBOutlet weak var textfield_pettype: UITextField!
    @IBOutlet weak var textfield_alergies: UITextField!
    @IBOutlet weak var view_pickupload: UIView!
    
    
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
    var Pet_breed = [""]
      var pet_type = [""]
      var petid = [""]
     let imagepicker = UIImagePickerController()
    var petimage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.pet_apoint_doc_attched.removeAll()
        self.imagepicker.delegate = self
        self.tblview_petdetail.delegate = self
        self.tblview_petdetail.dataSource = self
        self.tblview_pettype.delegate = self
        self.tblview_pettype.dataSource = self
        self.tblview_petbreed.delegate = self
        self.tblview_petbreed.dataSource = self
        self.view_change.layer.cornerRadius = 15.0
        self.view_change.dropShadow()
        self.view_selectpet.layer.cornerRadius = 9.0
        self.view_pattype.layer.cornerRadius = 9.0
        self.view_petname.layer.cornerRadius = 9.0
        self.view_petbreed.layer.cornerRadius = 9.0
        self.view_petalergy.layer.cornerRadius = 9.0
        self.view_discription.layer.cornerRadius = 9.0
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = true
        self.tblview_petdetail.isHidden = true
        self.textfield_alergies.delegate = self
        self.callpetdetailget()
        self.radio_emergency.image = UIImage(named: "Radio")
        self.radio_normal.image = UIImage(named: "selectedRadio")
        Servicefile.shared.pet_apoint_appointment_types = "Normal"
        self.textfield_petname.delegate = self
        self.textview_descrip.delegate = self
        self.textfield_pettype.delegate = self
        self.textfield_petbreed.delegate = self
        self.textfield_selectpettype.delegate = self
        self.textview_descrip.delegate = self
         
        self.textview_descrip.text = "Add comment here.."
        self.textview_descrip.textColor == UIColor.lightGray
        self.petimage = Servicefile.shared.sampleimag
        self.setuploadimg()
    }
    
   @IBAction func action_sos(_ sender: Any) {
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
             self.present(vc, animated: true, completion: nil)
         }
   
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     if self.textview_descrip.text!.count > 252 {
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
        self.textfield_alergies.resignFirstResponder()
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
                   self.image_petcurrent.layer.cornerRadius = 15.0
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
            
                   return cell
        } else if self.tblview_pettype == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ptype", for: indexPath)
            cell.textLabel?.text = self.pet_type[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Pbreed", for: indexPath)
            cell.textLabel?.text = self.Pet_breed[indexPath.row]
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
            self.textfield_selectpettype.text! = Servicefile.shared.pet_petlist[index].pet_name
                   self.textfield_petname.text = Servicefile.shared.pet_petlist[index].pet_name
                   self.textfield_pettype.text = Servicefile.shared.pet_petlist[index].pet_type
                    self.textfield_petbreed.text = Servicefile.shared.pet_petlist[index].pet_breed
                   self.textfield_petname.isUserInteractionEnabled = false
            self.petimage = Servicefile.shared.pet_petlist[index].pet_img
            self.view_pickupload.isHidden = true
        }else{
           self.view_pickupload.isHidden = false
            self.textfield_selectpettype.text! = ""
                   self.textfield_petname.text = ""
                   self.textfield_pettype.text = ""
                    self.textfield_petbreed.text = ""
                   self.textfield_petname.isUserInteractionEnabled = true
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
    
    @IBAction func action_emergency(_ sender: Any) {
        self.radio_emergency.image = UIImage(named: "selectedRadio")
        self.radio_normal.image = UIImage(named: "Radio")
        Servicefile.shared.pet_apoint_appointment_types = "Emergency"
    }
    
    @IBAction func action_normal(_ sender: Any) {
         self.radio_emergency.image = UIImage(named: "Radio")
        self.radio_normal.image = UIImage(named: "selectedRadio")
        Servicefile.shared.pet_apoint_appointment_types = "Normal"
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
                        let Data = res["Data"] as! String
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
                       let Message  = res["Message"] as! String
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
        }else if self.textfield_alergies.text == "" {
             self.alert(Message: "please enter the allergy")
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
            
            Servicefile.shared.pet_apoint_doctor_id = Servicefile.shared.petdoc[Servicefile.shared.selectedindex]._id
            Servicefile.shared.pet_apoint_booking_date = Servicefile.shared.ddMMyyyystringformat(date: Date())
            Servicefile.shared.pet_apoint_booking_time = Servicefile.shared.hhmmastringformat(date: Date())
            Servicefile.shared.pet_apoint_booking_date_time = Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date())
            Servicefile.shared.pet_apoint_communication_type = ""
            Servicefile.shared.pet_apoint_video_id = ""
            Servicefile.shared.pet_apoint_user_id = ""
            Servicefile.shared.pet_apoint_problem_info = self.textview_descrip.text!
            Servicefile.shared.pet_apoint_doc_feedback = ""
            Servicefile.shared.pet_apoint_doc_rate = ""
            Servicefile.shared.pet_apoint_user_feedback = ""
            Servicefile.shared.pet_apoint_user_rate = ""
            Servicefile.shared.pet_apoint_display_date = ""
            Servicefile.shared.pet_apoint_server_date_time = ""
            Servicefile.shared.pet_apoint_payment_id = ""
            Servicefile.shared.pet_apoint_payment_method = ""
            Servicefile.shared.pet_apoint_appointment_types = Servicefile.shared.pet_apoint_appointment_types
            Servicefile.shared.pet_apoint_allergies = self.textfield_alergies.text!
            Servicefile.shared.pet_apoint_amount = ""
            
            if self.textfield_selectpettype.text != ""{
                print("old pet ",Servicefile.shared.pet_apoint_pet_id)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "petdoccalenderViewController") as! petdoccalenderViewController
                self.present(vc, animated: true, completion: nil)
            }else{
                self.calladdpetdetails()
            }
        }
    }
    
    func calladdpetdetails(){
           self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petregister, method: .post, parameters:
           ["user_id" : Servicefile.shared.userid,
            "pet_img" : self.petimage,
           "pet_name" : self.textfield_petname.text!,
           "pet_type" : self.textfield_pettype.text!,
           "pet_breed" : self.textfield_petbreed.text!,
           "pet_gender" : "",
           "pet_color" : "",
           "pet_weight" : "0",
           "pet_age" : "0",
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
                                                        let id = Data["_id"] as! String
                                                        Servicefile.shared.pet_apoint_pet_id = id
                                                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "petdoccalenderViewController") as! petdoccalenderViewController
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
                      let pbv = pb["pet_type_title"] as! String
                      self.pet_type.append(pbv)
                  }
               for item in 0..<Pet_type.count{
                   let pb = Pet_type[item] as! NSDictionary
                      let pbv = pb["_id"] as! String
                      self.petid.append(pbv)
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
                                                                      let pbv = pb["pet_breed"] as! String
                                                                      self.Pet_breed.append(pbv)
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

}