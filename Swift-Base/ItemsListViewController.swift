//
//  ItemsListViewController.swift
//  Swift-Base
//
//  Created by Nikita Fomin on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ItemsListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listIndex: Int!
    var listViewController: ListViewController!
    
    lazy var items = {
        return Item.MR_findAllSortedBy(ItemAttributes.order.rawValue, ascending: true) as! [Item]
    }()
}

//MARK: - UICollectionViewDataSource
extension ItemsListViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemListCollectionViewCell", forIndexPath: indexPath) as! ItemListCollectionViewCell
        cell.prepareCell(self.items[indexPath.row])
        return cell
    }
}

extension ItemsListViewController: RACollectionViewDelegateTripletLayout {
    
    func sectionSpacingForCollectionView(collectionView: UICollectionView) -> CGFloat {
        return 8.0
    }
    
    func minimumInteritemSpacingForCollectionView(collectionView: UICollectionView) -> CGFloat {
        return 8.0
    }
    
    func minimumLineSpacingForCollectionView(collectionView: UICollectionView) -> CGFloat {
        return 8.0
    }
    
    func insetsForCollectionView(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }
    
    func collectionView(collectionView: UICollectionView, sizeForLargeItemsInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func autoScrollTrigerEdgeInsets(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(50, 0, 50, 0)
    }
    
    func autoScrollTrigerPadding(collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(64, 0, 0, 0)
    }
    
    func reorderingItemAlpha(collectionView: UICollectionView) -> CGFloat {
        return 0.3
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  didEndDraggingItemAtIndexPath indexPath: NSIndexPath) {
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // create new listedItem
        
        let listedItem = ListedItem.MR_createEntity()
        listedItem.item = self.items[indexPath.row]
        listedItem.count = 12
        listedItem.unit = Unit.Kilogramm.numberValue
        
        self.listViewController.listOfLists[self.listIndex].addListedItemsObject(listedItem)
        self.listViewController.collectionView?.reloadData()
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension ItemsListViewController: RACollectionViewReorderableTripletLayoutDataSource {
    
    func collectionView(collectionView: UICollectionView, itemAtIndexPath fromIndexPath: NSIndexPath, didMoveToIndexPath toIndexPath: NSIndexPath) {
        
        let item = self.items[fromIndexPath.item]
        self.items.removeAtIndex(fromIndexPath.item)
        self.items.insert(item, atIndex: toIndexPath.item)
        for i in 0...self.items.count-1 {
            self.items[i].order = i
        }
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion(nil)
    }

    func collectionView(collectionView: UICollectionView!, itemAtIndexPath fromIndexPath: NSIndexPath!, canMoveToIndexPath toIndexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
