//
//  Pet_searchlist_DRViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 14/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class Pet_searchlist_DRViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tbl_searchlist: UITableView!
   // @IBOutlet weak var view_footer: UIView!
    @IBOutlet weak var view_footer: petowner_footerview!
    @IBOutlet weak var view_header: petowner_header!
    
    var refreshControl = UIRefreshControl()
    var comm_type = 0
    
    @IBOutlet weak var view_top_doc: UIView!
    @IBOutlet weak var view_bac: UIView!
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var noofdoc: UILabel!
    @IBOutlet weak var switch_commtype: UISwitch!
    @IBOutlet weak var label_comm_type: UILabel!
    @IBOutlet weak var label_nodata: UILabel!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var view_care: UIView!
    @IBOutlet weak var col_ban: UICollectionView!
    var pagcount = 0
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        Servicefile.shared.moredocd.removeAll()
        self.view_top_doc.layer.cornerRadius = 20.0
        self.callsearchlist()
        self.noofdoc.text = "0"
        self.label_nodata.isHidden = true
        self.tbl_searchlist.delegate = self
        self.tbl_searchlist.dataSource = self
        self.col_ban.delegate = self
        self.col_ban.dataSource = self
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tbl_searchlist.addSubview(refreshControl) // not required when using UITableViewController
        self.label_comm_type.text = "Offline Doctors"
        self.switch_commtype.isOn = false
        self.textfield_search.delegate = self
        self.view_search.view_cornor()
        self.intial_setup_action()
        self.view_bac.layer.cornerRadius = self.view_bac.frame.height / 2
        
    }
    
    @IBAction func action_bac(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    func startTimer() {
        self.timer.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if Servicefile.shared.moredocd.count > 0 {
               self.pagcount += 1
               if self.pagcount == Servicefile.shared.moredocd.count {
                   self.pagcount = 0
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.col_ban.scrollToItem(at: indexPath, at: .left, animated: true)
               }else{
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.col_ban.scrollToItem(at: indexPath, at: .left, animated: true)
               }
              
           }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.moredocd.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as!  petbannerCollectionViewCell
            cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url:Servicefile.shared.moredocd[indexPath.row].doctor_img)) { (image, error, cache, urls) in
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
        
            return CGSize(width: self.col_ban.frame.size.width , height:  self.col_ban.frame.size.height)
      
    }
    
    @IBAction func action_shop(_ sender: Any) {
        
    //        Servicefile.shared.tabbar_selectedindex = 3
                   let tapbar = UIStoryboard.pet_sp_shop_dashboard_ViewController() // shop
    //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                   self.present(tapbar, animated: true, completion: nil)
    }
    
    @IBAction func action_pet_profile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petprofileViewController") as! petprofileViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
           self.present(vc, animated: true, completion: nil)
       }
    
    @IBAction func action_petservice(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 1
                       let tapbar = UIStoryboard.pet_dashfooter_servicelist_ViewController()
        //               tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                       self.present(tapbar, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_search.resignFirstResponder()
        return true
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.callsearchlist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tbl_searchlist.reloadData()
    }
    
    @IBAction func action_switch(_ sender: UISwitch) {
        if sender.isOn {
            self.comm_type = 1
            self.callsearchlist()
            self.label_comm_type.text = "Online Doctors"
        } else {
            self.comm_type = 0
            self.callsearchlist()
            self.label_comm_type.text = "Offline Doctors"
        }
    }
    
    
    @IBAction func action_home(_ sender: Any) {
        //        Servicefile.shared.tabbar_selectedindex = 2
                let tapbar = UIStoryboard.petloverDashboardViewController()
        //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                self.present(tapbar, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.moredocd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! searchlistTableViewCell
        cell.label_docname.text = Servicefile.shared.moredocd[indexPath.row].doctor_name
        var spe = ""
        for itm in 0..<Servicefile.shared.moredocd[indexPath.row].specialization.count{
            let spc = Servicefile.shared.moredocd[indexPath.row].specialization[itm].sepcial
            if itm == 0 {
                  spe = spc
            }else{
                // spe = spe + ", " + spc
                spe =  spc
            }
        }
        cell.selectionStyle = .none
        cell.label_docSubsci.text = spe
        let str = Servicefile.shared.moredocd[indexPath.row].clinic_loc
        //let result = String(str.prefix(8))
        cell.label_placeanddis.text = str
        cell.label_distance.text = Servicefile.shared.moredocd[indexPath.row].distance + " km"
        cell.label_likes.text = Servicefile.shared.moredocd[indexPath.row].review_count
        cell.label_rating.text =  Servicefile.shared.moredocd[indexPath.row].star_count
        cell.img_doc.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.moredocd[indexPath.row].doctor_img)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.img_doc.image = UIImage(named: imagelink.sample)
            } else {
                cell.img_doc.image = image
            }
        }
        cell.view_img_doc.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        //cell.view_img_doc.View_image_dropshadow(cornordarius: CGFloat(Servicefile.shared.viewcornorradius), iscircle: false)
        cell.view_book.dropShadow()
        cell.img_doc.dropShadow()
        cell.img_doc.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.view_book.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.btn_book.tag = indexPath.row
        cell.btn_book.addTarget(self, action: #selector(action_book), for: .touchUpInside)
        return cell
    }
    
    @objc func action_book(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.selectedindex = tag
        Servicefile.shared.sear_Docapp_id = Servicefile.shared.moredocd[tag].user_id
        Servicefile.shared.pet_apoint_amount = Int(Servicefile.shared.moredocd[tag].amount)!
        Servicefile.shared.pet_apoint_communication_type = Servicefile.shared.moredocd[tag].communication_type
        let vc = UIStoryboard.searchcalenderdetailsViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Servicefile.shared.sear_Docapp_id = Servicefile.shared.moredocd[indexPath.row].user_id
        Servicefile.shared.pet_apoint_amount = Int(Servicefile.shared.moredocd[indexPath.row].amount)!
        Servicefile.shared.pet_apoint_communication_type = Servicefile.shared.moredocd[indexPath.row].communication_type
        let vc = UIStoryboard.SearchtoclinicdetailViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    @IBAction func action_sidemenu(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_sidemenu_ViewController") as! Pet_sidemenu_ViewController
               self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_search(_ sender: Any) {
        self.textfield_search.resignFirstResponder()
        self.callsearchlist()
    }
    
    @IBAction func action_filter(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PetfilterpageViewController") as! PetfilterpageViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func callsearchlist(){
      print("user_id" , Servicefile.shared.userid,
        "search_string", self.textfield_search.text!,
         "communication_type", self.comm_type)
              self.startAnimatingActivityIndicator()
       if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_search, method: .post, parameters:
           ["user_id" : Servicefile.shared.userid,
            "search_string": self.textfield_search.text!,
             "communication_type": self.comm_type], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                  switch (response.result) {
                                                  case .success:
                                                        let res = response.value as! NSDictionary
                                                        print("success data",res)
                                                        let Code  = res["Code"] as! Int
                                                        if Code == 200 {
                                                            Servicefile.shared.moredocd.removeAll()
                                                          let Data = res["Data"] as! NSArray
                                                            for itm in 0..<Data.count{
                                                                let dat = Data[itm] as! NSDictionary
                                                                let _id = dat["_id"] as? String ?? ""
                                                                let amount = String(dat["amount"] as? Int ?? 0)
                                                                let clinic_loc = dat["clinic_loc"] as? String ?? ""
                                                                let clinic_name = dat["clinic_name"] as? String ?? ""
                                                                let communication_type = dat["communication_type"] as? String ?? ""
                                                                let distance = dat["distance"] as? String ?? ""
                                                                let doctor_img = dat["doctor_img"] as? String ?? Servicefile.sample_img
                                                                let doctor_name = dat["doctor_name"] as? String ?? ""
                                                                let dr_title = dat["dr_title"] as? String ?? ""
                                                                let review_count = String(dat["review_count"] as? Int ?? 0)
                                                                let specializations = dat["specialization"] as! NSArray
                                                                Servicefile.shared.specd.removeAll()
                                                                for i in 0..<specializations.count{
                                                                    let item = specializations[i] as! NSDictionary
                                                                    let specialization = item["specialization"] as? String ?? ""
                                                                    Servicefile.shared.specd.append(spec.init(i_spec: specialization))
                                                                }
                                                                let star_count = String(Double(truncating: dat["star_count"] as? NSNumber ?? 0))
                                                                let user_id = dat["user_id"] as? String ?? ""
                                                                Servicefile.shared.moredocd.append(moredoc.init(I_id: _id, I_clinic_loc: clinic_loc, I_clinic_name: clinic_name, I_communication_type: communication_type, I_distance: distance, I_doctor_img: doctor_img, I_doctor_name: doctor_name, I_dr_title: dr_title, I_review_count: review_count, I_star_count: star_count, I_user_id: user_id, I_specialization:  Servicefile.shared.specd, in_amount: amount))
                                                            }
                                                            self.noofdoc.text = String(Servicefile.shared.moredocd.count) + "  Doctors"
                                                            if  Servicefile.shared.moredocd.count ==  0{
                                                                 self.label_nodata.isHidden = false
                                                            }else{
                                                                 self.label_nodata.isHidden = true
                                                            }
                                                            self.tbl_searchlist.reloadData()
                                                            self.col_ban.reloadData()
                                                            self.startTimer()
                                                            self.refreshControl.endRefreshing()
                                                           self.stopAnimatingActivityIndicator()
                                                        }else{
                                                            if  Servicefile.shared.moredocd.count ==  0{
                                                                 self.label_nodata.isHidden = false
                                                            }else{
                                                                 self.label_nodata.isHidden = true
                                                            }
                                                          self.stopAnimatingActivityIndicator()
                                                          print("status code service denied")
                                                        }
                                                      break
                                                  case .failure(let Error):
                                                    if  Servicefile.shared.moredocd.count ==  0{
                                                         self.label_nodata.isHidden = false
                                                    }else{
                                                         self.label_nodata.isHidden = true
                                                    }
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
    
    func intial_setup_action(){
    // header action
        self.view_header.btn_sidemenu.addTarget(self, action: #selector(sidemenu), for: .touchUpInside)
        self.view_header.btn_profile.addTarget(self, action: #selector(profile), for: .touchUpInside)
        self.view_header.label_location.text = Servicefile.shared.pet_header_city
        var img = Servicefile.shared.userimage
        if img != "" {
            img = Servicefile.shared.userimage
        }else{
            img = Servicefile.sample_img
        }
        self.view_header.image_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: img)) { (image, error, cache, urls) in
            if (error != nil) {
                self.view_header.image_profile.image = UIImage(named: imagelink.sample)
            } else {
                self.view_header.image_profile.image = image
            }
        }
        self.view_header.image_profile.layer.cornerRadius = self.view_header.image_profile.frame.height / 2
        self.view_header.label_location.text = Servicefile.shared.pet_header_city
        self.view_header.btn_location.addTarget(self, action: #selector(manageaddress), for: .touchUpInside)
    // header action
    // footer action
        //self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.button1), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.button2), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button3), for: .touchUpInside)
        self.view_footer.btn_Fprocess_four.addTarget(self, action: #selector(self.button4), for: .touchUpInside)
        self.view_footer.btn_Fprocess_five.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
        
        self.view_footer.setup(b1: true, b2: false, b3: false, b4: false, b5: false)
    // footer action
    }
   

}
