//
//  JYSealFeelingSimpleView.m
//  Semo
//
//  Created by jiyang on 2022/3/29.
//

#import "JYSealFeelingSimpleView.h"
#import "JYPrefixHeader.h"

@interface JYSealFeelingSimpleView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer0;
@property (nonatomic, strong) CAShapeLayer *circleLayer1;
@property (nonatomic, strong) CAShapeLayer *circleLayer2;
@property (nonatomic, strong) CAShapeLayer *circleLayer3;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation JYSealFeelingSimpleView

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
    [self.layer addSublayer:self.circleLayer2];
    [self.layer addSublayer:self.circleLayer3];
    [self addSubview:self.textLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_circleLayer0.path) {
        CGFloat radius = self.width / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer0.path = [path CGPath];
    }
    
    if (!_circleLayer1.path) {
        CGFloat radius = (self.width * 0.9) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer1.path = [path CGPath];
    }
    
    if (!_circleLayer2.path) {
        CGFloat radius = (self.width * 0.68) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:1.2f * M_PI endAngle:1.8f * M_PI clockwise:true];
        _circleLayer2.path = [path CGPath];
    }
    
    if (!_circleLayer3.path) {
        CGFloat radius = (self.width * 0.68) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0.2 * M_PI endAngle:0.8f * M_PI clockwise:true];
        _circleLayer3.path = [path CGPath];
    }
}

- (CAShapeLayer *)circleLayer0 {
    if (!_circleLayer0) {
        _circleLayer0 = [[CAShapeLayer alloc] init];
        _circleLayer0.lineWidth = self.width / 40.f;
        _circleLayer0.strokeColor = SMSealRedColor.CGColor;
        _circleLayer0.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer0;
}

- (CAShapeLayer *)circleLayer1 {
    if (!_circleLayer1) {
        _circleLayer1 = [[CAShapeLayer alloc] init];
        _circleLayer1.lineWidth = self.width / 240.f;
        _circleLayer1.strokeColor = SMSealRedColor.CGColor;
        _circleLayer1.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer1;
}

- (CAShapeLayer *)circleLayer2 {
    if (!_circleLayer2) {
        _circleLayer2 = [[CAShapeLayer alloc] init];
        _circleLayer2.lineWidth = self.width / 120.f;
        _circleLayer2.strokeColor = SMSealRedColor.CGColor;
        _circleLayer2.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer2;
}

- (CAShapeLayer *)circleLayer3 {
    if (!_circleLayer3) {
        _circleLayer3 = [[CAShapeLayer alloc] init];
        _circleLayer3.lineWidth = self.width / 120.f;
        _circleLayer3.strokeColor = SMSealRedColor.CGColor;
        _circleLayer3.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer3;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        CGSize size = CGSizeMake(self.width * 0.68, self.width * 0.68);
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, (self.height - size.height) / 2.f, size.width, size.height)];
        _textLabel.font = [UIFont boldSystemFontOfSize:self.width * 0.42];
        _textLabel.textColor = SMSealRedColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.hidden = YES;
    }
    return _textLabel;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.textLabel.hidden = text.length > 0 ? NO:YES;
        self.textLabel.text = text;
    }
}

@end
