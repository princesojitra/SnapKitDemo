//
//  CommonFunctions.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 02/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation
import  UIKit

class Functions : NSObject {
    class  func topController(_ parent:UIViewController? = nil) -> UIViewController {
        if let vc = parent {
            if let tab = vc as? UITabBarController, let selected = tab.selectedViewController {
                return topController(selected)
            } else if let nav = vc as? UINavigationController, let top = nav.topViewController {
                return topController(top)
            } else if let presented = vc.presentedViewController {
                return topController(presented)
            } else {
                return vc
            }
        } else {
            return topController(UIApplication.shared.keyWindow!.rootViewController!)
        }
    }
    
    
}
