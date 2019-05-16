//
//  AppDelegate.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/13/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    
        navigationController.viewControllers = [FormContainer()]
        window?.rootViewController = navigationController
        
        IQKeyboardManager.shared().isEnabled = true
        return true
    }

}

