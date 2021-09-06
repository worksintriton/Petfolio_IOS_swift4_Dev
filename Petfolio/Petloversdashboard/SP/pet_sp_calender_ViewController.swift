//
//  pet_sp_calender_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire

class pet_sp_calender_ViewController: UIViewController , FSCalendarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var calender_cal: FSCalendar!
    @IBOutlet weak var coll_seltime: UICollectionView!
    @IBOutlet weak var View_shadow: UIView!
    @IBOutlet weak var view_popup: UIView!
    @IBOutlet weak var view_movetoapp: UIView!
    
    var seldate = ""
    var listtime = [""]
    var seltime = [""]
    var selectedtime = ""
    var bookstatus = [""]
    
    @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
    @IBOutlet weak var view_continue: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.intial_setup_action()
        self.listtime.removeAll()
        self.seltime.removeAll()
        self.view_continue.isHidden = true
        self.view_continue.view_cornor()
        self.view_popup.view_cornor()
        self.view_movetoapp.view_cornor()
        self.View_shadow.isHidden = true
        self.view_popup.isHidden = true
        self.seldate = Servicefile.shared.ddMMyyyystringformat(date: Date())
        self.coll_seltime.delegate = self
        self.coll_seltime.dataSource = self
        self.calender_cal.delegate = self
        self.callgetdatedetails()
        self.calender_cal.scope = .week
    }
    
    func intial_setup_action(){
    // header action
        self.view_subpage_header.label_header_title.text = "Appoinment"
        self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
        self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.ac_back), for: .touchUpInside)
        self.view_subpage_header.btn_sos.addTarget(self, action: #selector(self.action_sos), for: .touchUpInside)
        self.view_subpage_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
        self.view_subpage_header.btn_profile.addTarget(self, action: #selector(self.profile), for: .touchUpInside)
        self.view_subpage_header.btn_bag.addTarget(self, action: #selector(self.action_cart), for: .touchUpInside)
        self.view_subpage_header.sethide_view(b1: true, b2: false, b3: true, b4: false)
    // header action
    }
    
    @objc func ac_back(sender: UIButton){
        let vc = UIStoryboard.pet_sp_service_details_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = UIStoryboard.SOSViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_afterappBooked(_ sender: Any) {
        let vc = UIStoryboard.Pet_applist_ViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listtime.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pet_app_selectdoctordateCollectionViewCell
        cell.label_time.text = self.listtime[indexPath.row]
        print("sp calender",self.listtime[indexPath.row],self.bookstatus[indexPath.row])
        if self.bookstatus[indexPath.row] == "1" {
            if self.seltime[indexPath.row] == "1"{
                cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
                cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.applightgreen)
            }else{
                cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.applightgreen)
                cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            }
        }else{
            cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.lightgray)
            cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.black)
        }
        cell.view_time.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        return cell
    }
    
    
    @IBAction func action_bookappoint(_ sender: Any) {
        if Servicefile.shared.pet_apoint_booking_time != "" {
            let vc = UIStoryboard.sppetselectdetailsViewController()
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.bookstatus[indexPath.row] == "1" {
            self.seltime.removeAll()
            self.view_continue.isHidden = false
            for timitm in 0..<self.listtime.count{
                self.seltime.append("0")
            }
            self.seltime.remove(at: indexPath.row)
            self.seltime.insert("1", at: indexPath.row)
            Servicefile.shared.pet_apoint_booking_date = self.seldate
            Servicefile.shared.pet_apoint_booking_time = self.listtime[indexPath.row]
            self.coll_seltime.reloadData()
        }else{
            self.alert(Message: "Slot is not available")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100 , height:  35)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
         let formatter = DateFormatter()
              formatter.dateFormat = "yyyy-MM-dd"
              
              let nextstrDate = formatter.string(from: date)
              let currstrdate = formatter.string(from: Date())
              let nextDate = formatter.date(from: nextstrDate)
              let currdate = formatter.date(from: currstrdate)
              if currdate! > nextDate! {
                  return false
              } else {
            let selectdate = date
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy"
            let selddate =  Calendar.current.date(byAdding: .day, value: 0, to: selectdate)
            let nextDate = format.string(from: selddate!)
            print("selected date",nextDate)
            self.seldate = nextDate
            self.callgetdatedetails()
            return true
            
        }
    }
        
        
        
        
       
        
        func callgetdatedetails(){
            self.startAnimatingActivityIndicator()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_sp_avail_time, method: .post, parameters:
                ["user_id":Servicefile.shared.sp_user_id,
                 "Date": self.seldate,
                 "cur_date": Servicefile.shared.ddmmyyyystringformat(date: Date()),
                 "cur_time": Servicefile.shared.hhmmastringformat(date: Date()),
                 "current_time": Servicefile.shared.yyyyMMddHHmmssstringformat(date: Date())], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                    switch (response.result) {
                    case .success:
                        let res = response.value as! NSDictionary
                        print("success data",res)
                        let Code  = res["Code"] as! Int
                        if Code == 200 {
                            let Data = res["Data"] as! NSArray
                            for itm in 0..<Data.count{
                                self.bookstatus.removeAll()
                                self.listtime.removeAll()
                                self.seltime.removeAll()
                                let datadic = Data[itm] as! NSDictionary
                                let timedic = datadic["Times"] as! NSArray
                                for timitm in 0..<timedic.count{
                                    let timitmdic = timedic[timitm] as! NSDictionary
                                    let timval = timitmdic["time"]  as? NSString ?? ""
                                    self.listtime.append(timval as String)
                                    let bookstatus = timitmdic["book_status"]  as? Bool ?? false
                                    print("book status",bookstatus)
                                    if bookstatus ==  true {
                                        self.bookstatus.append("1")
                                    }else{
                                        self.bookstatus.append("0")
                                    }
                                    if timitm == 0 {
                                        self.seltime.append("0")
                                        self.selectedtime = timval as String
                                    }else{
                                        self.seltime.append("0")
                                    }
                                }
                            }
                            self.view_continue.isHidden = true
                            self.coll_seltime.reloadData()
                            self.stopAnimatingActivityIndicator()
                        }else{
                            self.listtime.removeAll()
                            self.seltime.removeAll()
                            self.coll_seltime.reloadData()
                            self.view_continue.isHidden = true
                            self.stopAnimatingActivityIndicator()
                            print("status code service denied")
                            let Message = res["Message"] as? String ?? ""
                            self.alert(Message: Message)
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
        
        //    func callcheckdatedetails(index: Int){
        //        self.startAnimatingActivityIndicator()
        //    if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_dov_check_time, method: .post, parameters:
        //        [ "user_id":Servicefile.shared.sp_user_id,
        //       "Booking_Date":self.seldate,"Booking_Time": self.listtime[index]], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
        //                                            switch (response.result) {
        //                                            case .success:
        //                                                  let res = response.value as! NSDictionary
        //                                                  print("success data",res)
        //                                                  let Code  = res["Code"] as! Int
        //                                                  if Code == 200 {
        //                                                    self.seltime.removeAll()
        //                                                    for timitm in 0..<self.listtime.count{
        //                                                            self.seltime.append("0")
        //                                                    }
        //                                                    self.seltime.remove(at: index)
        //                                                    self.seltime.insert("1", at: index)
        //                                                    Servicefile.shared.pet_apoint_booking_date = self.seldate
        //                                                    Servicefile.shared.pet_apoint_booking_time = self.listtime[index]
        //                                                    self.coll_seltime.reloadData()
        //                                                     self.stopAnimatingActivityIndicator()
        //                                                  }else{
        //                                                    self.stopAnimatingActivityIndicator()
        //                                                    print("status code service denied")
        //                                                      let Message = res["Message"] as? String ?? ""
        //                                                     self.alert(Message: Message)
        //                                                  }
        //                                                break
        //                                            case .failure(let Error):
        //                                                self.stopAnimatingActivityIndicator()
        //                                                print("Can't Connect to Server / TimeOut",Error)
        //                                                break
        //                                            }
        //                               }
        //        }else{
        //            self.stopAnimatingActivityIndicator()
        //            self.alert(Message: "No Intenet Please check and try again ")
        //        }
        //    }
        
}
