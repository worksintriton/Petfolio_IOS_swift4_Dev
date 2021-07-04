//
//  comunityViewController.swift
//  Petfolio
//
//  Created by Admin on 26/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class comunityViewController: UIViewController {

    @IBOutlet weak var image_comm: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.image_comm.image = UIImage(named: "petcoming")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
