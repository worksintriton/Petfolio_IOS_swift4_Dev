//
//  Pet_confrence_ViewController.swift
//  Petfolio
//
//  Created by sriram ramachandran on 01/02/21.
//  Copyright © 2021 sriram ramachandran. All rights reserved.
//

import UIKit
import Alamofire
import JitsiMeetSDK
import WebKit

class Pet_confrence_ViewController: UIViewController ,JitsiMeetViewDelegate {
    
    
    @IBOutlet weak var view_close_conversation: UIView!
    
    fileprivate var jitsiMeetView: JitsiMeetView?
    var inc = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Servicefile.shared.hexStringToUIColor(hex: Servicefile.shared.appviewcolor)
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
            builder.room =  Servicefile.shared.pet_applist_do_sp[Servicefile.shared.selectedindex]._id
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
    
    
    
    @IBAction func action_close_conversation(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
