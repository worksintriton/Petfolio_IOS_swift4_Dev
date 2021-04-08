//
//  sp_dash_product_TableViewCell.swift
//  Petfolio
//
//  Created by Admin on 18/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class sp_dash_product_TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var label_cate_value: UILabel!
    
    @IBOutlet weak var btn_cate_seemore_btn: UIButton!
    @IBOutlet weak var coll_cat_prod_list: UICollectionView!
     var delegate: SelectItmDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.coll_cat_prod_list.delegate = self
        self.coll_cat_prod_list.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prod", for: indexPath) as! pet_shop_product_CollectionViewCell
        cell.label_prod_title.text = Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_title
        cell.label_price.text = "₹ " + String(Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_price)
        cell.image_product.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.image_product.dropShadow()
        if Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_fav {
            cell.image_fav.image = UIImage(named: imagelink.favtrue)
        }else{
            cell.image_fav.image = UIImage(named: imagelink.favfalse)
        }
        cell.label_offer.isHidden = true
        if Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_discount > 0 {
            cell.label_offer.isHidden = false
            cell.label_offer.text = String(Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_discount) + " % off"
        }
        
        if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_img) {
           
            cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_img)) { (image, error, cache, urls) in
                          if (error != nil) {
                            cell.image_product.image = UIImage(named: imagelink.sample)
                          } else {
                              cell.image_product.image = image
                          }
                      }
        }else{
            cell.image_product.image = UIImage(named: imagelink.sample)
        }
        cell.label_ratting.text = Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_rating
        cell.label_likes.text = Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row].product_review
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.sp_shop_dash_tbl_coll_index = indexPath.row
        print("service category index",Servicefile.shared.sp_shop_dash_tbl_index)
        print("service product index",Servicefile.shared.sp_shop_dash_tbl_coll_index)
        Servicefile.shared.product_id = Servicefile.shared.sp_dash_Product_details[coll_cat_prod_list.tag].prod_details[indexPath.row]._id
        delegate?.buttonPressed(passdata: Servicefile.shared.product_id)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
