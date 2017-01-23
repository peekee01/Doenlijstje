//
//  Todo+CoreDataProperties.swift
//  
//
//  Created by Pieter Kuijsten on 22/01/2017.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo");
    }

    @NSManaged public var title: String?
    @NSManaged public var created: NSDate?

}
