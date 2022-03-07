//
//  UIDeviceHelper.m
//  Comhe
//
//  Created by jiyang on 2022/3/2.
//

#import "UIDeviceHelper.h"

@implementation UIDeviceHelper

static WBT_ScreenType screenType = WBT_ScreenTypeUndefined;

+ (CGFloat)statusBarHeight {
    if (WBDeviceIsFullScreenIphone) {
        return 44.f;
    }
    return 24.f;
}

+ (CGFloat)safeAreaHeight {
    return ((WBT_ScreenTypeIphoneX == [UIDeviceHelper screenType] || WBT_ScreenTypeIphoneXSM == [UIDeviceHelper screenType])? 44.f : 0.f);
}

+ (WBT_ScreenType)screenType
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int height = MAX(screenBounds.size.width, screenBounds.size.height);
    int width = MIN(screenBounds.size.width, screenBounds.size.height);
    screenType = [[self class] screenTypeForNormalWithWidth:width andWithHeight:height];
    return screenType;
}

+ (WBT_ScreenType)screenTypeForNormalWithWidth:(int)width andWithHeight:(int)height {
    int scale = [[UIScreen mainScreen] scale];
    if (height == 480 && width == 320) {
        if (scale == 1) {
            screenType = WBT_ScreenTypeClassic;
        } else if (scale == 2){
            screenType = WBT_ScreenTypeRetina;
        }
    } else if (height == 568 && width == 320){
        screenType = WBT_ScreenType4InchRetina;
    } else if (height == 667 && width == 375){
        screenType = WBT_ScreenType6;
    } else if (height == 736 && width == 414){
        screenType = WBT_ScreenType6Plus;
    } else if (height == 1024 && width == 768) {
        if (scale == 1){
            screenType = WBT_ScreenTypeIpadClassic;
        } else if (scale == 2) {
            screenType = WBT_ScreenTypeIpadRetina;
        }
    } else if (height == 812 && width == 375) {
        screenType = WBT_ScreenTypeIphoneX; //x xs 11Pro 12mini
    } else if (height == 844 && width == 390) {
        screenType = WBT_ScreenTypeIphoneXSM; //12 12Pro 为了兼容9图的显示先这么处理
    } else if (height == 896 && width == 414) {
        screenType = WBT_ScreenTypeIphoneXSM;//xsm xr 11 11ProMax
    } else if (height == 926 && width == 428) {
        screenType = WBT_ScreenTypeIphoneXSM; //12ProMax
    } else {
        screenType = [[self class] _screenTypeOfUnknownDevice];
    }
    return screenType;
}

+ (WBT_ScreenType)_screenTypeOfUnknownDevice
{
    BOOL hasSafeArea = NO;
    if (@available(iOS 11.0, *)) {
        double bottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
        hasSafeArea = bottom > 0;
    }
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int height = MAX(screenBounds.size.width, screenBounds.size.height);
    int width = MIN(screenBounds.size.width, screenBounds.size.height);
    
    // iPhone & iPod Touch
    
    if (hasSafeArea) {
        if (height > 812 && width > 375) return WBT_ScreenTypeIphoneXSM;
        return WBT_ScreenTypeIphoneX;
    }
    
    // 比 iPhone6 大
    if (height > 667 && width > 375) return WBT_ScreenType6Plus;
    
    return WBT_ScreenType6;
}

@end
