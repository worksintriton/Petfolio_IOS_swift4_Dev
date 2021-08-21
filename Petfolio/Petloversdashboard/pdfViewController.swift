//
//  pdfViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 28/01/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//


import UIKit
import WebKit
import Alamofire

class pdfViewController: UIViewController,UIWebViewDelegate, WKNavigationDelegate {

    @IBOutlet weak var pdfview: UIView!
    @IBOutlet weak var docname: UILabel!
//    @IBOutlet weak var webview: UIWebView!
    var webView : WKWebView!
    var pdflink = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
        self.callpescription()
        self.pdfview.isHidden = true
        self.docname.text = "Pescription"
    }
    
    @IBAction func action_download(_ sender: Any) {
//        let url = NSURL(string: self.pdflink)!
//        self.loadFileAsync(url: url as URL) { (path, error) in
//            self.alert(Message: "Your prescription has been downlaoded successfully")
//        }
    }
    
   
    
    
    @IBAction func backaction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func StrToURL(url: String)-> URL{
                    let str = url
                    let urldat = str
                    let data = urldat.replacingOccurrences(of: " ", with: "%20")
                    let url = URL(string: data)
                    return url!
         }
    
    func callpescription(){
    print("data in prescription")
             Servicefile.shared.userid = UserDefaults.standard.string(forKey: "userid")!
            self.startAnimatingActivityIndicator()
      if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.view_prescription_create, method: .post, parameters: [
        "Appointment_ID": Servicefile.shared.pet_apoint_id]
           , encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                                                switch (response.result) {
                                                case .success:
                                                      let res = response.value as! NSDictionary
                                                      print("success data",res)
                                                      let Code  = res["Code"] as! Int
                                                      if Code == 200 {
                                                        let Data = res["Data"] as? NSDictionary ?? ["":""]
                                                        let Prescription_data = Data["PDF_format"] as? String ?? ""
                                                        let str = Prescription_data
                                                        let myBlog = str
                                                        self.pdflink = str
                                                        let url = NSURL(string: myBlog)!
                                                        let request = NSURLRequest(url: url as URL)
                                                        self.webView = WKWebView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-100))
                                                        self.webView.navigationDelegate = self
                                                        self.webView.load(request as URLRequest)
                                                        self.view.addSubview(self.webView)
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
                                                }
                                   }
            }else{
                self.stopAnimatingActivityIndicator()
                self.alert(Message: "No Intenet Please check and try again ")
            }
        }
    
    
    
     func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
     {
         let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

         let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

         if FileManager().fileExists(atPath: destinationUrl.path)
         {
             print("File already exists [\(destinationUrl.path)]")
             completion(destinationUrl.path, nil)
         }
         else if let dataFromURL = NSData(contentsOf: url)
         {
             if dataFromURL.write(to: destinationUrl, atomically: true)
             {
                 print("file saved [\(destinationUrl.path)]")
                 completion(destinationUrl.path, nil)
             }
             else
             {
                 print("error saving file")
                 let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                 completion(destinationUrl.path, error)
             }
         }
         else
         {
             let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
             completion(destinationUrl.path, error)
         }
     }

     func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
     {
         let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

         let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

         if FileManager().fileExists(atPath: destinationUrl.path)
         {
             print("File already exists [\(destinationUrl.path)]")
             completion(destinationUrl.path, nil)
         }
         else
         {
             let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
             var request = URLRequest(url: url)
             request.httpMethod = "GET"
             let task = session.dataTask(with: request, completionHandler:
             {
                 data, response, error in
                 if error == nil
                 {
                     if let response = response as? HTTPURLResponse
                     {
                         if response.statusCode == 200
                         {
                             if let data = data
                             {
                                 if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                 {
                                     completion(destinationUrl.path, error)
                                 }
                                 else
                                 {
                                     completion(destinationUrl.path, error)
                                 }
                             }
                             else
                             {
                                 completion(destinationUrl.path, error)
                             }
                         }
                     }
                 }
                 else
                 {
                     completion(destinationUrl.path, error)
                 }
             })
             task.resume()
         }
     }
       
    
}

