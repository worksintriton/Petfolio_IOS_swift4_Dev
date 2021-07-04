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
import Razorpay
import SafariServices
import WebKit

class searchpetloverappointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate , RazorpayPaymentCompletionProtocol, RazorpayPaymentCompletionProtocolWithData, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    @IBOutlet weak var coll_imag: UICollectionView!
    @IBOutlet weak var tblview_petdetail: UITableView!
    @IBOutlet weak var tblview_pettype: UITableView!
    @IBOutlet weak var tblview_petbreed: UITableView!
    
    @IBOutlet weak var View_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_btn: UIView!
    
    @IBOutlet weak var view_visit: UIView!
    @IBOutlet weak var image_clinic: UIImageView!
    @IBOutlet weak var btn_clinic: UIButton!
    @IBOutlet weak var image_home: UIImageView!
    @IBOutlet weak var btn_home: UIButton!
    
    @IBOutlet weak var btn_online: UIButton!
    @IBOutlet weak var btn_visit: UIButton!
    @IBOutlet weak var image_visit: UIImageView!
    @IBOutlet weak var image_online: UIImageView!
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    
    var Pet_breed = [""]
    var pet_type = [""]
    var petid = [""]
    let imagepicker = UIImagePickerController()
    var petimage = ""
    var timer = Timer()
    var pagcount = 0
    
    var razorpay: RazorpayCheckout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.intial_setup_action()
        self.coll_imag.delegate = self
        self.coll_imag.dataSource = self
        self.coll_imag.isPagingEnabled = true
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
        print("Communication type",Servicefile.shared.pet_apoint_communication_type)
        self.checkappointmentcommtype()
        self.textfield_pettype.text = Servicefile.shared.pet_type_val
        self.textfield_petbreed.text = Servicefile.shared.Pet_breed_val
        self.textfield_petname.text = Servicefile.shared.pet_petlist[Servicefile.shared.pet_index].pet_name
        self.textfield_alergies.isUserInteractionEnabled = false
        self.textfield_alergies.text = Servicefile.shared.healthissue
        self.ispetnameselect(index: Servicefile.shared.pet_index)
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Appoinment"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: false, b2: false, b3: true, b4: false)
    // header action
   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           self.timer.invalidate()
       }
       
       func startTimer() {
           self.timer.invalidate()
           timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
       }
       
       @objc func scrollAutomatically(_ timer1: Timer) {
              if Servicefile.shared.petlistimg.count > 0 {
                  self.pagcount += 1
                  if self.pagcount == Servicefile.shared.petlistimg.count {
                      self.pagcount = 0
                      let indexPath = IndexPath(row: pagcount, section: 0)
                      self.coll_imag.scrollToItem(at: indexPath, at: .left, animated: true)
                  }else{
                      let indexPath = IndexPath(row: pagcount, section: 0)
                      self.coll_imag.scrollToItem(at: indexPath, at: .left, animated: true)
                  }
                 
              }
          }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  Servicefile.shared.petlistimg.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath)  as! petbannerCollectionViewCell
