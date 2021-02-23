//
//  pet_sp_filer_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 27/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class pet_sp_filer_ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

       
//       var orgspecialza = [""]
//       var isspecialza = ["0"]
    
    @IBOutlet weak var view_apply: UIView!
    @IBOutlet weak var view_clearall: UIView!
    @IBOutlet weak var tbl_spec: UITableView!
    @IBOutlet weak var img_4up: UIImageView!
    @IBOutlet weak var img_3up: UIImageView!
    @IBOutlet weak var img_2up: UIImageView!
    @IBOutlet weak var img_1up: UIImageView!
//    var selrate = 0
//    var selspec = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_apply.view_cornor()
        self.view_clearall.view_cornor()
        self.view_apply.dropShadow()
        self.view_clearall.dropShadow()
        if Servicefile.shared.SP_filter_price.count == 0 {
             self.callsppricedetails()
        }
        self.check_review()
        self.tbl_spec.delegate = self
        self.tbl_spec.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Servicefile.shared.SP_filter_price.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! filterTableViewCell
        if Servicefile.shared.isspecialza[indexPath.row] == "1" {
            cell.img_radio.image = UIImage(named: "selectedRadio")
        }else{
             cell.img_radio.image = UIImage(named: "Radio")
        }
        cell.label_spec.text = Servicefile.shared.SP_filter_price[indexPath.row].Display_text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         Servicefile.shared.isspecialza = Servicefile.shared.orgspecialza
        Servicefile.shared.isspecialza.remove(at: indexPath.row)
         Servicefile.shared.isspecialza.insert("1", at: indexPath.row)
        Servicefile.shared.selspec = Servicefile.shared.isspecialza[indexPath.row]
        self.tbl_spec.reloadData()
    }
    
    @IBAction func action_clearall(_ sender: Any) {
        Servicefile.shared.Count_value_end = 0
        Servicefile.shared.Count_value_start = 0
        Servicefile.shared.review_count = 0
        Servicefile.shared.selrate = 0
        self.check_review()
        //Servicefile.shared.SP_filter_price.removeAll()
        Servicefile.shared.isspecialza = Servicefile.shared.orgspecialza
        self.tbl_spec.reloadData()
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_apply(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_4up(_ sender: Any) {
         Servicefile.shared.selrate = 4
         self.check_review()
    }
    
    @IBAction func action_3up(_ sender: Any) {
         Servicefile.shared.selrate = 3
         self.check_review()
    }
    
    @IBAction func action2up(_ sender: Any) {
        Servicefile.shared.selrate = 2
         self.check_review()
    }
    
    @IBAction func action_1up(_ sender: Any) {
         Servicefile.shared.selrate = 1
        self.check_review()
    }
    
    func check_review(){
        if Servicefile.shared.selrate == 1 {
            self.img_1up.image = UIImage(named: "selectedRadio")
            self.img_2up.image = UIImage(named: "Radio")
            self.img_3up.image = UIImage(named: "Radio")
            self.img_4up.image = UIImage(named: "Radio")
        }else if Servicefile.shared.selrate == 2 {
            self.img_1up.image = UIImage(named: "Radio")
            self.img_2up.image = UIImage(named: "selectedRadio")
            self.img_3up.image = UIImage(named: "Radio")
            self.img_4up.image = UIImage(named: "Radio")
        }else if Servicefile.shared.selrate == 3 {
            self.img_1up.image = UIImage(named: "Radio")
            self.img_2up.image = UIImage(named: "Radio")
            self.img_3up.image = UIImage(named: "selectedRadio")
            self.img_4up.image = UIImage(named: "Radio")
        }else if Servicefile.shared.selrate == 4 {
            self.img_1up.image = UIImage(named: "Radio")
            self.img_2up.image = UIImage(named: "Radio")
            self.img_3up.image = UIImage(named: "Radio")
            self.img_4up.image = UIImage(named: "selectedRadio")
        }else{
            self.img_1up.image = UIImage(named: "Radio")
            self.img_2up.image = UIImage(named: "Radio")
            self.img_3up.image = UIImage(named: "Radio")
            self.img_4up.image = UIImage(named: "Radio")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let firstVC = presentingViewController as? pet_servicelist_ViewController {
            DispatchQueue.main.async {
                firstVC.viewWillAppear(true)
            }
        }
    }
    
    func callsppricedetails(){
        Servicefile.shared.SP_filter_price.removeAll()
        Servicefile.shared.orgspecialza.removeAll()
        Servicefile.shared.isspecialza.removeAll()
        self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() {
        AF.request(Servicefile.pet_sp_filter, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
        switch (response.result) {
        case .success:
            let resp = response.value as! NSDictionary
            print("display data",resp)
            let Code  = resp["Code"] as! Int
            if Code == 200 {
                let Data = resp["Data"] as! NSArray
                Servicefile.shared.SP_filter_price.removeAll()
                Servicefile.shared.orgspecialza.removeAll()
                Servicefile.shared.isspecialza.removeAll()
                for i in 0..<Data.count{
                    let dataval = Data[i] as! NSDictionary
                    let Display_text = dataval["Display_text"] as? String ?? ""
                    let Count_value_start = dataval["Count_value_start"] as? Int ?? 0
                    let Count_value_end = dataval["Count_value_end"] as? Int ?? 0
                    Servicefile.shared.SP_filter_price.append(sppricelist.init(IDisplay_text: Display_text, ICount_value_start: Count_value_start, ICount_value_end: Count_value_end))
                 Servicefile.shared.isspecialza.append("0")
                                   }
                 Servicefile.shared.orgspecialza = Servicefile.shared.isspecialza
                self.tbl_spec.reloadData()
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
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func alert(Message: String){
              let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                   }))
              self.present(alert, animated: true, completion: nil)
          }
}
