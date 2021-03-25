//
//  PetfilterpageViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 15/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class PetfilterpageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var specialza = [""]
    var orgspecialza = [""]
    var isspecialza = ["0"]
    
    @IBOutlet weak var view_apply: UIView!
    @IBOutlet weak var view_clearall: UIView!
    @IBOutlet weak var tbl_spec: UITableView!
    @IBOutlet weak var img_4up: UIImageView!
    @IBOutlet weak var img_3up: UIImageView!
    @IBOutlet weak var img_2up: UIImageView!
    @IBOutlet weak var img_1up: UIImageView!
    var selrate = 0
    var selspec = ""
    var selnearby = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_apply.view_cornor()
        self.view_clearall.view_cornor()
        self.callpetdetails()
        self.tbl_spec.delegate = self
        self.tbl_spec.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.specialza.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! filterTableViewCell
        if self.isspecialza[indexPath.row] == "1" {
            cell.img_radio.image = UIImage(named: "selectedRadio")
        }else{
            cell.img_radio.image = UIImage(named: "Radio")
        }
        cell.label_spec.text = self.specialza[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isspecialza = self.orgspecialza
        self.isspecialza.remove(at: indexPath.row)
        self.isspecialza.insert("1", at: indexPath.row)
        self.selspec = self.specialza[indexPath.row]
        self.tbl_spec.reloadData()
    }
    
    @IBAction func action_clearall(_ sender: Any) {
        self.isspecialza = self.orgspecialza
        self.tbl_spec.reloadData()
        self.img_1up.image = UIImage(named: "Radio")
        self.img_2up.image = UIImage(named: "Radio")
        self.img_3up.image = UIImage(named: "Radio")
        self.img_4up.image = UIImage(named: "Radio")
        self.selrate = 0
        self.selspec = ""
        self.selnearby = 0
    }
    
    @IBAction func action_apply(_ sender: Any) {
        self.callapply()
        print ("user_id" ,Servicefile.shared.userid,
               "specialization", self.selspec,
               "nearby", self.selnearby,
               "Review_count" , self.selrate)
    }
    
    @IBAction func action_4up(_ sender: Any) {
        self.img_1up.image = UIImage(named: "Radio")
        self.img_2up.image = UIImage(named: "Radio")
        self.img_3up.image = UIImage(named: "Radio")
        self.img_4up.image = UIImage(named: "selectedRadio")
        self.selrate = 4
    }
    
    @IBAction func action_3up(_ sender: Any) {
        self.img_1up.image = UIImage(named: "Radio")
        self.img_2up.image = UIImage(named: "Radio")
        self.img_3up.image = UIImage(named: "selectedRadio")
        self.img_4up.image = UIImage(named: "Radio")
        self.selrate = 3
    }
    
    @IBAction func action2up(_ sender: Any) {
        self.img_1up.image = UIImage(named: "Radio")
        self.img_2up.image = UIImage(named: "selectedRadio")
        self.img_3up.image = UIImage(named: "Radio")
        self.img_4up.image = UIImage(named: "Radio")
        self.selrate = 2
    }
    
    @IBAction func action_1up(_ sender: Any) {
        self.img_1up.image = UIImage(named: "selectedRadio")
        self.img_2up.image = UIImage(named: "Radio")
        self.img_3up.image = UIImage(named: "Radio")
        self.img_4up.image = UIImage(named: "Radio")
        self.selrate = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? Pet_searchlist_DRViewController {
            DispatchQueue.main.async {
                firstVC.viewWillAppear(true)
            }
        }
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
                        _ = Data["pet_handle"] as! NSArray
                        _ = Data["communication_type"] as! NSArray
                        self.specialza.removeAll()
                        self.isspecialza.removeAll()
                        for item in 0..<specialzation.count{
                            let pb = specialzation[item] as! NSDictionary
                            let pbv = pb["specialzation"] as? String ?? ""
                            if pbv != "" {
                                self.specialza.append(pbv)
                                self.isspecialza.append("0")
                            }
                           
                        }
                        self.orgspecialza = self.isspecialza
                        self.tbl_spec.reloadData()
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
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
    func callapply(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.filter, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid,
             "specialization": self.selspec,
             "nearby": self.selnearby,
             "Review_count" : self.selrate], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        Servicefile.shared.moredocd.removeAll()
                        let Data = res["Data"] as! NSArray
                        for itm in 0..<Data.count{
                            let dat = Data[itm] as! NSDictionary
                            let _id = dat["_id"] as? String ?? ""
                            let amount = String(dat["amount"] as? Int ?? 0)
                            let clinic_loc = dat["clinic_loc"] as? String ?? ""
                            let clinic_name = dat["clinic_name"] as? String ?? ""
                            let communication_type = dat["communication_type"] as? String ?? ""
                            let distance = dat["distance"] as? String ?? ""
                            let doctor_img = dat["doctor_img"] as? String ?? ""
                            let doctor_name = dat["doctor_name"] as? String ?? ""
                            let dr_title = dat["dr_title"] as? String ?? ""
                            let review_count = String(dat["review_count"] as? Int ?? 0)
                            let specializations = dat["specialization"] as! NSArray
                            Servicefile.shared.specd.removeAll()
                            for i in 0..<specializations.count{
                                let item = specializations[i] as! NSDictionary
                                let specialization = item["specialization"] as? String ?? ""
                                Servicefile.shared.specd.append(spec.init(i_spec: specialization))
                            }
                            let star_count = String(Double(truncating: dat["star_count"] as? NSNumber ?? 0.0))
                            let user_id = dat["user_id"] as? String ?? ""
                            Servicefile.shared.moredocd.append(moredoc.init(I_id: _id, I_clinic_loc: clinic_loc, I_clinic_name: clinic_name, I_communication_type: communication_type, I_distance: distance, I_doctor_img: doctor_img, I_doctor_name: doctor_name, I_dr_title: dr_title, I_review_count: review_count, I_star_count: star_count, I_user_id: user_id, I_specialization:  Servicefile.shared.specd, in_amount: amount))
                        }
                        self.stopAnimatingActivityIndicator()
                        self.dismiss(animated: true, completion: nil)
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
