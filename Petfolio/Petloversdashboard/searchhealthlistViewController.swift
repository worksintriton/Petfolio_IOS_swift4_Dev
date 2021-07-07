//
//  searchhealthlistViewController.swift
//  Petfolio
//
//  Created by Admin on 24/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class searchhealthlistViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var col_app_pet: UICollectionView!
    var healthissue = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.callpethealthissueget()
        Servicefile.shared.pet_type_val = ""
        Servicefile.shared.Pet_breed_val = ""
        let nibName = UINib(nibName: "healthissueCollectionViewCell", bundle:nil)
        self.col_app_pet.register(nibName, forCellWithReuseIdentifier: "cell")
        self.col_app_pet.delegate = self
        self.col_app_pet.dataSource = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.healthissue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! healthissueCollectionViewCell
        let data = self.healthissue[indexPath.row] as? NSDictionary  ?? ["":""]
        
        cell.label_title.text = data["health_issue_title"] as? String ?? ""
      
        let image = data["health_issue_img"] as? String ?? Servicefile.sample_img
        cell.image_data.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.image_data.sd_setImage(with: Servicefile.shared.StrToURL(url: image)) { (image, error, cache, urls) in
                    if (error != nil) {
                        cell.image_data.image = UIImage(named: imagelink.sample)
                    } else {
                        cell.image_data.image = image
                    }
                }
            
       
        
        cell.image_data.view_cornor()
        cell.view_main.view_cornor()
        cell.view_shadow.view_cornor()
        cell.view_image.view_cornor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.healthissue[indexPath.row] as? NSDictionary  ?? ["":""]
        let dataval = data["health_issue_title"] as? String ?? ""
        Servicefile.shared.healthissue = dataval
        let vc = UIStoryboard.searchpetloverappointmentViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.col_app_pet.frame.size.width , height:  100)
    }
    
   
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
func callpethealthissueget(){
    self.startAnimatingActivityIndicator()
    if Servicefile.shared.updateUserInterface() {
        AF.request(Servicefile.pet_healthissue, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
            switch (response.result) {
            case .success:
                let resp = response.value as! NSDictionary
                let Code  = resp["Code"] as! Int
                if Code == 200 {
                    let Data = resp["Data"] as? NSArray ?? [Any]() as NSArray
                    self.healthissue = Data as! [Any]
                    print("self.healthissue",self.healthissue)
                    self.col_app_pet.reloadData()
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
