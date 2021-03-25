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
    
    @IBOutlet weak var view_continue: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func action_sos(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SOSViewController") as! SOSViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_afterappBooked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Pet_applist_ViewController") as! Pet_applist_ViewController
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
        if self.seltime[indexPath.row] == "1"{
            cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.applightgreen)
        }else{
            cell.view_time.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.applightgreen)
            cell.label_time.textColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        }
        cell.view_time.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        return cell
    }
    
    
    @IBAction func action_bookappoint(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pet_sp_CreateApp_ViewController") as! pet_sp_CreateApp_ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
                                self.listtime.removeAll()
                                self.seltime.removeAll()
                                let datadic = Data[itm] as! NSDictionary
                                let timedic = datadic["Times"] as! NSArray
                                for timitm in 0..<timedic.count{
                                    let timitmdic = timedic[timitm] as! NSDictionary
                                    let timval = timitmdic["time"]  as? NSString ?? ""
                                    self.listtime.append(timval as String)
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
