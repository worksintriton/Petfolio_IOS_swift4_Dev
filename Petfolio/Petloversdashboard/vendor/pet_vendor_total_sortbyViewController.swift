//
//  pet_vendor_total_sortbyViewController.swift
//  Petfolio
//
//  Created by Admin on 26/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.

import UIKit
import Alamofire

class pet_vendor_total_sortbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var view_sortby: UIView!
    @IBOutlet weak var tbl_sortlist: UITableView!
    
    @IBOutlet weak var view_lightshade: UIView!
    @IBOutlet weak var view_apply: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_apply.view_cornor()
        self.view_sortby.view_cornor()
        self.tbl_sortlist.delegate = self
        self.tbl_sortlist.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(hidetbl))
        self.view_lightshade.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if Servicefile.shared.productsearchpage == "todaysdeal" {
            if let firstVC = presentingViewController as? todaysdealseemoreViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
        }else{
            if let firstVC = presentingViewController as? ProductdealsViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
        }
           
       }
    
    @objc func hidetbl() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! isselectionTableViewCell
        cell.label_val.text = Servicefile.shared.data[indexPath.row]
        if Servicefile.shared.isdata[indexPath.row] == "1" {
            cell.image_isselect.image = UIImage(named: "selectedRadio")
        }else{
            cell.image_isselect.image = UIImage(named: "Radio")
        }
        cell.selectionStyle = .none
        cell.btn_isselect.tag = indexPath.row
        cell.btn_isselect.addTarget(self, action: #selector(action_isselect), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    @objc func action_isselect(sender : UIButton){
        let tag = sender.tag
        Servicefile.shared.isdata = Servicefile.shared.isdataval
        Servicefile.shared.isdata.remove(at: tag)
        Servicefile.shared.isdata.insert("1", at: tag)
        self.tbl_sortlist.reloadData()
    }
    
    @IBAction func action_apply(_ sender: Any) {
        self.callsortby()
    }
    
    func callsortby(){
//        Servicefile.shared.loadingcount = 1
//        self.loadcount = self.loadcount + 1
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_vendor_sortby, method: .post, parameters:
                                                                    [ "recent": Servicefile.shared.isdata[0],
                                                                      "high_discount": Servicefile.shared.isdata[1],
                                                                      "best_sellers": Servicefile.shared.isdata[2],
                                                                      "high_to_low": Servicefile.shared.isdata[3],
                                                                      "low_to_high": Servicefile.shared.isdata[4]], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    
                    if Code == 200 {
                        let search_val = res["Data"] as! NSArray
                        if Servicefile.shared.productsearchpage == "todaysdeal" {
                            Servicefile.shared.sp_dash_Today_Special.removeAll()
                        }else{
                            Servicefile.shared.sp_dash_productdetails.removeAll()
                        }
                        for itm in 0..<search_val.count{
                            let itmdata = search_val[itm] as! NSDictionary
                            let id  = itmdata["_id"] as? String ?? ""
                            let product_discount = itmdata["product_discount"] as? Int ?? 0
                            let product_fav = itmdata["product_fav"] as? Bool ?? false
                            let product_img = itmdata["product_img"] as? String ?? Servicefile.sample_img
                            let product_price = itmdata["product_price"] as? Int ?? 0
                            let product_rating = String(itmdata["product_rating"] as? Double ?? 0.0 )
                            let product_review = String(itmdata["product_review"] as? Int ?? 0)
                            let product_title = itmdata["product_title"] as? String ?? ""
                            if Servicefile.shared.productsearchpage == "todaysdeal" {
                                Servicefile.shared.sp_dash_Today_Special.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
                            }else{
                                Servicefile.shared.sp_dash_productdetails.append(productdetails.init(In_id: id, In_product_discount: product_discount, In_product_fav: product_fav, In_product_img: product_img, In_product_price: product_price, In_product_rating: product_rating, In_product_review: product_review, In_product_title: product_title))
                            }
                        }
                        self.stopAnimatingActivityIndicator()
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.stopAnimatingActivityIndicator()
                    }
                    break
                case .failure(let Error):
                    //Servicefile.shared.loadingcount = 0
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
