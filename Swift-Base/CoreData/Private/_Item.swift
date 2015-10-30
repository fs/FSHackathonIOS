// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.swift instead.

import CoreData

enum ItemAttributes: String {
    case category = "category"
    case maxPrice = "maxPrice"
    case minPrice = "minPrice"
    case title = "title"
    case unit = "unit"
}

enum ItemRelationships: String {
    case list = "list"
}

@objc
class _Item: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "Item"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _Item.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var category: String?

    // func validateCategory(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var maxPrice: NSNumber?

    // func validateMaxPrice(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var minPrice: NSNumber?

    // func validateMinPrice(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var unit: String?

    // func validateUnit(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged
    var list: List?

    // func validateList(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

