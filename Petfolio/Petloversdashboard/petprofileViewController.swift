//
//  petprofileViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 08/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class petprofileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var View_profile: UIView!
    @IBOutlet weak var imag_user: UIImageView!
    @IBOutlet weak var label_user: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_phono: UILabel!
    @IBOutlet weak var coll_petlist: UICollectionView!
    @IBOutlet weak var view_footer: UIView!
    var ismenu = ["0"]
    var isorgi = ["0"]
    override func viewDidLoad() {
        super.viewDidLoad()
         Servicefile.shared.pet_status = ""
        self.ismenu.removeAll()
        self.view_footer.layer.cornerRadius = 15.0
        for itm in 0..<Servicefile.shared.pet_petlist.count{
            self.ismenu.append("0")
        }
        self.isorgi = self.ismenu
        self.coll_petlist.delegate = self
                     self.coll_petlist.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
             return Servicefile.shared.pet_petlist.count
        }else{
            return 1
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! petloverProfilepetlistCollectionViewCell
            cell.label_petname.text = Servicefile.shared.pet_petlist[indexPath.row].pet_name
            if Servicefile.shared.pet_petlist[indexPath.row].pet_img == "" {
                cell.imag_profile.image = UIImage(named: "sample")
            }else{
                cell.imag_profile.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.pet_petlist[indexPath.row].pet_img)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.imag_profile.image = UIImage(named: "sample")
                    } else {
                        cell.imag_profile.image = image
                    }
                }
            }
            cell.imag_profile.layer.cornerRadius =  cell.imag_profile.frame.width / 2
            if self.ismenu[indexPath.row] == "1"{
               cell.View_menu.isHidden = false
            }else{
                cell.View_menu.isHidden = true
            }
            cell.btn_menu.tag = indexPath.row
            cell.btn_menu.addTarget(self, action: #selector(action_clickmenu), for: .touchUpInside)
            cell.btn_edit.tag = indexPath.row
            cell.btn_edit.addTarget(self, action: #selector(action_clickedit), for: .touchUpInside)
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(action_clickdelete), for: .touchUpInside)
            cell.btn_healthrecord.tag = indexPath.row
            cell.btn_healthrecord.addTarget(self, action: #selector(action_healthrecord), for: .touchUpInside)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellimg", for: indexPath) as! petaddimgCollectionViewCell
            return cell
        }
        
    }
    
    @objc func action_clickmenu(sender: UIButton){
        let tag = sender.tag
        self.ismenu = self.isorgi
        self.ismenu.remove(at: tag)
        self.ismenu.insert("1", at: tag)
        self.coll_petlist.reloadData()
    }
    
    @objc func action_clickedit(sender: UIButton){
           let tag = sender.tag
        Servicefile.shared.pet_status = "edit"
        Servicefile.shared.pet_index = tag
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverEditandAddViewController") as! petloverEditandAddViewController
        self.present(vc, animated: true, completion: nil)
       }
    
    @objc func action_clickdelete(sender: UIButton){
              let tag = sender.tag
             
          }
    
    @objc func action_healthrecord(sender: UIButton){
                 let tag = sender.tag
                
             }
       
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 128 , height:  151)
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func action_editprofile(_ sender: Any) {
        
    }
    
    
    @IBAction func action_manageaddress(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "petManageaddressViewController") as! petManageaddressViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
