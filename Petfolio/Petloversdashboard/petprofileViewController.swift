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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_footer.layer.cornerRadius = 15.0
        self.coll_petlist.delegate = self
        self.coll_petlist.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.pet_petlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        return cell
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
        
    }
    
    
}
