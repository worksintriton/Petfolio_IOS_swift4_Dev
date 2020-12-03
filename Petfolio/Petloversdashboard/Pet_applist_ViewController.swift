//
//  Pet_applist_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 02/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Pet_applist_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var view_current: UIView!
       @IBOutlet weak var view_completed: UIView!
       @IBOutlet weak var view_cancelled: UIView!
    @IBOutlet weak var tbl_applist: UITableView!
    @IBOutlet weak var label_current: UILabel!
    @IBOutlet weak var label_complete: UILabel!
    @IBOutlet weak var label_cancelled: UILabel!
    
    @IBOutlet weak var view_footer: UIView!
    @IBOutlet weak var label_nodata: UILabel!
   
    
    var appointtype = "current"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_footer.layer.cornerRadius = 15.0
        self.view_current.layer.cornerRadius = 10.0
        self.view_cancelled.layer.cornerRadius = 10.0
        self.view_completed.layer.cornerRadius = 10.0
        self.view_current.layer.borderWidth = 0.5
        self.view_cancelled.layer.borderWidth = 0.5
        self.view_completed.layer.borderWidth = 0.5
         let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_cancelled.layer.borderColor = appcolor.cgColor
        self.tbl_applist.delegate = self
        self.tbl_applist.dataSource = self
        self.callnew()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.Doc_dashlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! docdashTableViewCell
        if self.appointtype == "current" {
            cell.view_commissed.isHidden = false
            cell.btn_complete.tag = indexPath.row
             cell.btn_cancel.tag = indexPath.row
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].book_date_time
            cell.labe_comMissed.text = "Booked on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else if self.appointtype == "Complete"{
             cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].book_date_time
            cell.labe_comMissed.text = "Completion on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            cell.view_commissed.isHidden = false
            cell.label_completedon.text = Servicefile.shared.Doc_dashlist[indexPath.row].book_date_time
             cell.labe_comMissed.text = "Cancelled on :"
            cell.label_completedon.textColor = UIColor.red
             cell.labe_comMissed.textColor = UIColor.red
        }
        cell.label_servicename.text = "Type : " + Servicefile.shared.Doc_dashlist[indexPath.row].appoinment_status
        if Servicefile.shared.Doc_dashlist[indexPath.row].appoinment_status == "Emergency" {
            cell.label_servicename.textColor = UIColor.red
        }else{
              cell.label_servicename.textColor = UIColor.black
        }
        
        cell.view_completebtn.layer.cornerRadius = 10.0
        cell.view_cancnel.layer.cornerRadius = 10.0
        cell.View_mainview.layer.borderWidth = 0.2
        cell.View_mainview.layer.borderColor = UIColor.lightGray.cgColor
        cell.label_petname.text = Servicefile.shared.Doc_dashlist[indexPath.row].pet_name
        cell.label_pettype.text = Servicefile.shared.Doc_dashlist[indexPath.row].pet_type
        cell.img_petimg.image = UIImage(named: "sample")
        cell.label_amount.text =  "₹" + Servicefile.shared.Doc_dashlist[indexPath.row].amount
        if Servicefile.shared.Doc_dashlist[indexPath.row].pet_img == "" {
              cell.img_petimg.image = UIImage(named: "sample")
        }else{
              cell.img_petimg.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.Doc_dashlist[indexPath.row].pet_img)) { (image, error, cache, urls) in
                        if (error != nil) {
                            cell.img_petimg.image = UIImage(named: "sample")
                        } else {
                            cell.img_petimg.image = image
                        }
                    }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    @IBAction func action_backaction(_ sender: Any) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
                          self.present(vc, animated: true, completion: nil)
       }

    @IBAction func action_cancelled(_ sender: Any) {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_cancelled.backgroundColor = appcolor
            self.label_cancelled.textColor = UIColor.white
            self.view_current.backgroundColor = UIColor.white
            self.label_current.textColor = appcolor
            self.label_complete.textColor = appcolor
            self.view_completed.backgroundColor = UIColor.white
            self.view_current.layer.borderColor = appcolor.cgColor
            self.view_current.backgroundColor = UIColor.white
            self.appointtype = "cancelled"
            self.callmiss()
            
        }
        @IBAction func action_completeappoint(_ sender: Any) {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_completed.backgroundColor = appcolor
            self.label_complete.textColor = UIColor.white
            self.view_current.backgroundColor = UIColor.white
            self.view_cancelled.backgroundColor = UIColor.white
            self.label_current.textColor = appcolor
            self.label_cancelled.textColor = appcolor
            self.view_current.layer.borderColor = appcolor.cgColor
            self.view_cancelled.layer.borderColor = appcolor.cgColor
            self.appointtype = "Complete"
            self.callcom()
           
        }
        @IBAction func action_currentappoint(_ sender: Any) {
            let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_current.backgroundColor = appcolor
            self.label_current.textColor = UIColor.white
            self.view_completed.backgroundColor = UIColor.white
            self.view_cancelled.backgroundColor = UIColor.white
            self.label_complete.textColor = appcolor
            self.label_cancelled.textColor = appcolor
            self.view_completed.layer.borderColor = appcolor.cgColor
            self.view_cancelled.layer.borderColor = appcolor.cgColor
            self.appointtype = "current"
            self.callnew()
            
        }
        
        @IBAction func action_logout(_ sender: Any) {
            
        }
        func callnew(){
             Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
            self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.plove_getlist_newapp, method: .post, parameters:
            ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                        Servicefile.shared.Doc_dashlist.removeAll()
                                                        let Data = res["Data"] as! NSArray
                                                        for itm in 0..<Data.count{
                                                            let dataitm = Data[itm] as! NSDictionary
                                                            let id = dataitm["_id"] as! String
                                                            let allergies = dataitm["allergies"] as! String
                                                            let amount = dataitm["amount"] as! String
                                                            let booking_date_time = dataitm["booking_date_time"] as! String
                                                            let appointment_types = dataitm["appointment_types"] as! String
                                                            let doc_business_info = dataitm["doc_business_info"] as! NSArray
                                                            var docimg = ""
                                                            var pet_name = ""
                                                            if doc_business_info.count > 0 {
                                                                let doc_business = doc_business_info[0] as! NSDictionary
                                                                let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                                                if clinic_pic.count > 0 {
                                                                    let imgdata = clinic_pic[0] as! NSDictionary
                                                                    docimg = imgdata["clinic_pic"] as! String
                                                                }
                                                                 pet_name = doc_business["clinic_name"] as! String
                                                            }
                                                            let petdetail = dataitm["pet_id"] as! NSDictionary
                                                            let petid = petdetail["_id"] as! String
                                                            let pet_type = petdetail["pet_name"] as! String
                                                            let pet_breed = petdetail["pet_breed"] as! String
                                                            let pet_img = petdetail["pet_img"] as! String
                                                            let user_id = petdetail["user_id"] as! String
                                                            Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time))
                                                        }
                                                       if Servicefile.shared.Doc_dashlist.count > 0 {
                                                            self.label_nodata.isHidden = true
                                                        }else{
                                                             self.label_nodata.isHidden = false
                                                        }
                                                        
    //
                                                        self.tbl_applist.reloadData()
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
        func callcom(){
                Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
               self.startAnimatingActivityIndicator()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.plove_getlist_comapp, method: .post, parameters:
               ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                            Servicefile.shared.Doc_dashlist.removeAll()
                                                            let Data = res["Data"] as! NSArray
                                                            for itm in 0..<Data.count{
                                                                let dataitm = Data[itm] as! NSDictionary
                                                                let id = dataitm["_id"] as! String
                                                                let allergies = dataitm["allergies"] as! String
                                                                let amount = dataitm["amount"] as! String
                                                                let booking_date_time = dataitm["booking_date_time"] as! String
                                                                let appointment_types = dataitm["appointment_types"] as! String
                                                                let doc_business_info = dataitm["doc_business_info"] as! NSArray
                                                                var docimg = ""
                                                                var pet_name = ""
                                                                if doc_business_info.count > 0 {
                                                                    let doc_business = doc_business_info[0] as! NSDictionary
                                                                    let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                                                    if clinic_pic.count > 0 {
                                                                        let imgdata = clinic_pic[0] as! NSDictionary
                                                                        docimg = imgdata["clinic_pic"] as! String
                                                                    }
                                                                     pet_name = doc_business["clinic_name"] as! String
                                                                }
                                                                let petdetail = dataitm["pet_id"] as! NSDictionary
                                                                let petid = petdetail["_id"] as! String
                                                                let pet_type = petdetail["pet_name"] as! String
                                                                let pet_breed = petdetail["pet_breed"] as! String
                                                                let pet_img = petdetail["pet_img"] as! String
                                                                let user_id = petdetail["user_id"] as! String
                                                                Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time))
                                                            }
                                                           if Servicefile.shared.Doc_dashlist.count > 0 {
                                                                self.label_nodata.isHidden = true
                                                            }else{
                                                                 self.label_nodata.isHidden = false
                                                            }
                                                            self.tbl_applist.reloadData()
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
        func callmiss(){
                   Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                  self.startAnimatingActivityIndicator()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.plove_getlist_missapp, method: .post, parameters:
                  ["user_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                      switch (response.result) {
                                                      case .success:
                                                            let res = response.value as! NSDictionary
                                                            print("success data",res)
                                                            let Code  = res["Code"] as! Int
                                                            if Code == 200 {
                                                                Servicefile.shared.Doc_dashlist.removeAll()
                                                                let Data = res["Data"] as! NSArray
                                                                for itm in 0..<Data.count{
                                                                    let dataitm = Data[itm] as! NSDictionary
                                                                    let id = dataitm["_id"] as! String
                                                                    let allergies = dataitm["allergies"] as! String
                                                                    let amount = dataitm["amount"] as! String
                                                                    let booking_date_time = dataitm["booking_date_time"] as! String
                                                                    let appointment_types = dataitm["appointment_types"] as! String
                                                                    let doc_business_info = dataitm["doc_business_info"] as! NSArray
                                                                    var docimg = ""
                                                                    var pet_name = ""
                                                                    if doc_business_info.count > 0 {
                                                                        let doc_business = doc_business_info[0] as! NSDictionary
                                                                        let clinic_pic = doc_business["clinic_pic"] as! NSArray
                                                                        if clinic_pic.count > 0 {
                                                                            let imgdata = clinic_pic[0] as! NSDictionary
                                                                            docimg = imgdata["clinic_pic"] as! String
                                                                        }
                                                                         pet_name = doc_business["clinic_name"] as! String
                                                                    }
                                                                    let petdetail = dataitm["pet_id"] as! NSDictionary
                                                                    let petid = petdetail["_id"] as! String
                                                                    let pet_type = petdetail["pet_name"] as! String
                                                                    let pet_breed = petdetail["pet_breed"] as! String
                                                                    let pet_img = petdetail["pet_img"] as! String
                                                                    let user_id = petdetail["user_id"] as! String
                                                                    Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appointment_types: appointment_types, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type, In_book_date_time: booking_date_time))
                                                                }
                                                                if Servicefile.shared.Doc_dashlist.count > 0 {
                                                                    self.label_nodata.isHidden = true
                                                                }else{
                                                                     self.label_nodata.isHidden = false
                                                                }
                                                                self.tbl_applist.reloadData()
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
        

}
