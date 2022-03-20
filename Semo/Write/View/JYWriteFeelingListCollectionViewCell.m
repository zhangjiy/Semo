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

//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2.5);
//    
//    CGContextSetLineJoin(context, kCGLineJoinRound);
//    
//    CGContextSetTextDrawingMode(context, kCGTextStroke);
//    
//    self.textColor = SMSealRedColor;
//    
//    [super drawTextInRect:rect];
//    
//    CGContextSetTextDrawingMode(context, kCGTextFill);
//    self.textColor = [UIColor whiteColor];
//    
//    [super drawTextInRect:rect];
//}

@end

@interface JYWriteFeelingListCollectionViewCell ()
@property (nonatomic, strong) CAShapeLayer *selectedLayer;
@property (nonatomic, strong) UILabel *textLabel;
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
    [self.contentView.layer addSublayer:self.selectedLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.size = CGSizeMake(self.contentView.width - 10, self.contentView.width - 10);
    _textLabel.centerX = self.contentView.width / 2.f;
    _textLabel.centerY = self.contentView.height / 2.f;
    
    _selectedLayer.frame = self.bounds;
}

- (CAShapeLayer *)selectedLayer {
    if (!_selectedLayer) {
        _selectedLayer = [[CAShapeLayer alloc] init];
        _selectedLayer.cornerRadius = self.contentView.width / 2.f;
        _selectedLayer.borderColor = [UIColor colorWithRed:193/225.f green:193/225.f blue:193/225.f alpha:1.f].CGColor;
    }
    
    return _selectedLayer;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.layer.masksToBounds = YES;
        _textLabel.layer.cornerRadius = (self.contentView.width - 10) / 2.f;
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

- (void)setColor:(UIColor *)color {
    if (_color != color) {
        _color = color;
        self.textLabel.backgroundColor = color;
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        _selectedLayer.borderWidth = isSelected ? 2.f : 0.f;
    }
}

@end
