//
//  doc_paymentdetilsViewController.swift
//  Petfolio
//
//  Created by Admin on 17/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class doc_paymentdetilsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

        
       
    @IBOutlet weak var view_footer: doc_footer!
    
        @IBOutlet weak var view_tx: UIView!
        @IBOutlet weak var view_all: UIView!
        @IBOutlet weak var view_income: UIView!
        @IBOutlet weak var view_outcome: UIView!
        @IBOutlet weak var view_subpage_header: petowner_otherpage_header!
        @IBOutlet weak var view_total_ex: UIView!
    @IBOutlet weak var tbl_pay_details: UITableView!
    var paydetails = [Any]()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            self.view_total_ex.view_cornor()
            self.view_tx.view_cornor()
            self.view_all.view_cornor()
            self.view_income.view_cornor()
            self.view_outcome.view_cornor()
            self.intial_setup_action()
            self.tbl_pay_details.register(UINib(nibName: "paymentdetails_TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            self.tbl_pay_details.delegate = self
            self.tbl_pay_details.dataSource = self
            self.callservice()
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.paydetails.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! paymentdetails_TableViewCell
            cell.contentView.backgroundColor = .clear
            let data = self.paydetails[indexPath.row] as! NSDictionary
            cell.view_main.view_cornor()
            cell.view_image.view_cornor()
            cell.label_amount.text  = "+ INR " + String(data["amount"] as? String ?? "")
            cell.label_type.text = data["communication_type"] as? String ?? ""
            cell.label_date.text = data["display_date"] as? String ?? ""
            cell.label_payment_id.text = data["payment_id"] as? String ?? ""
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
        
    
     func intial_setup_action(){
     // header action
         self.view_subpage_header.label_header_title.text = "Orders detail"
         self.view_subpage_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
         self.view_subpage_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
         self.view_subpage_header.view_profile.isHidden = true
         self.view_subpage_header.view_sos.isHidden = true
         self.view_subpage_header.view_bel.isHidden = true
         self.view_subpage_header.view_bag.isHidden = true
     // header action
     // footer action
         self.view_footer.setup(b1: false, b2: true, b3: false)
         self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.docshop), for: .touchUpInside)
         self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.docDashboard), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
     // footer action
     }
     
       
        @IBAction func action_all(_ sender: Any) {
        }
        @IBAction func action_income(_ sender: Any) {
        }

        @IBAction func action_outcome(_ sender: Any) {
        }
    
    func callservice(){
        Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_payment_details, method: .post, parameters:
            ["doctor_id": Servicefile.shared.userid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                       
                        let pay_details = res["Data"] as! NSArray
                        self.paydetails = pay_details as! [Any]
                        self.tbl_pay_details.reloadData()
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
