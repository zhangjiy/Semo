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
#import "UIView+ViewController.h"
#import "UIColor+Extensions.h"

#define SMHomeLeft 15

// PluginControl
#define SMPluginControlInset 6
#define SMPluginControlBorderWidth 4
#define SMPluginControlWidth 33
#define SMPluginControlHeight 33

// MoodsListView
#define SMMoodListCellHeight 180

#define SMPaintingMenuWidth (ScreenWidth - JYViewInset * 2)
#define SMPaintingMenuHeight 120
#define SMPaintingMenuItemHeight 40
#define SMPaintingStyleMenuItemInset 20

#define SMPaintingStyleMenuHeight 100
#define SMPaintingStyleMenuItemWidth 70

#define SMPaintingMenuSliderWidth (SMPaintingMenuWidth - JYViewInset * 2)
#define SMPaintingMenuSliderHeight 40

#define SMPaintingMenuSizeSlideTop 28
#define SMPaintingMenuColorSlideTop 33

// Color
//[UIColor wbt_ColorWithHexString:@"#F5F5F5"]
#define SMHomeBackgroudColor [UIColor colorWithRed:236/255.f green:237/255.f blue:232/255.f alpha:1.f]
#define SMPureBackgroudColor [UIColor wbt_ColorWithHexString:@"#FFFFFF"]
#define SMGhostWhiteColor [UIColor wbt_ColorWithHexString:@"#f5f5f5"]

#define SMReddishBlueColor [UIColor wbt_ColorWithHexString:@"#4169E1"]

#define SMSealRedColor [UIColor wbt_ColorWithHexString:@"#B42828"]
#define SMSealGreenColor [UIColor wbt_ColorWithHexString:@"#3cb371"]
#define SMSealBlueColor [UIColor wbt_ColorWithHexString:@"#1e90ff"]

#define SMGridLineColor [UIColor wbt_ColorWithHexString:@"#d3d3d3"]

#define StatusBarHeight  [UIDeviceHelper statusBarHeight]
#define SafeAreaHeight [UIDeviceHelper safeAreaHeight]
#define NavigationBarHeight (StatusBarHeight + 25)

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define JYViewInset 20
#define JYViewItemInset 10

#define JYHomeGridWidth (ScreenWidth - SMHomeLeft * 2)
#define JYHomeGridHeight (JYHomeGridWidth * 2.f)

#define JYWriteTop 50
#define JYWriteBottomHeight 155

#define JYWriteGridWidth (ScreenWidth + [UIScreen mainScreen].scale * 2)
#define JYWriteGridHeight (JYWriteGridWidth * 2.f)

#define JYWriteDisplayViewSize CGSizeMake((ScreenWidth - JYViewInset * 2), (ScreenWidth - JYViewInset * 2))

// image
#define JYOffset CGPointMake(0.f, 0.f)

#define JYRotate 0.f
#define JYCornerRadius 12.f

#define JYStrokeThickness    2.f
#define JYStrokeDash         @[@4.f, @2.f]
#define JYStrokeType         LGDrawerStrokeTypeCenter

#define JYShadowColor    [UIColor colorWithWhite:0.f alpha:0.6]
#define JYShadowOffset   CGPointMake(2.f, 2.f)
#define JYShadowBlur     6.f
#define JYShadowType     LGDrawerShadowTypeFill

#define JYCanvasWidth   (ScreenWidth - SMHomeLeft * 2.f)
#define JYCanvasHeight  ((ScreenWidth - SMHomeLeft * 2.f) * 0.65)
#define JYCanvasTop     130

#define Moods @[@"", @"喜", @"怒", @"忧", @"思", @"悲", @"恐", @"惊"]

#define MoodColors @[[UIColor whiteColor], [UIColor colorWithRed:218/255.f green:88/255.f blue:78/255.f alpha:1.f], [UIColor colorWithRed:230/255.f green:157/255.f blue:78/255.f alpha:1.f], [UIColor colorWithRed:241/255.f green:206/255.f blue:97/255.f alpha:1.f], [UIColor colorWithRed:121/255.f green:193/255.f blue:114/255.f alpha:1.f], [UIColor colorWithRed:64/255.f green:122/255.f blue:235/255.f alpha:1.f], [UIColor colorWithRed:173/255.f green:127/255.f blue:207/255.f alpha:1.f], [UIColor colorWithRed:149/255.f green:134/255.f blue:108/255.f alpha:1.f]]

#define Plantings @[@"1", @"2", @"3", @"4", @"5"]

#endif /* JYPrefixHeader_h */
