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
        cell.label_prod_title.text = "prod title " + "\(indexPath.row)"
        cell.label_price.text = "₹ 10"+"\(indexPath.row)"
        cell.image_product.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        cell.image_product.dropShadow()
        //cell.image_product.image = UIImage(named: "sample")
         
        if Servicefile.shared.verifyUrl(urlString: Servicefile.shared.sp_dash_Banner_details[indexPath.row].banner_img) {
            print("null value check",Servicefile.shared.sp_dash_Product_details[Servicefile.shared.sp_shop_dash_tbl_index].prod_details[indexPath.row].product_img)
            cell.image_product.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.sp_dash_Product_details[Servicefile.shared.sp_shop_dash_tbl_index].prod_details[indexPath.row].product_img)) { (image, error, cache, urls) in
                          if (error != nil) {
                              cell.image_product.image = UIImage(named: "sample")
                          } else {
                              cell.image_product.image = image
                          }
                      }
        }else{
            cell.image_product.image = UIImage(named: "sample")
        }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Servicefile.shared.sp_shop_dash_tbl_coll_index = indexPath.row
        print("service category index",Servicefile.shared.sp_shop_dash_tbl_index)
        print("service product index",Servicefile.shared.sp_shop_dash_tbl_coll_index)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}