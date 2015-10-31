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
    
    enum SegueIdentifier: String {
        case NewList = "NewList"
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - params
    var listOfLists: [List] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: - life cycle
    override func loadView() {
        super.loadView()
        
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        
        self.navigationController?.navigationBar.barTintColor = RGBA(53, 178, 226, 1.0)
        
        if let lTitle = self.navigationItem.title {
            let titleView = TitleView.createView()
            titleView.title.text = lTitle
            self.navigationItem.titleView = titleView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.exposedTopOverlap = 30.0
        self.exposedBottomOverlap = 50.0
        self.exposedLayoutMargin = UIEdgeInsetsMake(50.0, 0.0, 0.0, 0.0)
        self.stackedLayout.topReveal = 50
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadData:", name: "ReactivateApp", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
    }
    
    func reloadData (sender: AnyObject? = nil) {
        self.listOfLists = List.MR_findAllSortedBy(ListAttributes.date.rawValue, ascending: false, inContext: NSManagedObjectContext.MR_defaultContext()) as! [List]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }
        
        if let lSender = sender as? UIButton {
            //need change to identifier
            let itemsList = segue.destinationViewController as! ItemsListViewController
            itemsList.listIndex = lSender.tag
            itemsList.listViewController = self
            
            return
        }
        
        switch identifier {
        case SegueIdentifier.NewList.rawValue:
            let destinationViewController = segue.destinationViewController as! NewListViewController
            destinationViewController.transitioningDelegate = destinationViewController.popoverDelegate
            destinationViewController.modalPresentationStyle = .Custom
            
        default:
            super.prepareForSegue(segue, sender: sender)
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
