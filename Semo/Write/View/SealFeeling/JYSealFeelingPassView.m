//
//  JYSealFeelingPassView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYSealFeelingPassView.h"
#import "Semo-Swift.h"
#import "JYPrefixHeader.h"

@interface JYSealFeelingPassView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer0;
@property (nonatomic, strong) CAShapeLayer *circleLayer1;
@property (nonatomic, strong) JYARCArrangeTextView *arrangeTextView0;
@end

@implementation JYSealFeelingPassView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self layoutIfNeeded];
    [self.layer addSublayer:self.circleLayer0];
    [self.layer addSublayer:self.circleLayer1];
    [self addSubview:self.arrangeTextView0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_circleLayer0.path) {
        CGFloat radius = self.width / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.0f * M_PI clockwise:false];
        _circleLayer0.path = [path CGPath];
    }
    
    if (!_circleLayer1.path) {
        CGFloat radius = (self.width - 10) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.0f * M_PI clockwise:false];
        _circleLayer1.path = [path CGPath];
    }

}

- (CAShapeLayer *)circleLayer0 {
    if (!_circleLayer0) {
        _circleLayer0 = [[CAShapeLayer alloc] init];
        _circleLayer0.lineWidth = 3;
        _circleLayer0.strokeColor = [UIColor redColor].CGColor;
        _circleLayer0.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer0;
}

- (CAShapeLayer *)circleLayer1 {
    if (!_circleLayer1) {
        _circleLayer1 = [[CAShapeLayer alloc] init];
        _circleLayer1.lineWidth = 1;
        _circleLayer1.strokeColor = [UIColor redColor].CGColor;
        _circleLayer1.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer1;
}

- (JYARCArrangeTextView *)arrangeTextView0 {
    if (!_arrangeTextView0) {
        CGSize size = CGSizeMake(116, 116);
        _arrangeTextView0 = [[JYARCArrangeTextView alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, (self.height - size.height) / 2.f, size.width, size.height) text:@"西丰县房木镇潭清村"];
    }
    
    return _arrangeTextView0;
}

@end
