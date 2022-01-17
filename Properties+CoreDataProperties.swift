

import Foundation
import CoreData


extension Properties {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Properties> {
        return NSFetchRequest<Properties>(entityName: "Properties")
    }

    @NSManaged public var yearPercent: Double
    @NSManaged public var mortgageAmount: Double
    @NSManaged public var monthlyPayment: Double
    @NSManaged public var monthsAmount: Int16

}

extension Properties : Identifiable {

}
