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
    var items: NSOrderedSet

    func itemsSet() -> NSMutableOrderedSet {
        return self.items.mutableCopy() as! NSMutableOrderedSet
    }

}

extension _List {

    func addItems(objects: NSOrderedSet) {
        let mutable = self.items.mutableCopy() as! NSMutableOrderedSet
        mutable.unionOrderedSet(objects)
        self.items = mutable.copy() as! NSOrderedSet
    }

    func removeItems(objects: NSOrderedSet) {
        let mutable = self.items.mutableCopy() as! NSMutableOrderedSet
        mutable.minusOrderedSet(objects)
        self.items = mutable.copy() as! NSOrderedSet
    }

    func addItemsObject(value: Item!) {
        let mutable = self.items.mutableCopy() as! NSMutableOrderedSet
        mutable.addObject(value)
        self.items = mutable.copy() as! NSOrderedSet
    }

    func removeItemsObject(value: Item!) {
        let mutable = self.items.mutableCopy() as! NSMutableOrderedSet
        mutable.removeObject(value)
        self.items = mutable.copy() as! NSOrderedSet
    }

}

