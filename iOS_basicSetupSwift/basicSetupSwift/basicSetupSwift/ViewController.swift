//
//  ViewController.swift
//  basicSetupSwift
//
//  Created by Matthew Bell on 5/26/17.
//  Copyright © 2017 Leanplum. All rights reserved.
//

import UIKit
import UserNotifications
import Leanplum

class ViewController: UIViewController {
    
    @IBAction func trackButtonClick(_ sender: Any) {
        Leanplum.track("firstEvent")
    }
    
    @IBAction func registerForPushClick(_ sender: Any) {
        print("you clicked on Push Notification registration button")
        registerForPushNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerForPushNotifications(){
        //iOS-10
        if #available(iOS 10.0, *){
            let userNotifCenter = UNUserNotificationCenter.current()
            
            userNotifCenter.requestAuthorization(options: [.badge, .alert, .sound]){ (granted,error) in
                //Handle individual parts of the granting here
            }
            UIApplication.shared.registerForRemoteNotifications()
        }
        //iOS 8-9
        else if #available(iOS 8.0, *){
            let settings = UIUserNotificationSettings.init(types: [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound],
                                                           categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        //iOS 7
        else {
            UIApplication.shared.registerForRemoteNotifications(matching:
                [UIRemoteNotificationType.alert,
                 UIRemoteNotificationType.badge,
                 UIRemoteNotificationType.sound])
        }
        
    }

}

