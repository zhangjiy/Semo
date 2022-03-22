//
//  UIView+ViewController.h
//  Weibo
//
//  Created by 吴 天 on 12-10-26.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 source:http://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview-on-iphone
 "IMHO, this is a design flaw. The view should not need to be aware of the controller."
 But "one reason you need to allow the UIView to be aware of its UIViewController is when you have custom UIView subclasses that need to push a modal view/dialog."
 */

/**
 此类别和UIView+WBTViewController的区别是该类别里面
 主要是处理对微博自定义ViewController的处理逻辑
 */
@interface UIView (ViewController)
- (UIViewController *)firstAvailableWBViewController;

@end
