//
//  JYRecordPaintingUndoCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/13.
//

#import "JYRecordPaintingUndoCollectionViewCell.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYRecordPaintingUndoCollectionViewCell ()

@end

@implementation JYRecordPaintingUndoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    CGSize size = CGSizeMake(self.contentView.width * 0.4, self.contentView.height * 0.4);
    CGPoint startPoint = CGPointMake((self.contentView.width - size.width) / 2.f, (self.contentView.height - size.height) / 2.f);
    CGFloat x1 = startPoint.x + size.width * 0.8;
    CGFloat y1 = startPoint.y + size.height;
    
    CGFloat x2 = startPoint.x + size.width;
    CGFloat y2 = startPoint.y + size.height;
    
    CGFloat x3 = startPoint.x + size.width;
    CGFloat y3 = startPoint.y + size.height * 0.2;
    
    CGFloat x4 = startPoint.x + size.width * 0.3;
    CGFloat y4 = startPoint.y + size.height * 0.2;
    
    CGFloat x5 = startPoint.x + size.width * 0.3;
    CGFloat y5 = startPoint.y;
    
    CGFloat x6 = startPoint.x;
    CGFloat y6 = startPoint.y + size.height * 0.4;
    
    CGFloat x7 = startPoint.x + size.width * 0.3;;
    CGFloat y7 = startPoint.y + size.height * 0.7;
    
    CGFloat x8 = startPoint.x + size.width * 0.3;
    CGFloat y8 = startPoint.y + size.height * 0.4;
    
    CGFloat x9 = startPoint.x + size.width * 0.8;
    CGFloat y9 = startPoint.y + size.height * 0.4;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(x1, y1)];
    [path addLineToPoint:CGPointMake(x2, y2)];
    [path addLineToPoint:CGPointMake(x3, y3)];
    [path addLineToPoint:CGPointMake(x4, y4)];
    [path addLineToPoint:CGPointMake(x5, y5)];
    [path addLineToPoint:CGPointMake(x6, y6)];
    [path addLineToPoint:CGPointMake(x7, y7)];
    [path addLineToPoint:CGPointMake(x8, y8)];
    [path addLineToPoint:CGPointMake(x9, y9)];
    
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
