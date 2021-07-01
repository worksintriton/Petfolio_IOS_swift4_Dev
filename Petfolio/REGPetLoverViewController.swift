//
//  REGPetLoverViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 17/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
//, UITableViewDelegate, UITableViewDataSource
class REGPetLoverViewController: UIViewController, UITextFieldDelegate {
    
    
    
   
    @IBOutlet weak var view_Petname: selectval!
    @IBOutlet weak var view_petcolor: selectval!
    @IBOutlet weak var view_pet: selectval!
    @IBOutlet weak var view_petweight: selectval!
    @IBOutlet weak var view_selectdate: selectval! //  vacinated date
    @IBOutlet weak var view_selectdateCalender: selectval! // DOB
    @IBOutlet weak var view_petbio: selectval!
    
    @IBOutlet weak var view_gender: genderview!
    
    
    
    @IBOutlet weak var view_petage: UIView!
    @IBOutlet weak var view_datelabel: UIView!
    
    @IBOutlet weak var view_calender: UIView!
    @IBOutlet weak var view_calenderbtn: UIView!
    
    
    @IBOutlet weak var view_submit: UIView!
    
    
    
   
    @IBOutlet weak var textfiled_petage: UITextField!
    
    @IBOutlet weak var img_novaccine: UIImageView!
    @IBOutlet weak var img_yesvaccine: UIImageView!
    
//    @IBOutlet weak var tblview_pettype: UITableView!
//    @IBOutlet weak var tblview_petbreed: UITableView!
//    @IBOutlet weak var tblview_gender: UITableView!
    
    
    @IBOutlet weak var datepicker_date: UIDatePicker!
    
