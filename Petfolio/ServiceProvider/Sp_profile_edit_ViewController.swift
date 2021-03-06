//
//  Sp_profile_edit_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//


import UIKit
import Alamofire
import Toucan
import MobileCoreServices
import CoreLocation
import SDWebImage

class Sp_profile_edit_ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UITextViewDelegate, UIDocumentPickerDelegate, UIDocumentMenuDelegate, CLLocationManagerDelegate , UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let locationManager = CLLocationManager()
    var latitude : Double!
    var longitude : Double!
    let imagepicker = UIImagePickerController()
    var Img_uploadarea = "clinic"
    var locationaddress = ""
    
    @IBOutlet weak var view_Bus_name: UIView!
    @IBOutlet weak var view_addservice: UIView!
    @IBOutlet weak var view_Service_Btn_add: UIView!
    @IBOutlet weak var view_submit: UIView!
    
    @IBOutlet weak var textfield_Bus_name: UITextField!
    @IBOutlet weak var textfield_servicename: UITextField!
    @IBOutlet weak var textfield_spec: UITextField!
    
    @IBOutlet weak var coll_selservice: UICollectionView!
    @IBOutlet weak var coll_service: UICollectionView!
    @IBOutlet weak var coll_galary_img: UICollectionView!
    @IBOutlet weak var coll_certificate: UICollectionView!
    @IBOutlet weak var coll_speclist: UICollectionView!
    @IBOutlet weak var coll_selspec: UICollectionView!
    
    @IBOutlet weak var image_photo_id: UIImageView!
    @IBOutlet weak var image_gov: UIImageView!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_btn_ok: UIView!
    @IBOutlet weak var view_picker: UIView!
    @IBOutlet weak var tbl_service_list: UITableView!
    @IBOutlet weak var picker_time: UIPickerView!
    @IBOutlet weak var textfield_amt: UITextField!
    
    @IBOutlet weak var view_photo_id_close: UIView!
    @IBOutlet weak var view_govid_close: UIView!
    
    var selservice = ["0"]
    var selspec = ["0"]
    var added_service = [""]
    var added_spec = [""]
    var image_photo = ""
    var image_govid = ""
    var img_for = "Gall" // Photo or Gov or Certi
    var timeindex = 0
    var tblindex = 0
    
    
    @IBOutlet weak var textview_spaddress: UITextView!
    
    @IBOutlet weak var view_clinicaddress: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.textview_spaddress.delegate = self
        self.textview_spaddress.isUserInteractionEnabled = false
        self.call_protocals()
        self.callSP_Ser_Spec_get()
        self.added_service.removeAll()
        self.added_spec.removeAll()
        self.selservice.removeAll()
        self.selspec.removeAll()
        Servicefile.shared.servicelist.removeAll()
        Servicefile.shared.selectedamount.removeAll()
        Servicefile.shared.selectedservice.removeAll()
        Servicefile.shared.sertime.removeAll()
        Servicefile.shared.speclist.removeAll()
        self.view_photo_id_close.layer.cornerRadius =  self.view_photo_id_close.frame.size.height / 2
        self.view_govid_close.layer.cornerRadius =  self.view_govid_close.frame.size.height / 2
    }
    
    func call_protocals(){
        self.call_delegates()
        self.viewcornordadius()
        self.setimag()
        
    }
    
    func call_delegates(){
        self.view_picker.isHidden = true
        self.view_popup.isHidden = true
        self.view_shadow.isHidden = true
        self.imagepicker.delegate = self
        self.textfield_servicename.delegate = self
        self.textfield_Bus_name.delegate = self
        self.textfield_spec.delegate = self
        self.textfield_amt.delegate = self
        
        self.textfield_servicename.autocapitalizationType = .sentences
        self.textfield_Bus_name.autocapitalizationType = .sentences
            
        self.collectiondelegate()
    }
    
    func collectiondelegate(){
        
        self.picker_time.delegate = self
        self.picker_time.dataSource = self
        
        self.coll_galary_img.delegate = self
        self.coll_galary_img.dataSource = self
        
        self.coll_certificate.delegate = self
        self.coll_certificate.dataSource = self
        
        self.coll_selservice.delegate = self
        self.coll_selservice.dataSource = self
        
        self.coll_selspec.delegate = self
        self.coll_selspec.dataSource = self
        
        self.coll_speclist.delegate = self
        self.coll_speclist.dataSource = self
        
        self.tbl_service_list.delegate = self
        self.tbl_service_list.dataSource = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
              if textField == self.textfield_servicename {
               let aSet = NSCharacterSet(charactersIn: Servicefile.approvestring).inverted
                  let compSepByCharInSet = string.components(separatedBy: aSet)
                  let numberFiltered = compSepByCharInSet.joined(separator: "")
                  return string == numberFiltered
              }
              if textField == self.textfield_Bus_name {
                  let aSet = NSCharacterSet(charactersIn: Servicefile.approvestring).inverted
                  let compSepByCharInSet = string.components(separatedBy: aSet)
                  let numberFiltered = compSepByCharInSet.joined(separator: "")
                  return string == numberFiltered
              }
              if textField == self.textfield_spec{
                  let aSet = NSCharacterSet(charactersIn: Servicefile.approvestring).inverted
                  let compSepByCharInSet = string.components(separatedBy: aSet)
                  let numberFiltered = compSepByCharInSet.joined(separator: "")
                  return string == numberFiltered
              }
               if textField == self.textfield_amt{
               let aSet = NSCharacterSet(charactersIn: Servicefile.approvednumber).inverted
               let compSepByCharInSet = string.components(separatedBy: aSet)
               let numberFiltered = compSepByCharInSet.joined(separator: "")
               return string == numberFiltered
               }
              return true
          }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("location",Servicefile.shared.sp_loc, Servicefile.shared.sp_lat,Servicefile.shared.sp_long)
        self.textview_spaddress.text = Servicefile.shared.sp_loc
    }
    
    
    @IBAction func action_change_location(_ sender: Any) {
        let vc = UIStoryboard.Doc_new_setlocation_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        self.latLong(lat: self.latitude,long: self.longitude)
        self.locationManager.stopUpdatingLocation()
    }
    
    func latLong(lat: Double,long: Double)  {
        if Servicefile.shared.updateUserInterface(){
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lat , longitude: long)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                var pm: CLPlacemark!
                pm = placemarks?[0]
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                
                self.locationaddress = addressString
                print(addressString)
            })
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_resign()
        return true
    }
    
    func textfield_resign(){
        self.textfield_spec.resignFirstResponder()
        self.textfield_Bus_name.resignFirstResponder()
        self.textfield_servicename.resignFirstResponder()
        self.textfield_amt.resignFirstResponder()
    }
    
    func viewcornordadius(){
        self.view_submit.submit_cornor()
        self.view_Service_Btn_add.view_cornor()
        self.view_popup.view_cornor()
        self.view_shadow.view_cornor()
        self.view_btn_ok.view_cornor()
    }
    
    @IBAction func action_gallary_pic_upload(_ sender: Any) {
        self.img_for = "Gall"
        self.callgalaryimageprocess()
    }
    
    @IBAction func action_photo_upload(_ sender: Any) {
        self.img_for = "Photo"
        self.callgalaryprocess()
    }
    
    @IBAction func action_gov_upload(_ sender: Any) {
        
        self.img_for = "Gov"
        self.callgalaryprocess()
    }
    
    @IBAction func action_certificate_upload(_ sender: Any) {
        self.img_for = "Certi"
        self.callgalaryprocess()
    }
    
    @IBAction func action_add_servicename(_ sender: Any) {
        if self.textfield_servicename.text != "" {
            self.added_service.append(self.textfield_servicename.text!)
        }else{
            self.alert(Message: "Please enter the service")
        }
        self.coll_selservice.reloadData()
        self.textfield_servicename.text = ""
    }
    
    
    @IBAction func action_add_spec(_ sender: Any) {
        if self.textfield_spec.text != "" {
            self.added_spec.append(self.textfield_spec.text!)
        }else {
            self.alert(Message: "Please enter the specialization")
        }
        self.coll_selspec.reloadData()
        self.textfield_spec.text = ""
    }
    
    
    
    
    @IBAction func action_submit(_ sender: Any) {
        Servicefile.shared.speclistdicarray.removeAll()
        Servicefile.shared.servicelistdicarray.removeAll()
        for itm in 0..<self.selservice.count {
            if self.selservice[itm] == "1" {
                var ser = Servicefile.shared.servicelistdicarray
                var serarr = ser
                let a = ["bus_service_list": Servicefile.shared.servicelist[itm],
                         "time_slots":Servicefile.shared.selectedservice[itm],
                         "amount":Servicefile.shared.selectedamount[itm]] as NSDictionary
                serarr.append(a)
                ser = serarr
                print(ser)
                Servicefile.shared.servicelistdicarray = ser
                
            }
        }
        for itm in 0..<self.added_service.count {
            var ser = Servicefile.shared.servicelistdicarray
            var serarr = ser
            let a = ["bus_service_list": self.added_service[itm],
                     "time_slots":Servicefile.shared.selectedservice[itm],
                     "amount":0] as NSDictionary
            serarr.append(a)
            ser = serarr
            print(ser)
            Servicefile.shared.servicelistdicarray = ser
            // print("uploaded data in servicelistdicarray",Servicefile.shared.servicelistdicarray)
        }
        for itm in 0..<self.selspec.count {
            if self.selspec[itm] == "1" {
                var spec = Servicefile.shared.speclistdicarray
                var arr = spec
                let ar = ["bus_spec_list": Servicefile.shared.speclist[itm]] as NSDictionary
                arr.append(ar)
                spec = arr
                print(spec)
                Servicefile.shared.speclistdicarray = spec
            }
        }
        
        for itm in 0..<self.added_spec.count {
            var spec = Servicefile.shared.speclistdicarray
            var arr = spec
            let ar = ["bus_spec_list": added_spec[itm]] as NSDictionary
            arr.append(ar)
            spec = arr
            print(spec)
            Servicefile.shared.speclistdicarray = spec
            //print("uploaded data in speclistdicarray",Servicefile.shared.speclistdicarray)
        }
        
        if self.textfield_Bus_name.text == "" {
            self.alert(Message: "Please enter the business name")
        }else if Servicefile.shared.servicelistdicarray.count == 0 {
            self.alert(Message: "Please select service")
        }else if Servicefile.shared.speclistdicarray.count == 0 {
            self.alert(Message: "Please select Specialization")
        }else if Servicefile.shared.gallerydicarray.count == 0 {
            self.alert(Message: "Please upload the Gallary image")
        }else if self.image_photo == "" {
            self.alert(Message: "Please upload the Photo ID")
        }else if self.image_govid == "" {
            self.alert(Message: "Please upload the Goverment Id")
        }else if Servicefile.shared.certifdicarray.count == 0 {
            self.alert(Message: "Please upload the certificates")
        }else{
            self.callDocspec()
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Servicefile.shared.sertime.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Servicefile.shared.sertime[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Servicefile.shared.selectedservice.remove(at: self.timeindex)
        Servicefile.shared.selectedservice.insert( Servicefile.shared.sertime[row], at: self.timeindex)
        
    }
    
    @IBAction func action_addtTmeandAmt(_ sender: Any) {
        self.textfield_resign()
        if self.textfield_amt.text! == "" || self.textfield_amt.text! == "0" {
            self.alert(Message: "Please enter valid Service amount")
        }else{
            Servicefile.shared.selectedamount.remove(at: self.tblindex)
            Servicefile.shared.selectedamount.insert(Int(self.textfield_amt.text!)!, at: self.tblindex)
            self.view_picker.isHidden = true
            self.tbl_service_list.reloadData()
            self.selservice.append("0")
            if self.selservice[self.tblindex] == "1" {
                self.selservice.remove(at: self.tblindex)
                self.selservice.insert("0", at: self.tblindex)
            }else{
                self.selservice.remove(at: self.tblindex)
                self.selservice.insert("1", at: self.tblindex)
            }
            self.tbl_service_list.reloadData()
        }
        
    }
    
    @IBAction func action_closeamtview(_ sender: Any) {
        self.textfield_resign()
        self.view_picker.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.servicelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! service_select_TableViewCell
        cell.label_service.text = Servicefile.shared.servicelist[indexPath.row]
        cell.selectionStyle = .none
        if self.selservice[indexPath.row] != "0" {
            cell.imag_check.image = UIImage(named: imagelink.checkbox_1)
            cell.view_time.isHidden = false
            cell.view_amt.isHidden = false
        } else{
            cell.imag_check.image = UIImage(named: imagelink.checkbox)
            cell.view_time.isHidden = true
            cell.view_amt.isHidden = true
        }
        cell.label_amt.text = "₹ " + String(Servicefile.shared.selectedamount[indexPath.row])
        cell.label_time.text = Servicefile.shared.selectedservice[indexPath.row]
        cell.btn_drop.tag = indexPath.row
        cell.btn_drop.addTarget(self, action: #selector(clickdropdown), for: .touchUpInside)
        return cell
    }
    
    @objc func clickdropdown(sender: UIButton){
        let tag = sender.tag
        self.timeindex = tag
        self.view_picker.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selservice[indexPath.row] == "1" {
            self.selservice.remove(at: indexPath.row)
            self.selservice.insert("0", at: indexPath.row)
            self.tbl_service_list.reloadData()
        }else{
            self.textfield_amt.text = ""
            self.tblindex = indexPath.row
            self.view_picker.isHidden = false
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if coll_galary_img ==  collectionView {
            return Servicefile.shared.gallerydicarray.count
        }else if coll_certificate == collectionView {
            return Servicefile.shared.certifdicarray.count
        }else if coll_speclist == collectionView{
            return Servicefile.shared.speclist.count
        }else if coll_selservice == collectionView{
            return self.added_service.count
        }else{
            return self.added_spec.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if coll_galary_img == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galary", for: indexPath) as! imgidCollectionViewCell
            
            let imgdat = Servicefile.shared.gallerydicarray[indexPath.row] as! NSDictionary
            print("clinic data in", imgdat)
            cell.Img_id.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.Img_id.sd_setImage(with: Servicefile.shared.StrToURL(url: (imgdat["bus_service_gall"]  as? String ?? Servicefile.sample_img))) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.Img_id.image = UIImage(named: imagelink.sample)
                } else {
                    cell.Img_id.image = image
                }
            }
            cell.view_close.layer.cornerRadius =  cell.view_close.frame.size.height / 2
            cell.btn_close.tag = indexPath.row
            cell.btn_close.addTarget(self, action: #selector(action_close_gallary), for: .touchUpInside)
            cell.Img_id.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            return cell
        }else if coll_certificate == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "certifi", for: indexPath) as! imgidCollectionViewCell
            cell.view_close.layer.cornerRadius =  cell.view_close.frame.size.height / 2
            cell.btn_close.tag = indexPath.row
            cell.btn_close.addTarget(self, action: #selector(action_close_certifid), for: .touchUpInside)
            let imgdat = Servicefile.shared.certifdicarray[indexPath.row] as! NSDictionary
            let strdat = imgdat["bus_certif"] as? String ?? Servicefile.sample_img
            if self.spilit_string_data(array_string: strdat) == "" {
                cell.Img_id.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
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
            return cell
        }else if coll_speclist == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spec", for: indexPath) as! checkupCollectionViewCell
            cell.title.text = Servicefile.shared.speclist[indexPath.row]
            
            if self.selspec[indexPath.row] != "0" {
                cell.img_check.image = UIImage(named: imagelink.checkbox_1)
            } else{
                cell.img_check.image = UIImage(named: imagelink.checkbox)
            }
            return cell
        } else if coll_selservice == collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "servcell", for: indexPath) as! selectedCollectionViewCell
            cell.label_title.text = self.added_service[indexPath.row]
            cell.btn_close.tag = indexPath.row
            cell.btn_close.addTarget(self, action: #selector(sel_serli), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "speccell", for: indexPath) as! selectedCollectionViewCell
            cell.label_title.text = self.added_spec[indexPath.row]
            cell.btn_close.tag = indexPath.row
            cell.btn_close.addTarget(self, action: #selector(sel_spec), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if coll_galary_img == collectionView {
            return CGSize(width: 100 , height:  100)
        }else if coll_certificate == collectionView {
            return CGSize(width: 100 , height:  100)
        }else if coll_speclist == collectionView {
            return CGSize(width: self.coll_speclist.frame.width / 2.1 , height:  40)
        }else{
            return CGSize(width: 100 , height:  40)
        }
    }
    
    @IBAction func action_close_photoid(_ sender: Any) {
        self.image_photo = ""
        self.setimag()
        self.view_photo_id_close.isHidden = true
    }
    
    @IBAction func action_close_govid(_ sender: Any) {
        self.img_for = ""
        self.setimag()
        self.view_photo_id_close.isHidden = true
    }
    
    
    
    
    @objc func action_close_certifid(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.certifdicarray.remove(at: tag)
        self.coll_certificate.reloadData()
    }
    @objc func action_close_gallary(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.gallerydicarray.remove(at: tag)
        self.coll_galary_img.reloadData()
    }
    
    @objc func sel_serli(sender: UIButton){
        let tag = sender.tag
        self.added_service.remove(at: tag)
        self.coll_selservice.reloadData()
        
    }
    
    @objc func sel_spec(sender: UIButton){
        let tag = sender.tag
        self.added_service.remove(at: tag)
        self.coll_selspec.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if coll_speclist == collectionView {
            if self.selspec[indexPath.row] == "1" {
                self.selspec.remove(at: indexPath.row)
                self.selspec.insert("0", at: indexPath.row)
            }else{
                self.selspec.remove(at: indexPath.row)
                self.selspec.insert("1", at: indexPath.row)
            }
        }
        self.coll_speclist.reloadData()
        //self.coll_service.reloadData()
    }
    
    
    
    func spilit_string_data(array_string: String)-> String{
        let str = array_string.split(separator: ".")
        if str.last == "pdf" {
            return "pdf"
        }else if str.last == "PDF" {
            return "pdf"
        }else{
            return ""
        }
    }
    
    func setimag(){
        if self.image_photo != "" {
            self.image_photo_id.isHidden = false
            let strdat = self.image_photo as? String ?? Servicefile.sample_img
            if self.spilit_string_data(array_string: strdat) == "" {
                self.image_photo_id.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                self.image_photo_id.sd_setImage(with: Servicefile.shared.StrToURL(url: strdat)) { (image, error, cache, urls) in
                    if (error != nil) {
                        self.image_photo_id.image = UIImage(named: Servicefile.sample_img)
                    } else {
                        self.image_photo_id.image = image
                    }
                }
            }else{
                self.image_photo_id.image = UIImage(named: "pdf")
            }
            
            self.view_photo_id_close.isHidden = false
        }else{
            self.image_photo_id.isHidden = true
            self.view_photo_id_close.isHidden = true
        }
        
        if self.image_govid != "" {
            self.image_gov.isHidden = false
            let strdat = self.image_govid as? String ?? Servicefile.sample_img
            if self.spilit_string_data(array_string: strdat) == "" {
                self.image_gov.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                self.image_gov.sd_setImage(with: Servicefile.shared.StrToURL(url: strdat)) { (image, error, cache, urls) in
                    if (error != nil) {
                        self.image_gov.image = UIImage(named: Servicefile.sample_img)
                    } else {
                        self.image_gov.image = image
                    }
                }
            }else{
                self.image_gov.image = UIImage(named: "pdf")
            }
            self.image_gov.image = UIImage(named: "pdf")
            self.view_govid_close.isHidden = false
        }else{
            self.image_gov.isHidden = true
            self.view_govid_close.isHidden = true
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
        alert.addAction(UIAlertAction(title: "Pick from Gallery", style: UIAlertAction.Style.default, handler: { action in
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
        alert.addAction(UIAlertAction(title: "Pick from Gallery", style: UIAlertAction.Style.default, handler: { action in
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
            //let reimage = Toucan(image: pickedImg).resize(CGSize(width: 100, height: 100), fitMode: Toucan.Resize.FitMode.crop).image
            let convertimg = pickedImg.resized(withPercentage: CGFloat(Servicefile.shared.imagequantity))
            self.upload(imagedata: convertimg!)
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
                        let Data = res["Data"]  as? String ?? Servicefile.sample_img
                        print("Uploaded file url:",Data)
                        if self.img_for == "Gall" {
                            var B = Servicefile.shared.gallerydicarray
                            var arr = B
                            let a = ["bus_service_gall":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.gallerydicarray = B
                            print("uploaded data in certifi",Servicefile.shared.gallerydicarray)
                        }
                        
                        if self.img_for == "Certi" {
                            var B = Servicefile.shared.certifdicarray
                            var arr = B
                            let a = ["bus_certif":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.certifdicarray = B
                            print("uploaded data in certifi",Servicefile.shared.certifdicarray)
                        }
                        
                        if self.img_for == "Gov" {
                            self.image_govid = Data
                        }
                        
                        if self.img_for == "Photo" {
                            self.image_photo = Data
                        }
                        
                        self.setimag()
                        self.stopAnimatingActivityIndicator()
                        self.coll_galary_img.reloadData()
                        self.coll_certificate.reloadData()
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
                        let Data = res["Data"]  as? String ?? Servicefile.sample_img
                        print("Uploaded file url:",Data, self.img_for)
                        
                        if self.img_for == "Certi" {
                            var B = Servicefile.shared.certifdicarray
                            var arr = B
                            let a = ["bus_certif":Data] as NSDictionary
                            arr.append(a)
                            B = arr
                            print(B)
                            Servicefile.shared.certifdicarray = B
                            print("uploaded data in certifi",Servicefile.shared.certifdicarray)
                        }
                        
                        if self.img_for == "Gov" {
                            self.image_govid = Data
                        }
                        
                        if self.img_for == "Photo" {
                            self.image_photo = Data
                        }
                        
                        self.setimag()
                        self.coll_certificate.reloadData()
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
   
    func callDocspec(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.sp_Profile_edit, method: .post, parameters:
            [ "_id" : Servicefile.shared.sp_id,
              "user_id": Servicefile.shared.userid,
              "sp_loc": Servicefile.shared.sp_loc,
              "sp_lat": Servicefile.shared.sp_lat,
              "sp_long": Servicefile.shared.sp_long,
              "bus_user_name": Servicefile.shared.first_name,
              "bus_user_email": Servicefile.shared.user_email,
              "profile_status": true,
              "profile_verification_status":"Not verified",
              "bussiness_name": Servicefile.shared.checktextfield(textfield: self.textfield_Bus_name.text!),
              "bus_user_phone": Servicefile.shared.user_phone,
              "bus_service_list": Servicefile.shared.servicelistdicarray,
              "bus_spec_list": Servicefile.shared.speclistdicarray,
              "bus_service_gall": Servicefile.shared.gallerydicarray,
              "bus_profile": self.image_photo,
              "bus_proof": self.image_govid,
              "bus_certif": Servicefile.shared.certifdicarray,
              "date_and_time": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
              "mobile_type" : "IOS"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        _ = res["Data"] as! NSDictionary
                        self.view_shadow.isHidden = false
                        self.view_popup.isHidden = false
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
    
    @IBAction func action_update_popup(_ sender: Any) {
        let vc = UIStoryboard.Sp_dash_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func callSP_Ser_Spec_get(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.sp_dropdown, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let service_list = Data["service_list"] as! NSArray
                        let Specialization = Data["Specialization"] as! NSArray
                        let sertime = Data["time"] as! NSArray
                        self.selservice.removeAll()
                        self.selspec.removeAll()
                        Servicefile.shared.servicelist.removeAll()
                        Servicefile.shared.selectedamount.removeAll()
                        Servicefile.shared.selectedservice.removeAll()
                        Servicefile.shared.sertime.removeAll()
                        Servicefile.shared.speclist.removeAll()
                        for itm in 0..<sertime.count{
                            let sitm = sertime[itm] as! NSDictionary
                            let slistitm = sitm["time"] as? String ?? ""
                            if slistitm != "" {
                                Servicefile.shared.sertime.append(slistitm)
                            }
                        }
                        for itm in 0..<service_list.count{
                            let ditm = service_list[itm] as! NSDictionary
                            let listitm = ditm["service_list"] as? String ?? ""
                            if listitm != "" {
                                Servicefile.shared.servicelist.append(listitm)
                                Servicefile.shared.selectedservice.append(Servicefile.shared.sertime[0])
                                Servicefile.shared.selectedamount.append(0)
                                self.selservice.append("0")
                            }
                        }
                        for itm in 0..<Specialization.count{
                            let ditm = Specialization[itm] as! NSDictionary
                            let listitm = ditm["Specialization"] as? String ?? ""
                            if listitm != "" {
                                Servicefile.shared.speclist.append(listitm)
                                self.selspec.append("0")
                            }
                        }
                        
                        self.coll_speclist.reloadData()
                        //self.coll_service.reloadData()
                        self.callSp_details()
                        self.coll_speclist.reloadData()
                        //self.coll_service.reloadData()
                        self.tbl_service_list.reloadData()
                        self.picker_time.reloadAllComponents()
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
                }        }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
}


extension Sp_profile_edit_ViewController {
    func callSp_details(){
        Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.sp_dash_get, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let bus_certif = Data["bus_certif"] as! NSArray
                        let _id  = Data["_id"] as? String ?? ""
                        let bus_profile  = Data["bus_profile"] as? String ?? ""
                        let bus_proof  = Data["bus_proof"] as? String ?? ""
                        let bus_user_email  = Data["bus_user_email"] as? String ?? ""
                        let bus_user_name  = Data["bus_user_name"] as? String ?? ""
                        let bus_user_phone  = Data["bus_user_phone"] as? String ?? ""
                        let bussiness_name  = Data["bussiness_name"] as? String ?? ""
                        let date_and_time  = Data["date_and_time"] as? String ?? ""
                        let delete_status  = Data["delete_status"] as? Bool ?? false
                        let profile_status  = Data["profile_status"] as? Bool ?? false
                        let profile_verification_status  = Data["profile_verification_status"] as? String ?? ""
                        let sp_lat  = Data["sp_lat"] as? Double ?? 0.0
                        let sp_long  = Data["sp_long"] as? Double ?? 0.0
                        let sp_loc  = Data["sp_loc"] as? String ?? ""
                        let user_id  = Data["user_id"] as? String ?? ""
                        let bus_service_gall = Data["bus_service_gall"] as! NSArray
                        let bus_service_list = Data["bus_service_list"] as! NSArray
                        let bus_spec_list = Data["bus_spec_list"] as! NSArray
                        Servicefile.shared.Sp_bus_certifdicarray.removeAll()
                        Servicefile.shared.sp_bus_service_galldicarray.removeAll()
                        Servicefile.shared.sp_bus_service_list.removeAll()
                        Servicefile.shared.sp_bus_spec_list.removeAll()
                        Servicefile.shared.sp_id = _id
                        Servicefile.shared.sp_bus_profile = bus_profile
                        Servicefile.shared.sp_bus_proof = bus_proof
                        Servicefile.shared.Sp_bus_certifdicarray =  bus_certif as! [Any]
                        Servicefile.shared.sp_bus_service_galldicarray = bus_service_gall as! [Any]
                        Servicefile.shared.sp_bus_service_list = bus_service_list as! [Any]
                        Servicefile.shared.sp_bus_spec_list = bus_spec_list as! [Any]
                        Servicefile.shared.sp_bus_user_email = bus_user_email
                        Servicefile.shared.sp_bus_user_name = bus_user_name
                        Servicefile.shared.sp_bus_user_phone = bus_user_phone
                        Servicefile.shared.sp_bussiness_name = bussiness_name
                        Servicefile.shared.sp_date_and_time  = date_and_time
                        Servicefile.shared.sp_delete_status = delete_status
                        Servicefile.shared.sp_mobile_type = "IOS"
                        Servicefile.shared.sp_profile_status = profile_status
                        Servicefile.shared.sp_profile_verification_status = profile_verification_status
                        Servicefile.shared.sp_lat = sp_lat
                        Servicefile.shared.sp_loc = sp_loc
                        self.textview_spaddress.text = Servicefile.shared.sp_loc
                        Servicefile.shared.sp_long = sp_long
                        Servicefile.shared.sp_user_id = user_id
                        print("Details in certificate",Servicefile.shared.Sp_bus_certifdicarray)
                        self.resetdata()
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
    
    
    func resetdata(){
        self.selservice.removeAll()
        self.selspec.removeAll()
        for itm in 0..<Servicefile.shared.servicelist.count {
            let SP_itm = Servicefile.shared.servicelist[itm]
            self.selservice.append("0")
            for Edit_list in 0..<Servicefile.shared.sp_bus_service_list.count {
                let edit_itm = Servicefile.shared.sp_bus_service_list[Edit_list]
                let edit_str = edit_itm  as! NSDictionary
                if edit_str["bus_service_list"] as? String ?? "" == SP_itm {
                    print("data in edit profile",edit_itm)
                    let amt = edit_str["amount"] as? Int ?? 0
                    let time_slots = edit_str["time_slots"] as? String ?? ""
                    Servicefile.shared.selectedservice.remove(at: itm)
                    Servicefile.shared.selectedservice.insert(time_slots, at: itm)
                    Servicefile.shared.selectedamount.remove(at: itm)
                    Servicefile.shared.selectedamount.insert(amt, at: itm)
                    self.selservice.remove(at: itm)
                    self.selservice.insert("1", at: itm)
                }
            }
        }
        for itme in 0..<Servicefile.shared.speclist.count {
            let SP_itm = Servicefile.shared.speclist[itme]
            self.selspec.append("0")
            for Edit_speclist in 0..<Servicefile.shared.sp_bus_spec_list.count {
                let edit_specitm =  Servicefile.shared.sp_bus_spec_list[Edit_speclist]
                let edit_spestr = edit_specitm as! NSDictionary
                if  edit_spestr["bus_spec_list"] as? String ?? "" == SP_itm {
                    self.selspec.remove(at: itme)
                    self.selspec.insert("1", at: itme)
                }
            }
        }
        self.coll_speclist.reloadData()
        //self.coll_service.reloadData()
        self.tbl_service_list.reloadData()
        self.picker_time.reloadAllComponents()
        self.image_photo = Servicefile.shared.sp_bus_profile
        self.image_govid = Servicefile.shared.sp_bus_profile
        self.setimag()
        Servicefile.shared.gallerydicarray = Servicefile.shared.sp_bus_service_galldicarray
        Servicefile.shared.certifdicarray = Servicefile.shared.Sp_bus_certifdicarray
        self.coll_galary_img.reloadData()
        self.coll_certificate.reloadData()
        self.textfield_Bus_name.text = Servicefile.shared.sp_bussiness_name
    }
    
    
    
  
  
    
}
