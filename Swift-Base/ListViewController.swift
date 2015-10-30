//
//  ListViewController.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    private enum SectionIndex : Int {
        case List
        
        static var count : UInt {
            return UInt(1)
        }
    }
    
    enum CellIdentifier: String {
        case List = "List"
    }
    
    //MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - params
    private lazy var listsFetchedResultsController: NSFetchedResultsController = { [weak self] in
        
        let defaultContext = NSManagedObjectContext.MR_defaultContext()
        let request = List.MR_requestAllInContext(defaultContext)
        request.fetchBatchSize = Int(List.MR_defaultBatchSize())
        
        let sortDescription = NSSortDescriptor(key: ListAttributes.date.rawValue, ascending: false)
        request.sortDescriptors = [sortDescription]
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: defaultContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        NSManagedObject.MR_performFetch(controller)
        
        return controller
        }()
    
    var listOfLists: [List] {
        return self.listsFetchedResultsController.fetchedObjects as? [List] ?? []
    }
}

//MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentList = self.listOfLists[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.List.rawValue, forIndexPath: indexPath) as! ListTableViewCell
        cell.prepareCell(currentList)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
}


//MARK: - NSFetchedResultsControllerDelegate
extension ListViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        var sectionIndex = -1
        let tableView = self.tableView
        
        switch controller {
        case self.listsFetchedResultsController :
            sectionIndex = SectionIndex.List.rawValue
            
        default :
            return
        }
        
        var updatedIndexPath: NSIndexPath? = nil
        if let indexPathStrong = indexPath {
            updatedIndexPath = NSIndexPath(forRow: indexPathStrong.row, inSection: sectionIndex)
        }
        
        var updatedNewIndexPath: NSIndexPath? = nil
        if let newIndexPathStrong = newIndexPath {
            updatedNewIndexPath = NSIndexPath(forRow: newIndexPathStrong.row, inSection: sectionIndex)
        }
        
        switch type {
            
        case NSFetchedResultsChangeType.Insert :
            tableView.insertRowsAtIndexPaths([updatedNewIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        case NSFetchedResultsChangeType.Delete :
            tableView.deleteRowsAtIndexPaths([updatedIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        case NSFetchedResultsChangeType.Update :
            tableView.reloadRowsAtIndexPaths([updatedIndexPath!], withRowAnimation: UITableViewRowAnimation.None)
            
        case NSFetchedResultsChangeType.Move :
            
            if updatedIndexPath != updatedNewIndexPath {
                tableView.moveRowAtIndexPath(updatedIndexPath!, toIndexPath: updatedNewIndexPath!)
            }
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
}

