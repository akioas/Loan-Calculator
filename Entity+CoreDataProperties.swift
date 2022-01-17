//
//  Entity+CoreDataProperties.swift
//  Loan Calculator
//
//  Created by Катя on 17.01.2022.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var yearPercent: Double
    @NSManaged public var mortgageAmount: Double
    @NSManaged public var monthlyPayment: Double
    @NSManaged public var monthsAmount: Int16

}

extension Entity : Identifiable {

}
