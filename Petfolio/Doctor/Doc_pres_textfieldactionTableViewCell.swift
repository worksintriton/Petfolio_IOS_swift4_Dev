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
        self.btn_add.addTarget(self, action: #selector(returntext), for: .touchUpInside)
    }
    
    
    
    @objc func textFieldmediTyping(textField:UITextField) {
        if self.textfield_medi.text!.count > 24 {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvestring).inverted
            let string = textField.text
            let compSepByCharInSet = string!.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if string == numberFiltered {
                self.textfield_medi.text = string
                Servicefile.shared.medi = self.textfield_medi.text!
            }else{
                self.textfield_medi.text = numberFiltered
                Servicefile.shared.medi = self.textfield_medi.text!
            }
            self.textfield_medi.resignFirstResponder()
        } else {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvestring).inverted
            let string = textField.text
            let compSepByCharInSet = string!.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if string == numberFiltered {
                self.textfield_medi.text = string
                Servicefile.shared.medi = self.textfield_medi.text!
            }else{
                self.textfield_medi.text = numberFiltered
                Servicefile.shared.medi = self.textfield_medi.text!
            }
        }
    }
    
    @objc func textFieldnoofdayTyping(textField:UITextField) {
        if self.textfield_noofdays.text!.count > 2 {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvednumber).inverted
            let string = textField.text
            let compSepByCharInSet = string!.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if string == numberFiltered {
                self.textfield_noofdays.text = string
                Servicefile.shared.noofday = self.textfield_noofdays.text!
            }else{
                self.textfield_noofdays.text = numberFiltered
                Servicefile.shared.noofday = self.textfield_noofdays.text!
            }
            self.textfield_noofdays.resignFirstResponder()
        } else {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvednumber).inverted
            let string = textField.text
            let compSepByCharInSet = string!.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if string == numberFiltered {
                self.textfield_noofdays.text = string
                Servicefile.shared.noofday = self.textfield_noofdays.text!
            }else{
                self.textfield_noofdays.text = numberFiltered
                Servicefile.shared.noofday = self.textfield_noofdays.text!
            }
        }
    }
    
    @objc func textFieldTyping(textField:UITextField) {
        if self.conspdays.text!.count > 2 {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvednumber).inverted
            let string = textField.text
            let compSepByCharInSet = string!.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if string == numberFiltered {
                self.conspdays.text = string
                Servicefile.shared.consdays = self.conspdays.text!
            }else{
                self.conspdays.text = numberFiltered
                Servicefile.shared.consdays = self.conspdays.text!
            }
            self.conspdays.resignFirstResponder()
        } else {
            let aSet = NSCharacterSet(charactersIn: Servicefile.approvednumber).inverted
            let string = textField.text
            let compSepByCharInSet = string!.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            if string == numberFiltered {
                self.conspdays.text = string
                Servicefile.shared.consdays = self.conspdays.text!
            }else{
                self.conspdays.text = numberFiltered
                Servicefile.shared.consdays = self.conspdays.text!
            }
        }
        
    }
    
    @objc func returntext(sender: UIButton){
        self.textfield_medi.resignFirstResponder()
        self.textfield_noofdays.resignFirstResponder()
        self.conspdays.resignFirstResponder()
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
