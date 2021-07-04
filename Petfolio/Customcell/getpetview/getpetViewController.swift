//
//  getpetViewController.swift
//  Petfolio
//
//  Created by Admin on 19/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class getpetViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    // show type
    
    @IBOutlet weak var col_pettype: UICollectionView!
    // show type
    // show breed
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var view_search_breed: UIView!
    @IBOutlet weak var tbl_search_breed: UITableView!
    // show breed
    var Pet_breed_val = ""
    var pet_type_val = ""
    var Pet_breed = [Any]()
    var pet_type = [Any]()
    var searpet_breed = [""]
    var pet_breed_arr = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        //getpetCollectionViewCell
        self.textfield_search.delegate = self
        self.tbl_search_breed.register(UINib(nibName: "getbreedTableViewCell", bundle: nil), forCellReuseIdentifier: "getbreed")
        let nibName = UINib(nibName: "getpetCollectionViewCell", bundle:nil)
        self.col_pettype.register(nibName, forCellWithReuseIdentifier: "cell")
        self.col_pettype.delegate = self
        self.col_pettype.dataSource = self
        self.tbl_search_breed.delegate = self
        self.tbl_search_breed.dataSource = self
        self.view_search_breed.isHidden = true
        self.tbl_search_breed.isHidden = true
        self.callpetdetailget()
        self.textfield_search.addTarget(self, action: #selector(textFieldsearc), for: .editingChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            if let firstVC = presentingViewController as? REGPetLoverViewController {
                      DispatchQueue.main.async {
                       firstVC.viewWillAppear(true)
                      }
                  }
        if let firstVC = presentingViewController as? petloverEditandAddViewController {
                  DispatchQueue.main.async {
                   firstVC.viewWillAppear(true)
                  }
              }
       }
    
    @objc func textFieldsearc(textField:UITextField) {
        if textField.text != "" {
            let filteredArr = self.pet_breed_arr.filter({$0.contains(textField.text!)})
            self.searpet_breed = filteredArr
               tbl_search_breed.reloadData()
        }else{
            self.searpet_breed = pet_breed_arr
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
        return self.searpet_breed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "getbreed", for: indexPath) as! getbreedTableViewCell
        cell.label_title.text = self.searpet_breed[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Pet_breed_val = self.searpet_breed[indexPath.row]
        Servicefile.shared.Pet_breed_val = self.Pet_breed_val
        Servicefile.shared.pet_type_val = self.pet_type_val
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pet_type.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! getpetCollectionViewCell
        let pb = self.pet_type[indexPath.row] as! NSDictionary
        let pbv = pb["pet_type_title"] as? String ?? ""
        let pet_type_img = pb["pet_type_img"] as? String ?? ""
        cell.image_view.sd_setImage(with: Servicefile.shared.StrToURL(url: pet_type_img)) { (image, error, cache, urls) in
               if (error != nil) {
                   cell.image_view.image = UIImage(named: "sample")
               } else {
                   cell.image_view.image = image
               }
           }
        cell.label_data.text = pbv
        cell.view_image.view_cornor()
        cell.image_view.view_cornor()
        cell.view_image.dropShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pb = self.pet_type[indexPath.row] as! NSDictionary
        let pbvtitle = pb["pet_type_title"] as? String ?? ""
        let pbv = pb["_id"] as? String ?? ""
        self.pet_type_val = pbvtitle
        self.callpetbreedbyid(petid: pbv)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.col_pettype.frame.size.width / 2.1, height: 175)
    }
    
    @IBAction func action_close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func callpetdetailget(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.petdetailget, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! NSDictionary
                        let Pet_type = Data["usertypedata"] as! NSArray
                        self.pet_type.removeAll()
                        self.Pet_breed.removeAll()
                        self.pet_type = Pet_type as! [Any]
                       
//                        self.tblview_pettype.reloadData()
//                        self.tblview_petbreed.reloadData()
                        self.col_pettype.reloadData()
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
    
    func callpetbreedbyid(petid: String){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.petbreedid, method: .post, parameters:
            ["pet_type_id" : petid], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        //self.textfield_petbreed.text = ""
                        let Pet_bree = res["Data"] as! NSArray
                        self.Pet_breed.removeAll()
                        self.searpet_breed.removeAll()
                        self.pet_breed_arr.removeAll()
                        self.Pet_breed = Pet_bree as! [Any]
                        for item in 0..<Pet_bree.count{
                            let pb = Pet_bree[item] as! NSDictionary
                            let pbv = pb["pet_breed"] as? String ?? ""
                            if pbv != "" {
                                self.pet_breed_arr.append(pbv)
                            }
                        }
                        self.searpet_breed = self.pet_breed_arr
                        self.col_pettype.isHidden = true
                        self.tbl_search_breed.isHidden = false
                        self.view_search_breed.isHidden = false
                        self.tbl_search_breed.reloadData()
                        self.stopAnimatingActivityIndicator()
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
