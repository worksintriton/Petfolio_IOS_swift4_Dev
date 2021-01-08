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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_service_details()
        self.tabl_service.delegate = self
        self.tabl_service.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! service_TableViewCell
        
        return cell
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
                                                                let Service_provider = Data["Service_provider"] as! NSArray
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
                                                                    let service_provider_name = itmval["service_price"] as! String
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
