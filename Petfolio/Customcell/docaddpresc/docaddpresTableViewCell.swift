//
//  docaddpresTableViewCell.swift
//  Petfolio
//
//  Created by Admin on 30/06/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit

class docaddpresTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textfield_medi: UITextField!
    @IBOutlet weak var textfield_noofdays: UITextField!
    @IBOutlet weak var btn_add: UIButton!
    
    @IBOutlet weak var img_m: UIImageView!
    @IBOutlet weak var btn_m: UIButton!
    @IBOutlet weak var img_a: UIImageView!
    @IBOutlet weak var btn_a: UIButton!
    
    @IBOutlet weak var img_n: UIImageView!
    @IBOutlet weak var btn_n: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textfield_medi.delegate = self
        self.textfield_noofdays.delegate = self
        self.textfield_medi.addTarget(self, action: #selector(textFieldmediTyping), for: .editingChanged)
        self.textfield_noofdays.addTarget(self, action: #selector(textFieldnoofdayTyping), for: .editingChanged)
        self.btn_add.addTarget(self, action: #selector(returntext), for: .touchUpInside)
    }
    
    
    
    @objc func textFieldmediTyping(textField:UITextField) {
        if self.textfield_medi.text!.count > 24 {
            self.textfield_medi.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvestring, textcount: 25)
             Servicefile.shared.medi = self.textfield_medi.text!
            self.textfield_medi.resignFirstResponder()
        } else {
            self.textfield_medi.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvestring, textcount: 25)
             Servicefile.shared.medi = self.textfield_medi.text!
        }
    }
    
    @objc func textFieldnoofdayTyping(textField:UITextField) {
        if self.textfield_noofdays.text!.count > 2 {
            self.textfield_noofdays.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 2)
            Servicefile.shared.noofday = self.textfield_noofdays.text!
            self.textfield_noofdays.resignFirstResponder()
        } else {
             self.textfield_noofdays.text = Servicefile.textfieldrestrict(str: textField.text!, checkchar: Servicefile.approvednumber, textcount: 2)
             Servicefile.shared.noofday = self.textfield_noofdays.text!
        }
    }
    
   
    
    @objc func returntext(sender: UIButton){
        self.textfield_medi.resignFirstResponder()
        self.textfield_noofdays.resignFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textfield_medi.resignFirstResponder()
        self.textfield_noofdays.resignFirstResponder()
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
