//
//  SliderViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var dogshowcoll: UICollectionView!
    
    var petlist = ["mydog","mydog","mydog"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dogshowcoll.delegate = self
        self.dogshowcoll.dataSource = self
        self.dogshowcoll.isPagingEnabled = true
        // Do any additional setup after loading the view.
    }
    
   

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.petlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! petsliderCollectionViewCell
        cell.pettitle.text = self.petlist[indexPath.row]
        cell.petimage.image = UIImage(named: "mydog")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: self.dogshowcoll.frame.size.width , height:  self.dogshowcoll.frame.size.height)
       }
       
    
    @IBAction func skipaction(_ sender: Any) {
        print("skip action made")
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
