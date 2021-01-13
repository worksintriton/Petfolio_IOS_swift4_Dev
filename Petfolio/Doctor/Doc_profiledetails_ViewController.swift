//
//  Doc_profiledetails_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 31/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Doc_profiledetails_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var label_username: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_phno: UILabel!
    @IBOutlet weak var coll_clinic: UICollectionView!
    @IBOutlet weak var label_spec: UILabel!
    @IBOutlet weak var label_pethandle: UILabel!
    @IBOutlet weak var label_clinicaddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coll_clinic.delegate = self
        self.coll_clinic.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.label_username.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.calldetails()
    }
//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.DOC_clinicdicarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
        let img = Servicefile.shared.DOC_clinicdicarray[indexPath.row] as! NSDictionary
        let imgval = img["clinic_pic"] as! String
         cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: imgval)) { (image, error, cache, urls) in
                               if (error != nil) {
                                   cell.img_banner.image = UIImage(named: "sample")
                               } else {
                                   cell.img_banner.image = image
                               }
                           }
        return cell
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func action_image_upload(_ sender: Any) {
        
    }
    
    @IBAction func action_move_edit_busi_info(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_update_details_ViewController") as! Doc_update_details_ViewController
               self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_editprofile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile_edit_ViewController") as! profile_edit_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func alert(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
             }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func calldetails(){
         Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.DOc_get_details, method: .post, parameters:
        ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    let Data = res["Data"] as! NSDictionary
                                                    var _id = Data["_id"] as! String
                                                    var calender_status = Data["calender_status"] as! Bool
                                                    var clinic_lat = Data["clinic_lat"] as! Double
                                                    var clinic_loc = Data["clinic_loc"] as! String
                                                    var clinic_long = Data["clinic_long"] as! Double
                                                    var clinic_name = Data["clinic_name"] as! String
                                                    var communication_type = Data["communication_type"] as! String
                                                     var consultancy_fees = Data["consultancy_fees"] as! Int
                                                    var date_and_time = Data["date_and_time"] as! String
                                                    var delete_status = Data["delete_status"] as! Bool
                                                    var dr_name = Data["dr_name"] as! String
                                                     var dr_title = Data["dr_title"] as! String
                                                   var profile_status = Data["profile_status"] as! Bool
                                                    var profile_verification_status = Data["profile_verification_status"] as! String
                                                     let user_id = Data["user_id"] as! String
                                                    let govt_id_pic = Data["govt_id_pic"] as! NSArray
                                                    let mobile_type = Data["mobile_type"] as! String
                                                    let pet_handled = Data["pet_handled"] as! NSArray
                                                    let photo_id_pic = Data["photo_id_pic"] as! NSArray
                                                    let specialization = Data["specialization"] as! NSArray
                                                    let education_details = Data["education_details"] as! NSArray
                                                    let experience_details = Data["experience_details"] as! NSArray
                                                    let clinic_pic = Data["clinic_pic"] as! NSArray
                                                    let certificate_pic = Data["certificate_pic"] as! NSArray
                                                    Servicefile.shared.DOC_edudicarray = education_details as! [Any]
                                                    Servicefile.shared.DOC_expdicarray = experience_details as! [Any]
                                                    Servicefile.shared.DOC_specdicarray = specialization as! [Any]
                                                    Servicefile.shared.DOC_pethandicarray = pet_handled as! [Any]
                                                    Servicefile.shared.DOC_clinicdicarray = clinic_pic  as! [Any]
                                                    Servicefile.shared.DOC_certifdicarray = certificate_pic  as! [Any]
                                                    Servicefile.shared.DOC_govdicarray  = govt_id_pic as! [Any]
                                                    Servicefile.shared.DOC_photodicarray = photo_id_pic as! [Any]
                                                    Servicefile.shared.communication_type = communication_type
                                                    Servicefile.shared.consultancy_fees = String(consultancy_fees)
                                                    Servicefile.shared.Doc_id = _id
                                                    Servicefile.shared.Doc_bussiness_name = clinic_name
                                                    Servicefile.shared.Doc_date_and_time  = date_and_time
                                                    Servicefile.shared.Doc_delete_status = delete_status
                                                    Servicefile.shared.Doc_mobile_type = mobile_type
                                                    Servicefile.shared.Doc_profile_status = profile_status
                                                    Servicefile.shared.Doc_profile_verification_status = profile_verification_status
                                                    Servicefile.shared.Doc_lat = clinic_lat
                                                    Servicefile.shared.Doc_loc = clinic_loc
                                                    Servicefile.shared.Doc_long = clinic_long
                                                    Servicefile.shared.Doc_user_id = user_id
                                                    var petdata = ""
                                                    for itm in 0..<Servicefile.shared.DOC_pethandicarray.count{
                                                        let pethandle_data = Servicefile.shared.DOC_pethandicarray[itm] as! NSDictionary
                                                        let pethandicarray = pethandle_data["pet_handled"] as! String
                                                        if itm == 0 {
                                                             petdata = pethandicarray
                                                        }else{
                                                             petdata = petdata + ", " + pethandicarray
                                                        }
                                                       
                                                    }
                                                    self.label_pethandle.text = petdata
                                                    var specdata = ""
                                                    for specitm in 0..<Servicefile.shared.DOC_specdicarray.count{
                                                        let specialization_data = Servicefile.shared.DOC_specdicarray[specitm] as! NSDictionary
                                                        let specdicarray = specialization_data["specialization"] as! String
                                                        if specitm == 0 {
                                                             specdata = specdicarray
                                                        }else {
                                                             specdata = specdata + ", " + specdicarray
                                                        }
                                                       
                                                    }
                                                    self.label_spec.text = specdata
                                                    
                                                    self.label_clinicaddress.text = Servicefile.shared.Doc_loc
                                                    self.coll_clinic.reloadData()
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