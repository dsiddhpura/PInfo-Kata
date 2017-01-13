//
//  Helper.swift
//  Kata
//
//  Created by Dharmesh Siddhpura on 1/12/17.
//  Copyright © 2017 Dharmesh Siddhpura. All rights reserved.
//

import Foundation
import UIKit

func performOnMain(updates: @escaping () -> Void) {
    
    DispatchQueue.main.async{
        
        updates()
    }
}

func getRootVC() -> UIViewController
{
    let window: UIWindow! = AppDelegate.sharedInstance.appDelegate.window
    let vc: UIViewController! = window.rootViewController
    
    return vc
}

func showAlert(title: String?, message: String?, vc: UIViewController!)
{
    var vc = vc
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        
    })
    
    alertView.addAction(alertAction)
    
    if (vc == nil)
    {
        vc = getRootVC()
    }
    
    performOnMain {
        
        vc?.present(alertView, animated: true, completion: nil)
    }
}
