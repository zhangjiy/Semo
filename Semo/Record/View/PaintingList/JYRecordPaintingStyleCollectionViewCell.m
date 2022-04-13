//
//  JYRecordPaintingStyleCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import "JYRecordPaintingStyleCollectionViewCell.h"
#import "JYHeartView.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYRecordPaintingStyleCollectionViewCell ()
@property (nonatomic, strong) CAShapeLayer *circleLayer0;
@property (nonatomic, strong) CAShapeLayer *circleLayer1;
@property (nonatomic, strong) JYHeartView *heartView0;
@end

@implementation JYRecordPaintingStyleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView.layer addSublayer:self.circleLayer0];
    [self.contentView.layer addSublayer:self.circleLayer1];
    //[self.contentView addSubview:self.heartView0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_circleLayer0.path) {
        CGFloat radius = (self.contentView.width * 0.5) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.contentView.width / 2.f, self.contentView.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer0.path = [path CGPath];
    }
    
    if (!_circleLayer1.path) {
        CGFloat radius = (self.contentView.width * 0.4) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.contentView.width / 2.f, self.contentView.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer1.path = [path CGPath];
    }
    
    _heartView0.centerX = self.contentView.width / 2.f;
    _heartView0.centerY = self.contentView.height / 2.f;
}

- (CAShapeLayer *)circleLayer0 {
    if (!_circleLayer0) {
        _circleLayer0 = [[CAShapeLayer alloc] init];
        _circleLayer0.lineWidth = 2.f;
        _circleLayer0.strokeColor = [UIColor blackColor].CGColor;
        _circleLayer0.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer0;
}

- (CAShapeLayer *)circleLayer1 {
    if (!_circleLayer1) {
        _circleLayer1 = [[CAShapeLayer alloc] init];
        _circleLayer1.lineWidth = 1.f;
        _circleLayer1.strokeColor = [UIColor blackColor].CGColor;
        _circleLayer1.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer1;
}

- (JYHeartView *)heartView0 {
    if (!_heartView0) {
        CGFloat scale = 0.15;
        _heartView0 = [[JYHeartView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width * scale, self.contentView.height * scale)];
        _heartView0.heartColor = [UIColor blackColor];
        _heartView0.heartSize = self.contentView.width * scale;
    }
    
    return _heartView0;
}

@end
