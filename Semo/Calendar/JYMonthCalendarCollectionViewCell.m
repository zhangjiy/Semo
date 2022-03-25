//
//  JYMonthCalendarCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "JYMonthCalendarCollectionViewCell.h"
#import "JYDayCalendarView.h"
#import "JYPrefixHeader.h"

@interface JYMonthCalendarCollectionViewCell ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) JYDayCalendarView *dayCalendarView;
@end

@implementation JYMonthCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.dayCalendarView];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:15];
    }
    
    return _titleLabel;
}

- (JYDayCalendarView *)dayCalendarView {
    if (!_dayCalendarView) {
        _dayCalendarView = [[JYDayCalendarView alloc]initWithFrame:CGRectZero];
        _dayCalendarView.backgroundColor = [UIColor clearColor];
    }
    
    return _dayCalendarView;
}

- (void)updateViewWithMonth:(NSDate *)month calculator:(JYCalendarCalculator *)calculator {
    NSString *text = [calculator monthTextForMonth:month];
    self.titleLabel.text = text;
    self.dayCalendarView.calculator = calculator;
    self.dayCalendarView.month = month;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.top = 10;
    _titleLabel.size = CGSizeMake(self.contentView.width, 25);
    _titleLabel.centerX = self.contentView.width / 2.f;
    
    _dayCalendarView.width = self.contentView.width;
    _dayCalendarView.height = self.contentView.height - _titleLabel.bottom - JYViewInset;
    _dayCalendarView.top = _titleLabel.bottom + JYViewInset;
}

@end
