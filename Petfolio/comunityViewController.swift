//
//  comunityViewController.swift
//  Petfolio
//
//  Created by Admin on 26/05/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class comunityViewController: UIViewController {

    @IBOutlet weak var image_comm: UIImageView!
    @IBOutlet weak var label_comm: UILabel!
    
    @IBOutlet weak var view_main: UIView!
    @IBOutlet weak var view_ok: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_main.view_cornor()
        self.view_ok.view_cornor()
       // self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        //self.image_comm.image = UIImage(named: "petcoming")
        self.callpetdetailget()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func callpetdetailget(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.communitytext, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                   
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        let Data = resp["Data"] as? String ?? ""
                        self.label_comm.text = Data
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
                }        }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }

}
