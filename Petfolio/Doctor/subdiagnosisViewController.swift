//
//  subdiagnosisViewController.swift
//  Petfolio
//
//  Created by Admin on 14/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class subdiagnosisViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var view_search_breed: UIView!
    @IBOutlet weak var tbl_search_breed: UITableView!
    // show breed
    
    var diagno = [""]
    var diafno_sub = [""]
    var sub_diagno_dic_array = [Any]()
    var sear_diag = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.textfield_search.delegate = self
        self.tbl_search_breed.register(UINib(nibName: "getbreedTableViewCell", bundle: nil), forCellReuseIdentifier: "getbreed")
        self.tbl_search_breed.delegate = self
        self.tbl_search_breed.dataSource = self
        self.view_search_breed.isHidden = false
        self.tbl_search_breed.isHidden = false
        self.calldoc_diaog()
        self.textfield_search.addTarget(self, action: #selector(textFieldsearc), for: .editingChanged)
        self.textfield_search.autocapitalizationType = .sentences
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? Doc_prescriptionViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
        
       }
    
    @objc func textFieldsearc(textField:UITextField) {
        if textField.text != "" {
            let filteredArr = self.diafno_sub.filter({$0.contains(textField.text!)})
            self.sear_diag = filteredArr
            tbl_search_breed.reloadData()
        }else{
            self.sear_diag = self.diafno_sub
            tbl_search_breed.reloadData()
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sear_diag.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "getbreed", for: indexPath) as! getbreedTableViewCell
        cell.label_title.text = self.sear_diag[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<self.sub_diagno_dic_array.count{
            let dataval = self.sub_diagno_dic_array[i] as! NSDictionary
            let diagnosis = dataval["sub_diagnosis"] as? String ?? ""
            let id = dataval["_id"] as? String ?? ""
            if diagnosis == self.sear_diag[indexPath.row] {
                Servicefile.shared.doc_sub_diag = self.sear_diag[indexPath.row]
                Servicefile.shared.doc_sub_diag_id = id
            }
        }
        print("diagnosis",Servicefile.shared.doc_diag,Servicefile.shared.doc_diag_id)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func calldoc_diaog(){
        self.sub_diagno_dic_array.removeAll()
        self.diafno_sub.removeAll()
            if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_prescription_sub_diagno, method: .post, parameters: ["diagnosis_id" :Servicefile.shared.doc_diag_id]
                 , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                      switch (response.result) {
                                                      case .success:
                                                            let res = response.value as! NSDictionary
                                                            print("success data",res)
                                                            let Code  = res["Code"] as! Int
                                                            if Code == 200 {
                                                                let data  = res["Data"] as? NSArray ?? [Any]() as NSArray
                                                                self.sub_diagno_dic_array = data as! [Any]
                                                                for i in 0..<data.count{
                                                                    let dataval = data[i] as! NSDictionary
                                                                    let diagnosis = dataval["sub_diagnosis"] as? String ?? ""
                                                                    if diagnosis != "" {
                                                                        self.diafno_sub.append(diagnosis)
                                                                    }
                                                                }
                                                                self.sear_diag = self.diafno_sub
                                                                self.tbl_search_breed.reloadData()
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
