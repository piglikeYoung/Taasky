//
//  DetailViewController.swift
//  Taasky
//
//  Created by Audrey M Tam on 18/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
    @IBOutlet weak var backgroundImageView: UIImageView!

    var hamburgerView: HamburgerView?
  
    var menuItem: NSDictionary? {
        didSet {
                if let newMenuItem = menuItem {
                view.backgroundColor = UIColor(colorArray: newMenuItem["colors"] as! NSArray)
                backgroundImageView?.image = UIImage(named: newMenuItem["bigImage"] as! String)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 不显示navigation bar底部阴影
        navigationController!.navigationBar.clipsToBounds = true
        
        // 创建轻触手势，添加到汉堡按钮上
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
        // 创建汉堡按钮
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
    }

    func hamburgerViewTapped() {
        // 点击汉堡按钮改变菜单栏隐藏或显示
        let navigationController = parentViewController as! UINavigationController
        let containerViewController = navigationController.parentViewController as! ContainerViewController
        containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
    }
}
