//
//  Articles+CoreDataClass.swift
//  
//
//  Created by Prince Sojitra on 02/08/20.
//
//

import Foundation
import CoreData

@objc(Articles)
public class Articles: NSManagedObject,Codable {
    
    required convenience public init(from decoder: Decoder) throws {
        
        print(CoreDataContext.url)
        
        let context = CoreDataContext.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Articles", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent(String.self, forKey: .data)
        let dateStr = try container.decodeIfPresent(String.self, forKey: .date)
        date = dateStr?.toDate(withFormat: "mm/dd/yyyy")
        id = try container.decodeIfPresent(String.self, forKey: .id)
        type = try container.decodeIfPresent(String.self, forKey: .type)
    }

}
