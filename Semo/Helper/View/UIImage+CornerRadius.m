//
//  UIImage+CornerRadius.m
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import "UIImage+CornerRadius.h"

@implementation UIImage (CornerRadius)

- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(contextRef,path.CGPath);
    CGContextClip(contextRef);
    [self drawInRect:rect];
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
