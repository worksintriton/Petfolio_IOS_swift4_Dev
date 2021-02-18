//
//  sp_shop_dash_bannerTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 18/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class sp_shop_dash_bannerTableViewCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    @IBOutlet weak var coll_pet_dash_shop_banner: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.coll_pet_dash_shop_banner.delegate = self
        self.coll_pet_dash_shop_banner.dataSource = self
        self.coll_pet_dash_shop_banner.isPagingEnabled = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Servicefile.shared.sp_dash_Banner_details.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ban", for: indexPath) as! petbannerCollectionViewCell
        cell.img_banner.image = UIImage(named: "sample")
        cell.view_banner.layer.cornerRadius = 10
        cell.img_banner.layer.cornerRadius = 10
        cell.view_banner.dropShadow()
//    if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.sp_dash_Banner_details[indexPath.row].banner_img) {
//         print("null value check",Servicefile.shared.sp_dash_Banner_details[indexPath.row].banner_img)
//        cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.sp_dash_Banner_details[indexPath.row].banner_img)) { (image, error, cache, urls) in
//            if (error != nil) {
//                cell.img_banner.image = UIImage(named: "sample")
//            } else {
//                cell.img_banner.image = image
//            }
//        }
//    }else{
         cell.img_banner.image = UIImage(named: "sample")
    //}
    print("null value check",Servicefile.shared.sp_dash_Banner_details[indexPath.row].banner_img)
    
    return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("service dashboard banner index",indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: self.coll_pet_dash_shop_banner.frame.size.width , height:  self.coll_pet_dash_shop_banner.frame.size.height)
        }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
