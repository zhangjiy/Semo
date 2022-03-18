//
//  JYWriteFeelingListCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYWriteFeelingListCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYStrokeLabel : UILabel

@end

@implementation JYStrokeLabel

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.5);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    
    self.textColor = SMSealRedColor;
    
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = [UIColor whiteColor];
    
    [super drawTextInRect:rect];
}

@end

@interface JYWriteFeelingListCollectionViewCell ()
@property (nonatomic, strong) JYStrokeLabel *textLabel;
@end

@implementation JYWriteFeelingListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.frame = self.bounds;
}

- (JYStrokeLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[JYStrokeLabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.layer.masksToBounds = YES;
        _textLabel.layer.cornerRadius = 20.f;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.textLabel.text = text;
    }
}

@end
