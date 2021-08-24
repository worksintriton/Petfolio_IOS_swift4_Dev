//
//  mycouponViewController.swift
//  Petfolio
//
//  Created by Admin on 20/08/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class mycouponViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var view_subheader: petowner_otherpage_header!
    @IBOutlet weak var tbl_couponlist: UITableView!
    
    @IBOutlet weak var label_nodata: UILabel!
    var mycouponarr = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        intial_setup_action()
        self.tbl_couponlist.register(UINib(nibName: "mycouponlistTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tbl_couponlist.delegate = self
        self.tbl_couponlist.dataSource = self
        self.label_nodata.isHidden = true
        self.callcheckcoupon()
    }
    
    func intial_setup_action(){
    // header action
        self.view_subheader.label_header_title.text = "My Coupon"
        self.view_subheader.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subheader.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_subheader.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subheader.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subheader.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subheader.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subheader.sethide_view(b1: true, b2: false, b3: true, b4: false)
    // header action
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mycouponarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! mycouponlistTableViewCell
        let data = self.mycouponarr[indexPath.row] as! NSDictionary
        
        /*
         "coupon_code" = DIN100;
         "coupon_type" = "NORMAL CODE";
         descri = "";
         "expired_date" = "2021-08-30T00:00:00.000Z";
         title = "";
         "used_status" = "";
         */
        
        let img = data["image"] as? String ?? Servicefile.sample_img
        let title = data["title"] as? String ?? ""
        let sub_title = data["descri"] as? String ?? ""
        let ref = data["coupon_code"] as? String ?? ""
        let expir = data["expired_date"] as? String ?? ""
        cell.view_main.view_cornor()
        cell.view_main.dropShadow()
//        cell.image_img_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
//        cell.image_img_data.sd_setImage(with: Servicefile.shared.StrToURL(url: img)) { (image, error, cache, urls) in
//            if (error != nil) {
//                cell.image_img_data.image = UIImage(named: imagelink.sample)
//            } else {
//                cell.image_img_data.image = image
//            }
//        }
        cell.label_title.text = title
        cell.label_sub_title.text = sub_title
        var strddmm = ""
        if expir != "" {
            let dat = expir.detectDate
            strddmm = "Expires on : " + Servicefile.shared.ddMMyyyystringformat(date: dat ?? Date())
        }else{
            strddmm = ""
        }
        
        cell.label_expiry_date.text = strddmm
        cell.label_ref.text = ref
        cell.btn_copy_coupon.tag = indexPath.row
        cell.btn_copy_coupon.addTarget(self, action: #selector(copycoupon), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func copycoupon(sender: UIButton){
        let tag = sender.tag
        let data = self.mycouponarr[tag] as! NSDictionary
        let ref = data["coupon_code"] as? String ?? ""
        UIPasteboard.general.string = ref
        self.showToast(message : "Copied to Clipboard")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func callcheckcoupon(){
        print("my coupon")
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_app_get_coupon_sidemenu, method: .post, parameters: ["user_id" : Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let data  = res["Data"] as! NSArray
                        self.mycouponarr = data as! [Any]
                        if self.mycouponarr.count > 0 {
                            self.label_nodata.isHidden = true
                        }else{
                            self.label_nodata.isHidden = false
                        }
                        self.tbl_couponlist.reloadData()
                        self.stopAnimatingActivityIndicator()
                    }else{
                        self.stopAnimatingActivityIndicator()
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


}
