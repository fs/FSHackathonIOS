//
//  ListViewController.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ListViewController: TGLStackedViewController {
    private enum SectionIndex : Int {
        case List
        
        static var count : UInt {
            return UInt(1)
        }
    }
    
    enum CellIdentifier: String {
        case List = "List"
    }
    
    //MARK: - params
    var listOfLists: [List] = []
    
    //MARK: - life cycle
    override func loadView() {
        super.loadView()
        
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.exposedTopOverlap = 30.0
        self.exposedBottomOverlap = 50.0
        self.exposedLayoutMargin = UIEdgeInsetsMake(50.0, 0.0, 0.0, 0.0)
        self.stackedLayout.topReveal = 60
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.listOfLists = List.MR_findAllSortedBy(ListAttributes.date.rawValue, ascending: false, inContext: NSManagedObjectContext.MR_defaultContext()) as! [List]
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if let lSender = sender as? UIButton {
            let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier(CellIdentifier.List.rawValue, forIndexPath: NSIndexPath(forRow: lSender.tag, inSection: 0)) as! ListCollectionViewCell
            let itemsList = segue.destinationViewController as! ItemsListViewController
            itemsList.listCollectionViewCell = cell
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ListViewController {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfLists.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let list = self.listOfLists[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier.List.rawValue, forIndexPath: indexPath) as! ListCollectionViewCell
        cell.prepareCell(list)
        cell.addItemButton.tag = indexPath.row
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ListViewController {
    
}
