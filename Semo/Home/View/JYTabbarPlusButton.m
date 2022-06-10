//
//  JYTabbarPlusButton.m
//  Semo
//
//  Created by jiyang on 2022/4/26.
//

#import "JYTabbarPlusButton.h"
#import "JYHomeViewControllerProtocol.h"

@implementation JYTabbarPlusButton

+ (id)plusButton {
    JYTabbarPlusButton *button = [[JYTabbarPlusButton alloc] init];
    UIImage *normalButtonImage = [UIImage imageNamed:@"tabbar_addMood_normal"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"tabbar_addMood_normal"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:hlightButtonImage forState:UIControlStateHighlighted];
    [button setImage:hlightButtonImage forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    button.frame = CGRectMake(0.0, 0.0, 74, 70);
    
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish:) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish:(UIButton *)sender {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController <JYHomeViewControllerProtocol> *viewController = tabBarController.selectedViewController;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        viewController = navigationController.viewControllers.firstObject;
    }
    if ([viewController respondsToSelector:@selector(plusButtonAction:)]) {
        [viewController plusButtonAction:sender];
    }
}

#pragma mark - CYLPlusButtonSubclassing

//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 1;
//}

//+ (BOOL)shouldSelectPlusChildViewController {
//    BOOL isSelected = CYLExternPlusButton.selected;
//    if (isSelected) {
//        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
//    } else {
//        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
//    }
//    return YES;
//}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 2 : 4);
}

//+ (NSString *)tabBarContext {
//    return NSStringFromClass([self class]);
//}

@end
