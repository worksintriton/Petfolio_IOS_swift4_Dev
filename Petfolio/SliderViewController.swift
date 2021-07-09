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
import CircleBar


@available(iOS 13.0, *)
class SliderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var view_skip_btn: UIView!
    @IBOutlet weak var dogshowcoll: UICollectionView!
    //typealias Razorpay = RazorpayCheckout
    var petlist = [Any]()
    var demodata = [{}]
    
    @IBOutlet weak var pagecontrl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appgreen)
        self.view_skip_btn.layer.cornerRadius = self.view_skip_btn.frame.height / 2
        self.petlist.removeAll()
        Servicefile.shared.checkemailvalid = "login"
        self.dogshowcoll.delegate = self
        self.dogshowcoll.dataSource = self
        self.dogshowcoll.isPagingEnabled = true
        self.pagecontrl.numberOfPages = self.petlist.count
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
       
        //print("image path",self.petlist[indexPath.row])
        let itmval = self.petlist[indexPath.row] as! NSDictionary
        let img = itmval["img_path"] as? String ?? ""
        let title = itmval["title"] as? String ?? ""
        cell.pettitle.text = title
        cell.petimage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        print("check url",Servicefile.shared.StrToURL(url: img))
        cell.petimage.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.petimage.sd_setImage(with: Servicefile.shared.StrToURL(url: img)) { (image, error, cache, urls) in
            if (error != nil) {
                print("image path normal",img)
                cell.petimage.image = UIImage(named: imagelink.sample)
            } else {
                print("image path empty",img)
                cell.petimage.image = image
            }
        }
        cell.petimage.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pagecontrl.currentPage = indexPath.row
        
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
                if UserDefaults.standard.string(forKey: "my_ref_code") != nil {
                    if  UserDefaults.standard.string(forKey: "my_ref_code") != "" {
                    Servicefile.shared.my_ref_code = UserDefaults.standard.string(forKey: "my_ref_code")!
                    }else{
                        Servicefile.shared.my_ref_code = ""
                    }
                }else{
                    Servicefile.shared.my_ref_code = ""
                }
                
                print("user type ",Servicefile.shared.user_type,"user id",Servicefile.shared.userid)
                if Servicefile.shared.user_type == "1" {
                   
                    //        Servicefile.shared.tabbar_selectedindex = 2
                            let tapbar = UIStoryboard.petloverDashboardViewController()
                    //        tapbar.selectedIndex = Servicefile.shared.tabbar_selectedindex
                            self.present(tapbar, animated: true, completion: nil)
//                    pettabbarViewController
                } else if Servicefile.shared.user_type == "4" {
                    let vc = UIStoryboard.DocdashboardViewController()
                    self.present(vc, animated: true, completion: nil)
                } else if Servicefile.shared.user_type == "2" {
                    let vc = UIStoryboard.Sp_dash_ViewController()
                    self.present(vc, animated: true, completion: nil)
                } else{
                    let vc = UIStoryboard.vendor_myorder_ViewController()
                    self.present(vc, animated: true, completion: nil)
                }
            }else{
                let vc = UIStoryboard.LoginViewController()
                self.present(vc, animated: true, completion: nil)
            }
            
        }else{
            
            let vc = UIStoryboard.LoginViewController()
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
                        self.petlist = Data as! [Any]
//                        print("image path",self.petlist)
                        self.pagecontrl.numberOfPages = self.petlist.count
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
    
//    func startAnimatingActivityIndicator() {
//        Servicefile.shared.customview.frame = CGRect.init(x: 0, y: self.view.frame.origin.y + 60, width: self.view.frame.width, height: self.view.frame.height)
//        Servicefile.shared.customview.backgroundColor = UIColor.clear        //give color to the view
//        Servicefile.shared.customview.center = self.view.center
//        Servicefile.shared.cusstackview.frame = CGRect(x: 0, y: self.view.frame.origin.y + 60, width: self.view.frame.width, height: self.view.frame.height)
//        Servicefile.shared.backview.frame = CGRect(x: 20, y: 0, width: 50, height: 50)
//        Servicefile.shared.backview.backgroundColor = UIColor.lightGray
//        let view1 = UIView()
//        view1.frame = CGRect(x: 20, y: 120, width: self.view.frame.width-40, height: 50)
//        view1.backgroundColor = UIColor.white
//        let view2 = UIView()
//        view2.frame = CGRect(x: 20, y: 180, width: self.view.frame.width-40, height: 50)
//        view2.backgroundColor = UIColor.white
//        let view3 = UIView()
//        view3.frame = CGRect(x: 20, y: 240, width: self.view.frame.width-40, height: 50)
//        view3.backgroundColor = UIColor.white
//        Servicefile.shared.backview.startShimmeringViewAnimation()
//        view1.startShimmeringViewAnimation()
//        view2.startShimmeringViewAnimation()
//        view3.startShimmeringViewAnimation()
//        Servicefile.shared.customview.addSubview(Servicefile.shared.cusstackview)
//        Servicefile.shared.cusstackview.addSubview(Servicefile.shared.backview)
//        Servicefile.shared.cusstackview.addSubview(view1)
//        Servicefile.shared.cusstackview.addSubview(view2)
//        Servicefile.shared.cusstackview.addSubview(view3)
//        self.view.addSubview(Servicefile.shared.customview)
//
//    }
    
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

extension UIView {
    func startShimmeringViewAnimation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        let gradientColorOne = UIColor(white: 0.90, alpha: 1.0).cgColor
        let gradientColorTwo = UIColor(white: 0.95, alpha: 1.0).cgColor
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.25
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
