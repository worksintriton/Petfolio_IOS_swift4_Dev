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

class prescriptionViewController: UIViewController {

    
    
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_subtittle: UILabel!
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label_owner_name.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.callpescription()
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    
    func callpescription(){
    print("data in prescription")
             Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
            self.startAnimatingActivityIndicator()
      if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.view_prescription_create, method: .post, parameters: [
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
//                                                        "Prescription_data" =         (
//                                                                        {
//                                                                Quantity = 2;
//                                                                "Tablet_name" = Sample;
//                                                                consumption = "Morning - 1, Afternoon - 1, Night - 1";
//                                                            }
//                                                        );
                                                        
                                                        self.label_age.text = Data["age"] as? String ?? ""
                                                        self.label_alergies.text =  Data["allergies"] as? String ?? ""
                                                        self.label_diagnosis.text = Data["diagnosis"] as? String ?? ""
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
