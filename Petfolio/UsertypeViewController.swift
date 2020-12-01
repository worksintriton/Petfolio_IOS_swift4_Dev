//
//  UsertypeViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class UsertypeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collec_usertype: UICollectionView!
    
    
    var utype = [""]
    var selval = 0
    var locusel = [""]
    
    @IBOutlet weak var Viewchange: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locusel = Servicefile.shared.utypesel
        self.Viewchange.layer.cornerRadius = CGFloat(Servicefile.shared.viewcornorradius)
        self.collec_usertype.delegate = self
        self.collec_usertype.dataSource = self
        if Servicefile.shared.UtypeData.count > 0 {
             print("Data already used")
        }else{
            self.callusertype()
        }
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         if let firstVC = presentingViewController as? SignupViewController {
                   DispatchQueue.main.async {
                    firstVC.viewWillAppear(true)
                   }
               }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Servicefile.shared.UtypeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! User_typeCollectionViewCell
        
        cell.Img_Select.isHidden = false
        cell.Img_UT.sd_setImage(with: Servicefile.shared.StrToURL(url: Servicefile.shared.UtypeData[indexPath.row].user_type_img)) { (image, error, cache, urls) in
                   if (error != nil) {
                       cell.Img_UT.image = UIImage(named: "044.png")
                       cell.Img_UT.layer.cornerRadius = 3.0
                   } else {
                       cell.Img_UT.image = image
                   }
               }
        cell.Img_UT.layer.cornerRadius = 10.0
        cell.Lab_UT.text = Servicefile.shared.UtypeData[indexPath.row].user_type_title
        if self.locusel[indexPath.row] == "1"{
             cell.Img_Select.isHidden = false
            cell.Img_UT.layer.borderWidth = 2.0
            let borcolor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
            cell.Img_UT.layer.borderColor = borcolor.cgColor
        }else{
             cell.Img_UT.layer.borderWidth = 0.0
            cell.Img_Select.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.locusel = Servicefile.shared.orgiutypesel
       self.locusel.remove(at: indexPath.row)
        self.locusel.insert("1", at: indexPath.row)
        self.selval = indexPath.row
        self.collec_usertype.reloadData()
    }
    
    
    @IBAction func action_changeUT(_ sender: Any) {
        Servicefile.shared.utypesel = self.locusel
        Servicefile.shared.usertypetitle = Servicefile.shared.UtypeData[self.selval].user_type_title
        Servicefile.shared.user_type_value = Servicefile.shared.UtypeData[self.selval].user_type_value
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collec_usertype.frame.size.width / 2.2 , height:  self.collec_usertype.frame.size.width / 2)
    }
    
    func callusertype(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {  AF.request(Servicefile.usertype, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                       switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                        self.locusel.removeAll()
                                                        Servicefile.shared.UtypeData.removeAll()
                                                        Servicefile.shared.utypesel.removeAll()
                                                        Servicefile.shared.orgiutypesel.removeAll()
                                                        let data = res["Data"] as! NSDictionary
                                                        let usertypedata = data["usertypedata"] as! NSArray
                                                        for item in 0..<usertypedata.count{
                                                            let idata = usertypedata[item] as! NSDictionary
                                                            let id = idata["_id"] as! String
                                                            let ut_img = idata["user_type_img"] as! String
                                                            let ut_title = idata["user_type_title"] as! String
                                                            let ut_value = idata["user_type_value"] as! Int
                                                            Servicefile.shared.orgiutypesel.append("0")
                                                            if item != 0 {
                                                                 
                                                                 Servicefile.shared.utypesel.append("0")
                                                            }else{
                                                                 Servicefile.shared.utypesel.append("1")
                                                            }
                                                           
                                                            Servicefile.shared.UtypeData.append(Utype.init(UID: id, Utypeimg: ut_img, Utypetitle: ut_title, utypevalue: ut_value))
                                                        }
                                                        self.locusel = Servicefile.shared.utypesel
                                                        self.collec_usertype.reloadData()
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
    
    func alert(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
             }))
        self.present(alert, animated: true, completion: nil)
    }
    
    

}
