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

@implementation JYStyleImageFactory

+ (UIImage *)styleImageFactoryFromStyleType:(JYFeelingStyleType)styleType size:(CGSize)size {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    CGFloat viewInsert = 2;
    CGSize viewSize = CGSizeMake(size.width - viewInsert * 2, size.height - viewInsert * 2);
    if (styleType == JYFeelingStyleTypePass) {
        JYSealFeelingPassView *view = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(viewInsert, viewInsert, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeADR) {
        JYSealFeelingADRView *view = [[JYSealFeelingADRView alloc] initWithFrame:CGRectMake(viewInsert, viewInsert, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeSell) {
        JYSealFeelingSellView *view = [[JYSealFeelingSellView alloc] initWithFrame:CGRectMake(viewInsert, viewInsert, viewSize.width, viewSize.height)];
        [containerView addSubview:view];
        return [[self class] makeImageWithView:containerView withSize:size];
    } else if (styleType == JYFeelingStyleTypeLove) {
        JYSealFeelingLoveView *view = [[JYSealFeelingLoveView alloc] initWithFrame:CGRectMake(viewInsert, viewInsert, viewSize.width, viewSize.height)];
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

@end
