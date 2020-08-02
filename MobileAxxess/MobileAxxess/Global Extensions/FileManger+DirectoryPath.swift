//
//  FileManger+DirectoryPath.swift
//  MVVM Archiecture
//
//  Created by Prince Sojitra on 12/07/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation

extension FileManager {
    // get document directory path
    class func documentsDir() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    // get support directory path
    class func supportDir() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    // get cache directory path
    class func cachesDir() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}
