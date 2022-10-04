//
//  JYRecordMoodListCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYRecordMoodListCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodListCollectionViewCell ()
@property (nonatomic, strong) UIView *selectedView;
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
    [self.contentView addSubview:self.selectedView];
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] init];
    [gesture addTarget:self action:@selector(longPress:)];
    [self.contentView addGestureRecognizer:gesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.size = CGSizeMake(ceilf(self.contentView.width - 14), ceilf(self.contentView.width - 14));
    _textLabel.centerX = self.contentView.width / 2.f;
    _textLabel.bottom = self.contentView.height - 10;
    
    _selectedView.size = CGSizeMake(ceilf(self.contentView.width - 10), ceilf(self.contentView.width - 10));
    _selectedView.centerX = self.contentView.width / 2.f;
    _selectedView.centerY = _textLabel.centerY;
}

- (UIView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIView alloc] initWithFrame:CGRectZero];
        _selectedView.layer.masksToBounds = YES;
        _selectedView.layer.cornerRadius = ceilf((self.contentView.width - 10)) / 2.f;
        _selectedView.layer.borderWidth = 4.f;
        _selectedView.layer.borderColor = SMGridLineColor.CGColor;
        _selectedView.hidden = YES;
    }
    
    return _selectedView;
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
        _selectedView.hidden = isSelected ? NO : YES;
    }
}

- (void)longPress:(UIGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(recordMoodListCollectionViewCell:didLongPress:)]) {
        [self.delegate recordMoodListCollectionViewCell:self didLongPress:gesture];
    }
}

@end
