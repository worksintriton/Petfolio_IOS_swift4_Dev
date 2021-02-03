//
//  DemoViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class DemoViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var Democollec: UICollectionView!
    @IBOutlet weak var ViewGetstart: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.Democollec.delegate = self
        self.Democollec.dataSource = self
        self.ViewGetstart.layer.cornerRadius = 10.0
        self.Democollec.isPagingEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DemoCollectionViewCell
        cell.ImgD.image = UIImage(named: "Splash")
        cell.LabelDemodetaisl.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              return CGSize(width: self.Democollec.frame.size.width , height:  self.Democollec.frame.size.height)
          }

    
}
