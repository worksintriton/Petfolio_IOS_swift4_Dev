//
//  SearchtoclinicdetailViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 15/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class SearchtoclinicdetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var label_clinicname: UILabel!
    @IBOutlet weak var label_clinicdetails: UILabel!
    @IBOutlet weak var coll_imgview: UICollectionView!
    @IBOutlet weak var label_city: UILabel!
    @IBOutlet weak var label_distance: UILabel!
    @IBOutlet weak var label_Noofcomments: UILabel!
    @IBOutlet weak var Label_ratingval: UILabel!
    @IBOutlet weak var label_specdetails: UILabel!
    @IBOutlet weak var view_book: UIView!
    @IBOutlet weak var label_descrption: UILabel!
    
    var clinicpic = [""]
    var _id = ""
    var clinic_name = ""
    var descri = ""
    var dr_name = ""
    var dr_title = ""
    var star_count = ""
    
    var pet_type = [""]
     var petid = [""]
    var Pet_breed = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pet_type.removeAll()
         self.petid.removeAll()
        self.Pet_breed.removeAll()
        self.clinicpic.removeAll()
        self.coll_imgview.delegate = self
        self.coll_imgview.dataSource = self
        self.coll_imgview.isPagingEnabled = true
        self.view_book.layer.cornerRadius = 15.0
        // Do any additional setup after loading the view.
     print("selected doctor details",Servicefile.shared.sear_Docapp_id)
               // Do any additional setup after loading the view.
               self.calldocdetails()
           }
    
          @IBAction func action_sos(_ sender: Any) {
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
              self.present(vc, animated: true, completion: nil)
          }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.clinicpic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as!  petbannerCollectionViewCell
        
        cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url:self.clinicpic[indexPath.row])) { (image, error, cache, urls) in
                      if (error != nil) {
                          cell.img_banner.image = UIImage(named: "sample")
                      } else {
                          cell.img_banner.image = image
                      }
                  }
        cell.img_banner.layer.cornerRadius = 15.0
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
             return CGSize(width: self.coll_imgview.frame.size.width , height:  self.coll_imgview.frame.size.height)
        
       }
    
    @IBAction func action_share(_ sender: Any) {
        
    }
    
    @IBAction func action_book(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchpetloverappointmentViewController") as! searchpetloverappointmentViewController
               self.present(vc, animated: true, completion: nil)
    }
      
             func calldocdetails(){
                  Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                 self.startAnimatingActivityIndicator()
              if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_fetchdocdetails, method: .post, parameters:
                 ["user_id": Servicefile.shared.sear_Docapp_id], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                     switch (response.result) {
                                                     case .success:
                                                           let res = response.value as! NSDictionary
                                                           print("success data",res)
                                                           let Code  = res["Code"] as! Int
                                                           if Code == 200 {
                                                            self.clinicpic.removeAll()
                                                             let Data = res["Data"] as! NSDictionary
                                                            self._id = Data["_id"] as! String
                                                            self.clinic_name = Data["clinic_name"] as! String
                                                            let clidet = Data["clinic_pic"] as! NSArray
                                                            for itm in 0..<clidet.count{
                                                                let dat = clidet[itm] as! NSDictionary
                                                                let pic = dat["clinic_pic"] as! String
                                                                self.clinicpic.append(pic)
                                                            }
                                                            var specarray = ""
                                                            let spec =  Data["specialization"] as! NSArray
                                                            
                                                            for itm in 0..<spec.count{
                                                                let dat = spec[itm] as! NSDictionary
                                                                var pic = dat["specialization"] as! String
                                                                if itm == 0 {
                                                                    specarray =   pic
                                                                }else{
                                                                    var val = specarray + ", "
                                                                    specarray = val + pic
                                                                }
                                                            }
                                                            self.coll_imgview.reloadData()
                                                            self.descri = Data["descri"] as! String
                                                            self.dr_name = Data["dr_name"] as! String
                                                            self.dr_title = Data["dr_title"] as! String
                                                            var strcount = Data["star_count"] as! Int
                                                            var r_count =  Data["review_count"] as! Int
                                                            self.star_count = String(strcount)
                                                            let rcount = String(r_count)
                                                            if self.star_count == "" {
                                                                self.Label_ratingval.text = "0"
                                                            }else{
                                                                self.Label_ratingval.text = self.star_count
                                                            }
                                                            if rcount == "" {
                                                                self.label_Noofcomments.text = "0"
                                                            }else{
                                                                self.label_Noofcomments.text = rcount
                                                            }
                                                            
                                                            self.label_clinicdetails.text = self.clinic_name
                                                            
                                                            //                                                               self.label_city.text = ""
                                                            //                                                               self.label_distance.text = ""
                                                                                                                         
                                                            self.label_specdetails.text = specarray
                                                            self.label_descrption.text = self.descri
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
    
    func callpetdetailget(){
              self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() {
        AF.request(Servicefile.petdetailget, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
        switch (response.result) {
        case .success:
            let resp = response.value as! NSDictionary
            print("display data",resp)
            let Code  = resp["Code"] as! Int
            if Code == 200 {
                let Data = resp["Data"] as! NSDictionary
                let Pet_type = Data["usertypedata"] as! NSArray
                self.pet_type.removeAll()
                self.petid.removeAll()
               self.Pet_breed.removeAll()
            
                for item in 0..<Pet_type.count{
                    let pb = Pet_type[item] as! NSDictionary
                    let pbv = pb["pet_type_title"] as! String
                    self.pet_type.append(pbv)
                }
             for item in 0..<Pet_type.count{
                 let pb = Pet_type[item] as! NSDictionary
                    let pbv = pb["_id"] as! String
                    self.petid.append(pbv)
                }
//                self.tblview_pettype.reloadData()
//                self.tblview_petbreed.reloadData()
             
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
     
     func callpetbreedbyid(petid: String){
         self.startAnimatingActivityIndicator()
     if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petbreedid, method: .post, parameters:
      ["pet_type_id" : petid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                             switch (response.result) {
                                             case .success:
                                                   let res = response.value as! NSDictionary
                                                   print("success data",res)
                                                   let Code  = res["Code"] as! Int
                                                   if Code == 200 {
                                                     // self.textfield_petbreed.text = ""
                                                      let Pet_breed = res["Data"] as! NSArray
                                                                  self.Pet_breed.removeAll()
                                                                   for item in 0..<Pet_breed.count{
                                                                       let pb = Pet_breed[item] as! NSDictionary
                                                                       let pbv = pb["pet_breed"] as! String
                                                                       self.Pet_breed.append(pbv)
                                                                   }
                                                                  // self.tblview_petbreed.reloadData()
                                                                    self.stopAnimatingActivityIndicator()
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