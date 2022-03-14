//
//  JYDayCalendarCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import "JYDayCalendarCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYDayCalendarCollectionViewCell ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) JYCalendarCalculator * calculator;
@end

@implementation JYDayCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self.contentView addSubview:self.titleLabel];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.shadowRadius = 4.0f;
        _titleLabel.layer.shadowOpacity = 0.4f;
        _titleLabel.layer.shadowOffset = CGSizeMake(0, 0);
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return _titleLabel;
}

- (void)updateViewWithText:(NSString *)text {
    self.titleLabel.text = text;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    self.titleLabel.top = SafeAreaHeight;
    self.titleLabel.centerX = self.contentView.width / 2.f;
}

@end
