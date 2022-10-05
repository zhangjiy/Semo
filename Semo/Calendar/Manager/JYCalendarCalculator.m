//
//  JYCalendarCalculator.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "JYCalendarCalculator.h"
#import "NSCalendar+JYCalendarExtensions.h"

@interface JYCalendarCalculator () <JYCalendarDelegate>

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, id <JYMoodDate>> *months;

@property (nonatomic, strong) NSMutableDictionary<id <JYMoodDate>, NSNumber *> *rowCounts;

@property (nonatomic, readonly) NSCalendar *gregorian;
@property (nonatomic, readonly) id <JYMoodDate> minimumDate;
@property (nonatomic, readonly) id <JYMoodDate> maximumDate;

@property (nonatomic, strong) JYCalendar *calendar;

@end

@implementation JYCalendarCalculator

@dynamic gregorian, minimumDate, maximumDate;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.calendar = [[JYCalendar alloc] init];
        self.calendar.delegate = self;
        self.months = [NSMutableDictionary dictionary];
        self.rowCounts = [NSMutableDictionary dictionary];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotifications:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    if ([self.calendar respondsToSelector:selector]) {
        return self.calendar;
    }
    return [super forwardingTargetForSelector:selector];
}

- (void)clearCaches {
    [self.months removeAllObjects];
    [self.rowCounts removeAllObjects];
}

#pragma mark - Private functinos

- (void)didReceiveNotifications:(NSNotification *)notification {
    if ([notification.name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
        [self clearCaches];
    }
}

#pragma mark - Public functinos

- (void)adjustMonthPosition {
    [self.calendar adjustMonthPosition];
}

- (NSInteger)currentPage {
    return self.calendar.currentPage;
}

- (NSInteger)sameMonthName {
    return [self.gregorian component:NSCalendarUnitMonth fromDate:self.sameMonth.date];
}

- (NSInteger)todayName {
    return [self.gregorian component:NSCalendarUnitDay fromDate:self.today.date];
}

- (id <JYMoodDate>)sameMonth {
    return self.calendar.sameMonth;
}

- (id<JYMoodDate>)currentMonth {
    id<JYMoodDate> mouth = [self monthDateForIndex:self.currentPage];
    return mouth;
}

- (id<JYMoodDate>)today {
    return self.calendar.today;
}

- (NSInteger)numberOfMonths {
    return self.calendar.numberOfMonths;
}

- (NSInteger)numberOfRowsInMonth:(id <JYMoodDate>)month {
    if (!month) return 0;

    NSNumber *rowCount = self.rowCounts[month];
    if (rowCount == nil) {
        NSInteger numberOfDaysInMonth = [self.gregorian jy_numberOfDaysInMonth:month];
        rowCount = @(numberOfDaysInMonth);
        self.rowCounts[month] = rowCount;
    }
    return rowCount.integerValue;
}

- (NSString *)dayNameForDate:(id <JYMoodDate>)date {
    NSString *dayName = @([self.gregorian component:NSCalendarUnitDay fromDate:date.date]).stringValue;
    return dayName;
}

- (NSString *)monthNameForMonth:(id <JYMoodDate>)month {
    NSString *text = @([self.calendar.gregorian component:NSCalendarUnitMonth fromDate:month.date]).stringValue;
    return text;
}

- (NSString *)yearNameForMonth:(id <JYMoodDate>)month {
    NSString *text = @([self.calendar.gregorian component:NSCalendarUnitYear fromDate:month.date]).stringValue;
    return text;
}

- (BOOL)isToday:(id <JYMoodDate>)month index:(NSInteger)index {
    NSUInteger daysOffset = index;
    NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:daysOffset toDate:month.date options:0];
    if ([self.gregorian isDateInToday:date]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)dayNameForMonth:(id <JYMoodDate>)month index:(NSInteger)index {
    NSUInteger daysOffset = index;
    NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:daysOffset toDate:month.date options:0];
    NSString *text = @([self.gregorian component:NSCalendarUnitDay fromDate:date]).stringValue;
    return text;
}

- (JYMoodMonthDate *)monthDateForIndex:(NSInteger)index {
    NSNumber *key = @(index);
    id <JYMoodDate> month = self.months[key];
    if (!month) {
        NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:index toDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate].date options:0];
        month = [[JYMoodMonthDate alloc] initWithDate:date];
        self.months[key] = month;
    }
    return month;
}

- (id <JYMoodDate>)dayDayForIndex:(NSInteger)index {
    NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:index toDate:self.currentMonth.date options:0];
    return [[JYMoodDayDate alloc] initWithDate:date];
}

- (NSInteger)indexPathForDate:(id <JYMoodDate>)date atMonthPosition:(JYCalendarMonthPosition)position {
    NSInteger index = [self.gregorian components:NSCalendarUnitMonth fromDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate].date toDate:[self.gregorian jy_firstDayOfMonth:date].date options:0].month;
    if (position == JYCalendarMonthPositionPrevious) {
        index++;
    } else if (position == JYCalendarMonthPositionNext) {
        index--;
    }
    return index;
}

- (void)endScroll:(NSInteger)index {
    [self.calendar endScroll:index];
}

#pragma mark - JYCalendarDelegate

- (void)calendar:(JYCalendar *)calendar scrollToDate:(id <JYMoodDate>)date animated:(BOOL)animated {
    NSInteger scrollOffset = [self indexPathForDate:date atMonthPosition:JYCalendarMonthPositionCurrent];
    if ([self.delegate respondsToSelector:@selector(calendarCalculator:setContentOffset:animated:)]) {
        [self.delegate calendarCalculator:self setContentOffset:scrollOffset animated:animated];
    }
}

extern NSInteger JYCalendarDataIndexFromDateName(NSInteger value) {
    return MAX((value - 1), 0);
}

@end
