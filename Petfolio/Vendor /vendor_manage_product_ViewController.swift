//
//  vendor_manage_product_ViewController.swift
//  Petfolio
//
//  Created by Admin on 24/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class vendor_manage_product_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var tbl_manage_product: UITableView!
    @IBOutlet weak var textfield_search: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callgetproductdetails()
        self.tbl_manage_product.delegate = self
        self.tbl_manage_product.dataSource = self
    }
    
    @IBAction func action_search(_ sender: Any) {
        
    }
    
    @IBAction func action_disacrd(_ sender: Any) {
        
    }
    
    @IBAction func action_applydeal(_ sender: Any) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unhide", for: indexPath) as! manageproduct_withval_TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_bell(_ sender: Any) {
        
    }
    
    @IBAction func action_bag(_ sender: Any) {
        
    }
    
    @IBAction func action_profile(_ sender: Any) {
        
    }
    
    @IBAction func action_community(_ sender: Any) {
        
    }
    
    @IBAction func action_shop(_ sender: Any) {
        
    }
    
    @IBAction func action_home(_ sender: Any) {
        
    }
    
    func callgetproductdetails(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_manage_product, method: .post, parameters:
                                                                    ["vendor_id": Servicefile.shared.vendorid,
                                                                        "search_string":""], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSArray
                       
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
