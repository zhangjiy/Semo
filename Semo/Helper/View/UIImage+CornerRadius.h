//
//  UIImage+CornerRadius.h
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CornerRadius)
- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
