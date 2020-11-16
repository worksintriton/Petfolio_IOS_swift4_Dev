//
//  SliderViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var dogshowcoll: UICollectionView!
    
    var petlist = ["mydog","mydog","mydog"]
    var demodata = [{}]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dogshowcoll.delegate = self
        self.dogshowcoll.dataSource = self
        self.dogshowcoll.isPagingEnabled = true
        self.getdemo()
        // Do any additional setup after loading the view.
    }
    
   

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.demodata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! petsliderCollectionViewCell
        let val = self.demodata[indexPath.row]
        cell.pettitle.text = ""
        cell.petimage.image = UIImage(named: "mydog")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: self.dogshowcoll.frame.size.width , height:  self.dogshowcoll.frame.size.height)
       }
       
    
    @IBAction func skipaction(_ sender: Any) {
        print("skip action made")
    }
    
    func getdemo() {
        AF.request(Servicefile.slider, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        self.demodata.removeAll()
                        let Data = resp["Data"] as! NSDictionary
                        let SSdata = Data["SplashScreendata"] as! NSArray
                        
                      
                    }else{
                        print("status code service denied")
                    }
                    break
                case .failure(let Error):
                   
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }        }
    
        }

}
extension UIViewController  {
    
    func startAnimatingActivityIndicator() {
        Servicefile.shared.customview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        Servicefile.shared.customview.backgroundColor = UIColor.clear        //give color to the view
        Servicefile.shared.customview.center = self.view.center
        Servicefile.shared.backview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        Servicefile.shared.backview.backgroundColor = UIColor.black
        Servicefile.shared.backview.alpha = 0.4
        Servicefile.shared.loadlabel.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        Servicefile.shared.loadlabel.text = "Loading..."
        Servicefile.shared.loadlabel.textAlignment = .center
        Servicefile.shared.loadlabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        Servicefile.shared.loadlabel.textColor = UIColor.red
        Servicefile.shared.loadlabel.center = Servicefile.shared.customview.center
        Servicefile.shared.customview.addSubview(Servicefile.shared.backview)
        Servicefile.shared.customview.addSubview(Servicefile.shared.loadlabel)
        self.view.addSubview(Servicefile.shared.customview)

    }
    
    func stopAnimatingActivityIndicator() {
        Servicefile.shared.customview.removeFromSuperview()
        //        self.dismiss(animated: false, completion: nil)
        //        self.stopAnimating()
        //        Servicefile.shared.activity.stopAnimating()
        
    }
}
