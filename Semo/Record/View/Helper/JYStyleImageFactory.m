//
//  JYStyleImageFactory.m
//  Semo
//
//  Created by jiyang on 2022/3/29.
//

#import "JYStyleImageFactory.h"
#import "JYSealMoodPassView.h"
#import "JYSealMoodADRView.h"
#import "JYSealMoodSellView.h"
#import "JYSealMoodLoveView.h"
#import "JYSealMoodSimpleView.h"
#import "JYPrefixHeader.h"

@implementation JYStyleImageFactory

+ (UIImage *)styleImageFactoryFromStyleType:(JYMoodStyleType)styleType size:(CGSize)size borderWidth:(CGFloat)borderWidth {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    CGSize viewSize = CGSizeMake(size.width - borderWidth * 2, size.height - borderWidth * 2);
    if (styleType == JYMoodStyleTypePass) {
        JYSealMoodPassView *view = [[JYSealMoodPassView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYMoodStyleTypeADR) {
        JYSealMoodADRView *view = [[JYSealMoodADRView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYMoodStyleTypeSell) {
        JYSealMoodSellView *view = [[JYSealMoodSellView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYMoodStyleTypeLove) {
        JYSealMoodLoveView *view = [[JYSealMoodLoveView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYMoodStyleTypeEllipse) {
        JYSealMoodSimpleView *view = [[JYSealMoodSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeOval];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYMoodStyleTypeRectangle) {
        JYSealMoodSimpleView *view = [[JYSealMoodSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeRect];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYMoodStyleTypeRhombus) {
        JYSealMoodSimpleView *view = [[JYSealMoodSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeRhombus];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYMoodStyleTypeHexagon) {
        JYSealMoodSimpleView *view = [[JYSealMoodSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeHexagon];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    }
    
    return nil;
}

+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)textColorFactoryFromStyleType:(JYMoodStyleType)styleType {
    if (styleType == JYMoodStyleTypePass) {
        return SMSealRedColor;
    } else if (styleType == JYMoodStyleTypeADR) {
        return SMSealGreenColor;
    } else if (styleType == JYMoodStyleTypeSell) {
        return SMSealRedColor;
    } else if (styleType == JYMoodStyleTypeLove) {
        return SMSealBlueColor;
    } else {
        return [UIColor blackColor];
    }
}

+ (NSInteger)indexFactoryFromPenName:(NSString *)name {
    if ([name isEqualToString:@"Pencil"]) {
        return 1;
    } else if ([name isEqualToString:@"Brush"]) {
        return 2;
    } else if ([name isEqualToString:@"Grow"]) {
        return 3;
    } else if ([name isEqualToString:@"Eraser"]) {
        return 6;
    } else {
        return 0;
    }
}

@end
