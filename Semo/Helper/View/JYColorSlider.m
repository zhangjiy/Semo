//
//  JYColorSlider.m
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import "JYColorSlider.h"
#import "UIControl+Block.h"
#import "UIColor+Extensions.h"

@implementation JYColorSlider {
    CGSize _viewSize;
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[self sliderBackgroundWithSize:frame.size]];
        [self setMaximumTrackImage:[UIImage new] forState:UIControlStateNormal];
        
        [self setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
        
        __weak typeof(self) weakSelf = self;
        
        [self addBlock:^(UISlider * sender) {
            __strong typeof(self) strongSelf = weakSelf;
            if (sender.value >= 1.0) return ;
            strongSelf.currentColor = [weakSelf colorForValue:sender.value];
            
        } event:UIControlEventValueChanged];
        self.thumbTintColor = [self colorForValue:self.value];
        self.currentColor = color;
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

- (UIColor*)colorForValue:(CGFloat)value {
    if(value <= 1.0 / 3.f){
        return [UIColor colorWithWhite:value*3.0 alpha:1];;
    }
    
    return [UIColor colorWithHue:(value-1/3.0)*3.0/2.0 saturation:1 brightness:1 alpha:1];
}

- (void)setValue:(float)value {
    [super setValue:value];
}

- (void)setCurrentColor:(UIColor *)currentColor {
    
    if (!currentColor) {
        self.value = 0;
    } else {
        CGFloat white = currentColor.whiteValue;
        if (white == -1) {
            NSArray * hsbArray = currentColor.HSBArray;
            CGFloat h = [hsbArray.firstObject floatValue];
            CGFloat value = h*2.0/3.0 + 1/3.0;
            self.value = value;
        } else{
            self.value = white/3.0;
        }
    }
    
    self.thumbTintColor = _currentColor = [self colorForValue:self.value];
}

- (UIImage *)sliderBackgroundWithSize:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect frame = CGRectMake(5, (size.height-10)/2, size.width-10, 5);
    
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5].CGPath;
    
    CGContextAddPath(context, path);
    
    CGContextClip(context);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {
        0.0f, 0.0f, 0.0f, 1.0f,
        1.0f, 1.0f, 1.0f, 1.0f,
        1.0f, 1.0f, 1.0f, 1.0f,
        1.0f, 0.0f, 0.0f, 1.0f,
        1.0f, 1.0f, 0.0f, 1.0f,
        0.0f, 1.0f, 0.0f, 1.0f,
        0.0f, 1.0f, 1.0f, 1.0f,
        0.0f, 0.0f, 1.0f, 1.0f,
        1.0f, 0.0f, 1.0f, 1.0f,
        11.0f, 0.0f, 0.0f, 1.0f
    };
    
    size_t count = sizeof(components)/ (sizeof(CGFloat)* 4);
    
    CGFloat locations[] = {0.0f, 0.3, 1/3.0, 1/3.0, 1.33/3.0, 1.67/3.0, 2.0/3.0, 2.33/3.0, 2.67/3.0, 1.0};
    
    CGPoint startPoint = CGPointMake(5, 0);
    
    CGPoint endPoint = CGPointMake(size.width-5, 0);
    
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, count);
    
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end

