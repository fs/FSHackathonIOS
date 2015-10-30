// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ListadItam.swift instead.

import CoreData

enum ListadItamAttributes: String {
    case count = "count"
    case unit = "unit"
}

enum ListadItamRelationships: String {
    case item = "item"
    case list = "list"
}

@objc
class _ListadItam: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "ListadItam"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _ListadItam.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var count: NSNumber?

    // func validateCount(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var unit: NSNumber?

    // func validateUnit(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged
    var item: Item?

    // func validateItem(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var list: List?

    // func validateList(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

