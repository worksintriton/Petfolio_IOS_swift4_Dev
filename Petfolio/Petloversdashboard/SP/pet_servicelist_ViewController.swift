//
//  pet_servicelist_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 06/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SNShadowSDK
import SDWebImage

class pet_servicelist_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
   // @IBOutlet weak var view_image_catimg: SNShadowView!
    @IBOutlet weak var view_image_catimg: UIView!
    @IBOutlet weak var image_catimg: UIImageView!
    @IBOutlet weak var label_Service_count: UILabel!
    @IBOutlet weak var tabl_service: UITableView!
    @IBOutlet weak var label_nodatafound: UILabel!
    @IBOutlet weak var label_category: UILabel!
    @IBOutlet weak var view_sortby: UIView!
    @IBOutlet weak var view_filter: UIView!
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    
    @IBOutlet weak var col_servic: UICollectionView!
    @IBOutlet weak var view_footer: petowner_footerview!
    var bannerlist = [Any]()
    var pagcount = 0
    @IBOutlet weak var view_top_cat: UIView!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.col_servic.delegate = self
        self.col_servic.dataSource = self
        self.intial_setup_action()
        self.view_top_cat.layer.cornerRadius = 20.0
        //self.view_image_catimg.layer.cornerRadius = self.view_image_catimg.frame.height / 2
        self.view_image_catimg.View_image_dropshadow(cornordarius: self.view_image_catimg.frame.height / 2, iscircle: true)
        self.label_nodatafound.isHidden = true
        self.tabl_service.delegate = self
        self.tabl_service.dataSource = self
        self.image_catimg.layer.cornerRadius = self.image_catimg.frame.height / 2
        self.view_sortby.layer.cornerRadius = self.view_sortby.frame.height / 2
        self.view_filter.layer.cornerRadius = self.view_filter.frame.height / 2
    }
    
    
    
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Service Details"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.ac_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: true, b2: false, b3: false, b4: true)
        
        
//        self.view_header.image_button2.image = UIImage(named: imagelink.image_bag)
//        self.view_header.image_profile.image = UIImage(named: imagelink.image_bel)
//        self.view_header.btn_button2.addTarget(self, action: #selector(action_cart), for: .touchUpInside)
//        self.view_header.btn_profile.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
    // header action
    // footer action
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        self.view_footer.setup(b1: false, b2: true, b3: false, b4: false, b5: false)
    // footer action
    }
    
    @objc func ac_back(sender: UIButton){
        let vc = UIStoryboard.petloverDashboardViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func startTimer() {
        self.timer.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if self.bannerlist.count > 0 {
               self.pagcount += 1
               if self.pagcount == self.bannerlist.count {
                   self.pagcount = 0
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.col_servic.scrollToItem(at: indexPath, at: .right, animated: false)
               }else{
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.col_servic.scrollToItem(at: indexPath, at: .left, animated: false)
               }
              
           }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as!  petbannerCollectionViewCell
        let bannerimg = self.bannerlist[indexPath.row] as? NSDictionary ?? ["":""]
        let image = bannerimg["image_path"] as? String ?? ""
        cell.img_banner.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: image)) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.img_banner.image = UIImage(named: imagelink.sample)
                } else {
                    cell.img_banner.image = image
                }
            }
            // cell.img_banner.view_cornor()
            // cell.view_banner_two.view_cornor()
            return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: self.col_servic.frame.size.width , height:  self.col_servic.frame.size.height)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.call_service_details()
    }
    
    @IBAction func action_home(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_petcare(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 0
                let tapbar = UIStoryboard.Pet_searchlist_DRViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
        self.present(tapbar, animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func action_filter(_ sender: Any) {
        let vc = UIStoryboard.pet_sp_filer_ViewController()
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.pet_SP_service_details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! service_TableViewCell
        cell.label_distance.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].distance) + " KM away"
        cell.label_like.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].comments_count)
        cell.label_place.text = Servicefile.shared.pet_SP_service_details[indexPath.row].service_place
        cell.label_price.text = "₹ " +  String(Servicefile.shared.pet_SP_service_details[indexPath.row].service_price)
        cell.label_rating.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].rating_count)
        cell.label_offer.text = String(Servicefile.shared.pet_SP_service_details[indexPath.row].service_offer) + "% offer"
        cell.label_sp_name.text = Servicefile.shared.pet_SP_service_details[indexPath.row].service_provider_name
        cell.img_sp.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.img_sp.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_SP_service_details[indexPath.row].thumbnail_image)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.img_sp.image = UIImage(named: imagelink.sample)
            } else {
                cell.img_sp.image = image
            }
        }
        cell.selectionStyle = .none
        cell.view_img_sp.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
       // cell.view_img_sp.View_image_dropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle: false)
        cell.img_sp.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.view_book.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.btn_book.tag = indexPath.row
        cell.btn_book.addTarget(self, action: #selector(action_appointment), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = indexPath.row
        Servicefile.shared.service_index = tag
        
        Servicefile.shared.service_sp_id = Servicefile.shared.pet_SP_service_details[tag]._id
        let vc = UIStoryboard.pet_sp_service_details_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func action_appointment(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.service_index = tag
        Servicefile.shared.service_sp_id = Servicefile.shared.pet_SP_service_details[tag]._id
        let vc = UIStoryboard.pet_sp_service_details_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func call_service_details() {
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.pet_servicedetails, method: .post, parameters: [
            "user_id": Servicefile.shared.userid,
            "cata_id":Servicefile.shared.service_id,
            "Count_value_end":Servicefile.shared.Count_value_end,
            "Count_value_start":Servicefile.shared.Count_value_start,
            "distance":Servicefile.shared.distance,
            "review_count":Servicefile.shared.review_count]
            , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSDictionary
                        let Service_Details = Data["Service_Details"] as! NSDictionary
                        let _id = Service_Details["_id"] as? String ?? ""
                        let count = Service_Details["count"] as? Int ?? 0
                        let image_path = Service_Details["image_path"] as? String ?? Servicefile.sample_img
                        let title = Service_Details["title"] as? String ?? ""
                        self.label_category.text = title
                        self.image_catimg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                        self.image_catimg.sd_setImage(with: Servicefile.shared.StrToURL(url: image_path)) { (image, error, cache, urls) in
                            if (error != nil) {
                                self.image_catimg.image = UIImage(named: imagelink.sample)
                            } else {
                                self.image_catimg.image = image
                            }
                        }
                        let Service_provider = Data["Service_provider"] as! NSArray
                        self.label_Service_count.text = String(Service_provider.count) + "  Providers"
                        Servicefile.shared.pet_SP_service_details.removeAll()
                        for itm in 0..<Service_provider.count{
                            let itmval = Service_provider[itm] as! NSDictionary
                            let _id = itmval["_id"] as? String ?? ""
                            let comments_count = itmval["comments_count"] as? Int ?? 0
                            let distance = itmval["distance"] as? Double ?? 0.0
                            let image = itmval["image"] as? String ?? Servicefile.sample_img
                            let rating_count = itmval["rating_count"] as? Int ?? 0
                            let service_offer = itmval["service_offer"] as? Int ?? 0
                            let service_place = itmval["service_place"] as? String ?? ""
                            let service_price = Int(truncating: itmval["service_price"] as? NSNumber ?? 0)
                            let service_provider_name = itmval["service_provider_name"] as? String ?? ""
                            let thumbnail_image = itmval["thumbnail_image"] as? String ?? ""
                            Servicefile.shared.pet_SP_service_details.append(SP_service_details.init(I_id: _id, Icomments_count: comments_count, Idistance: distance, Iimage: image, Irating_count: rating_count, Iservice_offer: service_offer, Iservice_place: service_place, Iservice_price: service_price, Iservice_provider_name: service_provider_name, in_thumbnail_image: thumbnail_image))
                        }
                        if Servicefile.shared.pet_SP_service_details.count > 0 {
                            self.label_nodatafound.isHidden = true
                        }else{
                            self.label_nodatafound.isHidden = false
                            let msg = res["alert_msg"] as? String ?? ""
                            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                Servicefile.shared.distance = 1
                                self.call_service_details()
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        let banner = res["banner"] as! NSArray
                        self.bannerlist = banner as! [Any]
                        self.col_servic.reloadData()
                        self.startTimer()
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
        } else {
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
    
}
