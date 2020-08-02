//
//  String+Date.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 02/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation

extension String {
    // date conversion from string with specified dateformat
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        let strDate = self
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: strDate)
        return date
    }
}

extension Date {
    
    // string conversion from date with specified dateformat
    func toString(withFormat format: String = "dd MMMM, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
