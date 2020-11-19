//
//  DocdashboardViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 18/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire

class DocdashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var view_new: UIView!
    @IBOutlet weak var view_completed: UIView!
    @IBOutlet weak var view_missed: UIView!
    @IBOutlet weak var view_footer: UIView!
    
    
    @IBOutlet weak var tblview_applist: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view_new.layer.cornerRadius = 9.0
        self.view_missed.layer.cornerRadius = 9.0
        self.view_footer.layer.cornerRadius = 15.0
        self.view_completed.layer.cornerRadius = 9.0
        
        self.view_completed.layer.borderWidth = 0.5
        self.view_missed.layer.borderWidth = 0.5
        let appgree = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_completed.layer.borderColor = appgree.cgColor
        self.view_missed.layer.borderColor = appgree.cgColor
        
        self.tblview_applist.delegate = self
        self.tblview_applist.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    

    @IBAction func action_missed(_ sender: Any) {
    }
    @IBAction func action_completeappoint(_ sender: Any) {
    }
    @IBAction func action_newappoint(_ sender: Any) {
    }
    @IBAction func action_logout(_ sender: Any) {
        
    }
}
