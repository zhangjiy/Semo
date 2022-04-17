//
//  JYRecordPaintingSizeCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/13.
//

#import "JYRecordPaintingSizeCollectionViewCell.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYRecordPaintingSizeCollectionViewCell ()

@end

@implementation JYRecordPaintingSizeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat lineLength = self.contentView.width * 0.5;
    CGFloat left = (self.contentView.width - lineLength) / 2.f;
    CGPoint startPoint = CGPointMake(left, self.contentView.height / 2.f);
    CGFloat height = lineLength / 3.f;
    [path moveToPoint:startPoint];
    
    for (float x = 0.0; x < fabs(lineLength); x++) {
        float startX = x;
        float yCosine = sin(x / 10 * M_PI) * height + startPoint.y;
        CGPoint cosinePoint = CGPointMake(startX + startPoint.x, yCosine);
    
        [path addLineToPoint:cosinePoint];
    }
    
    
//    startPoint = CGPointMake(left, self.contentView.height / 3.f);
//    endPoint = CGPointMake((left + lineLength/2.f), self.contentView.height / 2.f);
//
//    for (float x = 0.0; x < fabs(endPoint.x - startPoint.x); x++) {
//        float startX;
//        if (width > 0) {
//            startX = x;
//        }else{
//            startX = -x;
//        }
//        float yCosine = sin(x / 50 * M_PI) * height + startPoint.y;
//        CGPoint cosinePoint = CGPointMake(startX + startPoint.x, yCosine);
//
//        [path addLineToPoint:cosinePoint];
//    }
//
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 2.f;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    [self.contentView.layer addSublayer:layer];
}



- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
