//
//  JYMainRootViewController.h
//  Semo
//
//  Created by jiyang on 2022/4/26.
//

#import <UIKit/UIKit.h>
#import "JYTabbarPlusButton.h"
#import "JYTabbarViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMainRootViewController : UINavigationController

@property (nonatomic, strong) JYTabbarViewController *tabBarController;

@end

NS_ASSUME_NONNULL_END
