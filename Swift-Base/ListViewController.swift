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
        
        self.exposedTopOverlap = 20.0
        self.exposedBottomOverlap = 20.0
        self.stackedLayout.layoutMargin = UIEdgeInsetsZero
        self.exposedLayoutMargin = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.listOfLists = List.MR_findAllSortedBy(ListAttributes.date.rawValue, ascending: false, inContext: NSManagedObjectContext.MR_defaultContext()) as! [List]
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
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ListViewController {
    
}
