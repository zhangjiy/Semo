//
//  JYSealFeelingLoveView.m
//  Semo
//
//  Created by jiyang on 2022/3/28.
//

#import "JYSealFeelingLoveView.h"
#import "Semo-Swift.h"
#import "JYARCArrangeStartView.h"
#import "JYHeartView.h"
#import "JYPrefixHeader.h"

@interface JYSealFeelingLoveView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer0;
@property (nonatomic, strong) CAShapeLayer *circleLayer1;
@property (nonatomic, strong) CAShapeLayer *circleLayer2;
@property (nonatomic, strong) CAShapeLayer *circleLayer3;
@property (nonatomic, strong) CAShapeLayer *circleLayer4;
@property (nonatomic, strong) UIView *dotView0;
@property (nonatomic, strong) UIView *dotView1;
@property (nonatomic, strong) UIView *dotView2;
@property (nonatomic, strong) UIView *dotView3;
@property (nonatomic, strong) JYARCArrangeTextView *arrangeTextView0;
@property (nonatomic, strong) JYARCArrangeTextView *arrangeTextView1;
@property (nonatomic, strong) JYHeartView *heartView0;
@property (nonatomic, strong) JYHeartView *heartView1;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation JYSealFeelingLoveView

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
    [self.layer addSublayer:self.circleLayer4];
    [self addSubview:self.heartView0];
    [self addSubview:self.heartView1];
    [self addSubview:self.arrangeTextView0];
    [self addSubview:self.arrangeTextView1];
    [self addSubview:self.dotView0];
    [self addSubview:self.dotView1];
    [self addSubview:self.dotView2];
    [self addSubview:self.dotView3];
    [self addSubview:self.textLabel];
    
    CGFloat alpha = M_PI;
    CATransform3D trans = CATransform3DIdentity;
    self.arrangeTextView1.layer.transform = CATransform3DRotate(trans, alpha, 0, 0, 1);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_circleLayer0.path) {
        CGFloat radius = self.width / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer0.path = [path CGPath];
    }
    
    if (!_circleLayer1.path) {
        CGFloat radius = (self.width * 0.68) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:1.08f * M_PI endAngle:1.92f * M_PI clockwise:true];
        _circleLayer1.path = [path CGPath];
    }
    
    if (!_circleLayer2.path) {
        CGFloat radius = (self.width * 0.68) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0.08 * M_PI endAngle:0.92f * M_PI clockwise:true];
        _circleLayer2.path = [path CGPath];
    }
    
    if (!_circleLayer3.path) {
        CGFloat radius = (self.width * 0.165) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width * 0.163, self.height / 2.f) radius:radius startAngle:1.5f * M_PI endAngle:2.5f * M_PI clockwise:true];
        _circleLayer3.path = [path CGPath];
    }
    
    if (!_circleLayer4.path) {
        CGFloat radius = (self.width * 0.165) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width * 0.837, self.height / 2.f) radius:radius startAngle:0.5f * M_PI endAngle:1.5f * M_PI clockwise:true];
        _circleLayer4.path = [path CGPath];
    }
}

