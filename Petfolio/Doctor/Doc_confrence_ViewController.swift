//
//  Doc_confrence_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 01/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import JitsiMeetSDK
import WebKit

class Doc_confrence_ViewController: UIViewController,JitsiMeetViewDelegate {
    
    @IBOutlet weak var view_noshow: UIView!
    @IBOutlet weak var view_close_conversation: UIView!
    fileprivate var jitsiMeetView: JitsiMeetView?
    var inc = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_noshow.layer.cornerRadius = self.view_noshow.frame.height / 2
        self.view_close_conversation.layer.cornerRadius = self.view_close_conversation.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if inc ==  1 {
             self.start_confrence()
            self.inc = 2
        }
    }
    
    func start_confrence(){
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.serverURL = URL(string: "https://meet.jit.si")
            builder.welcomePageEnabled = false
            builder.room = Servicefile.shared.Doc_dashlist[Servicefile.shared.selectedindex].Appid
            builder.setFeatureFlag("pip.enabled", withBoolean: false)
            builder.setFeatureFlag("add-people.enabled", withBoolean: false)
            builder.setFeatureFlag("invite.enabled", withBoolean: false)
            builder.setFeatureFlag("raise-hand.enabled", withBoolean: false)
            builder.setFeatureFlag("meeting-password.enabled", withBoolean: false)
            builder.setFeatureFlag("live-streaming.enabled", withBoolean: false)
            builder.setFeatureFlag("ios.recording.enabled", withBoolean: false)
            builder.setFeatureFlag("chat.enabled", withBoolean: false)
            builder.setFeatureFlag("server-url-change.enabled", withBoolean: false)
            builder.setFeatureFlag("toolbox.alwaysVisible", withBoolean: false)
            builder.setFeatureFlag("video-share.enabled", withBoolean: false)
        }
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.view = jitsiMeetView
        jitsiMeetView.join(options)
        present(vc, animated: true, completion: nil)
    }
    
    
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        print("confrence terminated")
        self.dismiss(animated: true, completion: nil)
    }
    
    func conferenceJoined(_ data: [AnyHashable : Any]!) {
        print("meeting started ")
    }
    
    func conferenceWillJoin(_ data: [AnyHashable : Any]!) {
        print("person will be joining soon please wait")
    }
    
    @IBAction func action_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func action_no_show(_ sender: Any) {
        self.call_Doc_calcel__confrence()
    }
    
    @IBAction func action_close_conversation(_ sender: Any) {
        Servicefile.shared.appointmentindex = Servicefile.shared.selectedindex
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doc_prescriptionViewController") as! Doc_prescriptionViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func call_Doc_calcel__confrence(){
        self.startAnimatingActivityIndicator()
        if Servicefile.shared.updateUserInterface() { AF.request(Servicefile.doc_cancel_appointment, method: .post, parameters:
            [ "_id": Servicefile.shared.Doc_dashlist[Servicefile.shared.selectedindex].Appid,
              "appoinment_status": "Missed",
              "missed_at": Servicefile.shared.ddMMyyyyhhmmastringformat(date: Date()),
              "appoint_patient_st": "Patient Not Available"], encoding: JSONEncoding.default).validate(statusCode: 200..<600).responseJSON { response in
                switch (response.result) {
                case .success:
                    let res = response.value as! NSDictionary
                    print("success data",res)
                    let Code  = res["Code"] as! Int
                    if Code == 200 {
                        self.dismiss(animated: true, completion: nil)
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
    
    func alert(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
