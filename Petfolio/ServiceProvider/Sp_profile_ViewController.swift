//
//  Sp_profile_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 23/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Sp_profile_ViewController: UIViewController {

    
    @IBOutlet weak var View_profile: UIView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_phono: UILabel!
    var ismenu = ["0"]
    var isorgi = ["0"]
    override func viewDidLoad() {
        super.viewDidLoad()
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                           UserDefaults.standard.set(Servicefile.shared.user_type, forKey: "usertype")
                           Servicefile.shared.usertype = UserDefaults.standard.string(forKey: "usertype")!
         Servicefile.shared.pet_status = ""
        self.ismenu.removeAll()
        Servicefile.shared.pet_petlist.removeAll()
        self.callpetdash()
        self.label_user.text = Servicefile.shared.first_name + " " + Servicefile.shared.last_name
        self.label_email.text = Servicefile.shared.user_email
        self.label_phono.text = Servicefile.shared.user_phone
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func action_profile_edit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_profile_edit_ViewController") as! Sp_profile_edit_ViewController
               self.present(vc, animated: true, completion: nil)
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
   
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func action_manageaddress(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petManageaddressViewController") as! petManageaddressViewController
//        self.present(vc, animated: true, completion: nil)
    }
    
    func callpetdash(){
              self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.sp_dash_get, method: .post, parameters:
           [   "user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                  switch (response.result) {
                                                  case .success:
                                                        let res = response.value as! NSDictionary
                                                        print("success data",res)
                                                        let Code  = res["Code"] as! Int
                                                        if Code == 200 {
                                                          let Data = res["Data"] as! NSDictionary
                                                         
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
