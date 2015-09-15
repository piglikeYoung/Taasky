//
//  ContainerViewController.swift
//  Taasky
//
//  Created by piglikeyoung on 15/9/15.
//  Copyright (c) 2015年 Ray Wenderlich. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    private var detailViewController: DetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailViewSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    
    var menuItem: NSDictionary? {
        didSet {
            if let detailViewController = detailViewController {
                detailViewController.menuItem = menuItem
            }
        }
    }

}
