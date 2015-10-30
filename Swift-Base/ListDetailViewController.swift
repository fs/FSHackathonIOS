//
//  ListDetailViewController.swift
//  Swift-Base
//
//  Created by Nikita Fomin on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    var list: List?
    
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

//MARK: - UITableView -

//MARK: - UITableViewDelegate
extension ListDetailViewController: UITableViewDelegate
{
    //MARK: Cells
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
}

//MARK: - UITableViewDataSource
extension ListDetailViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailItemViewCell") as! DetailItemViewCell
//        let item = self.list?.items[indexPath.row] as! Item
//        cell.prepareCell(item)
        return cell
    }
    
}
