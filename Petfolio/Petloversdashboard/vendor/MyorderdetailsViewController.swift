//
//  MyorderdetailsViewController.swift
//  Petfolio
//
//  Created by Admin on 11/03/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class MyorderdetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_myorderlist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.tbl_myorderlist.delegate = self
        self.tbl_myorderlist.dataSource = self
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
        cell.selectionStyle = .none
        return cell
    }
    

}
