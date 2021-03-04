//
//  testfileViewController.swift
//  Petfolio
//
//  Created by Admin on 27/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class testfileViewController: UIViewController {

    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var testviewgray: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testview.View_image_appcolordropshadow(cornordarius: 10.0, iscircle: false)
        self.testviewgray.View_image_dropshadow(cornordarius: 10.0, iscircle: false)
        // Do any additional setup after loading the view.
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
