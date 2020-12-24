//
//  SliderViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Razorpay
import SafariServices
import WebKit

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , RazorpayPaymentCompletionProtocol, RazorpayPaymentCompletionProtocolWithData {

    @IBOutlet weak var dogshowcoll: UICollectionView!
    //typealias Razorpay = RazorpayCheckout
    var petlist = ["mydog","mydog","mydog"]
    var demodata = [{}]
     var razorpay: RazorpayCheckout!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dogshowcoll.delegate = self
        self.dogshowcoll.dataSource = self
        self.dogshowcoll.isPagingEnabled = true
        self.getdemo()
        
       
        // Do any additional setup after loading the view.
    }
    
   

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.demodata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! petsliderCollectionViewCell
        let val = self.demodata[indexPath.row]
        cell.pettitle.text = ""
        cell.petimage.image = UIImage(named: "mydog")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: self.view.frame.size.width , height:  self.view.frame.size.height)
       }
       
    func movetestpayment(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "paymentpageViewController") as! paymentpageViewController
                                                                self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func skipaction(_ sender: Any) {
         //self.showPaymentForm()
        if  UserDefaults.standard.string(forKey: "usertype") != nil {
              if  UserDefaults.standard.string(forKey: "usertype") != "" {

                Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
                Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                 print("user type ",Servicefile.shared.user_type,"user id",Servicefile.shared.userid)
                if Servicefile.shared.user_type == "1" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
                    self.present(vc, animated: true, completion: nil)
                }else if Servicefile.shared.user_type == "4" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DocdashboardViewController") as! DocdashboardViewController
                    self.present(vc, animated: true, completion: nil)
                }else if Servicefile.shared.user_type == "2" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_dash_ViewController") as! Sp_dash_ViewController
                    self.present(vc, animated: true, completion: nil)
                }
                else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.present(vc, animated: true, completion: nil)
                }

            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(vc, animated: true, completion: nil)
            }

        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func getdemo() {
        AF.request(Servicefile.slider, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        self.demodata.removeAll()
                        let Data = resp["Data"] as! NSDictionary
                        let SSdata = Data["SplashScreendata"] as! NSArray
                        
                      
                    }else{
                        print("status code service denied")
                    }
                    break
                case .failure(let Error):
                   
                    print("Can't Connect to Server / TimeOut",Error)
                    break
                }        }
    
        }
    
    
    func showPaymentForm(){
         self.razorpay = RazorpayCheckout.initWithKey("rzp_test_zioohqmxDjJJtd", andDelegate: self)
        let options: [String:Any] = [
                    "amount": "100", //This is in currency subunits. 100 = 100 paise= INR 1.
                    "currency": "INR",//We support more that 92 international currencies.
                    "description": "some some",
                    "image": "http://52.25.163.13:3000/api/uploads/template.png",
                    "name": "sriram",
                    "prefill": [
                        "contact": "9003525711",
                        "email": "sriramchanr@gmail.com.com"
                    ],
                    "theme": [
                        "color": "#F37254"
                    ]
                ]

        if let rzp = self.razorpay {
                   rzp.open(options)
               } else {
                   print("Unable to initialize")
               }
        
//        self.razorpay = RazorpayCheckout.initWithKey("rzp_test_zioohqmxDjJJtd", andDelegate: self)
//               let options: [AnyHashable:Any] = [
//                   "amount": 100, //This is in currency subunits. 100 = 100 paise= INR 1.
//                   "currency": "INR",//We support more that 92 international currencies.
//                   "description": "some data",
//                   "order_id": "order_DBJOWzybf0sJbb",
//                   "image": "http://52.25.163.13:3000/api/uploads/template.png",
//                   "name": "sriram",
//                   "prefill": [
//                       "contact": "9003525711",
//                       "email": "sriramchanr@gmail.com"
//                   ],
//                   "theme": [
//                       "color": "#F37254"
//                   ]
//               ]
//               if let rzp = self.razorpay {
//                   rzp.open(options)
//               } else {
//                   print("Unable to initialize")
//               }
       
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
            print("Payment failed with code")
       }
       
       func onPaymentSuccess(_ payment_id: String) {
             print("Payment Success payment")
       }
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
           print("error: ", code)
          
       }
       
       func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
           print("success: ", payment_id)
           
       }

}
extension UIViewController  {
    
    func startAnimatingActivityIndicator() {
        Servicefile.shared.customview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        Servicefile.shared.customview.backgroundColor = UIColor.clear        //give color to the view
        Servicefile.shared.customview.center = self.view.center
        Servicefile.shared.backview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        Servicefile.shared.backview.backgroundColor = UIColor.black
        Servicefile.shared.backview.alpha = 0.4
        Servicefile.shared.loadlabel.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        Servicefile.shared.loadlabel.text = "Loading..."
        Servicefile.shared.loadlabel.textAlignment = .center
        Servicefile.shared.loadlabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        Servicefile.shared.loadlabel.textColor = UIColor.red
        Servicefile.shared.loadlabel.center = Servicefile.shared.customview.center
        Servicefile.shared.customview.addSubview(Servicefile.shared.backview)
        Servicefile.shared.customview.addSubview(Servicefile.shared.loadlabel)
        self.view.addSubview(Servicefile.shared.customview)

    }
    
    func stopAnimatingActivityIndicator() {
        Servicefile.shared.customview.removeFromSuperview()
        //        self.dismiss(animated: false, completion: nil)
        //        self.stopAnimating()
        //        Servicefile.shared.activity.stopAnimating()
        
    }
    
   
    
   
}
