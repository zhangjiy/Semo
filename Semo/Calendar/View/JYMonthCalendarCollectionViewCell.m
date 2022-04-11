//
//  JYMonthCalendarCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "JYMonthCalendarCollectionViewCell.h"
#import "JYDayCalendarView.h"
#import "JYPrefixHeader.h"

@interface JYMonthCalendarCollectionViewCell () <JYDayCalendarViewDelegate>
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
    [self.contentView addSubview:self.dayCalendarView];
}

- (JYDayCalendarView *)dayCalendarView {
    if (!_dayCalendarView) {
        _dayCalendarView = [[JYDayCalendarView alloc]initWithFrame:CGRectZero];
        _dayCalendarView.delegate = self;
        _dayCalendarView.backgroundColor = [UIColor clearColor];
    }
    
    return _dayCalendarView;
}

- (void)updateViewWithMonth:(JYMoodMonthDate *)month calculator:(JYCalendarCalculator *)calculator {
    self.dayCalendarView.calculator = calculator;
    self.dayCalendarView.month = month;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _dayCalendarView.width = self.contentView.width;
    _dayCalendarView.height = self.contentView.height - StatusBarHeight - JYViewInset;
    _dayCalendarView.top = StatusBarHeight + JYViewInset;
}

#pragma -- mark -- JYDayCalendarViewDelegate

- (void)dayCalendarView:(JYDayCalendarView *)view didSelectItemAtIndexPath:(id <JYMoodDate>)date {
    if ([self.delegate respondsToSelector:@selector(monthCalendarCollectionViewCell:didSelectItemAtIndexPath:)]) {
        [self.delegate monthCalendarCollectionViewCell:self didSelectItemAtIndexPath:date];
    }
}

@end
