//
//  orderlist_cancel_ViewController.swift
//  Petfolio
//
//  Created by Admin on 19/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class orderlist_cancel_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbl_cancellist: UITableView!
    @IBOutlet weak var label_cancelval: UILabel!
    @IBOutlet weak var view_cancel: UIView!
    @IBOutlet weak var view_cancel_order: UIView!
    
    var cancellistval = [""]
    var selval = "Select an issue"
    var showlist = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_cancel_order.view_cornor()
        self.view_cancel.view_cornor()
        self.tbl_cancellist.dropShadow()
        self.tbl_cancellist.isHidden = true
        self.tbl_cancellist.delegate = self
        self.tbl_cancellist.dataSource = self
        self.cancellistval.removeAll()
        self.callcanceldetails()
        self.label_cancelval.text = self.selval
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.cancellistval.removeAll()
        if let firstVC = presentingViewController as? Petlover_myorder_ViewController {
            DispatchQueue.main.async {
                firstVC.viewWillAppear(true)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cancellistval.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.cancellistval[indexPath.row]
        cell.textLabel?.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tbl_cancellist.isHidden = true
        self.selval = self.cancellistval[indexPath.row]
        self.label_cancelval.text = self.selval
    }
    
    
    @IBAction func action_cancel_order(_ sender: Any) {
        if self.selval != "Select an issue" {
            self.call_submit_cancel()
        }else{
            self.alert(Message: "please select the issue for cancellation")
        }
    }
    
    @IBAction func action_showlist(_ sender: Any) {
        if showlist {
            self.tbl_cancellist.isHidden = false
        } else {
            self.tbl_cancellist.isHidden = true
        }
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func call_submit_cancel(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_cancel, method: .post, parameters: ["_id" : Servicefile.shared.orderid, "activity_id" : 4, "activity_title" : "Order Cancelled", "activity_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()), "order_status" : "Cancelled", "user_cancell_info" : self.selval, "user_cancell_date" : Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date())]
        , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
            switch (response.result) {
            case .success:
                let res = response.value as! NSDictionary
                print("success data",res)
                let Code  = res["Code"] as! Int
                if Code == 200 {
                    self.dismiss(animated: true, completion: nil)
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
    
    func callcanceldetails(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.vendor_cancel_status, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let cancellist = Data["cancel_status"] as! NSArray
                        for i in 0..<cancellist.count{
                            let dataval = cancellist[i] as! NSDictionary
                            let title = dataval["title"] as! String
                            self.cancellistval.append(title)
                            
                        }
                        self.tbl_cancellist.reloadData()
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
    
    func alert(Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
