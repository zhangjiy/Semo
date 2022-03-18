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

#define SMHomeLeft 15

// PluginControl
#define SMPluginControlInset 6
#define SMPluginControlBorderWidth 4
#define SMPluginControlWidth 33
#define SMPluginControlHeight 33

// FeelingListView
#define SMFeelingListCellHeight 180

#define SMViewInset 20

// Color
#define SMHomeBackgroudColor [UIColor wbt_ColorWithHexString:@"#F5F5F5"]
#define SMPureBackgroudColor [UIColor wbt_ColorWithHexString:@"#FFFFFF"]
#define SMReddishBlueColor [UIColor wbt_ColorWithHexString:@"#4169E1"]

#define SMSealRedColor [UIColor wbt_ColorWithHexString:@"#B42828"]


#define StatusBarHeight  [UIDeviceHelper statusBarHeight]
#define SafeAreaHeight [UIDeviceHelper safeAreaHeight]
#define NavigationBarHeight (StatusBarHeight + 44)

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define Feelings @[@"喜", @"怒", @"忧", @"思", @"悲", @"恐", @"惊"]

#endif /* JYPrefixHeader_h */
