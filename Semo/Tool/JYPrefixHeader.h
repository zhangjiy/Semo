//
//  JYPrefixHeader.h
//  Semo
//
//  Created by jiyang on 2022/2/28.
//

#ifndef JYPrefixHeader_h
#define JYPrefixHeader_h

#import "UIDeviceHelper.h"
#import "UIView+JYFrame.h"
#import "UIColor+Extensions.h"

#define SMHomeBottomLineMagin 5
#define SMHomeBottomViewHeight 66

#define SMHomeHeaderViewHeight 66

#define SMHomeLeft 10

#define SMHomeItemInset 10
#define SMHomeItemImageSize CGSizeMake(44, 44)

#define SMHomeBackgroudColor [UIColor wbt_ColorWithHexString:@"#F5F5F5"]

#define SMItemBackgroudColor [UIColor wbt_ColorWithHexString:@"#FFFFFF"]

#define SMNavigationBarBackgroudColor [UIColor wbt_ColorWithHexString:@"#FFFFFF"]

#define SMThemeBlueColor [UIColor wbt_ColorWithHexString:@"#4682B4"]

#define SMItemCornerRadius 8

#define StatusBarHeight  [UIDeviceHelper statusBarHeight]

#define NavigationBarHeight (JYStatusBarHeight + 44)

#define SafeAreaHeight [UIDeviceHelper safeAreaHeight]

#define Feelings @[@"喜", @"怒", @"忧", @"思", @"悲", @"恐", @"惊"]

#endif /* JYPrefixHeader_h */
