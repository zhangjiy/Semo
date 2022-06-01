//
//  JYMainRootViewController.m
//  Semo
//
//  Created by jiyang on 2022/4/26.
//

#import "JYMainRootViewController.h"

@interface JYMainRootViewController () <UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@end

@implementation JYMainRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    [JYTabbarPlusButton registerPlusButton];
    [self createNewTabBar];
}

- (CYLTabBarController *)createNewTabBar {
    JYTabbarViewController *tabBarController = [[JYTabbarViewController alloc] init];
    tabBarController.delegate = self;
    self.viewControllers = @[tabBarController];
    [tabBarController setViewDidLayoutSubViewsBlockInvokeOnce:YES block:^(CYLTabBarController *tabBarController) {
    }];
    self.tabBarController = tabBarController;
    return tabBarController;
}

#pragma mark - delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    BOOL should = YES;
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController shouldSelect:should];


    if (should && [self cyl_tabBarController].selectedIndex == viewController.cyl_tabIndex) {
    }
    return should;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    UIControl *control = [viewController cyl_tabButton];
    UIView *animationView;
    // 如果 PlusButton 也添加了点击事件，那么点击 PlusButton 后不会触发该代理方法。
    if ([control isKindOfClass:[CYLExternPlusButton class]]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    } else if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        for (UIView *subView in control.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                animationView = subView;
            }
        }
    }
    
    if ([self cyl_tabBarController].selectedIndex == 0) {
        [self addScaleAnimationOnView:animationView repeatCount:1];
    }
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

@end
