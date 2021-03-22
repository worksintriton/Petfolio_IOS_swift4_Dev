//
//  pet_dashfooter_servicelist_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 06/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_dashfooter_servicelist_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var view_footer: UIView!
    
    @IBOutlet weak var coll_servicelist: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_footer.view_cornor()
        self.coll_servicelist.delegate = self
        self.coll_servicelist.dataSource = self
        self.call_service_cat()
    }
    
    @IBAction func action_back(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_sidemenu_ViewController") as! Pet_sidemenu_ViewController
                                    self.present(vc, animated: true, completion: nil)
    }
    @IBAction func action_home(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
                             self.present(vc, animated: true, completion: nil)
    }
    @IBAction func action_cares(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_searchlist_DRViewController") as! Pet_searchlist_DRViewController
                             self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
               self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_notifi(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_notification_ViewController") as! pet_notification_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_shop(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_sp_shop_dashboard_ViewController") as! pet_sp_shop_dashboard_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.pet_servicecat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! servicecat_CollectionViewCell
                   cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
                   cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
                   cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                                          if (error != nil) {
                                              cell.imag_cat.image = UIImage(named: "sample")
                                          } else {
                                              cell.imag_cat.image = image
                                          }
                                      }
                    cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
             cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
           
            
                   return cell
        }else if indexPath.row == 1 {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scell", for: indexPath) as! servicedashfooterCollectionViewCell
                      cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
                      cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
                      cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                                             if (error != nil) {
                                                 cell.imag_cat.image = UIImage(named: "sample")
                                             } else {
                                                 cell.imag_cat.image = image
                                             }
                                         }
                    cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
                      return cell
        }else if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! servicecat_CollectionViewCell
                      cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
                      cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
                      cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                                             if (error != nil) {
                                                 cell.imag_cat.image = UIImage(named: "sample")
                                             } else {
                                                 cell.imag_cat.image = image
                                             }
                                         }
                    cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
                      return cell
           
        }else{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scell", for: indexPath) as! servicedashfooterCollectionViewCell
                        cell.label_title.text = Servicefile.shared.pet_servicecat[indexPath.row].title
                        cell.label_subtitle.text = Servicefile.shared.pet_servicecat[indexPath.row].sub_title
                        cell.imag_cat.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_servicecat[indexPath.row].image)) { (image, error, cache, urls) in
                                               if (error != nil) {
                                                   cell.imag_cat.image = UIImage(named: "sample")
                                               } else {
                                                   cell.imag_cat.image = image
                                               }
                                           }
                        cell.imag_cat.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
                        cell.view_blur_image.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
            cell.view_blur_img.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
                        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.05 , height:   collectionView.frame.size.height / 1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.service_id = Servicefile.shared.pet_servicecat[indexPath.row]._id
        Servicefile.shared.service_index = indexPath.row
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_servicelist_ViewController") as! pet_servicelist_ViewController
                      self.present(vc, animated: true, completion: nil)
    }
    
    func call_service_cat(){
                Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
       self.startAnimatingActivityIndicator()
         if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_service_cat, method: .post, parameters: ["user_id": Servicefile.shared.userid]
              , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                   switch (response.result) {
                                                   case .success:
                                                         let res = response.value as! NSDictionary
                                                         print("success data",res)
                                                         let Code  = res["Code"] as! Int
                                                         if Code == 200 {
                                                            Servicefile.shared.pet_servicecat.removeAll()
                                                              let Data = res["Data"] as! NSArray
                                                            for itm in 0..<Data.count {
                                                                let itm_val = Data[itm] as! NSDictionary
                                                                let _id = itm_val["_id"] as? String ?? ""
                                                                let image = itm_val["image"] as? String ?? Servicefile.sample_img
                                                                let sub_title = itm_val["sub_title"] as? String ?? ""
                                                                let title = itm_val["title"] as? String ?? ""
                                                                Servicefile.shared.pet_servicecat.append(service_cat.init(I_id: _id, Iimage: image, Isub_title: sub_title, Ititle: title))
                                                            }
                                                            self.coll_servicelist.reloadData()
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
         let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              }))
         self.present(alert, animated: true, completion: nil)
     }
    
}
