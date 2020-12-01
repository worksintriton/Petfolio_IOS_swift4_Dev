//
//  DocdashboardViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 18/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class DocdashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var view_new: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_missed: UIView!
    @IBOutlet weak var view_footer: UIView!
    
    @IBOutlet weak var label_new: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    
    @IBOutlet weak var tblview_applist: UITableView!
    @IBOutlet weak var label_completed: UILabel!
    @IBOutlet weak var label_missed: UILabel!
    
    
    
    var appointtype = "New"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.label_nodata.isHidden = true
        
        self.view_new.layer.cornerRadius = 9.0
        self.view_missed.layer.cornerRadius = 9.0
        self.view_footer.layer.cornerRadius = 15.0
        self.view_completed.layer.cornerRadius = 9.0
        
        self.view_completed.layer.borderWidth = 0.5
        self.view_missed.layer.borderWidth = 0.5
        self.view_new.layer.borderWidth = 0.5
        let appgree = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appgree.cgColor
        self.view_missed.layer.borderColor = appgree.cgColor
        
        self.tblview_applist.delegate = self
        self.tblview_applist.dataSource = self
        // Do any additional setup after loading the view.
        self.callnew()
    }
    
    
    @IBAction func action_sidemenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "docsidemenuViewController") as! docsidemenuViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.Doc_dashlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! docdashTableViewCell
        if self.appointtype == "New" {
            cell.view_commissed.isHidden = true
            cell.btn_complete.tag = indexPath.row
             cell.btn_cancel.tag = indexPath.row
        }else if self.appointtype == "Complete"{
             cell.view_commissed.isHidden = false
            cell.label_completedon.text = "date on :"
            cell.labe_comMissed.text = "Completion on :"
            cell.label_completedon.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.labe_comMissed.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }else{
            cell.view_commissed.isHidden = false
            cell.label_completedon.text = "data"
             cell.labe_comMissed.text = "Missed on :"
            cell.label_completedon.textColor = UIColor.red
             cell.labe_comMissed.textColor = UIColor.red
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
    

    @IBAction func action_missed(_ sender: Any) {
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_missed.backgroundColor = appcolor
        self.label_missed.textColor = UIColor.white
        self.view_new.backgroundColor = UIColor.white
        self.label_new.textColor = appcolor
        self.label_completed.textColor = appcolor
        self.view_completed.backgroundColor = UIColor.white
        self.view_new.layer.borderColor = appcolor.cgColor
        self.view_new.backgroundColor = UIColor.white
        self.appointtype = "Missed"
        self.callmiss()
        
    }
    @IBAction func action_completeappoint(_ sender: Any) {
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.backgroundColor = appcolor
        self.label_completed.textColor = UIColor.white
        self.view_new.backgroundColor = UIColor.white
        self.view_missed.backgroundColor = UIColor.white
        self.label_new.textColor = appcolor
        self.label_missed.textColor = appcolor
        self.view_new.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
        self.appointtype = "Complete"
        self.callcom()
       
    }
    @IBAction func action_newappoint(_ sender: Any) {
        let appcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_new.backgroundColor = appcolor
        self.label_new.textColor = UIColor.white
        self.view_completed.backgroundColor = UIColor.white
        self.view_missed.backgroundColor = UIColor.white
        self.label_completed.textColor = appcolor
        self.label_missed.textColor = appcolor
        self.view_completed.layer.borderColor = appcolor.cgColor
        self.view_missed.layer.borderColor = appcolor.cgColor
        self.appointtype = "New"
        self.callnew()
        
    }
    
    @IBAction func action_logout(_ sender: Any) {
        
    }
    func callnew(){
         Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.docdashboardnewapp, method: .post, parameters:
        ["doctor_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                            switch (response.result) {
                                            case .success:
                                                  let res = response.value as! NSDictionary
                                                  print("success data",res)
                                                  let Code  = res["Code"] as! Int
                                                  if Code == 200 {
                                                    let Data = res["Data"] as! NSArray
                                                    for itm in 0..<Data.count{
                                                        let dataitm = Data[itm] as! NSDictionary
                                                        let id = dataitm["_id"] as! String
                                                        let allergies = dataitm["allergies"] as! String
                                                        let amount = dataitm["amount"] as! String
                                                        let appoinment_status = dataitm["appoinment_status"] as! String
                                                        let docatt = dataitm["doc_attched"] as! NSArray
                                                        var docimg = ""
                                                        if docatt.count > 0 {
                                                            let imgdata = docatt[0] as! NSDictionary
                                                            docimg = imgdata["file"] as! String
                                                        }
                                                        let petdetail = dataitm["pet_id"] as! NSDictionary
                                                        let petid = petdetail["_id"] as! String
                                                        let pet_type = petdetail["pet_type"] as! String
                                                        let pet_breed = petdetail["pet_breed"] as! String
                                                         let pet_img = petdetail["pet_img"] as! String
                                                          let pet_name = petdetail["pet_name"] as! String
                                                         let user_id = petdetail["user_id"] as! String
                                                        Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appoinment_status: appoinment_status, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type))
                                                    }
                                                   if Servicefile.shared.Doc_dashlist.count > 0 {
                                                        self.label_nodata.isHidden = true
                                                    }else{
                                                         self.label_nodata.isHidden = false
                                                    }
                                                    
//
                                                    self.tblview_applist.reloadData()
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.docdashboardcomapp, method: .post, parameters:
           ["doctor_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                                                            let appoinment_status = dataitm["appoinment_status"] as! String
                                                            let docatt = dataitm["doc_attched"] as! NSArray
                                                            var docimg = ""
                                                            if docatt.count > 0 {
                                                                let imgdata = docatt[0] as! NSDictionary
                                                                docimg = imgdata["file"] as! String
                                                            }
                                                            let petdetail = dataitm["pet_id"] as! NSDictionary
                                                            let petid = petdetail["_id"] as! String
                                                            let pet_type = petdetail["pet_type"] as! String
                                                            let pet_breed = petdetail["pet_breed"] as! String
                                                            let pet_img = petdetail["pet_img"] as! String
                                                            let pet_name = petdetail["pet_name"] as! String
                                                            let user_id = petdetail["user_id"] as! String
                                                            Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appoinment_status: appoinment_status, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type))
                                                        }
                                                       if Servicefile.shared.Doc_dashlist.count > 0 {
                                                            self.label_nodata.isHidden = true
                                                        }else{
                                                             self.label_nodata.isHidden = false
                                                        }
                                                        self.tblview_applist.reloadData()
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
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.docdashboardmissapp, method: .post, parameters:
              ["doctor_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
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
                                                                let appoinment_status = dataitm["appoinment_status"] as! String
                                                                let docatt = dataitm["doc_attched"] as! NSArray
                                                                var docimg = ""
                                                                if docatt.count > 0 {
                                                                    let imgdata = docatt[0] as! NSDictionary
                                                                    docimg = imgdata["file"] as! String
                                                                }
                                                                let petdetail = dataitm["pet_id"] as! NSDictionary
                                                                let petid = petdetail["_id"] as! String
                                                                let pet_type = petdetail["pet_type"] as! String
                                                                let pet_breed = petdetail["pet_breed"] as! String
                                                                let pet_img = petdetail["pet_img"] as! String
                                                                let pet_name = petdetail["pet_name"] as! String
                                                                let user_id = petdetail["user_id"] as! String
                                                                Servicefile.shared.Doc_dashlist.append(doc_Dash_petdetails.init(in_Appid: id, In_allergies: allergies, In_amount: amount, In_appoinment_status: appoinment_status, In_doc_attched: docimg, In_pet_id: petid, In_pet_breed: pet_breed, In_pet_img: pet_img, In_pet_name: pet_name, In_user_id: user_id, In_pet_type: pet_type))
                                                            }
                                                            if Servicefile.shared.Doc_dashlist.count > 0 {
                                                                self.label_nodata.isHidden = true
                                                            }else{
                                                                 self.label_nodata.isHidden = false
                                                            }
                                                            self.tblview_applist.reloadData()
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
    
    @IBAction func actionl_ogout(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        UserDefaults.standard.set("", forKey: "usertype")
        Servicefile.shared.usertype = UserDefaults.standard.string(forKey: "usertype")!
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
           self.present(vc, animated: true, completion: nil)
       }
}
