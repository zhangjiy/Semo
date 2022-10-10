//
//  JYHomeTodayMoodCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/6/2.
//

#import "JYHomeTodayMoodCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYStrokeLabel : UILabel

@end

@implementation JYStrokeLabel

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);

    CGContextSetLineJoin(context, kCGLineJoinRound);

    CGContextSetTextDrawingMode(context, kCGTextStroke);

    self.textColor = SMSealRedColor;

    [super drawTextInRect:rect];

    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = [UIColor whiteColor];

    [super drawTextInRect:rect];
}

@end

@interface JYHomeTodayMoodCollectionViewCell ()
@property (nonatomic, strong) JYStrokeLabel *textLabel;
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation JYHomeTodayMoodCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.countLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.size = CGSizeMake(20, 20);
    _textLabel.top = 5;
    _textLabel.centerX = self.contentView.width / 2.f;
    
    [_countLabel sizeToFit];
    _countLabel.top = _textLabel.bottom + 3;
    _countLabel.centerX = self.contentView.width / 2.f;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countLabel.font = [UIFont systemFontOfSize:6];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (JYStrokeLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[JYStrokeLabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:10];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.layer.masksToBounds = YES;
        _textLabel.layer.cornerRadius = 10;
    }
    return _textLabel;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.textLabel.text = text;
    }
}

- (void)setCount:(NSNumber *)count {
    if (_count != count) {
        _count = count;
        self.countLabel.text = [NSString stringWithFormat:@"%@", count];
    }
}

- (void)setColor:(UIColor *)color {
    if (_color != color) {
        _color = color;
        self.textLabel.backgroundColor = color;
    }
}


@end
