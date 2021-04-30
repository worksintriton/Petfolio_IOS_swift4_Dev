//
//  SliderViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 11/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices
import WebKit
import SDWebImage

class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var view_skip_btn: UIView!
    @IBOutlet weak var dogshowcoll: UICollectionView!
    //typealias Razorpay = RazorpayCheckout
    var petlist = [""]
    var demodata = [{}]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_skip_btn.layer.cornerRadius = self.view_skip_btn.frame.height / 2
        self.petlist.removeAll()
        Servicefile.shared.checkemailvalid = "login"
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
        return self.petlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! petsliderCollectionViewCell
        cell.pettitle.text = ""
        print("image path",self.petlist[indexPath.row])
        cell.petimage.sd_setImage(with: Servicefile.shared.StrToURL(url: self.petlist[indexPath.row])) { (image, error, cache, urls) in
            if (error != nil) {
                cell.petimage.image = UIImage(named: "sample")
            } else {
                cell.petimage.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width , height:  self.view.frame.size.height)
    }
    
    @IBAction func skipaction(_ sender: Any) {
        // self.showPaymentForm()
        if  UserDefaults.standard.string(forKey: "usertype") != nil {
            if  UserDefaults.standard.string(forKey: "usertype") != "" {
                Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
                Servicefile.shared.user_type = UserDefaults.standard.string(forKey: "usertype")!
                Servicefile.shared.first_name = UserDefaults.standard.string(forKey: "first_name")!
                Servicefile.shared.last_name = UserDefaults.standard.string(forKey: "last_name")!
                Servicefile.shared.user_email = UserDefaults.standard.string(forKey: "user_email")!
                Servicefile.shared.user_phone = UserDefaults.standard.string(forKey: "user_phone")!
                Servicefile.shared.userimage = UserDefaults.standard.string(forKey: "user_image")!
                
                print("user type ",Servicefile.shared.user_type,"user id",Servicefile.shared.userid)
                if Servicefile.shared.user_type == "1" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "petloverDashboardViewController") as! petloverDashboardViewController
                    self.present(vc, animated: true, completion: nil)
                } else if Servicefile.shared.user_type == "4" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DocdashboardViewController") as! DocdashboardViewController
                    self.present(vc, animated: true, completion: nil)
                } else if Servicefile.shared.user_type == "2" {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Sp_dash_ViewController") as! Sp_dash_ViewController
                    self.present(vc, animated: true, completion: nil)
                } else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "vendor_myorder_ViewController") as! vendor_myorder_ViewController
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
        startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() {
            AF.request(Servicefile.slider, method: .get, encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let resp = response.value as! NSDictionary
                    print("display data",resp)
                    let Code  = resp["Code"] as! Int
                    if Code == 200 {
                        self.demodata.removeAll()
                        let Data = resp["Data"] as! NSArray
                        self.petlist.removeAll()
                        for i in 0..<Data.count{
                            let itmval = Data[i] as! NSDictionary
                            let img = itmval["img_path"] as? String ?? ""
                            self.petlist.append(img)
                        }
                        print(self.petlist)
                        self.dogshowcoll.reloadData()
                        self.stopAnimatingActivityIndicator()
                    }else{
                        print("status code service denied")
                        self.stopAnimatingActivityIndicator()
                    }
                    break
                case .failure(let Error):
                    print("Can't Connect to Server / TimeOut",Error)
                    self.stopAnimatingActivityIndicator()
                    break
                }
            }
        }else{
            self.stopAnimatingActivityIndicator()
            self.alert(Message: "No Intenet Please check and try again ")
        }
    }
}
extension UIViewController  {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func startAnimatingActivityIndicator() {
        Servicefile.shared.customview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        Servicefile.shared.customview.backgroundColor = UIColor.clear        //give color to the view
        Servicefile.shared.customview.center = self.view.center
        Servicefile.shared.backview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        Servicefile.shared.backview.backgroundColor = UIColor.black
        Servicefile.shared.backview.alpha = 0.4
        Servicefile.shared.gifimg.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        //Servicefile.shared.gifimg.image = UIImage(named: "doganimate.gif")
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "doganimate", withExtension: "gif")!)
        Servicefile.shared.gifimg.image = UIImage.sd_image(withGIFData: imageData)
        //        Servicefile.shared.loadlabel.textAlignment = .center
        //        Servicefile.shared.loadlabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        //        Servicefile.shared.loadlabel.textColor = UIColor.red
        Servicefile.shared.gifimg.center = Servicefile.shared.customview.center
        Servicefile.shared.customview.addSubview(Servicefile.shared.backview)
        Servicefile.shared.customview.addSubview(Servicefile.shared.gifimg)
        self.view.addSubview(Servicefile.shared.customview)
        
    }
    
    func startAnimatingActivityIndicator_gif(named: String) {
        Servicefile.shared.customview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        Servicefile.shared.customview.backgroundColor = UIColor.clear        //give color to the view
        Servicefile.shared.customview.center = self.view.center
        Servicefile.shared.backview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        Servicefile.shared.backview.backgroundColor = UIColor.black
        Servicefile.shared.backview.alpha = 0.4
        Servicefile.shared.gifimg.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        //Servicefile.shared.gifimg.image = UIImage(named: "doganimate.gif")
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "cat_walk1", withExtension: "gif")!)
        Servicefile.shared.gifimg.image = UIImage.sd_image(withGIFData: imageData)
        //        Servicefile.shared.loadlabel.textAlignment = .center
        //        Servicefile.shared.loadlabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        //        Servicefile.shared.loadlabel.textColor = UIColor.red
        Servicefile.shared.gifimg.center = Servicefile.shared.customview.center
        Servicefile.shared.customview.addSubview(Servicefile.shared.backview)
        Servicefile.shared.customview.addSubview(Servicefile.shared.gifimg)
        self.view.addSubview(Servicefile.shared.customview)
        
    }
    
    func stopAnimatingActivityIndicator() {
        Servicefile.shared.customview.removeFromSuperview()
    }
  
    func alert(Message: String){
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
