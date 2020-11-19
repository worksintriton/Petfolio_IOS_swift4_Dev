//
//  petloverDashboardViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 17/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan
import SDWebImage

class petloverDashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var colleView_banner: UICollectionView!
    @IBOutlet weak var colleView_Doctor: UICollectionView!
    @IBOutlet weak var colleView_Service: UICollectionView!
    @IBOutlet weak var colleView_product: UICollectionView!
    @IBOutlet weak var view_footer: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view_footer.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.colleView_banner.delegate = self
        self.colleView_banner.dataSource = self
        self.colleView_Doctor.delegate = self
        self.colleView_Doctor.dataSource = self
        self.colleView_product.delegate = self
        self.colleView_product.dataSource = self
        self.colleView_Service.delegate = self
        self.colleView_Service.dataSource = self
        self.colleView_banner.isPagingEnabled = true
        self.callpetdash()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.colleView_banner == collectionView {
           return Servicefile.shared.petbanner.count
        }else if self.colleView_Doctor == collectionView {
            return Servicefile.shared.petdoc.count
        }else if self.colleView_Service == collectionView {
            return Servicefile.shared.petser.count
        }else {
            return Servicefile.shared.petprod.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.colleView_banner == collectionView {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
            cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petbanner[indexPath.row].img_path)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_banner.image = UIImage(named: "sample")
                } else {
                    cell.img_banner.image = image
                }
            }
           return cell
        }else if self.colleView_Doctor == collectionView {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "doc", for: indexPath) as! petdocCollectionViewCell
            cell.img_doc.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petdoc[indexPath.row].doctor_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_doc.image = UIImage(named: "sample")
                } else {
                    cell.img_doc.image = image
                }
            }
            cell.label_docname.text = Servicefile.shared.petdoc[indexPath.row].doctor_name
            cell.label_spec.text = Servicefile.shared.petdoc[indexPath.row].doctor_name
            cell.label_rateing.text = String(Servicefile.shared.petdoc[indexPath.row].star_count)
            cell.label_ratedno.text = String(Servicefile.shared.petdoc[indexPath.row].review_count)
            return cell
        }else if self.colleView_Service == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ser", for: indexPath) as! petServCollectionViewCell
            let uicolo = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.petser[indexPath.row].background_color)
            cell.view_ser.layer.shadowColor = uicolo.cgColor
                       cell.view_ser.layer.shadowOpacity = 1
                       cell.view_ser.layer.shadowOffset = CGSize.zero
                       cell.view_ser.layer.shadowRadius = 2
                       cell.view_ser.layer.cornerRadius = 5.0
                       cell.view_ser.layer.borderWidth = 0.5
            cell.view_ser.layer.borderColor = uicolo.cgColor
            cell.label_ser.text = Servicefile.shared.petser[indexPath.row].service_title
            cell.view_ser.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.petser[indexPath.row].background_color)
            cell.img_ser.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petser[indexPath.row].service_icon)) { (image, error, cache, urls) in
                           if (error != nil) {
                               cell.img_ser.image = UIImage(named: "sample")
                           } else {
                               cell.img_ser.image = image
                           }
                       }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prod", for: indexPath) as! petprodCollectionViewCell
            cell.img_prod.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.petprod[indexPath.row].products_img)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_prod.image = UIImage(named: "sample")
                } else {
                    cell.img_prod.image = image
                }
            }
            cell.label_prodtitile.text = Servicefile.shared.petprod[indexPath.row].product_title
            cell.label_rateing.text =  Servicefile.shared.petprod[indexPath.row].product_rate
            cell.label_ratedno.text =  String(Servicefile.shared.petprod[indexPath.row].review_count)
            cell.price.text = String(Servicefile.shared.petprod[indexPath.row].product_prices) + " % off"
            if Servicefile.shared.petprod[indexPath.row].product_fav_status != false {
                
                cell.img_Fav.image = UIImage(named: "Like 3")
            }else{
                cell.img_Fav.image = UIImage(named: "Like 2")
                
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.colleView_banner == collectionView {
          return CGSize(width: self.colleView_banner.frame.size.width , height:  self.colleView_banner.frame.size.height)
        }else if self.colleView_Doctor == collectionView {
             return CGSize(width: 138 , height:  171)
        }else if self.colleView_Service == collectionView {
             return CGSize(width: 138 , height:  130)
        }else {
             return CGSize(width: 138 , height:  171)
        }
               
    }
    
    func alert(Message: String){
         let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              }))
         self.present(alert, animated: true, completion: nil)
     }
    

    func callpetdash(){
           self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petdashboard, method: .post, parameters:
        [   "user_id" : Servicefile.shared.userid,
        "lat" : 12.09090,
        "long" : 80.09093,
        "user_type" : 1 ,
        "address" : "Muthamil nager, Kodugaiyur, Chennai - 600 118"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                               switch (response.result) {
                                               case .success:
                                                     let res = response.value as! NSDictionary
                                                     print("success data",res)
                                                     let Code  = res["Code"] as! Int
                                                     if Code == 200 {
                                                       let Data = res["Data"] as! NSDictionary
                                                       let dash = Data["Dashboarddata"] as! NSDictionary
                                                       let user_details = Data["userdetails"] as! NSDictionary
                                                        Servicefile.shared.first_name = user_details["first_name"] as! String
                                                        Servicefile.shared.last_name = user_details["last_name"] as! String
                                                        Servicefile.shared.user_email = user_details["user_email"] as! String
                                                        Servicefile.shared.user_phone = user_details["user_phone"] as! String
                                                        Servicefile.shared.user_type = String(user_details["user_type"] as! Int)
                                                       Servicefile.shared.date_of_reg = user_details["date_of_reg"] as! String
                                                       Servicefile.shared.otp = String(user_details["otp"] as! Int)
                                                       let userid = user_details["_id"] as! String
                                                       UserDefaults.standard.set(userid, forKey: "userid")
                                                        Servicefile.shared.petbanner.removeAll()
                                                        let Banner_details = dash["Banner_details"] as! NSArray
                                                        for item in 0..<Banner_details.count {
                                                            let Bval = Banner_details[item] as! NSDictionary
                                                            let id = Bval["_id"] as! String
                                                            let imgpath = Bval["img_path"] as! String
                                                            let title =  Bval["title"] as! String
                                                            Servicefile.shared.petbanner.append(Petdashbanner.init(UID: id, img_path: imgpath, title: title))
                                                        }
                                                        Servicefile.shared.petdoc.removeAll()
                                                        let Doctor_details = dash["Doctor_details"] as! NSArray
                                                        for item in 0..<Doctor_details.count {
                                                            let Bval = Doctor_details[item] as! NSDictionary
                                                            let id = Bval["_id"] as! String
                                                            let imgpath = Bval["doctor_img"] as! String
                                                            let title =  Bval["doctor_name"] as! String
                                                            let review_count =  Bval["review_count"] as! Int
                                                             let star_count =  Bval["star_count"] as! Int
                                                            Servicefile.shared.petdoc.append(Petdashdoc.init(UID: id, doctor_img: imgpath, doctor_name: title, review_count: review_count, star_count: star_count))
                                                        }
                                                        Servicefile.shared.petprod.removeAll()
                                                        let Products_details = dash["Products_details"] as! NSArray
                                                        for item in 0..<Products_details.count {
                                                            let Bval = Products_details[item] as! NSDictionary
                                                            let id = Bval["_id"] as! String
                                                            let product_fav_status = Bval["product_fav_status"] as! Bool
                                                            let product_offer_status =  Bval["product_offer_status"] as! Bool
                                                            let product_offer_value =  Bval["product_offer_value"] as! Int
                                                            let product_prices =  Bval["product_prices"] as! Int
                                                            let product_rate =  String(Double(Bval["product_rate"] as! NSNumber))
                                                            let product_title =  Bval["product_title"] as! String
                                                            let products_img =  Bval["products_img"] as! String
                                                            let review_count =  Bval["review_count"] as! Int
                                                            Servicefile.shared.petprod.append(Petdashproduct.init(UID: id, product_fav_status: product_fav_status, product_offer_status: product_offer_status, product_offer_value: product_offer_value, product_prices: product_prices, product_rate: product_rate, product_title: product_title, products_img: products_img, review_count: review_count))
                                                        }
                                                        Servicefile.shared.petser.removeAll()
                                                        let Service_details = dash["Service_details"] as! NSArray
                                                        for item in 0..<Service_details.count {
                                                            let Bval = Service_details[item] as! NSDictionary
                                                            let id = Bval["_id"] as! String
                                                            let background_color = Bval["background_color"] as! String
                                                            let service_icon =  Bval["service_icon"] as! String
                                                             let service_title =  Bval["service_title"] as! String
                                                            Servicefile.shared.petser.append(Petdashservice.init(UID: id, background_color: background_color, service_icon: service_icon, service_title: service_title))
                                                        }
                                                        self.colleView_banner.reloadData()
                                                        self.colleView_Doctor.reloadData()
                                                        self.colleView_product.reloadData()
                                                        self.colleView_Service.reloadData()
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
    
    
    @IBAction func actionl_ogout(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "userid")
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
