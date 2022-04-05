//
//  JYStyleImageFactory.m
//  Semo
//
//  Created by jiyang on 2022/3/29.
//

#import "JYStyleImageFactory.h"
#import "JYSealFeelingPassView.h"
#import "JYSealFeelingADRView.h"
#import "JYSealFeelingSellView.h"
#import "JYSealFeelingLoveView.h"
#import "JYSealFeelingSimpleView.h"
#import "JYPrefixHeader.h"

@implementation JYStyleImageFactory

+ (UIImage *)styleImageFactoryFromStyleType:(JYFeelingStyleType)styleType size:(CGSize)size borderWidth:(CGFloat)borderWidth {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    CGSize viewSize = CGSizeMake(size.width - borderWidth * 2, size.height - borderWidth * 2);
    if (styleType == JYFeelingStyleTypePass) {
        JYSealFeelingPassView *view = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeADR) {
        JYSealFeelingADRView *view = [[JYSealFeelingADRView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeSell) {
        JYSealFeelingSellView *view = [[JYSealFeelingSellView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeLove) {
        JYSealFeelingLoveView *view = [[JYSealFeelingLoveView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeEllipse) {
        JYSealFeelingSimpleView *view = [[JYSealFeelingSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeOval];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeRectangle) {
        JYSealFeelingSimpleView *view = [[JYSealFeelingSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeRect];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeRhombus) {
        JYSealFeelingSimpleView *view = [[JYSealFeelingSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeRhombus];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeHexagon) {
        JYSealFeelingSimpleView *view = [[JYSealFeelingSimpleView alloc] initWithFrame:CGRectMake(borderWidth, borderWidth, viewSize.width, viewSize.height) type:ZHFigureDrawingTypeHexagon];
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

+ (UIColor *)textColorFactoryFromStyleType:(JYFeelingStyleType)styleType {
    if (styleType == JYFeelingStyleTypePass) {
        return SMSealRedColor;
    } else if (styleType == JYFeelingStyleTypeADR) {
        return SMSealGreenColor;
    } else if (styleType == JYFeelingStyleTypeSell) {
        return SMSealRedColor;
    } else if (styleType == JYFeelingStyleTypeLove) {
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
