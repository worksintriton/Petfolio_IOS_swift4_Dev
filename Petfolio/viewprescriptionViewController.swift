//
//  viewprescriptionViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 19/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class viewprescriptionViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet weak var tbl_medilist: UITableView!
    @IBOutlet weak var textview_descrip: UITextView!
    @IBOutlet weak var view_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var label_popup: UILabel!
    @IBOutlet weak var view_btn: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        Servicefile.shared.Doc_pres.removeAll()
        self.callpescription()
        self.tbl_medilist.delegate = self
        self.tbl_medilist.dataSource = self
        self.view_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.view_popup.view_cornor()
        self.view_btn.view_cornor()
        self.view_btn.dropShadow()
        self.textview_descrip.delegate = self
        self.textview_descrip.isUserInteractionEnabled = false
    }
    
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return Servicefile.shared.Doc_pres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "pres", for: indexPath) as! Doc_pres_labelTableViewCell
        let presdata = Servicefile.shared.Doc_pres[indexPath.row] as! NSDictionary
        cell.label_medi.text = presdata["Tablet_name"] as? String ?? ""
        cell.label_consp.text = presdata["consumption"] as? String ?? ""
        cell.label_noofdays.text = presdata["Quantity"] as? String ?? ""
        cell.selectionStyle = .none
        return cell
    }
    
    

    
    
    func callpescription(){
        print("data in prescription")
                 Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                self.startAnimatingActivityIndicator()
          if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.view_prescription_create, method: .post, parameters: [
            "Appointment_ID": Servicefile.shared.pet_apoint_id ]
               , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                    switch (response.result) {
                                                    case .success:
                                                          let res = response.value as! NSDictionary
                                                          print("success data",res)
                                                          let Code  = res["Code"] as! Int
                                                          if Code == 200 {
                                                             let Data = res["Data"] as! NSDictionary
                                                            let Doctor_Comments = Data["Doctor_Comments"] as! String
                                                            self.textview_descrip.text = Doctor_Comments
                                                            let Prescription_data = Data["Prescription_data"] as! NSArray
                                                            Servicefile.shared.Doc_pres = Prescription_data as! [Any]
                                                            self.tbl_medilist.reloadData()
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
                    self.alert(Message: "Seems there is a connectivity issue. Please check your internet connection and try again ")
                }
            }
}
