//
//  HamburgerView.swift
//  Taasky
//
//  Created by piglikeyoung on 15/9/15.
//  Copyright (c) 2015年 Ray Wenderlich. All rights reserved.
//

import UIKit

class HamburgerView: UIView {

    let imageView:UIImageView! = UIImageView(image: UIImage(named: "Hamburger"))
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: Private
    
    private func configure() {
        imageView.contentMode = UIViewContentMode.Center
        addSubview(imageView)
    }

}