    var isdob = false
    var Pet_breed_val = ""
    var pet_type_val = ""
    var Pet_breed = [""]
    var pet_type = [""]
    var petid = [""]
    var petage = ""
    var petgender = [""]
    var isselectdate = ""
    var isvaccin = true
    var gender = "Male"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pet_type.removeAll()
        self.Pet_breed.removeAll()
        self.setdesign()
        self.view_selectdate.view_cornor()
//        self.view_pettypeDrop.view_cornor()
        self.view_pet.view_cornor()
        self.view_petcolor.view_cornor()
        self.view_selectdateCalender.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_submit.view_cornor()
        // Do any additional setup after loading the view.
        self.callpetdetails()
        self.callpetdetailget()
        self.view_pet.textfield_value.delegate = self
        self.view_Petname.textfield_value.delegate = self
        self.view_petbio.textfield_value.delegate = self
        self.view_petweight.textfield_value.delegate = self
        self.textfiled_petage.delegate = self
        self.view_petcolor.textfield_value.delegate = self
        
        
        self.view_calender.isHidden = true
        self.view_calenderbtn.view_cornor()
        self.datepicker_date.datePickerMode = .date
        self.datepicker_date.maximumDate = Date()
        if #available(iOS 13.4, *) {
                    self.datepicker_date.preferredDatePickerStyle = .wheels
                       } else {
                           // Fallback on earlier versions
                }
        self.textfiled_petage.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.datepicker_date.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.view_pet.btn_get_data.addTarget(self, action: #selector(action_getpet), for: .touchUpInside)
        
        self.view_pet.textfield_value.text = Servicefile.shared.pet_type_val + Servicefile.shared.Pet_breed_val
        self.view_selectdateCalender.btn_get_data.addTarget(self, action: #selector(action_showDOBcalender), for: .touchUpInside)
        self.view_selectdate.btn_get_data.addTarget(self, action: #selector(action_showcalender), for: .touchUpInside)
        self.view_Petname.btn_get_data.addTarget(self, action: #selector(action_get), for: .touchUpInside)
        self.view_gender.maleselect()
        self.gender = "Male"
        self.view_gender.btn_m.addTarget(self, action: #selector(action_getm), for: .touchUpInside)
        self.view_gender.btn_f.addTarget(self, action: #selector(action_getf), for: .touchUpInside)
        self.view_gender.btn_o.addTarget(self, action: #selector(action_geto), for: .touchUpInside)
    }
    
   
    @objc func action_getm(_ sender: Any) {
        self.view_gender.maleselect()
        self.gender = "Male"
    }
    
    @objc func action_getf(_ sender: Any) {
        self.view_gender.femaleselect()
        self.gender = "Female"
    }
    
    @objc func action_geto(_ sender: Any) {
        self.view_gender.othersselect()
        self.gender = "Others"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Servicefile.shared.pet_type_val != "" {
            self.view_pet.textfield_value.text = Servicefile.shared.pet_type_val + ", " + Servicefile.shared.Pet_breed_val
        }
       
    }
    
    @objc func action_getpet(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "getpetViewController") as! getpetViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_get(_ sender: Any) {
        print("you have clicked")
    }
    
    
    func setdesign(){
        Servicefile.shared.Pet_breed_val = ""
        Servicefile.shared.pet_type_val = ""
        self.view_Petname.textfield_value.placeholder = "Pet name"
        self.view_pet.textfield_value.placeholder = "Pet Type & Breed"
        self.view_selectdate.textfield_value.placeholder = "Select Vaccinated date"
        self.view_selectdateCalender.textfield_value.placeholder = "Date of Birth"
        self.view_petcolor.textfield_value.placeholder = "Pet color"
        self.view_petweight.textfield_value.placeholder = "Pet weight (Kg)"
        self.view_petbio.textfield_value.placeholder = "Pet Bio"
        self.view_pet.view_btn_side.isHidden = false
        self.view_pet.btn_get_data.isHidden = false
        self.view_Petname.btn_get_data.isHidden = true
        self.view_petbio.btn_get_data.isHidden = true
        self.view_petcolor.btn_get_data.isHidden = true
        self.view_selectdate.view_btn_side.isHidden = false
        self.view_selectdate.btn_get_data.isHidden = false
        self.view_selectdateCalender.view_btn_side.isHidden = false
        self.view_selectdateCalender.btn_get_data.isHidden = false
        self.view_selectdate.image_side_view.image = UIImage(named: "calender")
        self.view_selectdateCalender.image_side_view.image = UIImage(named: "calender")
        
    }
    
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let senderdate = sender.date
        let sedate = Servicefile.shared.ddMMyyyystringformat(date: senderdate)
        if self.isdob {
            self.isselectdate = sedate
            self.view_selectdateCalender.textfield_value.text = Servicefile.shared.checkyearmonthdiffer(sdate: senderdate, edate: Date())
        }else{
            self.view_selectdate.textfield_value.text = sedate
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
//        self.tblview_petbreed.isHidden = true
//        self.tblview_pettype.isHidden = true
//        self.tblview_gender.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.view_Petname.textfield_value {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvestring).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        if textField == self.view_petbio.textfield_value {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvestring).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        if textField == self.view_petweight.textfield_value {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvednumberandspecial).inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
//        if textField == self.textfiled_petage{
//            let aSet = NSCharacterSet(charactersIn: Servicefile.approvednumberandspecial).inverted
//            let compSepByCharInSet = string.components(separatedBy: aSet)
//            let numberFiltered = compSepByCharInSet.joined(separator: "")
//            return string == numberFiltered
//        }
//        self.tblview_petbreed.isHidden = true
//        self.tblview_pettype.isHidden = true
//        self.tblview_gender.isHidden = true
        return true
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        if self.view_Petname.textfield_value == textField {
            if self.view_Petname.textfield_value.text!.count > 24 {
                self.view_Petname.textfield_value.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvedalphanumeric, textcount: 25)
                self.view_Petname.textfield_value.resignFirstResponder()
            }else{
                self.view_Petname.textfield_value.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvedalphanumeric, textcount: 25)
            }
            if self.view_petcolor.textfield_value.text!.count > 14 {
                self.view_petcolor.textfield_value.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvestring, textcount: 15)
                self.view_petcolor.textfield_value.resignFirstResponder()
            }else{
                self.view_petcolor.textfield_value.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvestring, textcount: 15)
            }
            if self.view_petweight.textfield_value.text!.count > 4 {
                self.view_petweight.textfield_value.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 15)
                self.view_petweight.textfield_value.resignFirstResponder()
            }else{
                self.view_petweight.textfield_value.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 15)
            }
//            if self.textfiled_petage.text!.count > 1 {
//                self.textfiled_petage.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 15)
//                self.textfiled_petage.resignFirstResponder()
//            }else{
//                self.textfiled_petage.text  = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 15)
//            }
        }
    }
    
    @IBAction func action_skip(_ sender: Any) {
        self.callSkipupdatestatus()
        
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.pushtologin()
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        if self.tblview_pettype == tableView {
////            return self.pet_type.count
////        }else if self.tblview_petbreed == tableView {
////            return self.Pet_breed.count
////        }else{
////            return self.petgender.count
////        }
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if self.tblview_pettype == tableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Ptype", for: indexPath)
//            cell.textLabel?.text = self.pet_type[indexPath.row]
//            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
//            cell.selectionStyle = .none
//            return cell
//        }else if self.tblview_gender == tableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "gender", for: indexPath)
//            cell.textLabel?.text = self.petgender[indexPath.row]
//            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
//            cell.selectionStyle = .none
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Pbreed", for: indexPath)
//            cell.textLabel?.text = self.Pet_breed[indexPath.row]
//            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
//            cell.selectionStyle = .none
//            return cell
//        }
//
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.tblview_petbreed.isHidden = true
//        self.tblview_pettype.isHidden = true
//        self.tblview_gender.isHidden = true
//        if self.tblview_petbreed ==  tableView {
//            self.textfield_petbreed.text! = self.Pet_breed[indexPath.row]
//        }else if self.tblview_pettype ==  tableView {
//            self.textfield_pettype.text! = self.pet_type[indexPath.row]
//            self.callpetbreedbyid(petid: self.petid[indexPath.row])
//        }else{
//            self.textfield_petgender.text = self.petgender[indexPath.row]
//        }
//    }
    
    @IBAction func action_pettype(_ sender: Any) {
//        self.tblview_petbreed.isHidden = true
//        self.tblview_pettype.isHidden = false
//        self.tblview_gender.isHidden = true
        
    }
    
    
    @IBAction func action_gender(_ sender: Any) {
//        self.tblview_petbreed.isHidden = true
//        self.tblview_pettype.isHidden = true
//        self.tblview_gender.isHidden = false
    }
    
    
    @IBAction func action_petbreed(_ sender: Any) {
        if self.Pet_breed.count > 0 {
//            self.tblview_petbreed.isHidden = false
//            self.tblview_pettype.isHidden = true
//            self.tblview_gender.isHidden = true
        }
    }
    
    @IBAction func action_Novaccine(_ sender: Any) {
        self.img_novaccine.image = UIImage(named: "selectedRadio")
        self.img_yesvaccine.image = UIImage(named: "Radio")
        self.view_datelabel.isHidden = true
        self.view_selectdate.isHidden = true
        self.isvaccin = false
    }
    
    
    @IBAction func action_yesvaccine(_ sender: Any) {
        self.img_novaccine.image = UIImage(named: "Radio")
        self.img_yesvaccine.image = UIImage(named: "selectedRadio")
        self.view_datelabel.isHidden = false
        self.view_selectdate.isHidden = false
        self.isvaccin = true
    }
    
    @IBAction func action_selectdate(_ sender: Any) {
        
    }
    
    
    @objc func action_showDOBcalender(_ sender: Any) {
        self.isdob = true
        self.view_calender.isHidden = false
    }
    
    @objc func action_showcalender(_ sender: Any) {
        self.isdob = false
        self.view_calender.isHidden = false
    }
    
    @IBAction func action_GetDate(_ sender: Any) {
        self.view_calender.isHidden = true
    }
    
    @IBAction func action_submit(_ sender: Any) {
        if self.view_Petname.textfield_value.text == "" {
            self.alert(Message: "Please enter Pet name")
        }else if self.view_petbio.textfield_value.text == "" {
            self.alert(Message: "Please enter Pet Bio")
        }else if Servicefile.shared.pet_type_val == "" {
            self.alert(Message: "Please select Pet Type and Breed")
        }else if self.view_petcolor.textfield_value.text == "" {
            self.alert(Message: "Please enter Pet color")
        }else if self.view_selectdateCalender.textfield_value.text == "" {
            self.alert(Message: "Please enter Pet age")
        }else{
            print("user_id", Servicefile.shared.userid,
                  "pet_img" ,"",
                  "pet_name" , Servicefile.shared.checktextfield(textfield: self.view_Petname.textfield_value.text!),
                  "pet_type" , Servicefile.shared.pet_type_val ,
                  "pet_breed" ,Servicefile.shared.Pet_breed_val,
                  "petbio" ,Servicefile.shared.checktextfield(textfield: self.view_petbio.textfield_value.text!),
                  "pet_gender" , Servicefile.shared.checktextfield(textfield: ""), /*self.textfield_petgender.text!*/
                  "pet_color" , Servicefile.shared.checktextfield(textfield: self.view_petcolor.textfield_value.text!),
                  "pet_weight" , Servicefile.shared.checkInttextfield(strtoInt: self.view_petweight.textfield_value.text!),
                  "pet_age" , Servicefile.shared.checkInttextfield(strtoInt: self.textfiled_petage.text!),"pet_dob" , Servicefile.shared.checktextfield(textfield: self.textfiled_petage.text!),
                  "vaccinated" , self.isvaccin,
                  "last_vaccination_date" , Servicefile.shared.checktextfield(textfield: self.view_selectdate.textfield_value.text!),
                  "default_status" , true,
                  "date_and_time" , Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()))
            if self.isvaccin != false {
                if self.view_selectdate.textfield_value.text == "" {
                    self.alert(Message: "Please select vaccinated date")
                }else{
                    let birthdate =  Servicefile.shared.ddMMyyyydateformat(date: self.isselectdate)
                    let vacinateddate = Servicefile.shared.ddMMyyyydateformat(date: self.view_selectdate.textfield_value.text! )
                    if  Servicefile.shared.checkdaydiffer(sdate: birthdate, edate: vacinateddate) {
                    self.calladdpetdetails()
                    }else{
                        self.alert(Message: "Please select valid vaccinated date")
                    }
                }
            }else{
               // self.calladdpetdetails()
            }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        if self.textfiled_petage == textField{
        //             self.moveTextField(textField: textField, up:true)
        //        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        if self.textfiled_petage == textField || self.textfiled_petage == textField {
        //              self.moveTextField(textField: textField, up:false)
        //        }
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
                        //                    let Pet_breed = Data["Pet_breed"] as! NSArray
                        //                    let Pet_type = Data["Pet_type"] as! NSArray
                        let Gender = Data["Gender"] as! NSArray
                        //                    self.pet_type.removeAll()
                        //                    self.Pet_breed.removeAll()
                        self.petgender.removeAll()
                        //                    for item in 0..<Pet_breed.count{
                        //                        let pb = Pet_breed[item] as! NSDictionary
                        //                        let pbv = pb["pet_breed"] as! String
                        //                        self.Pet_breed.append(pbv)
                        //                    }
                        //                    for item in 0..<Pet_type.count{
                        //                        let pb = Pet_type[item] as! NSDictionary
                        //                        let pbv = pb["pet_type"] as! String
                        //                        self.pet_type.append(pbv)
                        //                    }
                        for item in 0..<Gender.count{
                            let pb = Gender[item] as! NSDictionary
                            let pbv = pb["gender"] as? String ?? ""
                            if pbv != "" {
                                self.petgender.append(pbv)
                            }
                            
                        }
                        //                    self.tblview_pettype.reloadData()
                        //                    self.tblview_petbreed.reloadData()
                        //self.tblview_gender.reloadData()
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
    func calladdpetdetails(){
        print("user_id", Servicefile.shared.userid,
              "pet_img" ,"",
              "pet_name" , Servicefile.shared.checktextfield(textfield: self.view_Petname.textfield_value.text!),
              "pet_type" , Servicefile.shared.pet_type_val,
              "pet_breed" , Servicefile.shared.Pet_breed_val,
              "pet_gender" , Servicefile.shared.checktextfield(textfield: ""), /*self.textfield_petgender.text!*/
              "petbio" ,Servicefile.shared.checktextfield(textfield: self.view_petbio.textfield_value.text!),
              "pet_color" , Servicefile.shared.checktextfield(textfield: self.view_petcolor.textfield_value.text!),
              "pet_weight" , Servicefile.shared.checkInttextfield(strtoInt: self.view_petweight.textfield_value.text!),
              "pet_age" , Servicefile.shared.checkInttextfield(strtoInt: self.textfiled_petage.text!),"pet_dob" , Servicefile.shared.checktextfield(textfield: self.textfiled_petage.text!),
              "vaccinated" , self.isvaccin,
              "last_vaccination_date" , Servicefile.shared.checktextfield(textfield: self.view_selectdate.textfield_value.text!),
              "default_status" , true,
              "date_and_time" , Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()))
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petregister, method: .post, parameters:
            ["user_id": Servicefile.shared.userid,
             "pet_img" :"",
             "pet_name" : Servicefile.shared.checktextfield(textfield: self.view_Petname.textfield_value.text!),
             "pet_type" : Servicefile.shared.pet_type_val,
             "pet_breed" : Servicefile.shared.Pet_breed_val,
             "petbio": Servicefile.shared.checktextfield(textfield: self.view_petbio.textfield_value.text!),
             "pet_gender" : Servicefile.shared.checktextfield(textfield: ""), /*self.textfield_petgender.text!*/
             "pet_color" : Servicefile.shared.checktextfield(textfield: self.view_petcolor.textfield_value.text!),
             "pet_weight" : Servicefile.shared.checkInttextfield(strtoInt: self.view_petweight.textfield_value.text!),
             "pet_age" : Servicefile.shared.checkInttextfield(strtoInt: self.textfiled_petage.text!),"pet_dob" : Servicefile.shared.checktextfield(textfield: self.textfiled_petage.text!),
             "vaccinated" : self.isvaccin,
             "last_vaccination_date" : Servicefile.shared.checktextfield(textfield: self.view_selectdate.textfield_value.text!),
             "default_status" : true,
             "date_and_time" : Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()),"mobile_type" : "IOS"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        Servicefile.shared.petid = Data["_id"] as? String ?? ""
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_other_information_ViewController") as! pet_other_information_ViewController
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
                        let Data = res["Data"] as! NSDictionary
                        let userid = Data["_id"] as? String ?? ""
                        UserDefaults.standard.set(userid, forKey: "userid")
                        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petimageUploadViewController") as! petimageUploadViewController
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
    
    func callSkipupdatestatus(){
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
                        let Data = res["Data"] as! NSDictionary
                        let userid = Data["_id"] as? String ?? ""
                        UserDefaults.standard.set(userid, forKey: "userid")
                        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                        Servicefile.shared.tabbar_selectedindex = 2
                        let tapbar = self.storyboard?.instantiateViewController(withIdentifier: "pettabbarViewController") as! SHCircleBarControll
                        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                        self.present(tapbar, animated: true, completion: nil)
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
                            if pbv != ""{
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
//                        self.tblview_pettype.reloadData()
//                        self.tblview_petbreed.reloadData()
                        
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
                        //self.textfield_petbreed.text = ""
                        let Pet_breed = res["Data"] as! NSArray
                        self.Pet_breed.removeAll()
                        for item in 0..<Pet_breed.count{
                            let pb = Pet_breed[item] as! NSDictionary
                            let pbv = pb["pet_breed"] as? String ?? ""
                            if pbv != "" {
                                self.Pet_breed.append(pbv)
                            }
                        }
//                        self.tblview_petbreed.reloadData()
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
    
}

extension UIViewController {
    func pushtologin(){
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        UserDefaults.standard.set("", forKey: "first_name")
        UserDefaults.standard.set("", forKey: "last_name")
        UserDefaults.standard.set("", forKey: "user_email")
        UserDefaults.standard.set("", forKey: "user_phone")
        UserDefaults.standard.set("", forKey: "user_image")
        UserDefaults.standard.set("", forKey: "my_ref_code")
        UserDefaults.standard.set(false, forKey: "email_status")
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        let vc = UIStoryboard.LoginViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
