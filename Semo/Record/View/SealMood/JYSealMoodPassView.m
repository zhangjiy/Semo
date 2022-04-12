//
//  JYSealMoodPassView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYSealMoodPassView.h"
#import "Semo-Swift.h"
#import "JYARCArrangeStartView.h"
#import "JYPrefixHeader.h"

@interface JYSealMoodPassView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer0;
@property (nonatomic, strong) CAShapeLayer *circleLayer1;
@property (nonatomic, strong) CAShapeLayer *circleLayer2;
@property (nonatomic, strong) CAShapeLayer *circleLayer3;
@property (nonatomic, strong) JYARCArrangeTextView *arrangeTextView0;
@property (nonatomic, strong) JYARCArrangeTextView *arrangeTextView1;
@property (nonatomic, strong) JYARCArrangeStartView *arrangeStartView0;
@property (nonatomic, strong) JYARCArrangeStartView *arrangeStartView1;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation JYSealMoodPassView

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
    [self addSubview:self.arrangeTextView0];
    [self addSubview:self.arrangeTextView1];
    [self addSubview:self.arrangeStartView0];
    [self addSubview:self.arrangeStartView1];
    [self addSubview:self.textLabel];
    
    CGFloat alpha = M_PI;
    CATransform3D trans = CATransform3DIdentity;
    self.arrangeTextView1.layer.transform = CATransform3DRotate(trans, alpha, 0, 0, 1);
    self.arrangeStartView1.layer.transform = CATransform3DRotate(trans, alpha, 0, 0, 1);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_circleLayer0.path) {
        CGFloat radius = self.width / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer0.path = [path CGPath];
    }
    
    if (!_circleLayer1.path) {
        CGFloat radius = (self.width * 0.95) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:0 endAngle:2.f * M_PI clockwise:false];
        _circleLayer1.path = [path CGPath];
    }
    
    if (!_circleLayer2.path) {
        CGFloat radius = (self.width * 0.72) / 2.f;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2.f, self.height / 2.f) radius:radius startAngle:1.2f * M_PI endAngle:1.8f * M_PI clockwise:true];
        _circleLayer2.path = [path CGPath];
    }
    
    if (!_circleLayer3.path) {
        CGFloat radius = (self.width * 0.72) / 2.f;
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

- (JYARCArrangeTextView *)arrangeTextView0 {
    if (!_arrangeTextView0) {
        CGSize size = CGSizeMake(self.width * 0.9, self.height * 0.7);
        _arrangeTextView0 = [[JYARCArrangeTextView alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, self.height / 50.f, size.width, size.height)];
        _arrangeTextView0.text = @"20220316 10:45";
        [_arrangeTextView0 drawText];
    }
    return _arrangeTextView0;
}

- (JYARCArrangeTextView *)arrangeTextView1 {
    if (!_arrangeTextView1) {
        CGSize size = CGSizeMake(self.width * 0.9, self.height * 0.7);
        _arrangeTextView1 = [[JYARCArrangeTextView alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, (self.height * 0.28), size.width, size.height)];
        _arrangeTextView1.text = @"20220316 10:45";
        [_arrangeTextView1 drawText];
    }
    return _arrangeTextView1;
}


- (JYARCArrangeStartView *)arrangeStartView0 {
    if (!_arrangeStartView0) {
        CGSize size = CGSizeMake(self.width / 2.2, self.height / 12.f);
        _arrangeStartView0 = [[JYARCArrangeStartView alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, self.height * 0.21, size.width, size.height)];
        [_arrangeStartView0 drawStars];
    }
    
    return _arrangeStartView0;
}

- (JYARCArrangeStartView *)arrangeStartView1 {
    if (!_arrangeStartView1) {
        CGSize size = CGSizeMake(self.width / 2.2, self.height / 12.f);
        _arrangeStartView1 = [[JYARCArrangeStartView alloc] initWithFrame:CGRectMake((self.width - size.width) / 2.f, self.height * 0.71, size.width, size.height)];
        [_arrangeStartView1 drawStars];
    }
    
    return _arrangeStartView1;
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
