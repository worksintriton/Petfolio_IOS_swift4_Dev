//
//  reg_cal_hour_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 30/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class reg_cal_hour_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var view_next: UIView!
    @IBOutlet weak var tbl_horlist: UITableView!
    var availhour = ["Monday"]
    var isavailhour = ["0"]
    var format = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callmycalender()
        self.view_next.view_cornor()
        self.view_next.dropShadow()
        self.tbl_horlist.delegate = self
        self.tbl_horlist.dataSource = self
         print("Doc_mycalender data to pass",Servicefile.shared.Doc_mycalender_selecteddates)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availhour.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Mycal_edit_availdayTableViewCell
        if self.isavailhour[indexPath.row] != "0" {
            cell.img_check.image = UIImage(named: imagelink.checkbox_1)
        } else{
            cell.img_check.image = UIImage(named: imagelink.checkbox)
        }
        cell.label_weekday.text! = self.availhour[indexPath.row]
        cell.view_edit.isHidden = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btntag = indexPath.row
              if self.isavailhour[btntag] == "0" {
                  self.isavailhour.remove(at: btntag)
                  self.isavailhour.insert("1", at: btntag)
              }else{
                  self.isavailhour.remove(at: btntag)
                  self.isavailhour.insert("0", at: btntag)
              }
              self.tbl_horlist.reloadData()
          }
    
    @IBAction func action_next(_ sender: Any) {
        Servicefile.shared.Doc_mycalender_selectedhours.removeAll()
        Servicefile.shared.docMycalHourdicarray.removeAll()
        for itme in 0..<isavailhour.count{
            let data = isavailhour[itme]
            if data == "1"{
                Servicefile.shared.Doc_mycalender_selectedhours.append(self.availhour[itme])
                var B = Servicefile.shared.docMycalHourdicarray
                                   var arr = B
                                   let a = ["Time" : self.availhour[itme],
                                   "Status" : true,
                                    "format" : self.format[itme]] as NSDictionary
                                   arr.append(a)
                                   B = arr
                                   print(B)
                                   Servicefile.shared.docMycalHourdicarray = B
            }else{
                var B = Servicefile.shared.docMycalHourdicarray
                var arr = B
                let a = ["Time" : self.availhour[itme],
                         "Status" : false,
                         "format" : self.format[itme]] as NSDictionary
                arr.append(a)
                B = arr
                print(B)
                Servicefile.shared.docMycalHourdicarray = B
            }
        }
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
               print("Doc_mycalender data to pass",Servicefile.shared.Doc_mycalender_selecteddates)
                     print("selected data by hour",Servicefile.shared.docMycalHourdicarray)
                  print("user type",Servicefile.shared.userid)
       
        self.callsubmit()
    }
    
     override func viewWillDisappear(_ animated: Bool) {
             if let firstVC = presentingViewController as? mycalenderViewController {
                       DispatchQueue.main.async {
                        firstVC.viewWillAppear(true)
                       }
                   }
        }
    
    func callsubmit(){
                   self.startAnimatingActivityIndicator()
               if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.Docupdatemycalender_hour, method: .post, parameters:
                [ "user_id": Servicefile.shared.userid,
                  "days" : Servicefile.shared.Doc_mycalender_selecteddates,
                "timing" : Servicefile.shared.docMycalHourdicarray], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                       switch (response.result) {
                                                       case .success:
                                                             let res = response.value as! NSDictionary
                                                             print("success data",res)
                                                             let Code  = res["Code"] as! Int
                                                            
                                                             if Code == 200 {
                                                               let Data = res["Data"] as! NSDictionary
                                                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DocdashboardViewController") as! DocdashboardViewController
                                                                                  self.present(vc, animated: true, completion: nil)
                                                                self.stopAnimatingActivityIndicator()
                                                             }else{
                                                               self.stopAnimatingActivityIndicator()
                                                               print("status code service denied")
                                                                 let Message = res["Message"] as? String ?? ""
                                                                self.alert(Message: Message)
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

     func callmycalender(){
        var day = ""
        if Servicefile.shared.Doc_mycalender_selecteddates.count == 1 {
            day = Servicefile.shared.Doc_mycalender_selecteddates[0]
        }else{
            day = ""
        }
        print("day val",day)
        self.availhour.removeAll()
        self.isavailhour.removeAll()
         self.format.removeAll()
            Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
           print("user type",Servicefile.shared.userid)
                   self.startAnimatingActivityIndicator()
               if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.mycalender_hour, method: .post, parameters:
                [ "user_id": Servicefile.shared.userid,
                  "Day": day], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                       switch (response.result) {
                                                       case .success:
                                                             let res = response.value as! NSDictionary
                                                             print("success data",res)
                                                             let Code  = res["Code"] as! Int
                                                             if Code == 200 {
                                                               let Data = res["Data"] as! NSArray
                                                                for itm in 0..<Data.count{
                                                                    let itdata = Data[itm] as! NSDictionary
                                                                    let title = itdata["Time"] as? String ?? ""
                                                                    let status = itdata["Status"] as? Bool ?? false
                                                                    let forma = itdata["format"] as? String ?? ""
    //                                                                if false checkbok should allow to click check box else
    //                                                                show edit box
                                                                    var isstatus = "0"
                                                                    if status != true {
                                                                          isstatus = "0"
                                                                    }else{
                                                                         isstatus = "1"
                                                                    }
                                                                    self.format.append(forma)
                                                                    self.availhour.append(title)
                                                                    self.isavailhour.append(isstatus)
                                                                }
                                                              
                                                                self.tbl_horlist.reloadData()
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
