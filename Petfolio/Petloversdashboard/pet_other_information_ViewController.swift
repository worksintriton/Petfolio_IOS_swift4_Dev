//
//  pet_other_information_ViewController.swift
//  Petfolio
//
//  Created by Admin on 03/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_other_information_ViewController: UIViewController {
    
    var isspay = false
    var ispurebreed = false
    var isfriend_dog = false
    var isfriend_cat = false
    var isfriend_kid = false
    var istickfree = false
    var ismicrochip = false
    var isallow_private_part = false
    
    @IBOutlet weak var img_spay_yes: UIImageView!
    @IBOutlet weak var img_spay_no: UIImageView!
    
    @IBOutlet weak var img_purebreed_yes: UIImageView!
    @IBOutlet weak var img_pure_breed_no: UIImageView!
    
    @IBOutlet weak var img_friend_dogs_yes: UIImageView!
    @IBOutlet weak var img_friend_dog_no: UIImageView!
    
    @IBOutlet weak var img_friend_cats: UIImageView!
    @IBOutlet weak var img_friends_cats_no: UIImageView!
    
    @IBOutlet weak var img_friends_kid_yes:UIImageView!
    @IBOutlet weak var img_friends_kid_no:UIImageView!
    
    @IBOutlet weak var img_tickfree_yes:UIImageView!
    @IBOutlet weak var img_tickfree_no:UIImageView!
    
    @IBOutlet weak var img_microchip_yes:UIImageView!
    @IBOutlet weak var img_microchip_no:UIImageView!
    
    @IBOutlet weak var img_allowprivate_yes:UIImageView!
    @IBOutlet weak var img_allowprivate_no:UIImageView!
    
    
    @IBOutlet weak var view_next_btn: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.img_spay_yes.image = UIImage(named: "Radio")
        self.img_spay_no.image = UIImage(named: "Radio")
        
        self.img_purebreed_yes.image = UIImage(named: "Radio")
        self.img_pure_breed_no.image = UIImage(named: "Radio")
        
        self.img_friend_dogs_yes.image = UIImage(named: "Radio")
        self.img_friend_dog_no.image = UIImage(named: "Radio")
        
        self.img_friend_cats.image = UIImage(named: "Radio")
        self.img_friends_cats_no.image = UIImage(named: "Radio")
        
        self.img_friends_kid_yes.image = UIImage(named: "Radio")
        self.img_friends_kid_no.image = UIImage(named: "Radio")
        
        self.img_tickfree_yes.image = UIImage(named: "Radio")
        self.img_tickfree_no.image = UIImage(named: "Radio")
        
        self.img_microchip_yes.image = UIImage(named: "Radio")
        self.img_microchip_no.image = UIImage(named: "Radio")
        
        self.img_allowprivate_yes.image = UIImage(named: "Radio")
        self.img_allowprivate_no.image = UIImage(named: "Radio")
        self.view_next_btn.view_cornor()
    }
    
    @IBAction func action_btn_spray_true(_ sender: Any) {
        self.isspay = true
        self.img_spay_yes.image = UIImage(named: "selectedRadio")
        self.img_spay_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_spray_false(_ sender: Any) {
        self.isspay = false
        self.img_spay_yes.image = UIImage(named: "Radio")
        self.img_spay_no.image = UIImage(named: "selectedRadio")
    }
    
    @IBAction func action_btn_pruebreed_true(_ sender: Any) {
        self.ispurebreed = true
        self.img_purebreed_yes.image = UIImage(named: "selectedRadio")
        self.img_pure_breed_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_pruebreed_false(_ sender: Any) {
        self.ispurebreed = false
        self.img_purebreed_yes.image = UIImage(named: "Radio")
        self.img_pure_breed_no.image = UIImage(named: "selectedRadio")
    }
    @IBAction func action_btn_fri_dog_true(_ sender: Any) {
        self.isfriend_dog = true
        self.img_friend_dogs_yes.image = UIImage(named: "selectedRadio")
        self.img_friend_dog_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_fri_dog_false(_ sender: Any) {
        self.isfriend_dog = false
        self.img_friend_dogs_yes.image = UIImage(named: "Radio")
        self.img_friend_dog_no.image = UIImage(named: "selectedRadio")
    }
    @IBAction func action_btn_fri_cat_true(_ sender: Any) {
        self.isfriend_cat = true
        self.img_friend_cats.image = UIImage(named: "selectedRadio")
        self.img_friends_cats_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_fri_cat_false(_ sender: Any) {
        self.isfriend_cat = false
        self.img_friend_cats.image = UIImage(named: "Radio")
        self.img_friends_cats_no.image = UIImage(named: "selectedRadio")
    }
    @IBAction func action_btn_fri_kids_true(_ sender: Any) {
        self.isfriend_kid = true
        self.img_friends_kid_yes.image = UIImage(named: "selectedRadio")
        self.img_friends_kid_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_fri_kids_false(_ sender: Any) {
        self.isfriend_kid = false
        self.img_friends_kid_yes.image = UIImage(named: "Radio")
        self.img_friends_kid_no.image = UIImage(named: "selectedRadio")
    }
    @IBAction func action_btn_tickfree_true(_ sender: Any) {
        self.istickfree = true
        self.img_tickfree_yes.image = UIImage(named: "selectedRadio")
        self.img_tickfree_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_tickfree_false(_ sender: Any) {
        self.istickfree = false
        self.img_tickfree_yes.image = UIImage(named: "Radio")
        self.img_tickfree_no.image = UIImage(named: "selectedRadio")
    }
    @IBAction func action_btn_microchip_true(_ sender: Any) {
        self.ismicrochip = true
        self.img_microchip_yes.image = UIImage(named: "selectedRadio")
        self.img_microchip_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_microchip_false(_ sender: Any) {
        self.ismicrochip = false
        self.img_microchip_yes.image = UIImage(named: "Radio")
        self.img_microchip_no.image = UIImage(named: "selectedRadio")
    }
    @IBAction func action_btn_allowprivate_true(_ sender: Any) {
        self.isallow_private_part = true
        self.img_allowprivate_yes.image = UIImage(named: "selectedRadio")
        self.img_allowprivate_no.image = UIImage(named: "Radio")
    }
    
    @IBAction func action_btn_allowprivate_false(_ sender: Any) {
        self.isallow_private_part = false
        self.img_allowprivate_yes.image = UIImage(named: "Radio")
        self.img_allowprivate_no.image = UIImage(named: "selectedRadio")
    }
    
    @IBAction func action_skip(_ sender: Any) {
        self.callSkipupdatestatus()
    }
    @IBAction func action_back(_ sender: Any) {
        self.pushtologin()
        
    }
    
    @IBAction func action_next(_ sender: Any) {
        self.callupdatestatus()
        
    }
    
    func callSkipupdatestatus(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.updatestatus, method: .post, parameters:
            ["user_id" : Servicefile.shared.userid,
             "user_status": "complete"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let userid = Data["_id"] as? String ?? ""
                        UserDefaults.standard.set(userid, forKey: "userid")
                        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
                        self.present(vc, animated: true, completion: nil)
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
    
    func callupdatestatus(){
        print("_id", Servicefile.shared.petid,
              "pet_spayed", self.isspay,
              "pet_purebred", self.ispurebreed,
              "pet_frnd_with_dog", self.isfriend_dog,
              "pet_frnd_with_cat", self.isfriend_cat,
              "pet_frnd_with_kit", self.isfriend_kid,
              "pet_microchipped", self.ismicrochip,
              "pet_tick_free", self.istickfree,
              "pet_private_part", self.isallow_private_part)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.updateotherinfo, method: .post, parameters:
            ["_id" : Servicefile.shared.petid,
             "pet_spayed": self.isspay,
             "pet_purebred": self.ispurebreed,
             "pet_frnd_with_dog": self.isfriend_dog,
             "pet_frnd_with_cat": self.isfriend_cat,
             "pet_frnd_with_kit": self.isfriend_kid,
             "pet_microchipped": self.ismicrochip,
             "pet_tick_free": self.istickfree,
             "pet_private_part": self.isallow_private_part], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petimageUploadViewController") as! petimageUploadViewController
                        self.present(vc, animated: true, completion: nil)
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