- (CAShapeLayer *)circleLayer0 {
    if (!_circleLayer0) {
        _circleLayer0 = [[CAShapeLayer alloc] init];
        _circleLayer0.lineWidth = self.width / 40.f;
        _circleLayer0.strokeColor = SMSealBlueColor.CGColor;
        _circleLayer0.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer0;
}

- (CAShapeLayer *)circleLayer1 {
    if (!_circleLayer1) {
        _circleLayer1 = [[CAShapeLayer alloc] init];
        _circleLayer1.lineWidth = self.width / 60.f;
        _circleLayer1.strokeColor = SMSealBlueColor.CGColor;
        _circleLayer1.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer1;
}

- (CAShapeLayer *)circleLayer2 {
    if (!_circleLayer2) {
        _circleLayer2 = [[CAShapeLayer alloc] init];
        _circleLayer2.lineWidth = self.width / 60.f;
        _circleLayer2.strokeColor = SMSealBlueColor.CGColor;
        _circleLayer2.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer2;
}

- (CAShapeLayer *)circleLayer3 {
    if (!_circleLayer3) {
        _circleLayer3 = [[CAShapeLayer alloc] init];
        _circleLayer3.lineWidth = self.width / 60.f;
        _circleLayer3.strokeColor = SMSealBlueColor.CGColor;
        _circleLayer3.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer3;
}

- (CAShapeLayer *)circleLayer4 {
    if (!_circleLayer4) {
        _circleLayer4 = [[CAShapeLayer alloc] init];
        _circleLayer4.lineWidth = self.width / 60.f;
        _circleLayer4.strokeColor = SMSealBlueColor.CGColor;
        _circleLayer4.fillColor = [UIColor clearColor].CGColor;
    }
     
    return _circleLayer4;
}

- (UIView *)dotView0 {
    if (!_dotView0) {
        CGFloat width = self.width * 0.028;
        _dotView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _dotView0.left = self.width * 0.09;
        _dotView0.top = self.height * 0.38;
        _dotView0.layer.masksToBounds = YES;
        _dotView0.layer.cornerRadius = width / 2.f;
        _dotView0.backgroundColor = SMSealBlueColor;
    }
     
    return _dotView0;
}

- (UIView *)dotView1 {
    if (!_dotView1) {
        CGFloat width = self.width * 0.028;
        _dotView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _dotView1.left = self.width * 0.09;
        _dotView1.top = self.height * 0.61;
        _dotView1.layer.masksToBounds = YES;
        _dotView1.layer.cornerRadius = width / 2.f;
        _dotView1.backgroundColor = SMSealBlueColor;
    }
     
    return _dotView1;
}

- (UIView *)dotView2 {
    if (!_dotView2) {
        CGFloat width = self.width * 0.028;
        _dotView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _dotView2.left = self.width * 0.88;
        _dotView2.top = self.height * 0.38;
        _dotView2.layer.masksToBounds = YES;
        _dotView2.layer.cornerRadius = width / 2.f;
        _dotView2.backgroundColor = SMSealBlueColor;
    }
     
    return _dotView2;
}

- (UIView *)dotView3 {
    if (!_dotView3) {
        CGFloat width = self.width * 0.028;
        _dotView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _dotView3.left = self.width * 0.88;
        _dotView3.top = self.height * 0.62;
        _dotView3.layer.masksToBounds = YES;
        _dotView3.layer.cornerRadius = width / 2.f;
        _dotView3.backgroundColor = SMSealBlueColor;
    }
     
    return _dotView3;
}

- (JYHeartView *)heartView0 {
    if (!_heartView0) {
        CGFloat scale = 0.1;
        _heartView0 = [[JYHeartView alloc] initWithFrame:CGRectMake(0, 0, self.width * scale, self.height * scale)];
        _heartView0.heartColor = SMSealBlueColor;
        _heartView0.heartSize = self.width * scale;
        _heartView0.left = self.width * 0.11;
        _heartView0.centerY = self.height / 2.f;
    }
    
    return _heartView0;
}

- (JYHeartView *)heartView1 {
    if (!_heartView1) {
        CGFloat scale = 0.1;
        _heartView1 = [[JYHeartView alloc] initWithFrame:CGRectMake(0, 0, self.width * scale, self.height * scale)];
        _heartView1.heartColor = SMSealBlueColor;
        _heartView1.heartSize = self.width * scale;
        _heartView1.left = self.width * 0.89;
        _heartView1.centerY = self.height / 2.f;
    }
    
    return _heartView1;
}

- (JYARCArrangeTextView *)arrangeTextView0 {
    if (!_arrangeTextView0) {
        CGSize size = CGSizeMake(self.width * 0.9, self.height * 0.6);
        _arrangeTextView0 = [[JYARCArrangeTextView alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, self.height / 48.f, size.width, size.height)];
        _arrangeTextView0.text = @"Fir.20220316 10:45";
        _arrangeTextView0.color = SMSealBlueColor;
        [_arrangeTextView0 drawText];
    }
    return _arrangeTextView0;
}

- (JYARCArrangeTextView *)arrangeTextView1 {
    if (!_arrangeTextView1) {
        CGSize size = CGSizeMake(self.width * 0.8, self.width * 0.6);
        _arrangeTextView1 = [[JYARCArrangeTextView alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, (self.height * 0.38), size.width, size.height)];
        _arrangeTextView1.text = @"Seven Mood";
        _arrangeTextView1.color = SMSealBlueColor;
        [_arrangeTextView1 drawText];
    }
    return _arrangeTextView1;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        CGSize size = CGSizeMake(self.width * 0.68, self.width * 0.68);
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, (self.height - size.height) / 2.f, size.width, size.height)];
        _textLabel.font = [UIFont boldSystemFontOfSize:self.width * 0.42];
        _textLabel.textColor = SMSealBlueColor;
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

