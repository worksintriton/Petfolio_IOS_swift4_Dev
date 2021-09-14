//
//  AddproductViewController.swift
//  Petfolio
//
//  Created by Admin on 23/07/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import iOSDropDown

class AddproductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var view_header: petowner_otherpage_header!
    @IBOutlet weak var view_footer: doc_footer!
    @IBOutlet weak var col_prodlist: UICollectionView!
    @IBOutlet weak var view_selectmain: UIView!
    @IBOutlet weak var label_selecttext: UILabel!
    @IBOutlet weak var view_drop_down: UIView!
    @IBOutlet weak var dropdown_cate: DropDown!
    @IBOutlet weak var label_noprodfound: UILabel!
    
    var cate = [""]
    var cate_dic = [Any]()
    var scate = ""
    var scateid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inital_setup()
        self.cate.removeAll()
        self.cate_dic.removeAll()
        self.label_noprodfound.isHidden = true
        self.view_drop_down.view_cornor()
        self.view_selectmain.view_cornor()
        self.view_drop_down.dropShadow()
        self.view_selectmain.dropShadow()
        let addnib = UINib(nibName: "addingprodCollectionViewCell", bundle: nil)
        self.col_prodlist.register(addnib, forCellWithReuseIdentifier: "cell")
        let shownib = UINib(nibName: "showprodCollectionViewCell", bundle: nil)
        self.col_prodlist.register(shownib, forCellWithReuseIdentifier: "cell1")
        self.col_prodlist.delegate = self
        self.col_prodlist.dataSource = self
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callprodlist()
        self.calldrop()
    }

    func calldrop(){
        self.dropdown_cate.optionArray = self.cate
        self.dropdown_cate.didSelect{(selectedText , index ,id) in
            let data = "Selected String: \(selectedText) \n index: \(index)"
            print(data)
            self.label_selecttext.text = selectedText
            self.scate = selectedText
            for _ in 0..<self.cate_dic.count {
                let dataval = self.cate_dic[index] as! NSDictionary
                let diag = dataval["product_cate_name"] as? String ?? ""
                let add_id = dataval["_id"] as? String ?? ""
                print(diag,self.label_selecttext.text!)
                if diag == self.label_selecttext.text! {
                    self.scate = diag
                    self.scateid = add_id
                    self.callprodlist()
                }
            }
            self.dropdown_cate.hideList()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.addproddic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let val = Servicefile.shared.addproddic[indexPath.row] as! NSDictionary
        let status = val["status"] as! Bool
        let product_title = val["product_title"] as! String
        let product_img = val["product_img"] as! String
        if status {
            let cell = col_prodlist.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! showprodCollectionViewCell
            cell.image_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: product_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_data.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.image_data.image = image
                    }
            }
            cell.label_data.text = product_title
            cell.view_main.view_cornor()
            cell.view_main.dropShadow()
            cell.image_data.view_cornor()
            return cell
        }else{
            let cell = col_prodlist.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! addingprodCollectionViewCell
            cell.image_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: product_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_data.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.image_data.image = image
                    }
            }
            cell.image_data.view_cornor()
            cell.label_data.text = product_title
            cell.btn_add.tag = indexPath.row
            cell.btn_add.addTarget(self, action: #selector(addaction), for: .touchUpInside)
            cell.view_main.view_cornor()
            cell.view_main.dropShadow()
            return cell
        }
    }
    
    @objc func addaction(sender: UIButton){
        let tag = sender.tag
        Servicefile.shared.vselectedindex = tag
        let vc = UIStoryboard.addnewprodViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let val = Servicefile.shared.addproddic[indexPath.row] as! NSDictionary
        let status = val["status"] as! Bool
        print(status)
        if status {
            return CGSize(width: self.col_prodlist.frame.size.width / 2.1, height: 185)
        }else{
            return CGSize(width: self.col_prodlist.frame.size.width / 2.1, height: 225)
        }
    }
    
    func inital_setup(){
        // header action
            self.view_header.label_header_title.text = "Add product"
            self.view_header.label_header_title.textColor =  Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.textcolor)
            self.view_header.btn_back.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
        self.view_header.btn_profile.addTarget(self, action: #selector(self.vendorprofile), for: .touchUpInside)
        self.view_header.btn_bel.addTarget(self, action: #selector(self.action_notifi), for: .touchUpInside)
            self.view_header.view_sos.isHidden = true
            self.view_header.view_bag.isHidden = true
        // header action
        self.view_footer.setup(b1: false, b2: true, b3: false)
        self.view_footer.label_Fprocess_one.text = "Add Products"
        self.view_footer.btn_Fprocess_one.addTarget(self, action: #selector(self.vendorproduct), for: .touchUpInside)
        self.view_footer.btn_Fprocess_two.addTarget(self, action: #selector(self.vendordash), for: .touchUpInside)
        self.view_footer.btn_Fprocess_three.addTarget(self, action: #selector(self.button5), for: .touchUpInside)
    }

    @IBAction func action_drop_down(_ sender: Any) {
        
        self.dropdown_cate.showList()
    }
    
    func callprodlist(){
        print("vendor_id", Servicefile.shared.vendorid,"cat_id",self.scateid,"skip_count",1)
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.vendor_add_product_list, method: .post, parameters:
                                                                    ["vendor_id": Servicefile.shared.vendorid,"cat_id":self.scateid,"skip_count":1], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data in add product",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        let Data = res["Data"] as! NSArray
                        Servicefile.shared.addproddic = Data as! [Any]
                        if Servicefile.shared.addproddic.count > 0 {
                            self.label_noprodfound.isHidden = true
                        }else{
                            self.label_noprodfound.isHidden = false
                        }
                        self.col_prodlist.reloadData()
                        
                        self.stopAnimatingActivityIndicator()
                        self.callget()
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
    
    func callget(){
        
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.petprodcateget, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as! [Any]
                        self.cate_dic = Data
                        self.cate.removeAll()
                        for i in 0..<self.cate_dic.count {
                            let dataval = self.cate_dic[i] as! NSDictionary
                            let diag = dataval["product_cate_name"] as? String ?? ""
                            self.cate.append(diag)
                        }
                        self.calldrop()
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
    
}
