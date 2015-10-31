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
    
    private var searchItems: [Item] = []
    private var enableDrag: Bool = true
    
    override func loadView() {
        super.loadView()
        self.searchBar.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = RGBA(53, 178, 226, 1.0)
        
        if let lTitle = self.navigationItem.title {
            let titleView = TitleView.createView()
            titleView.title.text = lTitle
            self.navigationItem.titleView = titleView
        }
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Noteworthy-Light", size: 15.0)!,
                                                  NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Noteworthy-Light", size: 15.0)!,
                                                  NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: UIControlState.Highlighted)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchItems = self.items
        self.searchBar.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier, let destinationViewController = segue.destinationViewController as? ItemListAddingViewController else { return }
        
        switch identifier {
            case "itemListAdding":
            destinationViewController.itemsListViewController = self
            destinationViewController.list = self.listViewController.listOfLists[self.listIndex]
            destinationViewController.item = self.items[self.collectionView.indexPathsForSelectedItems()!.first!.row]
            
            destinationViewController.transitioningDelegate = destinationViewController.popoverDelegate
            destinationViewController.modalPresentationStyle = .Custom
            
        default:
            super.prepareForSegue(segue, sender: sender)
        }
    }

}

extension ItemsListViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            self.enableDrag = true
            self.searchItems = self.items
            self.collectionView.reloadData()
            return
        }
        
        self.enableDrag = false
        self.searchItems = self.items.filter({ (item: Item) -> Bool in
            
            if let lTitle = item.title {
                if let _ = lTitle.rangeOfString(searchText) {
                    return true
                } else {
                    return false
                }
            }
            return false
        })
        self.collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension ItemsListViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemListCollectionViewCell", forIndexPath: indexPath) as! ItemListCollectionViewCell
        cell.prepareCell(self.searchItems[indexPath.row])
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
        self.performSegueWithIdentifier("itemListAdding", sender: nil)
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
        self.searchItems = self.items
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion(nil)
    }

    func collectionView(collectionView: UICollectionView!, itemAtIndexPath fromIndexPath: NSIndexPath!, canMoveToIndexPath toIndexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.enableDrag
    }
}
