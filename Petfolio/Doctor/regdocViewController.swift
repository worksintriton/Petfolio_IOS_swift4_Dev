//
//  regdocViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 19/11/20.
//  Copyright © 2020 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import Toucan

class regdocViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var tbl_educationlist: UITableView!
    @IBOutlet weak var tbl_experience: UITableView!
    
    var tbl_educationlistHeight: CGFloat = 0
    var tbl_experienceHeight: CGFloat = 0
     let imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imagepicker.delegate = self
        self.tbl_experience.delegate = self
        self.tbl_experience.dataSource = self
        self.tbl_educationlist.delegate = self
        self.tbl_educationlist.dataSource = self
//         tbl_experience.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
//        tbl_educationlist.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func action_uploadimg(_ sender: Any) {
        self.callgalaryprocess()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func callgalaryprocess(){
        let alert = UIAlertController(title: "Profile", message: "Choose the process", preferredStyle: UIAlertController.Style.alert)
              // add the actions (buttons)
              alert.addAction(UIAlertAction(title: "Take Photo", style: UIAlertAction.Style.default, handler: { action in
                  self.imagepicker.allowsEditing = false
                 self.imagepicker.sourceType = .camera
                  self.present(self.imagepicker, animated: true, completion: nil)
              }))
              alert.addAction(UIAlertAction(title: "Pick from Gallary", style: UIAlertAction.Style.default, handler: { action in
                 self.imagepicker.allowsEditing = false
                 self.imagepicker.sourceType = .photoLibrary
                  self.present(self.imagepicker, animated: true, completion: nil)
              }))
              alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: { action in
                print("ok")
              }))
              self.present(alert, animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               let reimage = Toucan(image: pickedImg).resize(CGSize(width: 100, height: 100), fitMode: Toucan.Resize.FitMode.crop).image
            let url = NSURL(fileURLWithPath: Servicefile.imageupload)
            self.upload(imagedata: reimage!, to: url as! URLRequestConvertible)
           }
             dismiss(animated: true, completion: nil)
       }
    
    func upload(imagedata: UIImage, to url: Alamofire.URLRequestConvertible) {
         print("Upload started")
        AF.upload(multipartFormData: { (multiPart) in
            if let imageData = imagedata.jpegData(compressionQuality: 0.5) {
                multiPart.append(imageData, withName: "sampleFile", fileName: "_profile_", mimeType: "image/png")
            }
        }, with: url)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
                //Do what ever you want to do with response
            })
    }
    
//   func uploadprocess(image: UIImage){
//        let imagedata = image
//        let now = Date()
//               let formatter = DateFormatter()
//               formatter.timeZone = TimeZone.current
//               formatter.dateFormat = "yyyy-MM-dd HH:mm"
//               let datetime = formatter.string(from: now)
//        let headers: HTTPHeaders = [
//            "Content-Type": "multipart/form-data"
//        ]
//        AF.upload(multipartFormData: { multipartFormData in
//            if let imageData = imagedata.jpegData(compressionQuality: 0.5) {
//                multipartFormData.append(imageData, withName: "file", fileName: "_profile_", mimeType: "image/png")
//            }
//        }, to: Servicefile.imageupload, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
//            switch result{
//            case .success(let upload, _,_):
//                upload.responseJSON(completionHandler: { (response) in
//                    if response.error != nil{
//                        print("error details",response.error)
//                        return
//                    }else{
//                        print("Succesfully Uploaded")
//                     let result = response.result.value as! NSDictionary
//                        print("uploaded data in Voxit application:",result)
//                        let data = result["response"] as! NSArray
//                        for item in 0..<data.count{
//                            let dat = data[item] as! NSDictionary
//                            let status = dat["status"] as! Int
//                            if status == 1 {
//                                let fullpath = dat["full_path"] as! String
//
//                                self.saveimageinserver(imgpath: fullpath)
//                            }
//                            print("ddata",dat)
//                        }
//                    }
//                })
//                upload.uploadProgress { progress in
//                    print("upoad progress",progress.fractionCompleted)
//                }
//            case .failure(let error):
//                print("Error in Upload: \(error.localizedDescription)")
//            }
//        }
//    }
}
