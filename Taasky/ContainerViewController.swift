//
//  ContainerViewController.swift
//  Taasky
//
//  Created by piglikeyoung on 15/9/15.
//  Copyright (c) 2015年 Ray Wenderlich. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var menuContainerView: UIView!
    
    private var detailViewController: DetailViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideOrShowMenu(false, animated: false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailViewSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    
    var menuItem: NSDictionary? {
        didSet {
            hideOrShowMenu(false, animated: true)
            if let detailViewController = detailViewController {
                detailViewController.menuItem = menuItem
            }
        }
    }
    
    func hideOrShowMenu(show: Bool, animated: Bool) {
        // menuOffset就是menuContainView的宽度80，如果是true，偏移量就是0，菜单栏不显示
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointZero : CGPoint(x: menuOffset, y: 0), animated: animated)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        /*
        Fix for the UIScrollView paging-related issue mentioned here:
        http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
        */
        // ScrollView的偏移量和菜单栏宽度相等的时候，禁用pagingEnabled
        scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame))
    }

}
