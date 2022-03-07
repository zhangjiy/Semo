//
//  UIDeviceHelper.h
//  Comhe
//
//  Created by jiyang on 2022/3/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define WBDeviceIsFullScreenIphone ([UIDeviceHelper screenType] == WBT_ScreenTypeIphoneX || [UIDeviceHelper screenType] == WBT_ScreenTypeIphoneXSM)

typedef NS_ENUM(NSUInteger, WBT_ScreenType)
{
    WBT_ScreenTypeUndefined = 0,
    WBT_ScreenTypeClassic = 1,//3gs及以下
    WBT_ScreenTypeRetina = 2,//4&4s
    WBT_ScreenType4InchRetina = 3,//5&5s&5c&SE
    WBT_ScreenType6 = 4,//6或者6+放大模式，7&8&SE2
    WBT_ScreenType6Plus = 5,//6+&7+&8+
    WBT_ScreenTypeIpadClassic = 6,//iPad 1,2,mini
    WBT_ScreenTypeIpadRetina = 7,//iPad 3以上,mini2以上
    WBT_ScreenTypeIphoneX = 8,//x xs 11Pro
    WBT_ScreenTypeIphoneXSM  = 9,//xsm xr 11 11ProMax
};

@interface UIDeviceHelper : NSObject
+ (CGFloat)statusBarHeight;
+ (CGFloat)safeAreaHeight;
@end

NS_ASSUME_NONNULL_END
