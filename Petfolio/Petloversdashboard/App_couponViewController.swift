//
//  App_couponViewController.swift
//  Petfolio
//
//  Created by Admin on 20/08/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class App_couponViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var tbl_cancellist: UITableView!
    var coupon_arr = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coupon_arr.removeAll()
        self.view_popup.view_cornor()
        self.tbl_cancellist.register(UINib(nibName: "App_couponTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tbl_cancellist.delegate = self
        self.tbl_cancellist.dataSource = self
        self.callcheckcoupon()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? Pet_applist_ViewController {
                  DispatchQueue.main.async {
                   firstVC.viewWillAppear(true)
                  }
              }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coupon_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! App_couponTableViewCell
        let data = self.coupon_arr[indexPath.row] as! NSDictionary
        let img = data["image"] as? String ?? Servicefile.sample_img
        let title = data["title"] as? String ?? ""
        let sub_title = data["descri"] as? String ?? ""
        let ref = data["refund"] as? String ?? ""
        cell.view_main.view_cornor()
        cell.view_main.dropShadow()
        cell.image_img_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.image_img_data.sd_setImage(with: Servicefile.shared.StrToURL(url: img)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.image_img_data.image = UIImage(named: imagelink.sample)
            } else {
                cell.image_img_data.image = image
            }
        }
        cell.label_title.text = title
        cell.label_sub_title.text = sub_title
        if ref != "" {
            let refdetail = Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].cost
            cell.label_ref.text = "REF" + refdetail
        }else{
            cell.label_ref.text = ""
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.coupon_arr[indexPath.row] as! NSDictionary
        let ref = data["refund"] as? String ?? ""
        var refval = ""
        var c_type = ""
        if Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].clinic_name != "" {
            c_type = "2"
        }else{
            c_type = "1"
        }
        if ref != "" {
            let refdetail = Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].cost
            refval = "REF" + refdetail
            self.callcreateprocess(code: refval,amount: Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex].cost,ctype: c_type, userid: Servicefile.shared.userid)
        }else{
            refval = "Bank"
           // self.dismiss(animated: true, completion: nil)
            self.callcreateprocess(code: refval,amount: "0",ctype: c_type, userid: Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex]._id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func callcheckcoupon(){
        
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_app_coupon_get, method: .get, parameters: nil, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data  = res["Data"] as! NSArray
                        self.coupon_arr = data as! [Any]
                        self.tbl_cancellist.reloadData()
                    }else{
                        let Message = res["Message"] as? String ?? ""
                        self.alert(Message: Message)
                    }
                    break
                case .failure(let Error):
                    self.stopAnimatingActivityIndicator()
                    
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
    func callcreateprocess(code: String,amount: String,ctype: String, userid: String){
        
        
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_app_coupon_create, method: .post, parameters:
                                                                    ["created_by" : "User",
                                                                     "coupon_type" : ctype,
                                                                     "code" : code,
                                                                     "amount" : amount,
                                                                     "user_details" : Servicefile.shared.userid,
                                                                     "used_status": "Not Used"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data  = res["Data"] as! NSDictionary
                        let Message = res["Message"] as? String ?? ""
                        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            let vc = UIStoryboard.Pet_applist_ViewController()
                            self.present(vc, animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        let alert = UIAlertController(title: "", message: "There is some technical issue in ourside, Please contact admin for details", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            let vc = UIStoryboard.Pet_applist_ViewController()
                            self.present(vc, animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    break
                case .failure(let Error):
                    self.stopAnimatingActivityIndicator()
                    
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    

}
