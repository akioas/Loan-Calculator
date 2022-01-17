

import Foundation
import CoreData


extension Feature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feature> {
        return NSFetchRequest<Feature>(entityName: "Feature")
    }

    @NSManaged public var yearPercent: Double
    @NSManaged public var mortgageAmount: Double
    @NSManaged public var monthlyPayment: Double
    @NSManaged public var monthsAmount: Int16

}

extension Feature : Identifiable {

}
