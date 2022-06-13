//
//  NSString+WBTSize.h
//  Pods
//
//  Created by LiuYuxi on 15/11/17.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (WBTSize)

- (CGSize)wbt_sizeWithFont:(UIFont *)font;
- (CGSize)wbt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)wbt_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)wbt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;
- (CGSize)wbt_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
