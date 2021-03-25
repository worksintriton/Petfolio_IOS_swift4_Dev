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
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    var pagcount = 0
    var timer = Timer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pagecontrol.numberOfPages = Servicefile.shared.sp_dash_Banner_details.count
        self.coll_pet_dash_shop_banner.delegate = self
        self.coll_pet_dash_shop_banner.dataSource = self
        self.coll_pet_dash_shop_banner.isPagingEnabled = true
        self.startTimer()
    }
    
   
    
    func startTimer() {
        self.timer.invalidate()
        timer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
           if Servicefile.shared.petbanner.count > 0 {
               self.pagcount += 1
               if self.pagcount == Servicefile.shared.sp_dash_Banner_details.count {
                   self.pagcount = 0
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.coll_pet_dash_shop_banner.scrollToItem(at: indexPath, at: .left, animated: true)
               }else{
                   let indexPath = IndexPath(row: pagcount, section: 0)
                   self.coll_pet_dash_shop_banner.scrollToItem(at: indexPath, at: .left, animated: true)
               }
               self.pagecontrol.currentPage = self.pagcount
           }
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
        cell.view_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.img_banner.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.view_banner.dropShadow()
    if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.sp_dash_Banner_details[indexPath.row].banner_img) {
         
        cell.img_banner.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.sp_dash_Banner_details[indexPath.row].banner_img)) { (image, error, cache, urls) in
            if (error != nil) {
                cell.img_banner.image = UIImage(named: "sample")
            } else {
                cell.img_banner.image = image
            }
        }
    }else{
         cell.img_banner.image = UIImage(named: "sample")
    }
   
    
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
