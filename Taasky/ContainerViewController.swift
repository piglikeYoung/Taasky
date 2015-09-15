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
    
    // 默认不显示菜单栏
    var showingMenu = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideOrShowMenu(showingMenu, animated: false)
        
        // 将锚点的x设为1，y设为0.5，这样就可以沿右边距旋转了。
        menuContainerView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
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
    
    // MARK: - Private Method
    func hideOrShowMenu(show: Bool, animated: Bool) {
        
        showingMenu = show
        
        // menuOffset就是menuContainView的宽度80，如果是true，偏移量就是0，菜单栏不显示
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointZero : CGPoint(x: menuOffset, y: 0), animated: animated)
    }
    
    /**
    在菜单完全隐藏时，fraction = 0，完全显示时，fraction = 1；
    
    CATransform3DIdentity是一个4*4的矩阵，对角线是1，其他是0；
    CATransform3DIdentity的m34属性是这个矩阵中的第三列第四行，它控制着变换中的立体程度；
    CATransform3DRotate通过angle这个变量来控制y轴的旋转量：-90度呈现的是菜单栏垂直于屏幕的状态，0度呈现的是与xy轴平行的状态；
    rotateTransform的旋转变换，是根据m34矩阵与y轴旋转量来的；
    translateTransform设置了x轴的偏移量为菜单栏的一般；
    CATransform3DConcat将rotateTransform与translateTransform联系起来，使得在做翻转动画时，也有偏移动画。
    */
    func transformForFraction(fraction:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -M_PI_2
        let xOffset = CGRectGetWidth(menuContainerView.bounds) * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        /*
        Fix for the UIScrollView paging-related issue mentioned here:
        http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
        */
        // ScrollView的偏移量和菜单栏宽度相等的时候，禁用pagingEnabled
        scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame))
        
        
        
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        // 如果ScrollView的偏移量和menuContainerView的宽度相同(即菜单栏隐藏)， showingMenu设置为false，相反为true
        showingMenu = !CGPointEqualToPoint(CGPoint(x: menuOffset, y: 0), scrollView.contentOffset)
        println("didEndDecelerating showingMenu \(showingMenu)")
        
        
        /**
        offset的值在0到1之间。当offset的值为0的时候，菜单栏处于显示状态；当offset为1的时候，菜单栏处于隐藏状态。
        
        fraction是菜单显示部分所占的比例，范围在0到1之间，0是菜单栏完全隐藏，1是显示状态。
        
        同时，fraction也用来调整菜单栏的alpha值，从暗到明，从隐藏到显示。
        */
        let multiplier = 1.0 / CGRectGetWidth(menuContainerView.bounds)
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fraction)
        menuContainerView.alpha = fraction
    }


}
