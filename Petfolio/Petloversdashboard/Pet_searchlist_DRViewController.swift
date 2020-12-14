//
//  Pet_searchlist_DRViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 14/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Pet_searchlist_DRViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_searchlist: UITableView!
    @IBOutlet weak var view_footer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callsearchlist()
        self.tbl_searchlist.delegate = self
        self.tbl_searchlist.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! searchlistTableViewCell
        cell.label_docname.text = ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func action_sidemenu(_ sender: Any) {
        
    }
    
    @IBAction func action_search(_ sender: Any) {
        
    }
    
    @IBAction func action_filter(_ sender: Any) {
    }
    
    func callsearchlist(){
              self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_search, method: .post, parameters:
           ["user_id" : Servicefile.shared.userid,
            "search_string": "",
             "communication_type":0], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                  switch (response.result) {
                                                  case .success:
                                                        let res = response.value as! NSDictionary
                                                        print("success data",res)
                                                        let Code  = res["Code"] as! Int
                                                        if Code == 200 {
                                                          let Data = res["Data"] as! NSArray
                                                            for itm in 0..<Data.count{
                                                                let dat = Data[itm] as! NSDictionary
                                                                let _id = dat["_id"] as! String
                                                                let clinic_loc = dat["clinic_loc"] as! String
                                                                let clinic_name = dat["clinic_name"] as! String
                                                                let communication_type = dat["communication_type"] as! String
                                                                let distance = String(Double(truncating: dat["distance"] as! NSNumber))
                                                                let doctor_img = dat["doctor_img"] as! String
                                                                let doctor_name = dat["doctor_name"] as! String
                                                                let dr_title = dat["dr_title"] as! String
                                                                let review_count = String(dat["review_count"] as! Int)
                                                                let specializations = dat["specialization"] as! NSArray
                                                                Servicefile.shared.specd.removeAll()
                                                                for i in 0..<specializations.count{
                                                                    let item = specializations[i] as! NSDictionary
                                                                    let specialization = item["specialization"] as! String
                                                                    Servicefile.shared.specd.append(spec.init(i_spec: specialization))
                                                                }
                                                                let star_count = String(Double(truncating: dat["star_count"] as! NSNumber))
                                                                let user_id = dat["doctor_name"] as! String
                                                                Servicefile.shared.moredocd.append(moredoc.init(I_id: _id, I_clinic_loc: clinic_loc, I_clinic_name: clinic_name, I_communication_type: communication_type, I_distance: distance, I_doctor_img: doctor_img, I_doctor_name: doctor_name, I_dr_title: dr_title, I_review_count: review_count, I_star_count: star_count, I_user_id: user_id, I_specialization:  Servicefile.shared.specd))
                                                            }
                                                            
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
