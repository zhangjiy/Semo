//
//  UIImageView+CornerRadius.m
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import "UIImageView+CornerRadius.h"
#import "UIImage+CornerRadius.h"

@implementation UIImageView (CornerRadius)

- (void)quickSetCornerRadius:(CGFloat)cornerRadius {
    if (!self.image) {
        self.image = [self.image imageAddCornerWithRadius:cornerRadius andSize:self.bounds.size];
    }
}

@end
