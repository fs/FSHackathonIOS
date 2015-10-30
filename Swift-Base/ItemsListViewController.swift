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
        return Item.MR_findAll() as! [Item]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UICollectionView -

//MARK: - UICollectionViewDelegate
extension ItemsListViewController: UICollectionViewDelegate
{
    //MARK: Cells
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // create new listedItem
        
        let listedItem = ListedItem.MR_createEntity()
        listedItem.item = self.items[indexPath.row]
        listedItem.count = 12
        listedItem.unit = Unit.Kilogramm.numberValue
        
        self.listViewController.listOfLists[self.listIndex].addListedItemObject(listedItem)
        self.listViewController.collectionView?.reloadData()
        self.navigationController?.popViewControllerAnimated(true)
    }
}

//MARK: - UICollectionViewDataSource
extension ItemsListViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemListCollectionViewCell", forIndexPath: indexPath) as! ItemListCollectionViewCell
        cell.prepareCell(self.items[indexPath.row])
        return cell
    }
}
