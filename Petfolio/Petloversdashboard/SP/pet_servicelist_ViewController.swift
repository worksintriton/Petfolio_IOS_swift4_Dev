//
//  pet_servicelist_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 06/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_servicelist_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var image_catimg: UIImageView!
    @IBOutlet weak var label_Service_count: UILabel!
    @IBOutlet weak var tabl_service: UITableView!
    @IBOutlet weak var label_nodatafound: UILabel!
    @IBOutlet weak var label_category: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_service_details()
        self.tabl_service.delegate = self
        self.tabl_service.dataSource = self
        self.image_catimg.layer.cornerRadius = 10.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.pet_SP_service_details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! service_TableViewCell
        cell.label_distance.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].distance)
        cell.label_like.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].comments_count)
        cell.label_place.text = Servicefile.shared.pet_SP_service_details[indexPath.row].service_place
        cell.label_price.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].service_price)
        cell.label_rating.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].rating_count)
        cell.label_offer.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].service_offer) + "% offer"
        cell.label_sp_name.text = Servicefile.shared.pet_SP_service_details[indexPath.row].service_provider_name
        cell.img_sp.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_SP_service_details[indexPath.row].image)) { (image, error, cache, urls) in
                                      if (error != nil) {
                                          cell.img_sp.image = UIImage(named: "sample")
                                      } else {
                                          cell.img_sp.image = image
                                      }
                                  }
        cell.img_sp.layer.cornerRadius = 10.0
        cell.view_book.layer.cornerRadius = 10.0
        cell.btn_book.tag = indexPath.row
        cell.btn_book.addTarget(self, action: #selector(action_appointment), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = indexPath.row
        Servicefile.shared.service_sp_id = Servicefile.shared.pet_SP_service_details[tag]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_sp_service_details_ViewController") as! pet_sp_service_details_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_appointment(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.service_sp_id = Servicefile.shared.pet_SP_service_details[tag]._id
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_sp_service_details_ViewController") as! pet_sp_service_details_ViewController
                                    self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func call_service_details(){
                   Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
          self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_servicedetails, method: .post, parameters: ["user_id": Servicefile.shared.userid,"cata_id":Servicefile.shared.service_id]
                 , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                      switch (response.result) {
                                                      case .success:
                                                            let res = response.value as! NSDictionary
                                                            print("success data",res)
                                                            let Code  = res["Code"] as! Int
                                                            if Code == 200 {
                                                                 let Data = res["Data"] as! NSDictionary
                                                                let Service_Details = Data["Service_Details"] as! NSDictionary
                                                                let _id = Service_Details["_id"] as! String
                                                                let count = Service_Details["count"] as! Int
                                                                let image_path = Service_Details["image_path"] as! String
                                                                let title = Service_Details["title"] as! String
                                                                self.label_category.text = title
                                                                self.image_catimg.sd_setImage(with: Servicefile.shared.StrToURL(url: image_path)) { (image, error, cache, urls) in
                                                                    if (error != nil) {
                                                                        self.image_catimg.image = UIImage(named: "sample")
                                                                    } else {
                                                                        self.image_catimg.image = image
                                                                    }
                                                                }
                                                                let Service_provider = Data["Service_provider"] as! NSArray
                                                                self.label_Service_count.text = String(Service_provider.count)
                                                                for itm in 0..<Service_provider.count{
                                                                    let itmval = Service_provider[itm] as! NSDictionary
                                                                    let _id = itmval["_id"] as! String
                                                                    let comments_count = itmval["comments_count"] as! Int
                                                                    let distance = itmval["distance"] as! Double
                                                                    let image = itmval["image"] as! String
                                                                    let rating_count = itmval["rating_count"] as! Int
                                                                    let service_offer = itmval["service_offer"] as! Int
                                                                    let service_place = itmval["service_place"] as! String
                                                                    let service_price = itmval["service_price"] as! Int
                                                                    let service_provider_name = itmval["service_provider_name"] as! String
                                                                    Servicefile.shared.pet_SP_service_details.append(SP_service_details.init(I_id: _id, Icomments_count: comments_count, Idistance: distance, Iimage: image, Irating_count: rating_count, Iservice_offer: service_offer, Iservice_place: service_place, Iservice_price: service_price, Iservice_provider_name: service_provider_name))
                                                                }
                                                               
                                                               self.tabl_service.reloadData()
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
