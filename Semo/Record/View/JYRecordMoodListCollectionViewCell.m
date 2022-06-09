//
//  JYRecordMoodListCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYRecordMoodListCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodListCollectionViewCell ()
@property (nonatomic, strong) CAShapeLayer *selectedLayer;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation JYRecordMoodListCollectionViewCell

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
    _textLabel.size = CGSizeMake(ceilf(self.contentView.width - 14), ceilf(self.contentView.width - 14));
    _textLabel.centerX = self.contentView.width / 2.f;
    _textLabel.centerY = self.contentView.height / 2.f;
    
    _selectedLayer.frame = CGRectMake(5, 5, ceilf(self.contentView.width - 10), ceilf(self.contentView.width - 10));
}

- (CAShapeLayer *)selectedLayer {
    if (!_selectedLayer) {
        _selectedLayer = [[CAShapeLayer alloc] init];
        _selectedLayer.masksToBounds = YES;
        _selectedLayer.cornerRadius = ceilf((self.contentView.width - 10)) / 2.f;
        _selectedLayer.borderWidth = 4.f;
        _selectedLayer.borderColor = SMGridLineColor.CGColor;
        _selectedLayer.hidden = YES;
    }
    
    return _selectedLayer;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.layer.masksToBounds = YES;
        _textLabel.layer.cornerRadius = ceilf((self.contentView.width - 14)) / 2.f;
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
        _selectedLayer.hidden = isSelected ? NO : YES;
    }
}

@end
