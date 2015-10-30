// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to List.swift instead.

import CoreData

enum ListAttributes: String {
    case date = "date"
    case title = "title"
}

enum ListRelationships: String {
    case items = "items"
}

@objc
class _List: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "List"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _List.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var date: NSNumber?

    // func validateDate(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged
    var title: String?

    // func validateTitle(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged
    var items: NSSet

    func itemsSet() -> NSMutableSet {
        return self.items.mutableCopy() as! NSMutableSet
    }

}

extension _List {

    func addItems(objects: NSSet) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.items = mutable.copy() as! NSSet
    }

    func removeItems(objects: NSSet) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.items = mutable.copy() as! NSSet
    }

    func addItemsObject(value: Item!) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.items = mutable.copy() as! NSSet
    }

    func removeItemsObject(value: Item!) {
        let mutable = self.items.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.items = mutable.copy() as! NSSet
    }

}

