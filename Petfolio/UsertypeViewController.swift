//
//  UsertypeViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class UsertypeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collec_usertype: UICollectionView!
    
    var utype = ["Pet lovers","Service Provider", "Vendor", "Doctors"]
    var utypesel = ["1","0","0","0"]
     var orgiutypesel = ["0","0","0","0"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collec_usertype.delegate = self
        self.collec_usertype.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.utype.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! User_typeCollectionViewCell
        cell.Img_Select.isHidden = false
        cell.Img_UT.image = UIImage(named: "mydog")
        cell.Lab_UT.text = self.utype[indexPath.row]
        if self.utypesel[indexPath.row] == "1"{
             cell.Img_Select.backgroundColor = UIColor.green
        }else{
            cell.Img_Select.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.utypesel = self.orgiutypesel
        self.utypesel.remove(at: indexPath.row)
        self.utypesel.insert("1", at: indexPath.row)
        self.collec_usertype.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collec_usertype.frame.size.width / 2 , height:  self.collec_usertype.frame.size.width / 2)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
