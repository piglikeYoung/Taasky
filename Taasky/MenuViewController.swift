//
//  MenuViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
  
  lazy var menuItems: NSArray = {
    let path = NSBundle.mainBundle().pathForResource("MenuItems", ofType: "plist")
    return NSArray(contentsOfFile: path!)!
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Remove the drop shadow from the navigation bar
    navigationController!.navigationBar.clipsToBounds = true
  }
  
  // MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow() {
        let object = menuItems[indexPath.row] as! NSDictionary
        (segue.destinationViewController as! DetailViewController).menuItem = object
      }
    }
  }
  
  // MARK: - Table View
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    // adjust row height so items all fit into view
    return max(80, CGRectGetHeight(view.bounds) / CGFloat(menuItems.count))
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell") as! MenuItemCell
    let menuItem = menuItems[indexPath.row] as! NSDictionary
    cell.configureForMenuItem(menuItem)
    return cell
  }
  
}
