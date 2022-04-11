//
//  JYYearCalendarCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/4/11.
//

#import "JYYearCalendarCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYYearCalendarCollectionViewCell ()
@property (nonatomic, strong) UIView * backgroundContentView;
@property (nonatomic, strong) UILabel * yearLabel;
@property (nonatomic, strong) UILabel * monthLabel;
@end

@implementation JYYearCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self.contentView addSubview:self.backgroundContentView];
    [self.contentView addSubview:self.yearLabel];
    [self.contentView addSubview:self.monthLabel];
}

- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _yearLabel.textAlignment = NSTextAlignmentCenter;
        _yearLabel.textColor = [UIColor blackColor];
        _yearLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return _yearLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.textColor = [UIColor blackColor];
        _monthLabel.font = [UIFont systemFontOfSize:30];
    }
    
    return _monthLabel;
}

- (UIView *)backgroundContentView {
    if (!_backgroundContentView) {
        _backgroundContentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _backgroundContentView;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        self.yearLabel.text = @"2022";
        self.monthLabel.text = @"四月";
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backgroundContentView.frame = self.contentView.bounds;
    [_yearLabel sizeToFit];
    _yearLabel.centerX = self.contentView.width / 2.f;
    _yearLabel.centerY = self.contentView.height / 6.f;
    
    [_monthLabel sizeToFit];
    _monthLabel.centerX = self.contentView.width / 2.f;
    _monthLabel.top = _yearLabel.bottom;
}

@end
