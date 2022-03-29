//
//  JYSealFeelingSellView.m
//  Semo
//
//  Created by jiyang on 2022/3/28.
//

#import "JYSealFeelingSellView.h"
#import "Semo-Swift.h"
#import "JYARCArrangeStartView.h"
#import "JYPrefixHeader.h"

@interface JYSealFeelingSellView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer0;
@property (nonatomic, strong) CAShapeLayer *circleLayer1;
@property (nonatomic, strong) CAShapeLayer *circleLayer2;
@property (nonatomic, strong) JYARCArrangeTextView *arrangeTextView0;
@property (nonatomic, strong) JYARCArrangeStartView *arrangeStartView0;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation JYSealFeelingSellView

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
    [self addSubview:self.arrangeTextView0];
    [self addSubview:self.arrangeStartView0];
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
        CGFloat radius = (self.width * 0.85) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer1.path = [path CGPath];
    }
    
    if (!_circleLayer2.path) {
        CGFloat radius = (self.width * 0.8) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer2.path = [path CGPath];
    }
    
}

- (CAShapeLayer *)circleLayer0 {
    if (!_circleLayer0) {
        _circleLayer0 = [[CAShapeLayer alloc] init];
        _circleLayer0.lineWidth = self.width / 70.f;
        _circleLayer0.strokeColor = SMSealRedColor.CGColor;
        _circleLayer0.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer0;
}

- (CAShapeLayer *)circleLayer1 {
    if (!_circleLayer1) {
        _circleLayer1 = [[CAShapeLayer alloc] init];
        _circleLayer1.lineWidth = self.width / 60.f;
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

- (JYARCArrangeStartView *)arrangeStartView0 {
    if (!_arrangeStartView0) {
        CGSize size = CGSizeMake(self.width * 0.74, self.height * 0.74);
        _arrangeStartView0 = [[JYARCArrangeStartView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _arrangeStartView0.centerY = self.height / 2.45;
        _arrangeStartView0.centerX = self.width / 2.f;
        _arrangeStartView0.stars = @[@(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f)), @(5.f * (self.width / 300.f))];
        [_arrangeStartView0 drawStars];
    }
    
    return _arrangeStartView0;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        CGSize size = CGSizeMake(self.width * 0.68, self.width * 0.68);
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, (self.height - size.height) / 2.f, size.width, size.height)];
        _textLabel.font = [UIFont boldSystemFontOfSize:self.width * 0.42];
        _textLabel.textColor = SMSealGreenColor;
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
