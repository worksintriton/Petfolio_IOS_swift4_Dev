//
//  Doc_pres_textfieldactionTableViewCell.swift
//  Petfolio
//
//  Created by sriram ramachandran on 04/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit


class Doc_pres_textfieldactionTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textfield_medi: UITextField!
    @IBOutlet weak var textfield_noofdays: UITextField!
    @IBOutlet weak var conspdays: UITextField!
    @IBOutlet weak var btn_add: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textfield_medi.delegate = self
        self.textfield_noofdays.delegate = self
        self.conspdays.delegate = self
        self.textfield_medi.addTarget(self, action: #selector(textFieldmediTyping), for: .editingChanged)
        self.textfield_noofdays.addTarget(self, action: #selector(textFieldnoofdayTyping), for: .editingChanged)
        self.conspdays.addTarget(self, action: #selector(textFieldTyping), for: .editingChanged)
    }
    
    @objc func textFieldmediTyping(textField:UITextField)
    {
        Servicefile.shared.medi = self.textfield_medi.text!
    }
    @objc func textFieldnoofdayTyping(textField:UITextField)
    {
       Servicefile.shared.noofday = self.textfield_noofdays.text!
    }
    @objc func textFieldTyping(textField:UITextField)
    {
        Servicefile.shared.consdays = self.conspdays.text!
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_medi.resignFirstResponder()
        self.textfield_noofdays.resignFirstResponder()
        self.conspdays.resignFirstResponder()
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
