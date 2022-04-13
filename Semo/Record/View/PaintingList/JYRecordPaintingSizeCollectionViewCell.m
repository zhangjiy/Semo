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
    path.lineCapStyle = kCGLineCapRound;
    CGFloat lineLength = self.contentView.width * 0.8;
    CGFloat left = (self.contentView.width - lineLength) / 2.f;
    [path moveToPoint:CGPointMake(left, self.contentView.height / 2.f)];
    [path addCurveToPoint:CGPointMake(lineLength, self.contentView.height / 2.f) controlPoint1:CGPointMake(lineLength * 0.4, 0) controlPoint2:CGPointMake(lineLength * 0.6, self.contentView.height)];
    [path stroke];
    [path closePath];
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
