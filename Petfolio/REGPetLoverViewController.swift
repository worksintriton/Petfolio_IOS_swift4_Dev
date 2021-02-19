//
//  REGPetLoverViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 17/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class REGPetLoverViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var view_Petname: UIView!
    @IBOutlet weak var view_pettype: UIView!
    @IBOutlet weak var view_pettypeDrop: UIView!
    @IBOutlet weak var view_petbreedDrop: UIView!
    @IBOutlet weak var view_petbreed: UIView!
    @IBOutlet weak var view_petgender: UIView!
    @IBOutlet weak var view_petweight: UIView!
    @IBOutlet weak var view_petage: UIView!
    @IBOutlet weak var view_datelabel: UIView!
    @IBOutlet weak var view_selectdate: UIView!
    @IBOutlet weak var view_selectdateCalender: UIView!
    @IBOutlet weak var view_calender: UIView!
    @IBOutlet weak var view_calenderbtn: UIView!
    @IBOutlet weak var view_petcolor: UIView!
    @IBOutlet weak var view_submit: UIView!
    
    
    @IBOutlet weak var textfield_petname: UITextField!
    @IBOutlet weak var textfield_pettype: UITextField!
    @IBOutlet weak var textfield_petbreed: UITextField!
    @IBOutlet weak var textfield_petgender: UITextField!
    @IBOutlet weak var textfield_petweight: UITextField!
    @IBOutlet weak var textfiled_petage: UITextField!
    @IBOutlet weak var textfield_selectdate: UITextField!
    
    @IBOutlet weak var textfield_petcolor: UITextField!
    @IBOutlet weak var img_novaccine: UIImageView!
    @IBOutlet weak var img_yesvaccine: UIImageView!
    
    @IBOutlet weak var tblview_pettype: UITableView!
    @IBOutlet weak var tblview_petbreed: UITableView!
    @IBOutlet weak var tblview_gender: UITableView!
    
    
    @IBOutlet weak var datepicker_date: UIDatePicker!
    
    var Pet_breed = [""]
    var pet_type = [""]
    var petid = [""]
    
    var petgender = [""]
    
    var isvaccin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pet_type.removeAll()
        self.Pet_breed.removeAll()
        self.view_Petname.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_petage.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_pettype.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_petbreed.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_petgender.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_petage.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_selectdate.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_pettypeDrop.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_petbreedDrop.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_petcolor.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_selectdateCalender.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.view_submit.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        // Do any additional setup after loading the view.
        self.callpetdetails()
        self.callpetdetailget()
        
        self.textfield_petname.delegate = self
        self.textfield_petgender.delegate = self
        self.textfield_petweight.delegate = self
        self.textfiled_petage.delegate = self
        self.textfield_petcolor.delegate = self
        
        self.tblview_pettype.delegate = self
        self.tblview_pettype.dataSource = self
        self.tblview_petbreed.delegate = self
        self.tblview_petbreed.dataSource = self
        self.tblview_gender.delegate = self
        self.tblview_gender.dataSource = self
        
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = true
        self.tblview_gender.isHidden = true
        
        self.view_calenderbtn.dropShadow()
        
        let apgreen = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.tblview_petbreed.layer.borderColor = apgreen.cgColor
        self.tblview_pettype.layer.borderColor = apgreen.cgColor
        self.tblview_gender.layer.borderColor = apgreen.cgColor
        self.tblview_petbreed.layer.borderWidth = 0.2
        self.tblview_pettype.layer.borderWidth = 0.2
        self.tblview_gender.layer.borderWidth = 0.2
        
        self.tblview_petbreed.layer.cornerRadius = 9.0
        self.tblview_pettype.layer.cornerRadius = 9.0
        self.tblview_gender.layer.cornerRadius = 9.0
        
        self.view_calender.isHidden = true
        self.view_calenderbtn.layer.cornerRadius = CGFloat(Servicefile.shared.viewLabelcornorraius)
        self.datepicker_date.datePickerMode = .date
        self.datepicker_date.maximumDate = Date()
        self.textfiled_petage.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        self.datepicker_date.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let senderdate = sender.date
        let sedate = Servicefile.shared.ddMMyyyystringformat(date: senderdate)
        self.textfield_selectdate.text = sedate
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = true
        self.tblview_gender.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_petname.resignFirstResponder()
        self.textfield_petgender.resignFirstResponder()
        self.textfield_petweight.resignFirstResponder()
        self.textfiled_petage.resignFirstResponder()
        self.textfield_petcolor.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.textfield_petname {
            let aSet = NSCharacterSet(charactersIn:"qwertyuiopasdfghjklzxcvbnm ").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        if textField == self.textfield_petweight {
            let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        if textField == self.textfiled_petage{
            let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = true
        self.tblview_gender.isHidden = true
        return true
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        if self.textfield_petname == textField {
            if self.textfield_petname.text!.count > 24 {
                self.textfield_petname.resignFirstResponder()
            }else{
                self.textfield_petname.text = textField.text
            }
            if self.textfield_petcolor.text!.count > 24 {
                self.textfield_petcolor.resignFirstResponder()
            }else{
                self.textfield_petcolor.text = textField.text
            }
            if self.textfield_petweight.text!.count > 4 {
                self.textfield_petweight.resignFirstResponder()
            }else{
                self.textfield_petweight.text = textField.text
            }
            if self.textfiled_petage.text!.count > 4 {
                self.textfiled_petage.resignFirstResponder()
            }else{
                self.textfiled_petage.text = textField.text
            }
        }
    }
    
    @IBAction func action_skip(_ sender: Any) {
        self.callSkipupdatestatus()
        
    }
    
    @IBAction func action_back(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tblview_pettype == tableView {
            return self.pet_type.count
        }else if self.tblview_petbreed == tableView {
            return self.Pet_breed.count
        }else{
            return self.petgender.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.tblview_pettype == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Ptype", for: indexPath)
            cell.textLabel?.text = self.pet_type[indexPath.row]
            cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            return cell
        }else if self.tblview_gender == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "gender", for: indexPath)
            cell.textLabel?.text = self.petgender[indexPath.row]
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
        self.tblview_gender.isHidden = true
        if self.tblview_petbreed ==  tableView {
            self.textfield_petbreed.text! = self.Pet_breed[indexPath.row]
        }else if self.tblview_pettype ==  tableView {
            self.textfield_pettype.text! = self.pet_type[indexPath.row]
            self.callpetbreedbyid(petid: self.petid[indexPath.row])
        }else{
            self.textfield_petgender.text = self.petgender[indexPath.row]
        }
    }
    
    @IBAction func action_pettype(_ sender: Any) {
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = false
        self.tblview_gender.isHidden = true
        
    }
    
    
    @IBAction func action_gender(_ sender: Any) {
        self.tblview_petbreed.isHidden = true
        self.tblview_pettype.isHidden = true
        self.tblview_gender.isHidden = false
    }
    
    
    @IBAction func action_petbreed(_ sender: Any) {
        if self.Pet_breed.count > 0 {
            self.tblview_petbreed.isHidden = false
            self.tblview_pettype.isHidden = true
            self.tblview_gender.isHidden = true
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
    
    @IBAction func action_showcalender(_ sender: Any) {
        self.view_calender.isHidden = false
    }
    
    @IBAction func action_GetDate(_ sender: Any) {
        self.view_calender.isHidden = true
    }
    
    @IBAction func action_submit(_ sender: Any) {
        if self.textfield_petname.text == "" {
            self.alert(Message: "Please enter Pet name")
        }else if self.textfield_pettype.text == "" {
            self.alert(Message: "Please select Pet type")
        }else if self.textfield_petbreed.text == "" {
            self.alert(Message: "Please select Pet breed")
        }else if self.textfield_petgender.text == "" {
            self.alert(Message: "Please select Pet gender")
        }else if self.textfield_petcolor.text == "" {
            self.alert(Message: "Please enter Pet color")
        }else if self.textfiled_petage.text == "" {
            self.alert(Message: "Please enter Pet age")
        }else{
            if self.isvaccin != false {
                if self.textfield_selectdate.text == "" {
                    self.alert(Message: "Please select vaccinated date")
                }else{
                    self.calladdpetdetails()
                }
            }else{
                self.calladdpetdetails()
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
    func alert(Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
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
                        self.tblview_gender.reloadData()
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
              "pet_name" , Servicefile.shared.checktextfield(textfield: self.textfield_petname.text!),
              "pet_type" , Servicefile.shared.checktextfield(textfield: self.textfield_pettype.text!),
              "pet_breed" , Servicefile.shared.checktextfield(textfield: self.textfield_petbreed.text!),
              "pet_gender" , Servicefile.shared.checktextfield(textfield: self.textfield_petgender.text!),
              "pet_color" , Servicefile.shared.checktextfield(textfield: self.textfield_petcolor.text!),
              "pet_weight" , Servicefile.shared.checkInttextfield(strtoInt: self.textfield_petweight.text!),
              "pet_age" , Servicefile.shared.checkInttextfield(strtoInt: self.textfiled_petage.text!),
              "vaccinated" , self.isvaccin,
              "last_vaccination_date" , Servicefile.shared.checktextfield(textfield: self.textfield_selectdate.text!),
              "default_status" , true,
              "date_and_time" , Servicefile.shared.ddmmyyyyHHmmssstringformat(date: Date()))
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petregister, method: .post, parameters:
            ["user_id": Servicefile.shared.userid,
             "pet_img" :"",
             "pet_name" : Servicefile.shared.checktextfield(textfield: self.textfield_petname.text!),
             "pet_type" : Servicefile.shared.checktextfield(textfield: self.textfield_pettype.text!),
             "pet_breed" : Servicefile.shared.checktextfield(textfield: self.textfield_petbreed.text!),
             "pet_gender" : Servicefile.shared.checktextfield(textfield: self.textfield_petgender.text!),
             "pet_color" : Servicefile.shared.checktextfield(textfield: self.textfield_petcolor.text!),
             "pet_weight" : Servicefile.shared.checkInttextfield(strtoInt: self.textfield_petweight.text!),
             "pet_age" : Servicefile.shared.checkInttextfield(strtoInt: self.textfiled_petage.text!),
             "vaccinated" : self.isvaccin,
             "last_vaccination_date" : Servicefile.shared.checktextfield(textfield: self.textfield_selectdate.text!),
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
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
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
    
}
