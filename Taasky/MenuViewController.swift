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
    // 不显示navigation bar底部阴影
    navigationController!.navigationBar.clipsToBounds = true
    
    // 默认选中第一个
    (navigationController!.parentViewController as! ContainerViewController).menuItem =
        (menuItems[0] as! NSDictionary)
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 取消选中
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 从menuItems数组中取出menuItem字典
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        // 改变detailView的内容
        (navigationController!.parentViewController as! ContainerViewController).menuItem = menuItem
    }
  
}
