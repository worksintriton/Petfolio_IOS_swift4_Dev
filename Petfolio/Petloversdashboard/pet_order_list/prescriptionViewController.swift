//
//  prescriptionViewController.swift
//  Petfolio
//
//  Created by Admin on 02/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class prescriptionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var label_pres: UILabel!
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_subtittle: UILabel!
    @IBOutlet weak var label_dr_id: UILabel!
    @IBOutlet weak var label_doc_address: UILabel!
    @IBOutlet weak var label_PH_no: UILabel!
    
    @IBOutlet weak var label_powered_title: UILabel!
    @IBOutlet weak var label_powered_ph: UILabel!
    
    @IBOutlet weak var label_breed: UILabel!
    @IBOutlet weak var label_owner_name: UILabel!
    @IBOutlet weak var label_pet_name: UILabel!
    @IBOutlet weak var label_pet_type: UILabel!
    @IBOutlet weak var label_petgender: UILabel!
    @IBOutlet weak var label_pet_weight: UILabel!
    @IBOutlet weak var label_age: UILabel!
    @IBOutlet weak var label_diagnosis: UILabel!
    @IBOutlet weak var label_subdiagnosis: UILabel!
    @IBOutlet weak var tbl_prescription: UITableView!
    @IBOutlet weak var img_signature: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_alergies: UILabel!
    @IBOutlet weak var label_doccomments: UILabel!
    
    @IBOutlet weak var label_doc_name: UILabel!
    
    @IBOutlet weak var image_preview: UIImageView!
    @IBOutlet weak var view_pres: UIView!
    
    @IBOutlet weak var view_manual: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.Doc_pres.removeAll()
        self.tbl_prescription.register(UINib(nibName: "previewdocpresTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.label_owner_name.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.tbl_prescription.delegate = self
        self.tbl_prescription.dataSource = self
        self.view_pres.isHidden = true
        self.callpescription()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.Doc_pres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! previewdocpresTableViewCell
        let presdata = Servicefile.shared.Doc_pres[indexPath.row] as! NSDictionary
        cell.label_title.text = presdata["Tablet_name"] as? String ?? ""
        let cons = presdata["consumption"] as? String ?? ""
        cell.label_consuption.text = cons
        cell.labe_count.text = presdata["Quantity"] as? String ?? ""
        return cell
    }
   
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    
    func callpescription(){
        var url = ""
        if Servicefile.shared.iswalkin {
            url = Servicefile.view_walkin_prescription_create
        }else{
            url = Servicefile.view_prescription_create
        }
    print("data in prescription Servicefile.shared.iswalkin",Servicefile.shared.iswalkin,url)
             Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
            self.startAnimatingActivityIndicator()
      if Servicefile.shared.updateUserInterface() { AF.request(url, method: .post, parameters: [
        "Appointment_ID": Servicefile.shared.pet_apoint_id]
           , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                        let Data = res["Data"] as? NSDictionary ?? ["":""]
                                                        self.label_doccomments.text = Data["Doctor_Comments"] as? String ?? ""
                                                        let Prescription_data = Data["Prescription_data"] as? NSArray ?? [Any]() as NSArray
                                                        Servicefile.shared.Doc_pres = Prescription_data as! [Any]
                                                        self.tbl_prescription.reloadData()
                                                        self.label_age.text = Data["age"] as? String ?? ""
                                                        self.label_alergies.text =  Data["allergies"] as? String ?? ""
                                                        self.label_diagnosis.text = Data["diagnosis"] as? String ?? ""
                                                        self.label_dr_id.text = Data["doctor_id"] as? String ?? ""
                                                        self.label_doc_address.text = Data["clinic_loc"] as? String ?? ""
                                                        self.label_PH_no.text = Data["clinic_no"] as? String ?? ""
                                                        self.label_pres.text = Data["Prescription_id"] as? String ?? ""
                                                        let signature = Data["digital_sign"] as? String ?? ""
                                                        self.img_signature.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                                                        self.img_signature.sd_setImage(with: Servicefile.shared.StrToURL(url:  signature)) { (image, error, cache, urls) in
                                                            if (error != nil) {
                                                                self.img_signature.image = UIImage(named: imagelink.sample)
                                                            } else {
                                                                self.img_signature.image = image
                                                            }
                                                        }
                                                        var spec = ""
                                                        let docspec = Data["doctor_speci"] as? NSArray ?? [Any]() as NSArray
                                                        var petha = ""
                                                        for i in 0..<docspec.count{
                                                            let pethan = docspec[i] as! NSDictionary
                                                            let val = pethan["specialization"] as? String ?? ""
                                                            if i == 0 {
                                                                if i == docspec.count-1 {
                                                                    petha = val + "."
                                                                }else{
                                                                    petha = val + ", "
                                                                }
                                                                
                                                            }else  if i == docspec.count-1 {
                                                                petha = petha + val + "."
                                                            }else{
                                                                petha = petha + ", " + val
                                                            }
                                                            
                                                        }
                                                        self.label_subtittle.text = petha
                                                        self.label_title.text =  Data["doctorname"] as? String ?? ""
                                                        self.label_doc_name.text =  Data["doctorname"] as? String ?? ""
                                                        Servicefile.shared.doc_diag_type =  Data["Prescription_type"] as? String ?? ""
                                                        if Servicefile.shared.doc_diag_type == "PDF"{
                                                            self.view_pres.isHidden = true
                                                            self.view_manual.isHidden = false
                                                        }else{
                                                            self.view_pres.isHidden = false
                                                            self.view_manual.isHidden = true
                                                        }
                                                        let presimg =  Data["Prescription_img"] as? String ?? ""
                                                        self.image_preview.sd_setImage(with: Servicefile.shared.StrToURL(url: presimg)) { (image, error, cache, urls) in
                                                            if (error != nil) {
                                                                self.image_preview.image = UIImage(named: imagelink.sample)
                                                            } else {
                                                                self.image_preview.image = image
                                                            }
                                                        }
                                                        self.label_petgender.text =  Data["gender"] as? String ?? ""
                                                       // "health_issue_title" = "Dental issues";
                                                        self.label_owner_name.text =  Data["owner_name"]  as? String ?? ""
                                                        self.label_breed.text =  Data["pet_breed"] as? String ?? ""
                                                        self.label_pet_name.text = Data["pet_name"] as? String ?? ""
                                                        self.label_pet_type.text = Data["pet_type"] as? String ?? ""
                                                        self.label_powered_ph.text = Data["phone_number"] as? String ?? ""
                                                        self.label_subdiagnosis.text = Data["sub_diagnosis"] as? String ?? ""
                                                        self.label_powered_title.text = Data["web_name"] as? String ?? ""
                                                        self.label_pet_weight.text = String(Data["weight"] as? Int ?? 0)
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
