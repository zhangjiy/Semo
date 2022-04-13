//
//  JYRecordPaintingPenCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/13.
//

#import "JYRecordPaintingPenCollectionViewCell.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYRecordPaintingPenCollectionViewCell ()

@end

@implementation JYRecordPaintingPenCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    CGSize size = CGSizeMake(self.contentView.width * 0.12, self.contentView.height * 0.4);
    CGFloat left = (self.contentView.width - size.width) / 2.f;
    CGFloat right = left + size.width;
    CGFloat top = (self.contentView.height - size.height) / 2.f;
    CGFloat bottom = top + size.height;
    CGFloat triangle = 3;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(right, bottom)];
    [path addLineToPoint:CGPointMake(right, top)];
    [path addLineToPoint:CGPointMake(left, top)];
    [path addLineToPoint:CGPointMake(left, bottom)];
    [path addLineToPoint:CGPointMake((left + size.width / 2.f), bottom + triangle)];
    [path closePath];
    
    [path moveToPoint:CGPointMake(left, top + triangle)];
    [path addLineToPoint:CGPointMake(right, top + triangle)];
    [path closePath];

    [path stroke];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 1.f;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    [self.contentView.layer addSublayer:layer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
