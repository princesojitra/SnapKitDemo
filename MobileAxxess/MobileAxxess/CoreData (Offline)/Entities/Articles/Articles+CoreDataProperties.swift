//
//  Articles+CoreDataProperties.swift
//  
//
//  Created by Prince Sojitra on 02/08/20.
//
//

import Foundation
import CoreData


extension Articles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Articles> {
        return NSFetchRequest<Articles>(entityName: "Articles")
    }

    @NSManaged public var data: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var type: String?

    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case date = "date"
        case id = "id"
        case type = "type"
    }
    
   public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encode(date, forKey: .date)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
    }
}
