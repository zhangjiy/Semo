//
//  JYMonthCalendarCollectionViewCell.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "JYMonthCalendarCollectionViewCell.h"
#import "JYGridView.h"
#import "JYDayCalendarView.h"
#import "JYPrefixHeader.h"

@interface JYMonthCalendarCollectionViewCell () <JYDayCalendarViewDelegate>
@property (nonatomic, strong) JYGridView *gridView;
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
    //[self.contentView addSubview:self.gridView];
    [self.gridView drawGridWithVerLineCount:4 horLineCount:8 scale:4/3.f];
    [self.contentView addSubview:self.dayCalendarView];
}

- (JYGridView *)gridView {
    if (!_gridView) {
        _gridView = [[JYGridView alloc] initWithFrame:CGRectMake(0, 0, JYHomeGridWidth, JYHomeGridHeight)];
        _gridView.backgroundColor = [UIColor redColor];
    }
    
    return _gridView;
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
    _gridView.frame = self.contentView.bounds;
    _dayCalendarView.frame = self.contentView.bounds;
}

#pragma -- mark -- JYDayCalendarViewDelegate

- (void)dayCalendarView:(JYDayCalendarView *)view didSelectedItem:(id <JYMoodDate>)date didSelectedItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(monthCalendarCollectionViewCell:didSelectedItem:didSelectedItemAtIndex:)]) {
        [self.delegate monthCalendarCollectionViewCell:self didSelectedItem:date didSelectedItemAtIndex:index];
    }
}

- (void)dayCalendarView:(JYDayCalendarView *)view didDeletedItem:(id <JYMoodDate>)date didDeletedItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(monthCalendarCollectionViewCell:didDeletedItem:didDeletedItemAtIndex:)]) {
        [self.delegate monthCalendarCollectionViewCell:self didDeletedItem:date didDeletedItemAtIndex:index];
    }
}

@end