//        let petimg = Servicefile.shared.petlistimg[indexPath.row] as! NSDictionary
//        let imgstr = petimg["pet_img"] as? String ?? Servicefile.sample_img
//        cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: imgstr)) { (image, error, cache, urls) in
//            if (error != nil) {
//                cell.img_banner.image = UIImage(named: "b_sample")
//            } else {
//                cell.img_banner.image = image
//            }
//        }
//        cell.img_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
//        //cell.view_banner_two.isHidden = true
//        cell.view_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
//        return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath)  as! imgidCollectionViewCell
        let petimg = Servicefile.shared.petlistimg[indexPath.row] as! NSDictionary
        let imgstr = petimg["pet_img"] as? String ?? Servicefile.sample_img
        cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: imgstr)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.Img_id.image = UIImage(named: "b_sample")
            } else {
                cell.Img_id.image = image
            }
        }
        cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        if self.textfield_selectpettype.text! == "" {
            cell.view_close.isHidden = false
        }else{
            cell.view_close.isHidden = true
        }
        cell.btn_close.tag = indexPath.row
        cell.btn_close.addTarget(self, action: #selector(action_close), for: .touchUpInside)
        return cell
    }
    
    @objc func action_close(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.petlistimg.remove(at: tag)
        self.coll_imag.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               return CGSize(width: 100 , height:  100)
    }
    
    func checkappointmentcommtype(){
        if Servicefile.shared.pet_apoint_communication_type == "Online Or Visit" {
            self.image_visit.image = UIImage(named: "Radio")
            self.image_online.image = UIImage(named: "selectedRadio")
            self.btn_visit.isHidden = false
            self.btn_online.isHidden = false
            self.view_visit.isHidden = true
            Servicefile.shared.pet_apoint_communication_type = "Online"
        }else if Servicefile.shared.pet_apoint_communication_type == "Online" {
            self.image_visit.image = UIImage(named: "Radio")
            self.image_online.image = UIImage(named: "selectedRadio")
            self.btn_visit.isHidden = true
            self.btn_online.isHidden = true
            self.view_visit.isHidden = true
        }else if Servicefile.shared.pet_apoint_communication_type == "Visit" {
            self.image_visit.image = UIImage(named: "selectedRadio")
            self.image_online.image = UIImage(named: "Radio")
            self.btn_visit.isHidden = true
            self.btn_online.isHidden = true
            self.view_visit.isHidden = false
        }
        
        if Servicefile.shared.pet_apoint_visit_type == "" {
            self.image_home.image = UIImage(named: "Radio")
            self.image_clinic.image = UIImage(named: "Radio")
        }else if Servicefile.shared.pet_apoint_visit_type == "Home" {
            self.image_home.image = UIImage(named: "selectedRadio")
            self.image_clinic.image = UIImage(named: "Radio")
        }else if Servicefile.shared.pet_apoint_visit_type == "Clinic" {
            self.image_home.image = UIImage(named: "Radio")
            self.image_clinic.image = UIImage(named: "selectedRadio")
        }
    }
    
    func checkcommtype(){
        if Servicefile.shared.pet_apoint_communication_type == "Online Or Visit" {
            self.image_visit.image = UIImage(named: "Radio")
            self.image_online.image = UIImage(named: "selectedRadio")
            self.btn_visit.isHidden = false
            self.btn_online.isHidden = false
            self.view_visit.isHidden = true
            Servicefile.shared.pet_apoint_communication_type = "Online"
        }else if Servicefile.shared.pet_apoint_communication_type == "Online" {
            self.image_visit.image = UIImage(named: "Radio")
            self.image_online.image = UIImage(named: "selectedRadio")
            self.view_visit.isHidden = true
        }else if Servicefile.shared.pet_apoint_communication_type == "Visit" {
            self.image_visit.image = UIImage(named: "selectedRadio")
            self.image_online.image = UIImage(named: "Radio")
            self.view_visit.isHidden = false
        }
        
        if Servicefile.shared.pet_apoint_visit_type == "" {
            self.image_home.image = UIImage(named: "Radio")
            self.image_clinic.image = UIImage(named: "Radio")
        }else if Servicefile.shared.pet_apoint_visit_type == "Home" {
            self.image_home.image = UIImage(named: "selectedRadio")
            self.image_clinic.image = UIImage(named: "Radio")
        }else if Servicefile.shared.pet_apoint_visit_type == "Clinic" {
            self.image_home.image = UIImage(named: "Radio")
            self.image_clinic.image = UIImage(named: "selectedRadio")
        }
    }
    
    @IBAction func action_visit(_ sender: Any) {
        Servicefile.shared.pet_apoint_communication_type = "Visit"
        Servicefile.shared.pet_apoint_visit_type = ""
        Servicefile.shared.pet_apoint_location_id = ""
        self.checkcommtype()
    }
    
    @IBAction func action_online(_ sender: Any) {
        Servicefile.shared.pet_apoint_communication_type = "Online"
        Servicefile.shared.pet_apoint_visit_type = ""
        Servicefile.shared.pet_apoint_location_id = ""
        self.checkcommtype()
    }
    
    
     @IBAction func action_Home(_ sender: Any) {
         Servicefile.shared.pet_apoint_visit_type = "Home"
         self.checkcommtype()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_app_select_address_ViewController") as! pet_app_select_address_ViewController
        self.present(vc, animated: true, completion: nil)
        
     }
     
     
     @IBAction func action_clinic(_ sender: Any) {
         Servicefile.shared.pet_apoint_visit_type = "Clinic"
         self.checkcommtype()
     }
     
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_afterappBooked(_ sender: Any) {
        let vc = UIStoryboard.Pet_applist_ViewController()
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
//        if self.petimage == "" {
//            self.image_petcurrent.image = UIImage(named: "sample")
//        }else{
//            self.image_petcurrent.sd_setImage(with: Servicefile.shared.StrToURL(url: petimage)) { (image, error, cache, urls) in
//                if (error != nil) {
//                    self.image_petcurrent.image = UIImage(named: "sample")
//                } else {
//                    self.image_petcurrent.image = image
//                }
//            }
//            self.image_petcurrent.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
//        }
        
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
            cell.selectionStyle = .none
            return cell
        } else if self.tblview_pettype == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ptype", for: indexPath)
            cell.textLabel?.text = self.pet_type[indexPath.row]
            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Pbreed", for: indexPath)
            cell.textLabel?.text = self.Pet_breed[indexPath.row]
            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.selectionStyle = .none
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
            Servicefile.shared.petlistimg = Servicefile.shared.pet_petlist[index].pet_img
            self.view_pickupload.isHidden = true
            self.coll_imag.reloadData()
            self.startTimer()
        }else{
            self.view_pickupload.isHidden = false
            self.textfield_selectpettype.text! = ""
            self.textfield_petname.text = ""
            self.textfield_pettype.text = ""
            self.textfield_petbreed.text = ""
            self.textfield_petname.isUserInteractionEnabled = true
            Servicefile.shared.petlistimg = [Any]()
            self.coll_imag.reloadData()
            self.startTimer()
        }
       // self.setuploadimg()
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
                        var B = Servicefile.shared.petlistimg
                        var arr = B
                        let a = ["pet_img":Data] as NSDictionary
                        arr.append(a)
                        B = arr
                        print(B)
                        Servicefile.shared.petlistimg = B
                        self.coll_imag.reloadData()
                        self.startTimer()
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
            
            Servicefile.shared.pet_apoint_doctor_id = Servicefile.shared.sear_Docapp_id
            Servicefile.shared.pet_apoint_booking_date_time = Servicefile.shared.pet_apoint_booking_date + " " + Servicefile.shared.pet_apoint_booking_time
            Servicefile.shared.pet_apoint_video_id = ""
            Servicefile.shared.pet_apoint_user_id = ""
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
            Servicefile.shared.pet_apoint_allergies = self.textfield_alergies.text!
            
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_createappointm, method: .post, parameters:
            [ "doctor_id":  Servicefile.shared.pet_apoint_doctor_id,
              "booking_date": Servicefile.shared.pet_apoint_booking_date,
              "booking_time": Servicefile.shared.pet_apoint_booking_time,
              "booking_date_time" : Servicefile.shared.pet_apoint_booking_date_time,
              "communication_type": Servicefile.shared.pet_apoint_communication_type,
              "video_id":  Servicefile.shared.pet_apoint_video_id,
              "user_id": Servicefile.shared.userid,
              "pet_id" : Servicefile.shared.pet_apoint_pet_id,
              "problem_info": Servicefile.shared.pet_apoint_problem_info,
              "doc_attched": Servicefile.shared.pet_apoint_doc_attched ,
              "doc_feedback":  Servicefile.shared.pet_apoint_doc_feedback,
              "doc_rate": Servicefile.shared.pet_apoint_doc_rate,
              "user_feedback" : Servicefile.shared.pet_apoint_user_feedback,
              "user_rate" : Servicefile.shared.pet_apoint_user_rate,
              "display_date" : Servicefile.shared.pet_apoint_display_date,
              "server_date_time" : Servicefile.shared.pet_apoint_server_date_time ,
              "payment_id" : Servicefile.shared.pet_apoint_payment_id ,
              "payment_method" : Servicefile.shared.pet_apoint_payment_method ,
              "appointment_types" : Servicefile.shared.pet_apoint_appointment_types,
              "allergies" : Servicefile.shared.pet_apoint_allergies,
              "amount" : Servicefile.shared.pet_apoint_amount,
              "mobile_type" : "IOS",
              "service_name" : "",
              "service_amount": "",
              "location_id": Servicefile.shared.pet_apoint_location_id,
              "visit_type": Servicefile.shared.pet_apoint_visit_type,
              "health_issue_title":Servicefile.shared.healthissue], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
             "pet_img" : Servicefile.shared.petlistimg,
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
        if Servicefile.shared.pet_apoint_amount != 0 {
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
                 "color": Servicefile.shared.appgreen
                ]
            ]
            
            if let rzp = self.razorpay {
                // rzp.open(options)
                rzp.open(options,displayController:self)
            } else {
                print("Unable to initialize")
            }
            
            //        self.razorpay = RazorpayCheckout.initWithKey("rzp_test_zioohqmxDjJJtd", andDelegate: self)
            //               let options: [AnyHashable:Any] = [
            //                   "amount": 100, //This is in currency subunits. 100 = 100 paise= INR 1.
            //                   "currency": "INR",//We support more that 92 international currencies.
            //                   "description": "some data",
            //                   "order_id": "order_DBJOWzybf0sJbb",
            //                   "image": "http://52.25.163.13:3000/api/uploads/template.png",
            //                   "name": "sriram",
            //                   "prefill": [
            //                       "contact": "9003525711",
            //                       "email": "sriramchanr@gmail.com"
            //                   ],
            //                   "theme": [
            //                       "color": "#F37254"
            //                   ]
            //               ]
            //               if let rzp = self.razorpay {
            //                   rzp.open(options)
            //               } else {
            //                   print("Unable to initialize")
            //               }
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_doc_notification, method: .post, parameters:
            ["appointment_UID": "",
             "date": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
             "doctor_id":Servicefile.shared.pet_apoint_doctor_id,
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
