//
//  regdocViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 19/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import MobileCoreServices
import CoreLocation
import AASignatureView

class regdocViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UITextViewDelegate, UIDocumentPickerDelegate, UIDocumentMenuDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var view_clinic: UIView!
    @IBOutlet weak var view_education: UIView!
    @IBOutlet weak var view_experience: UIView!
    @IBOutlet weak var view_experience_company: UIView!
    @IBOutlet weak var view_experience_from: UIView!
    @IBOutlet weak var view_experience_to: UIView!
    @IBOutlet weak var view_experience_add: UIView!
    @IBOutlet weak var view_speciali: UIView!
    @IBOutlet weak var view_speciali_textview: UIView!
    @IBOutlet weak var view_speciali_add: UIView!
    @IBOutlet weak var view_pethandle: UIView!
    @IBOutlet weak var view_pethandle_text: UIView!
    @IBOutlet weak var view_pethandle_add: UIView!
    @IBOutlet weak var view_clinicaddress: UIView!
    @IBOutlet weak var view_clinicimgadd: UIView!
    @IBOutlet weak var view_certificate: UIView!
    @IBOutlet weak var view_govtid: UIView!
    @IBOutlet weak var view_photoid: UIView!
    @IBOutlet weak var view_submit: UIView!
    @IBOutlet weak var view_ser_amt: UIView!
    
    @IBOutlet weak var view_signature_lib: AASignatureView!
    
    
    @IBOutlet weak var coll_photoid: UICollectionView!
    @IBOutlet weak var coll_govtid: UICollectionView!
    @IBOutlet weak var coll_certificate: UICollectionView!
    @IBOutlet weak var coll_clinicpic: UICollectionView!
    @IBOutlet weak var coll_pettype: UICollectionView!
    @IBOutlet weak var coll_speciali: UICollectionView!
    @IBOutlet weak var tbl_educationlist: UITableView!
    @IBOutlet weak var tbl_experience: UITableView!
    @IBOutlet weak var tbl_commtype: UITableView!
    
    @IBOutlet weak var textfield_pethandle: UITextField!
    @IBOutlet weak var textfield_spec: UITextField!
    @IBOutlet weak var textview_clinicaddress: UITextView!
    @IBOutlet weak var textfield_clinicname: UITextField!
    @IBOutlet weak var textfield_education: UITextField!
    @IBOutlet weak var textfield_edu_YOC: UITextField!
    @IBOutlet weak var textfield_exp_company: UITextField!
    @IBOutlet weak var label_exp_from: UILabel!
    @IBOutlet weak var label_exp_to: UILabel!
    @IBOutlet weak var textfield_commtype: UITextField!
    @IBOutlet weak var textfield_ser_amt: UITextField!
    
    @IBOutlet weak var Img_clinic: UIImageView!
    @IBOutlet weak var view_edudate: UIView!
    @IBOutlet weak var datepicker_date: UIDatePicker!
    @IBOutlet weak var image_signature: UIImageView!
    
    @IBOutlet weak var view_close: UIView!
    @IBOutlet weak var view_signature: UIView!
    @IBOutlet weak var view_expire: UIView!
    @IBOutlet weak var datepicker_expdate: UIDatePicker!
    
    
    var issubmit = false
    
    
    var specialza = [""]
    var pethandle = [""]
    var orgspecialza = [""]
    var orgpethandle = [""]
    var isspecialza = ["0"]
    var ispethandle = ["0"]
    var comm_type = [""]
    
    var comm_type_Value = [""]
    var collphotoid = [""]
    var collgovtid = [""]
    var collcertificate = [""]
    var collclinicpic = [""]
    var collpettype = [""]
    var collspeciali = [""]
    var edudetails : NSMutableDictionary = ["":""]
    var expdetails : NSMutableDictionary = ["":""]
    var specdetails : NSMutableDictionary = ["":""]
    var pethandetails : NSMutableDictionary = ["":""]
    var clinicdetails : NSMutableDictionary = ["":""]
    var certifdetails : NSMutableDictionary = ["":""]
    var govdetails : NSMutableDictionary = ["":""]
    var photodetails : NSMutableDictionary = ["":""]
    var tbl_educationlistHeight: CGFloat = 0
    var tbl_experienceHeight: CGFloat = 0
    let imagepicker = UIImagePickerController()
    var seldate = "F"
    var clinicpic = ""
    var Img_uploadarea = ""
    var digisignature = ""
    
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_action: UIView!
    @IBOutlet weak var view_communi: UIView!
    
    @IBOutlet weak var view_clear_signature: UIView!
    @IBOutlet weak var view_get_sign: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.digisignature = ""
        self.set_signa_image(strimage: self.digisignature)
         
        self.view_signature.isHidden = true
        self.view_clinic.view_cornor()
        self.view_communi.view_cornor()
        self.view_clear_signature.view_cornor()
        self.view_signature.view_cornor()
        self.view_get_sign.view_cornor()
        self.view_signature_lib.view_cornor()
        
        self.specialza.removeAll()
        self.pethandle.removeAll()
        self.comm_type.removeAll()
        self.comm_type_Value.removeAll()
        self.callpetdetails()
        print("lat long",self.latitude, self.longitude)
        Servicefile.shared.edudicarray.removeAll()
        Servicefile.shared.clinicdicarray.removeAll()
        Servicefile.shared.certifdicarray.removeAll()
        Servicefile.shared.govdicarray.removeAll()
        Servicefile.shared.photodicarray.removeAll()
        
        self.view_submit.view_cornor()
        self.view_popup.view_cornor()
        self.view_action.view_cornor()
        self.view_action.dropShadow()
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        
        self.clinicdetails.removeAllObjects()
        self.edudetails.removeAllObjects()
        self.expdetails.removeAllObjects()
        self.specdetails.removeAllObjects()
        self.pethandetails.removeAllObjects()
        self.certifdetails.removeAllObjects()
        self.govdetails.removeAllObjects()
        self.photodetails.removeAllObjects()
        self.imagepicker.delegate = self
        self.tbl_experience.delegate = self
        self.tbl_experience.dataSource = self
        self.tbl_educationlist.delegate = self
        self.tbl_educationlist.dataSource = self
        self.tbl_educationlist.isHidden = true
        self.tbl_experience.isHidden = true
        self.tbl_commtype.delegate = self
        self.tbl_commtype.dataSource = self
        self.tbl_commtype.isHidden = true
        
        self.coll_photoid.delegate = self
        self.coll_photoid.dataSource = self
        self.coll_govtid.delegate = self
        self.coll_govtid.dataSource = self
        self.coll_certificate.delegate = self
        self.coll_certificate.dataSource = self
        self.coll_clinicpic.delegate = self
        self.coll_clinicpic.dataSource = self
        self.coll_pettype.delegate = self
        self.coll_pettype.dataSource = self
        self.coll_speciali.delegate = self
        self.coll_speciali.dataSource = self
        
        self.textview_clinicaddress.delegate = self
        self.textfield_clinicname.delegate = self
        self.textfield_education.delegate = self
        self.textfield_edu_YOC.delegate = self
        self.textfield_exp_company.delegate = self
        self.textfield_spec.delegate = self
        self.textfield_pethandle.delegate = self
        self.textfield_ser_amt.delegate = self
        
        self.datepicker_date.datePickerMode = .date
        self.datepicker_expdate.datePickerMode = .date
        
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        print("user id",Servicefile.shared.userid)
        self.datepicker_expdate.addTarget(self, action: #selector(dateChangedexp(_:)), for: .valueChanged)
        self.datepicker_date.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.view_edudate.isHidden = true
        self.view_expire.isHidden = true
        self.datepicker_date.maximumDate = Date()
        self.datepicker_expdate.maximumDate = Date()
//        self.textview_clinicaddress.text = "Write here.."
//        self.textview_clinicaddress.textColor = UIColor.lightGray
        //self.setclinicimag()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidetbl))
        self.view_shadow.addGestureRecognizer(tap)
        self.calllocationcheck()
    }
    
    @objc func hidetbl() {
        if  self.issubmit {
            self.view_shadow.isHidden = false
        }else{
            self.view_shadow.isHidden = true
            self.view_signature.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("location",Servicefile.shared.Doc_loc, Servicefile.shared.Doc_lat,Servicefile.shared.Doc_long)
        self.textview_clinicaddress.text = Servicefile.shared.Doc_loc
    }
    
    
    @IBAction func action_commtype(_ sender: Any) {
        self.tbl_commtype.isHidden = false
        self.view_edudate.isHidden = true
        self.view_expire.isHidden = true
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        UserDefaults.standard.set("", forKey: "first_name")
        UserDefaults.standard.set("", forKey: "last_name")
        UserDefaults.standard.set("", forKey: "user_email")
        UserDefaults.standard.set("", forKey: "user_phone")
        UserDefaults.standard.set("", forKey: "user_image")
        UserDefaults.standard.set("", forKey: "user_image")
        UserDefaults.standard.set(false, forKey: "email_status")
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sidemenu(_ sender: Any) {
        
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        
        let filename = URL(fileURLWithPath: String(describing:urls)).lastPathComponent // print: myfile.pdf]
        
        self.PDFupload(dat: myURL)
//        print("import result : \(myURL)","name of file ",filename)
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        documentPicker.present(documentPicker, animated: true, completion: nil)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let senderdate = sender.date
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let nextDate = format.string(from: senderdate)
        self.textfield_edu_YOC.text = nextDate
        self.view_edudate.isHidden = true
        self.view_expire.isHidden = true
    }
    
    @objc func dateChangedexp(_ sender: UIDatePicker) {
        let senderdate = sender.date
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let nextDate = format.string(from: senderdate)
        if self.seldate == "F" {
            self.label_exp_from.text = nextDate
        }else{
            if self.label_exp_from.text == "From" {
                self.alert(Message: "Please select the From date")
            }else{
                self.label_exp_to.text = nextDate
            }
        }
        self.view_edudate.isHidden = true
        self.view_expire.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.textfield_clinicname {
            self.textfield_clinicname.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvedalphanumeric, textcount: 25)
        }
        if textField == self.textfield_education {
            self.textfield_education.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvedalphanumeric, textcount: 25)
        }
        if textField == self.textfield_exp_company {
            self.textfield_education.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvedalphanumeric, textcount: 25)
        }
        if textField == self.textfield_ser_amt {
            self.textfield_ser_amt.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 4)
        }
        return true
    }
    
   
    
    
    func viewdesign(){
        self.view_clinic.view_cornor()
        self.view_education.view_cornor()
        self.view_experience.view_cornor()
        self.view_experience_company.view_cornor()
        self.view_experience_from.view_cornor()
        self.view_experience_to.view_cornor()
        self.view_experience_add.view_cornor()
        self.view_speciali.view_cornor()
        self.view_speciali_textview.view_cornor()
        self.view_speciali_add.view_cornor()
        self.view_pethandle.view_cornor()
        self.view_pethandle_text.view_cornor()
        self.view_pethandle_add.view_cornor()
        self.view_clinicaddress.view_cornor()
        self.view_clinicimgadd.view_cornor()
        self.view_certificate.view_cornor()
        self.view_govtid.view_cornor()
        self.view_photoid.view_cornor()
        self.view_submit.view_cornor()
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        self.textview_clinicaddress.resignFirstResponder()
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resigntext()
        return true
    }
    
    func resigntext(){
        self.textview_clinicaddress.resignFirstResponder()
        self.textfield_clinicname.resignFirstResponder()
        self.textfield_education.resignFirstResponder()
        self.textfield_edu_YOC.resignFirstResponder()
        self.textfield_exp_company.resignFirstResponder()
        self.textfield_spec.resignFirstResponder()
        self.textfield_pethandle.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.textfield_ser_amt {
            self.moveTextField(textField: textField, up:true)
        }
        self.tbl_commtype.isHidden = true
    }
    
    
    @IBAction func action_education_add(_ sender: Any) {
        if self.textfield_education.text == "" {
            self.alert(Message: "Please enter Education")
        }else if self.textfield_edu_YOC.text == "" {
            self.alert(Message: "Please enter Year of completion")
        }else {
            
            var B = Servicefile.shared.edudicarray
            var arr = B
            let a = ["education":self.textfield_education.text!,
                     "year":self.textfield_edu_YOC.text!] as NSDictionary
            arr.append(a)
            B = arr
            print(B)
            Servicefile.shared.edudicarray = B
            
            self.tbl_educationlist.isHidden = false
            self.tbl_educationlist.reloadData()
            self.textfield_education.text = ""
            self.textfield_edu_YOC.text = ""
            
        }
        print("edudetails",Servicefile.shared.edudicarray)
        
    }
    
    @IBAction func action_speciali_add(_ sender: Any) {
        if self.textfield_spec.text == "" {
            self.alert(Message: "Please enter the Specialisation")
        }else{
            self.specialza.append(self.textfield_spec.text!)
            self.isspecialza.append("1")
        }
        self.coll_speciali.reloadData()
        Servicefile.shared.specdicarray.removeAll()
        for itm in 0..<specialza.count{
            if self.isspecialza[itm] != "0" {
                var B = Servicefile.shared.specdicarray
                var arr = B
                let a = ["specialization":self.specialza[itm]] as NSDictionary
                arr.append(a)
                B = arr
                print(B)
                Servicefile.shared.specdicarray = B
            }
        }
    }
    
    @IBAction func action_pethandle_add(_ sender: Any) {
        if self.textfield_pethandle.text == "" {
            self.alert(Message: "Please enter the pethandle")
        }else{
            self.pethandle.append(self.textfield_pethandle.text!)
            self.ispethandle.append("1")
        }
        self.coll_pettype.reloadData()
        Servicefile.shared.pethandicarray.removeAll()
        for itm in 0..<pethandle.count{
            if self.ispethandle[itm] != "0" {
                var B = Servicefile.shared.pethandicarray
                var arr = B
                let a = ["pet_handled":self.pethandle[itm]] as NSDictionary
                arr.append(a)
                B = arr
                print(B)
                Servicefile.shared.pethandicarray = B
            }
        }
    }
    
    @IBAction func action_experience_add(_ sender: Any) {
        if self.textfield_exp_company.text == "" {
            self.alert(Message: "Please enter Education")
        }else if self.label_exp_from.text == "From" {
            self.alert(Message: "Please Select from date")
        }else if self.label_exp_to.text == "To" {
            self.alert(Message: "Please Select To date")
        }else {
            let format = DateFormatter()
            format.dateFormat = "YYYY"
            let fromdate = format.date(from: self.label_exp_from.text!)
            let todate = format.date(from: self.label_exp_to.text!)
            
            var  compdate = Calendar.current.dateComponents([.year], from: fromdate!, to: todate!).year ?? 0
            var cdate = String(compdate + 1)
            print("comared date",cdate)
            
            var B = Servicefile.shared.expdicarray
            var arr = B
            let a = ["company":self.textfield_exp_company.text!,
                     "from":self.label_exp_from.text!,
                     "to":self.label_exp_to.text!,
                     "yearsofexperience": cdate] as NSDictionary
            arr.append(a)
            B = arr
            print(B)
            Servicefile.shared.expdicarray = B
            self.tbl_experience.isHidden = false
            self.tbl_experience.reloadData()
            self.textfield_exp_company.text = ""
            self.label_exp_from.text = "From"
            self.label_exp_to.text = "To"
        }
        print("edudetails",Servicefile.shared.expdicarray)
    }
    
    
    @IBAction func action_edu_date(_ sender: Any) {
        self.view_expire.isHidden = true
        self.view_edudate.isHidden = false
        self.tbl_commtype.isHidden = true
        self.resigntext()
    }
    
    @IBAction func action_exp_from(_ sender: Any) {
        self.seldate = "F"
        self.view_edudate.isHidden = true
        self.tbl_commtype.isHidden = true
        self.view_expire.isHidden = false
        self.resigntext()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let fromdat = format.date(from: "1950")
        print("fromdate",fromdat)
        self.datepicker_expdate.minimumDate = fromdat
        
    }
    
    @IBAction func action_exp_to(_ sender: Any) {
        self.seldate = "T"
        if self.label_exp_from.text == "From" {
            self.alert(Message: "Please select the from date")
            self.view_expire.isHidden = false
        }else{
            let format = DateFormatter()
            format.dateFormat = "yyyy"
            let fromdat = format.date(from: self.label_exp_from.text!)
            print("fromdate",fromdat)
            self.datepicker_expdate.minimumDate = fromdat
        }
        self.resigntext()
        self.view_edudate.isHidden = true
        self.tbl_commtype.isHidden = true
        self.view_expire.isHidden = false
    }
    
    @IBAction func action_addclinicimg(_ sender: Any) {
        self.Img_uploadarea = "clinic"
        if Servicefile.shared.clinicdicarray.count < 3 {
            self.callgalaryimageprocess()
        }else{
            self.alert(Message: "You can upload only 3 Photo")
        }
        self.tbl_commtype.isHidden = true
    }
    
    @IBAction func action_addcertifiimg(_ sender: Any) {
        self.Img_uploadarea = "certif"
        if Servicefile.shared.certifdicarray.count < 3 {
            self.callgalaryprocess()
        }else{
            self.alert(Message: "You can upload only 3 File")
        }
        self.tbl_commtype.isHidden = true
    }
    
    @IBAction func action_addgovimg(_ sender: Any) {
        self.Img_uploadarea = "gov"
        if Servicefile.shared.govdicarray.count < 3 {
            self.callgalaryprocess()
        }else{
            self.alert(Message: "You can upload only 3 File")
        }
        self.tbl_commtype.isHidden = true
    }
    
    
    @IBAction func action_photoimg(_ sender: Any) {
        self.Img_uploadarea = "photo"
        if Servicefile.shared.photodicarray.count < 3 {
            self.callgalaryprocess()
        }else{
            self.alert(Message: "You can upload 3 File")
        }
        self.tbl_commtype.isHidden = true
    }
    
    
    @IBAction func action_clear_signature(_ sender: Any) {
        self.view_signature_lib.clear()
    }
    
    @IBAction func action_view_signature(_ sender: Any) {
        self.view_signature.isHidden = false
        self.view_shadow.isHidden = false
    }
    
    @IBAction func action_close_signature(_ sender: Any) {
        self.digisignature = ""
        self.set_signa_image(strimage: self.digisignature)
    }
    
    @IBAction func action_get_signature(_ sender: Any) {
        if let setimage = view_signature_lib.signature {
            //self.image_signature.image = setimage
            self.Img_uploadarea = "sign"
            self.upload(imagedata: setimage)
        }
        self.view_signature.isHidden = true
        self.view_shadow.isHidden = true
    }
    
    func set_signa_image(strimage: String){
        self.image_signature.sd_setImage(with: Servicefile.shared.StrToURL(url: strimage)) { (image, error, cache, urls) in
            if (error != nil) {
                self.image_signature.image = UIImage(named: "sample")
            } else {
                self.image_signature.image = image
            }
        }
        self.image_signature.layer.borderWidth = 0.5
        self.view_close.layer.borderWidth = 0.5
        self.image_signature.layer.borderColor = UIColor.lightGray.cgColor
        self.view_close.layer.cornerRadius = self.view_close.frame.height / 2
        self.image_signature.layer.cornerRadius = 8.0
        if self.digisignature == "" {
            self.view_close.isHidden = true
        }else{
            self.view_close.isHidden = false
        }
    }
    
    @IBAction func action_submit(_ sender: Any) {
        self.tbl_commtype.isHidden = true
        if self.textfield_clinicname.text == "" {
            self.alert(Message: "please enter the clinic name")
        } else if self.textfield_commtype.text == "" {
            self.alert(Message: "please Select the Communication Type")
        } else if Servicefile.shared.edudicarray.count == 0 {
            self.alert(Message: "please enter the Education details")
        } else if Servicefile.shared.expdicarray.count == 0 {
            self.alert(Message: "please enter the Experience details")
        } else if Servicefile.shared.expdicarray.count == 0 {
            self.alert(Message: "please enter the Experience details")
        } else if Servicefile.shared.specdicarray.count == 0 {
            self.alert(Message: "Please select the Specialisation")
        } else if Servicefile.shared.pethandicarray.count == 0 {
            self.alert(Message: "Please select the pet type")
        } else if Servicefile.shared.clinicdicarray.count == 0 {
            self.alert(Message: "Please select the pet type")
        } else if Servicefile.shared.certifdicarray.count == 0 {
            self.alert(Message: "Please select the certificate")
        } else if Servicefile.shared.govdicarray.count == 0 {
            self.alert(Message: "Please select the Goverment ID")
        } else if Servicefile.shared.photodicarray.count == 0 {
            self.alert(Message: "Please select the photo")
        }else if  self.textfield_ser_amt.text == "" {
            self.alert(Message: "please enter the Service amount")
        }else if  self.digisignature == "" {
            self.alert(Message: "please upload the digital signature")
        } else {
            print("user_id" , Servicefile.shared.userid,
                  "communication_type",self.textfield_commtype.text!,
                  "dr_title" , "",
                  "dr_name" , "",
                  "clinic_name" , self.textfield_clinicname.text!,
                  "clinic_loc" , Servicefile.shared.Doc_loc,
                  "clinic_lat" , String(Servicefile.shared.Doc_lat),
                  "clinic_long" , String(Servicefile.shared.Doc_long),
                  "education_details" , Servicefile.shared.edudicarray,
                  "experience_details" , Servicefile.shared.expdicarray,
                  "specialization" , Servicefile.shared.specdicarray,
                  "pet_handled" , Servicefile.shared.pethandicarray,
                  "clinic_pic" , Servicefile.shared.clinicdicarray,
                  "certificate_pic" ,  Servicefile.shared.certifdicarray,
                  "govt_id_pic" , Servicefile.shared.govdicarray,
                  "photo_id_pic" , Servicefile.shared.photodicarray,
                  "profile_status" , true ,
                  "profile_verification_status" , "Not verified",
                  "date_and_time" , Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()),
                  "consultancy_fees" , "200")
            self.callDocreg()
        }
       
        
        print("spec details", Servicefile.shared.specdicarray)
        print("pet details",self.pethandle, Servicefile.shared.pethandicarray)
    }
    
    
    @IBAction func action_backtologin(_ sender: Any) {
        self.pushtologin()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tbl_experience == tableView {
            return Servicefile.shared.expdicarray.count
        }else if self.tbl_commtype == tableView {
            return self.comm_type.count
        }else{
            return Servicefile.shared.edudicarray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.tbl_experience == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "exper", for: indexPath) as! experienceTableViewCell
            let expval = Servicefile.shared.expdicarray[indexPath.row] as! NSDictionary
            cell.Label_company.text = (expval["company"]  as? String ?? "")
            cell.Label_fromto.text = (expval["from"]  as? String ?? "") + " - " + (expval["to"]  as? String ?? "")
            cell.selectionStyle = .none
            cell.BTN_expclose.tag = indexPath.row
            cell.BTN_expclose.addTarget(self, action: #selector(closeexp), for: .touchUpInside)
            return cell
        } else if self.tbl_commtype == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = self.comm_type[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "edu", for: indexPath) as! eduTableViewCell
            let eduval = Servicefile.shared.edudicarray[indexPath.row] as! NSDictionary
            cell.label_educa.text = (eduval["education"]  as? String ?? "")
            cell.label_yoc.text = (eduval["year"]  as? String ?? "")
            cell.BTN_close.tag = indexPath.row
            cell.BTN_close.addTarget(self, action: #selector(closeedu), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.tbl_commtype == tableView {
            self.textfield_commtype.text = self.comm_type[indexPath.row]
            self.tbl_commtype.isHidden = true
        }
    }
    
    @objc func closeedu(sender: UIButton){
        let btnsender = sender.tag
        Servicefile.shared.edudicarray.remove(at: btnsender)
        self.tbl_educationlist.reloadData()
    }
    @objc func closeexp(sender: UIButton){
        let btnsender = sender.tag
        Servicefile.shared.expdicarray.remove(at: btnsender)
        self.tbl_experience.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.tbl_commtype == tableView {
            return 40
        }else{
            return 69
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if coll_govtid == collectionView {
            return Servicefile.shared.govdicarray.count
        }else if coll_pettype == collectionView {
            return self.pethandle.count
        }else if coll_photoid == collectionView {
            return Servicefile.shared.photodicarray.count
        }else if coll_speciali == collectionView {
            return  self.specialza.count
        }else if coll_certificate == collectionView {
            return Servicefile.shared.certifdicarray.count
        }else  {
            return Servicefile.shared.clinicdicarray.count
        }
        
        
    }
    
    func spilit_string_data(array_string: String)-> String{
        var str = array_string.split(separator: ".")
        if str.last == "pdf" {
            return "pdf"
        }else{
            return ""
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if coll_govtid == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "govtid", for: indexPath) as! imgidCollectionViewCell
            let imgdat = Servicefile.shared.govdicarray[indexPath.row] as! NSDictionary
            let strdat = imgdat["govt_id_pic"] as? String ?? Servicefile.sample_img
            if self.spilit_string_data(array_string: strdat) == "" {
                cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: strdat)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.Img_id.image = UIImage(named: Servicefile.sample_img)
                    } else {
                        cell.Img_id.image = image
                    }
                }
            }else{
                cell.Img_id.image = UIImage(named: "pdf")
            }
            cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_close.layer.cornerRadius =  cell.view_close.frame.size.height / 2
            cell.btn_close.addTarget(self, action: #selector(action_close_govid), for: .touchUpInside)
            return cell
        }else if coll_pettype == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pettype", for: indexPath) as! checkupCollectionViewCell
            print("is pethandle",self.ispethandle[indexPath.row])
            if self.ispethandle[indexPath.row] != "0" {
                cell.img_check.image = UIImage(named: imagelink.checkbox_1)
            } else{
                cell.img_check.image = UIImage(named: imagelink.checkbox)
            }
            cell.title.text = self.pethandle[indexPath.row]
            return cell
        }else if coll_photoid == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoid", for: indexPath)  as! imgidCollectionViewCell
            let imgdat = Servicefile.shared.photodicarray[indexPath.row] as! NSDictionary
            let strdat = imgdat["photo_id_pic"] as? String ?? Servicefile.sample_img
            if self.spilit_string_data(array_string: strdat) == "" {
                cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: strdat)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.Img_id.image = UIImage(named: Servicefile.sample_img)
                    } else {
                        cell.Img_id.image = image
                    }
                }
            }else{
                cell.Img_id.image = UIImage(named: "pdf")
            }
            let val = Servicefile.shared.certifdicarray[indexPath.row]
            print("certificate val",val)
            cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_close.layer.cornerRadius =  cell.view_close.frame.size.height / 2
            cell.btn_close.addTarget(self, action: #selector(action_close_photoid), for: .touchUpInside)
            
            return cell
        }else if coll_speciali == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "speciali", for: indexPath) as! checkupCollectionViewCell
            print("is spec",self.isspecialza[indexPath.row])
            if self.isspecialza[indexPath.row] != "0" {
                cell.img_check.image = UIImage(named: imagelink.checkbox_1)
            } else{
                cell.img_check.image = UIImage(named: imagelink.checkbox)
            }
            cell.title.text = self.specialza[indexPath.row]
            return cell
        }else if coll_certificate == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "certificate", for: indexPath)  as! imgidCollectionViewCell
            let imgdat = Servicefile.shared.certifdicarray[indexPath.row] as! NSDictionary
            let strdat = imgdat["certificate_pic"] as? String ?? Servicefile.sample_img
            print("details",self.spilit_string_data(array_string: strdat))
            if self.spilit_string_data(array_string: strdat) == "" {
                cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: strdat)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.Img_id.image = UIImage(named: Servicefile.sample_img)
                    } else {
                        cell.Img_id.image = image
                    }
                }
            }else{
                cell.Img_id.image = UIImage(named: "pdf")
            }
            
            cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_close.layer.cornerRadius =  cell.view_close.frame.size.height / 2
            cell.btn_close.addTarget(self, action: #selector(action_close_certifid), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clinic", for: indexPath)  as! imgidCollectionViewCell
            let imgdat = Servicefile.shared.clinicdicarray[indexPath.row] as! NSDictionary
            print("clinic data in", imgdat)
            let strdat = imgdat["clinic_pic"] as? String ?? Servicefile.sample_img
                cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: strdat)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.Img_id.image = UIImage(named: "pdf")
                    } else {
                        cell.Img_id.image = image
                    }
                }
            cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_close.layer.cornerRadius =  cell.view_close.frame.size.height / 2
            cell.btn_close.addTarget(self, action: #selector(action_close_clinic), for: .touchUpInside)
            return cell
            
        }
    }
    
    
    @objc func action_close_clinic(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.clinicdicarray.remove(at: tag)
        self.coll_clinicpic.reloadData()
    }
    
    @objc func action_close_govid(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.govdicarray.remove(at: tag)
        self.coll_govtid.reloadData()
    }
    
    @objc func action_close_photoid(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.photodicarray.remove(at: tag)
        self.coll_photoid.reloadData()
    }
    
    @objc func action_close_certifid(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.certifdicarray.remove(at: tag)
        self.coll_certificate.reloadData()
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view_edudate.isHidden = true
        self.tbl_commtype.isHidden = true
        self.view_expire.isHidden = true
        if coll_pettype == collectionView {
            if self.ispethandle[indexPath.row] == "1" {
                self.ispethandle.remove(at: indexPath.row)
                self.ispethandle.insert("0", at: indexPath.row)
            }else{
                self.ispethandle.remove(at: indexPath.row)
                self.ispethandle.insert("1", at: indexPath.row)
            }
            self.coll_pettype.reloadData()
            Servicefile.shared.pethandicarray.removeAll()
            for itm in 0..<pethandle.count{
                if self.ispethandle[itm] != "0" {
                    var B = Servicefile.shared.pethandicarray
                    var arr = B
                    let a = ["pet_handled":self.pethandle[itm]] as NSDictionary
                    arr.append(a)
                    B = arr
                    print(B)
                    Servicefile.shared.pethandicarray = B
                }
            }
            print("data  in",self.isspecialza)
        }else if coll_speciali == collectionView {
            
            if self.isspecialza[indexPath.row] == "1" {
                self.isspecialza.remove(at: indexPath.row)
                self.isspecialza.insert("0", at: indexPath.row)
            }else{
                self.isspecialza.remove(at: indexPath.row)
                self.isspecialza.insert("1", at: indexPath.row)
            }
            self.coll_speciali.reloadData()
            Servicefile.shared.specdicarray.removeAll()
            
            for itm in 0..<specialza.count{
                if self.isspecialza[itm] != "0" {
                    var B = Servicefile.shared.specdicarray
                    var arr = B
                    let a = ["specialization":self.specialza[itm]] as NSDictionary
                    arr.append(a)
                    B = arr
                    print(B)
                    Servicefile.shared.specdicarray = B
                    
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if coll_govtid == collectionView {
            return CGSize(width: 100 , height:  100)
        }else if coll_pettype == collectionView {
            return CGSize(width: collectionView.frame.size.width / 2.1 , height:   40)
        }else if coll_photoid == collectionView {
            return CGSize(width: 100 , height:  100)
        }else if coll_speciali == collectionView {
            //           return CGSize(width: 80 , height:  40)
            return CGSize(width: coll_speciali.frame.size.width / 2.1 , height:   40)
        }else if coll_certificate == collectionView {
            return CGSize(width: 100 , height:  100)
        }else{
            return CGSize(width: 100 , height:  100)
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
    
    func callgalaryimageprocess(){
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
        alert.addAction(UIAlertAction(title: "Pick from Document", style: UIAlertAction.Style.default, handler: { action in
            self.callDocprocess()
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
                        let Data = res["Data"] as? String ?? ""
                        print("Uploaded file url:",Data)
                        if self.Img_uploadarea == "clinic" {
                            self.clinicdetails.removeAllObjects()
                            print("data while insert",self.clinicdetails)
                            var B = Servicefile.shared.clinicdicarray
                            var arr = B
                            let a = ["clinic_pic":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.clinicdicarray = B
                            print("uploaded data in clinic",Servicefile.shared.clinicdicarray)
                        }else if self.Img_uploadarea == "certif" {
                            var B = Servicefile.shared.certifdicarray
                            var arr = B
                            let a = ["certificate_pic":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.certifdicarray = B
                            print("uploaded data in certifi",Servicefile.shared.certifdicarray)
                        }else if self.Img_uploadarea == "gov" {
                            var B = Servicefile.shared.govdicarray
                            var arr = B
                            let a = ["govt_id_pic":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.govdicarray = B
                            print("uploaded data in govt_id_pic",Servicefile.shared.govdicarray)
                        }else if self.Img_uploadarea == "photo" {
                            var B = Servicefile.shared.photodicarray
                            var arr = B
                            let a = ["photo_id_pic":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.photodicarray = B
                            print("uploaded data in photodicarray",Servicefile.shared.photodicarray)
                        } else if self.Img_uploadarea == "sign" {
                            print("Uploaded file digital sign url:",Data)
                            self.digisignature = Data
                            self.set_signa_image(strimage: Data)
                            self.view_signature_lib.clear()
                        }
                        self.coll_certificate.reloadData()
                        self.coll_govtid.reloadData()
                        self.coll_photoid.reloadData()
                        self.coll_clinicpic.reloadData()
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
                        let Data = res["Data"] as? String ?? ""
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
                        self.coll_certificate.reloadData()
                        self.coll_govtid.reloadData()
                        self.coll_photoid.reloadData()
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
    
    func setclinicimag(){
        if self.clinicpic != "" {
            self.Img_clinic.sd_setImage(with: Servicefile.shared.StrToURL(url: self.clinicpic)) { (image, error, cache, urls) in
                if (error != nil) {
                    self.Img_clinic.image = UIImage(named: "sample")
                } else {
                    self.Img_clinic.image = image
                }
            }
        }else{
            self.Img_clinic.image = UIImage(named: "sample")
        }
    }
    
    
    @IBAction func action_change_location(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_new_setlocation_ViewController") as! Doc_new_setlocation_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func callpetdetails(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.petdetails, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let specialzation = Data["specialzation"] as! NSArray
                        let pet_handle = Data["pet_handle"] as! NSArray
                        let comm_type_arr = Data["communication_type"] as! NSArray
                        self.specialza.removeAll()
                        self.pethandle.removeAll()
                        self.orgpethandle.removeAll()
                        self.orgspecialza.removeAll()
                        self.isspecialza.removeAll()
                        self.ispethandle.removeAll()
                        self.comm_type.removeAll()
                        
                        
                        for item in 0..<comm_type_arr.count{
                            let pb = comm_type_arr[item] as! NSDictionary
                            let pbv = pb["com_type"] as? String ?? ""
                            let Value = String(pb["Value"] as? Int ?? 0)
                            if Value != "0" && pbv != "" {
                                self.comm_type.append(pbv)
                                self.comm_type_Value.append(Value)
                            }
                        }
                        
                        for item in 0..<pet_handle.count{
                            let pb = pet_handle[item] as! NSDictionary
                            let pbv = pb["pet_handle"] as? String ?? ""
                            if pbv != ""{
                                self.pethandle.append(pbv)
                                self.ispethandle.append("0")
                            }
                        }
                        for item in 0..<specialzation.count{
                            let pb = specialzation[item] as! NSDictionary
                            let pbv = pb["specialzation"] as? String ?? ""
                            if pbv != ""{
                                self.specialza.append(pbv)
                                self.isspecialza.append("0")
                            }
                        }
                        self.orgspecialza = self.specialza
                        self.orgpethandle = self.pethandle
                        self.coll_pettype.reloadData()
                        self.coll_speciali.reloadData()
                        self.tbl_commtype.reloadData()
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
    
    //        Servicefile.shared.Doc_lat
    //        Servicefile.shared.Doc_loc
    //        Servicefile.shared.Doc_long
    
    func callDocreg(){
        self.textfield_ser_amt.resignFirstResponder()
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.docbusscreate, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid,
             "dr_title" : "Dr",
             "dr_name" : Servicefile.shared.first_name,
             "clinic_name" : Servicefile.shared.checktextfield(textfield: self.textfield_clinicname.text!),
             "communication_type": Servicefile.shared.checktextfield(textfield: self.textfield_commtype.text!),
             "clinic_loc" : Servicefile.shared.checktextfield(textfield: Servicefile.shared.Doc_loc),
             "clinic_lat" : Servicefile.shared.Doc_lat,
             "clinic_long" : Servicefile.shared.Doc_long,
             "education_details" : Servicefile.shared.edudicarray,
             "experience_details" : Servicefile.shared.expdicarray,
             "specialization" : Servicefile.shared.specdicarray,
             "pet_handled" : Servicefile.shared.pethandicarray,
             "clinic_pic" : Servicefile.shared.clinicdicarray,
             "certificate_pic" :  Servicefile.shared.certifdicarray,
             "govt_id_pic" : Servicefile.shared.govdicarray,
             "photo_id_pic" : Servicefile.shared.photodicarray,
             "profile_status" : true,
             "profile_verification_status" : "Not verified",
             "consultancy_fees" : Servicefile.shared.checkInttextfield(strtoInt: self.textfield_ser_amt.text!),
             "date_and_time" : Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()),
             "mobile_type" : "IOS",
             "signature": self.digisignature], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.issubmit = true
                        //let Data = res["Data"] as! NSDictionary
                        self.view_popup.isHidden = false
                        self.view_shadow.isHidden = false
                        //self.callupdatestatus()
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
    
    func moveTextField(textField: UITextField, up: Bool){
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
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.textfield_ser_amt {
            self.moveTextField(textField: textField, up:false)
        }
    }
    
    func calldetailget(){
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

extension regdocViewController { // location setup
    
    func calllocationcheck(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textview_clinicaddress == textView  {
            if textView.text == "Write here.." {
                textView.text = ""
                if textView.textColor == UIColor.lightGray {
                    textView.text = nil
                    textView.textColor = UIColor.black
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.textview_clinicaddress.text!.count > 49 {
            textview_clinicaddress.resignFirstResponder()
        }else{
            self.textview_clinicaddress.text = textView.text
        }
        if(text == "\n") {
            textview_clinicaddress.resignFirstResponder()
            return false
        }
        self.view_edudate.isHidden = true
        self.tbl_commtype.isHidden = true
        self.view_expire.isHidden = true
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
       
        Servicefile.shared.Doc_lat = locValue.latitude
        Servicefile.shared.Doc_long = locValue.longitude
        
        self.findareabylatlong()
        self.locationManager.stopUpdatingLocation()
    }
    
    func findareabylatlong(){
       
        let latlng = String(Servicefile.shared.Doc_lat)+","+String(Servicefile.shared.Doc_long)
        if Servicefile.shared.updateUserInterface() { AF.request("https://maps.googleapis.com/maps/api/geocode/json?latlng="+latlng+"&key=AIzaSyAlvAK3lZepIaApTDbDZUNfO0dBmuP6h4A", method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
            switch (response.result) {
            case .success:
                let data = response.value as! NSDictionary
                let area = data["results"] as! NSArray
                let areadetails = area[0] as! NSDictionary
                Servicefile.shared.Doc_loc = (areadetails["formatted_address"] as? String)!
                _ = areadetails["address_components"] as! NSArray
                self.textview_clinicaddress.text! = Servicefile.shared.Doc_loc
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
