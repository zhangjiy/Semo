//
//  JYSizeSlider.m
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import "JYSizeSlider.h"
#import "UIColor+Extensions.h"

@implementation JYSizeSlider {
    CGSize _viewSize;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithPatternImage:[self sliderBackgroundWithSize:frame.size]];
        
        [self setMaximumTrackImage:[UIImage new] forState:UIControlStateNormal];
        
        [self setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
        
        self.value = 0.1;
        self.thumbTintColor = [UIColor wbt_ColorWithHexString:@"#ffffff"];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateViewSize:self.frame.size];
}

- (void)updateViewSize:(CGSize)size {
    if (!CGSizeEqualToSize(size, _viewSize)) {
        _viewSize = size;
        self.backgroundColor = [UIColor colorWithPatternImage:[self sliderBackgroundWithSize:size]];
    }
}

- (UIImage *)sliderBackgroundWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *color = [UIColor wbt_colorWithHexString:@"#000000" alpha:0.5];
    
    CGFloat strRadius = 1;
    
    CGFloat endRadius = size.height/2 * 0.6;
    
    CGPoint strPoint = CGPointMake(strRadius + 5, size.height/2 - 2);
    
    CGPoint endPoint = CGPointMake(size.width-endRadius - 1, strPoint.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, strPoint.x, strPoint.y, strRadius, -M_PI/2, M_PI-M_PI/2, YES);
    
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y + endRadius);
    
    CGPathAddArc(path, NULL, endPoint.x, endPoint.y, endRadius, M_PI/2, M_PI+M_PI/2, YES);
    
    CGPathAddLineToPoint(path, NULL, strPoint.x, strPoint.y - strRadius);
    
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillPath(context);
    
    UIImage *tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    CGPathRelease(path);
    
    UIGraphicsEndImageContext();
    
    return tmp;
}

@end
