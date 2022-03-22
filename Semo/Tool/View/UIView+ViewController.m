//
//  UIView+ViewController.m
//  Weibo
//
//  Created by 吴 天 on 12-10-26.
//  Copyright (c) 2012年 Sina. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)firstAvailableWBViewController
{
    id nextResponder = [self nextResponder];
    
    while (nextResponder)
    {
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
//            UIViewController *vc = nextResponder;
//            if (!vc.ignoreResponse)
//            {
                return nextResponder;
//            }
        }
        else if (![nextResponder isKindOfClass:[UIViewController class]] &&
                 ![nextResponder isKindOfClass:[UIView class]])
        {
            /*  根据文档：
                UIView          的nextResponder是它的controller或superview；
                UIViewController的nextResponder是它view的superview；
                UIWindow        的nextResponder是UIApplication对象；
                UIApplication   的nextResponder是nil。
    
                因此当responder不是UIView或UIViewController之一时，无需再进行剩下的操作
             */
            break;
        }
        
        nextResponder = [nextResponder nextResponder];
    }
    
    return nil;
}

@end
