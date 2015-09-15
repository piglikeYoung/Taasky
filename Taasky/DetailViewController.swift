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
  
  var menuItem: NSDictionary? {
    didSet {
      if let newMenuItem = menuItem {
        view.backgroundColor = UIColor(colorArray: newMenuItem["colors"] as! NSArray)
        backgroundImageView?.image = UIImage(named: newMenuItem["bigImage"] as! String)
      }
    }
  }
  
}
