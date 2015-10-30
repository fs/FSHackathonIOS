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
        cell.layer.cornerRadius = 5
        cell.prepareCell(list)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ListViewController {
    
}
