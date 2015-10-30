// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Item.swift instead.

import CoreData

enum ItemAttributes: String {
    case category = "category"
    case image = "image"
    case maxPrice = "maxPrice"
    case minPrice = "minPrice"
    case order = "order"
    case title = "title"
}

enum ItemRelationships: String {
    case listedItems = "listedItems"
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
    var image: String?

    // func validateImage(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var maxPrice: NSNumber?

    // func validateMaxPrice(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var minPrice: NSNumber?

    // func validateMinPrice(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var order: NSNumber?

    // func validateOrder(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged
    var listedItems: NSSet

    func listedItemsSet() -> NSMutableSet {
        return self.listedItems.mutableCopy() as! NSMutableSet
    }

}

extension _Item {

    func addListedItems(objects: NSSet) {
        let mutable = self.listedItems.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.listedItems = mutable.copy() as! NSSet
    }

    func removeListedItems(objects: NSSet) {
        let mutable = self.listedItems.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.listedItems = mutable.copy() as! NSSet
    }

    func addListedItemsObject(value: ListedItem!) {
        let mutable = self.listedItems.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.listedItems = mutable.copy() as! NSSet
    }

    func removeListedItemsObject(value: ListedItem!) {
        let mutable = self.listedItems.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.listedItems = mutable.copy() as! NSSet
    }

}

