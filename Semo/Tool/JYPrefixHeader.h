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

// Color
//[UIColor wbt_ColorWithHexString:@"#F5F5F5"]
#define SMHomeBackgroudColor [UIColor colorWithRed:236/225.f green:237/225.f blue:232/225.f alpha:1.f]
#define SMPureBackgroudColor [UIColor wbt_ColorWithHexString:@"#FFFFFF"]
#define SMReddishBlueColor [UIColor wbt_ColorWithHexString:@"#4169E1"]

#define SMSealRedColor [UIColor wbt_ColorWithHexString:@"#B42828"]

#define SMGridLineColor [UIColor wbt_ColorWithHexString:@"#B42828"]

#define StatusBarHeight  [UIDeviceHelper statusBarHeight]
#define SafeAreaHeight [UIDeviceHelper safeAreaHeight]
#define NavigationBarHeight (StatusBarHeight + 25)

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define JYViewInset 20

#define JYHomeGridWidth (ceilf((ScreenWidth - JYViewInset * 2) / 8.f) * 8.f)
#define JYHomeGridHeight (JYHomeGridWidth * 2.f)

#define JYWriteTop 50
#define JYWriteBottomHeight 155

#define JYWriteGridWidth (ceilf((ScreenWidth) / 14.f) * 14.f)
#define JYWriteGridHeight (JYWriteGridWidth * 2.f)


#define Feelings @[@"喜", @"怒", @"忧", @"思", @"悲", @"恐", @"惊"]

#define FeelingColors @[[UIColor colorWithRed:218/225.f green:88/225.f blue:78/225.f alpha:1.f], [UIColor colorWithRed:230/225.f green:157/225.f blue:78/225.f alpha:1.f], [UIColor colorWithRed:241/225.f green:206/225.f blue:97/225.f alpha:1.f], [UIColor colorWithRed:121/225.f green:193/225.f blue:114/225.f alpha:1.f], [UIColor colorWithRed:64/225.f green:122/225.f blue:235/225.f alpha:1.f], [UIColor colorWithRed:173/225.f green:127/225.f blue:207/225.f alpha:1.f], [UIColor colorWithRed:149/225.f green:134/225.f blue:108/225.f alpha:1.f]]

#define Plantings @[@"1", @"2", @"3", @"4", @"5"]

#endif /* JYPrefixHeader_h */
