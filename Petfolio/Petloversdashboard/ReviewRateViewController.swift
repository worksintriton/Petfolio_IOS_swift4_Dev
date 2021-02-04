//
//  ReviewRateViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 16/12/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire

class ReviewRateViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var Cosmos_rate: CosmosView!
    @IBOutlet weak var textview_review: UITextView!
    @IBOutlet weak var view_addreview: UIView!
    @IBOutlet weak var view_main: UIView!
    @IBOutlet var view_shadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Cosmos_rate.rating = 4
        Cosmos_rate.settings.fillMode = .full
        self.view_main.layer.cornerRadius = 15.0
        self.view_addreview.layer.cornerRadius = 10.0
        self.textview_review.delegate = self
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view_shadow.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            self.dismiss(animated: true, completion: nil)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
                if let firstVC = presentingViewController as? Pet_applist_ViewController {
                          DispatchQueue.main.async {
                           firstVC.viewWillAppear(true)
                          }
                      }
           }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if self.textview_review.text!.count > 250 {
                        textview_review.resignFirstResponder()
                     }else{
                         self.textview_review.text = textView.text
                     }
           if(text == "\n") {
                             textview_review.resignFirstResponder()
                             return false
                         }
              return true
          }
    
    
    @IBAction func action_addreview(_ sender: Any) {
        self.callupdaterateandreview()
    }
    
   func alert(Message: String){
                let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                     }))
                self.present(alert, animated: true, completion: nil)
            }
      
      func callupdaterateandreview(){
         self.startAnimatingActivityIndicator()
         if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.pet_review_update, method: .post, parameters:
             ["_id": Servicefile.shared.pet_apoint_id,
              "user_feedback": self.textview_review.text!,
              "user_rate": self.Cosmos_rate.rating
              ], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                    switch (response.result) {
                                                    case .success:
                                                          let res = response.value as! NSDictionary
                                                          print("success data",res)
                                                          let Code  = res["Code"] as! Int
                                                          if Code == 200 {
                                                          let alert = UIAlertController(title: "", message: "Rating and Review updated successfully", preferredStyle: .alert)
                                                                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                                             self.dismiss(animated: true, completion: nil)
                                                                              }))
                                                                         self.present(alert, animated: true, completion: nil)
                                                             
                                                          }else{
                                                            self.stopAnimatingActivityIndicator()
                                                            print("status code service denied")
                                                          }
                                                        break
                                                    case .failure(let Error):
                                                        self.stopAnimatingActivityIndicator()
                                                        print("Can't Connect to Server / TimeOut",Error)
                                                        break
                                                    }
                                       }
                }else{
                    self.stopAnimatingActivityIndicator()
                    self.alert(Message: "No Intenet Please check and try again ")
                }
            }
}
