// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to List.swift instead.

import CoreData

enum ListAttributes: String {
    case date = "date"
    case title = "title"
}

enum ListRelationships: String {
    case listedItem = "listedItem"
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
    var listedItem: NSSet

    func listedItemSet() -> NSMutableSet {
        return self.listedItem.mutableCopy() as! NSMutableSet
    }

}

extension _List {

    func addListedItem(objects: NSSet) {
        let mutable = self.listedItem.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.listedItem = mutable.copy() as! NSSet
    }

    func removeListedItem(objects: NSSet) {
        let mutable = self.listedItem.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.listedItem = mutable.copy() as! NSSet
    }

    func addListedItemObject(value: ListadItam!) {
        let mutable = self.listedItem.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.listedItem = mutable.copy() as! NSSet
    }

    func removeListedItemObject(value: ListadItam!) {
        let mutable = self.listedItem.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.listedItem = mutable.copy() as! NSSet
    }

}

