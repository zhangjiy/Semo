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
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, id <JYMoodDate>> *monthHeads;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, id <JYMoodDate>> *weeks;
@property (nonatomic, strong) NSMutableDictionary<id <JYMoodDate>, NSNumber *> *rowCounts;

@property (nonatomic, readonly) NSCalendar *gregorian;
@property (nonatomic, readonly) id <JYMoodDate> minimumDate;
@property (nonatomic, readonly) id <JYMoodDate> maximumDate;

@property (nonatomic, strong) JYCalendar *calendar;

- (void)didReceiveNotifications:(NSNotification *)notification;

@end

@implementation JYCalendarCalculator

@dynamic gregorian, minimumDate, maximumDate;

- (instancetype)initWithCalendar:(JYCalendar *)calendar {
    self = [super init];
    if (self) {
        self.calendar = calendar;
        self.calendar.delegate = self;
        self.months = [NSMutableDictionary dictionary];
        self.monthHeads = [NSMutableDictionary dictionary];
        self.weeks = [NSMutableDictionary dictionary];
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

- (id <JYMoodDate>)dateForIndexPath:(NSIndexPath *)indexPath scope:(JYCalendarScope)scope {
    if (!indexPath) return nil;
    switch (scope) {
        case JYCalendarScopeMonth: {
            id <JYMoodDate> head = [self monthHeadForSection:indexPath.section];
            NSUInteger daysOffset = indexPath.item;
            NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:daysOffset toDate:head.date options:0];
            JYMoodMonthDate *monthDate = [[JYMoodMonthDate alloc] initWithDate:date];
            return monthDate;
            break;
        }
        case JYCalendarScopeWeek: {
            id <JYMoodDate> currentPage = [self weekForSection:indexPath.section];
            NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:indexPath.item toDate:currentPage.date options:0];
            JYMoodWeekDate *weekDate = [[JYMoodWeekDate alloc] initWithDate:date];
            return weekDate;
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathForDate:(id <JYMoodDate>)date scope:(JYCalendarScope)scope {
    return [self indexPathForDate:date atMonthPosition:JYCalendarMonthPositionCurrent scope:scope];
}

- (NSIndexPath *)indexPathForDate:(id <JYMoodDate>)date atMonthPosition:(JYCalendarMonthPosition)position scope:(JYCalendarScope)scope {
    if (!date) return nil;
    NSInteger item = 0;
    NSInteger section = 0;
    switch (scope) {
        case JYCalendarScopeMonth: {
            section = [self.gregorian components:NSCalendarUnitMonth fromDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate].date toDate:[self.gregorian jy_firstDayOfMonth:date].date options:0].month;
            if (position == JYCalendarMonthPositionPrevious) {
                section++;
            } else if (position == JYCalendarMonthPositionNext) {
                section--;
            }
            id <JYMoodDate> head = [self monthHeadForSection:section];
            item = [self.gregorian components:NSCalendarUnitDay fromDate:head.date toDate:date.date options:0].day;
            break;
        }
        case JYCalendarScopeWeek: {
            section = [self.gregorian components:NSCalendarUnitWeekOfYear fromDate:[self.gregorian jy_firstDayOfWeek:self.minimumDate].date toDate:[self.gregorian jy_firstDayOfWeek:date].date options:0].weekOfYear;
            item = (([self.gregorian component:NSCalendarUnitWeekday fromDate:date.date] - self.gregorian.firstWeekday) + 7) % 7;
            break;
        }
    }
    if (item < 0 || section < 0) {
        return nil;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    return indexPath;
}

- (NSIndexPath *)indexPathForDate:(id <JYMoodDate>)date atMonthPosition:(JYCalendarMonthPosition)position {
    return [self indexPathForDate:date atMonthPosition:position scope:self.calendar.scope];
}

- (id <JYMoodDate>)pageForSection:(NSInteger)section {
    switch (self.calendar.scope) {
        case JYCalendarScopeWeek:
            return [self.gregorian jy_middleDayOfWeek:[self weekForSection:section]];
        case JYCalendarScopeMonth:
            return [self monthForSection:section];
        default:
            break;
    }
}

- (id <JYMoodDate>)monthForSection:(NSInteger)section {
    NSNumber *key = @(section);
    id <JYMoodDate> month = self.months[key];
    if (!month) {
        NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:section toDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate].date options:0];
        month = [[JYMoodMonthDate alloc] initWithDate:date];
        NSInteger numberOfHeadPlaceholders = [self numberOfHeadPlaceholdersForMonth:month];
        NSDate *dateHead = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-numberOfHeadPlaceholders toDate:month.date options:0];
        JYMoodMonthDate *monthHead = [[JYMoodMonthDate alloc] initWithDate:dateHead];
        self.months[key] = month;
        self.monthHeads[key] = monthHead;
    }
    return month;
}

- (id <JYMoodDate>)monthHeadForSection:(NSInteger)section {
    NSNumber *key = @(section);
    id <JYMoodDate> monthHead = self.monthHeads[key];
    if (!monthHead) {
        NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:section toDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate].date options:0];
        JYMoodMonthDate *month = [[JYMoodMonthDate alloc] initWithDate:date];
        NSInteger numberOfHeadPlaceholders = [self numberOfHeadPlaceholdersForMonth:month];
        NSDate *dateHead = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-numberOfHeadPlaceholders toDate:month.date options:0];
        JYMoodMonthDate *monthHead = [[JYMoodMonthDate alloc] initWithDate:dateHead];
        self.months[key] = month;
        self.monthHeads[key] = monthHead;
    }
    return monthHead;
}

- (id <JYMoodDate>)weekForSection:(NSInteger)section {
    NSNumber *key = @(section);
    id <JYMoodDate> week = self.weeks[key];
    if (!week) {
        NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitWeekOfYear value:section toDate:[self.gregorian jy_firstDayOfWeek:self.minimumDate].date options:0];
        week = [[JYMoodWeekDate alloc] initWithDate:date];
        self.weeks[key] = week;
    }
    return week;
}

- (NSInteger)numberOfSectionsIn {
    switch (self.calendar.scope) {
        case JYCalendarScopeMonth: {
            return self.calendar.numberOfMonths;
        }
        case JYCalendarScopeWeek: {
            return self.calendar.numberOfWeeks;
        }
    }
}

- (NSInteger)numberOfHeadPlaceholdersForMonth:(id <JYMoodDate>)month {
    NSInteger currentWeekday = [self.gregorian component:NSCalendarUnitWeekday fromDate:month.date];
    NSInteger number = ((currentWeekday- self.gregorian.firstWeekday) + 7) % 7 ?: (7 * (!self.calendar.floatingMode&&(self.calendar.placeholderType == JYCalendarPlaceholderTypeFillSixRows)));
    return number;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (self.calendar.scope == JYCalendarScopeWeek) return 1;
    JYMoodMonthDate *monthDate = [self monthForSection:section];
    return [self numberOfRowsInMonth:monthDate];
}

- (JYCalendarMonthPosition)monthPositionForIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) return JYCalendarMonthPositionNotFound;
    if (self.calendar.scope == JYCalendarScopeWeek) {
        return JYCalendarMonthPositionCurrent;
    }
    id <JYMoodDate> date = [self dateForIndexPath:indexPath];
    id <JYMoodDate> page = [self pageForSection:indexPath.section];
    NSComparisonResult comparison = [self.gregorian compareDate:date.date toDate:page.date toUnitGranularity:NSCalendarUnitMonth];
    switch (comparison) {
        case NSOrderedAscending:
            return JYCalendarMonthPositionPrevious;
        case NSOrderedSame:
            return JYCalendarMonthPositionCurrent;
        case NSOrderedDescending:
            return JYCalendarMonthPositionNext;
    }
}

- (JYCalendarCoordinate)coordinateForIndexPath:(NSIndexPath *)indexPath {
    JYCalendarCoordinate coordinate;
    coordinate.row = indexPath.item / 7;
    coordinate.column = indexPath.item % 7;
    return coordinate;
}

- (void)clearCaches {
    [self.months removeAllObjects];
    [self.monthHeads removeAllObjects];
    [self.weeks removeAllObjects];
    [self.rowCounts removeAllObjects];
}

#pragma mark - Private functinos

- (void)didReceiveNotifications:(NSNotification *)notification {
    if ([notification.name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
        [self clearCaches];
    }
}

#pragma mark - Public functinos

- (id <JYMoodDate>)currentMonth {
    return self.calendar.currentPage;
}

- (void)adjustMonthPosition {
    [self.calendar adjustMonthPosition];
}

- (NSIndexPath *)indexPathForDate:(id <JYMoodDate>)date {
    return [self indexPathForDate:date atMonthPosition:JYCalendarMonthPositionCurrent scope:self.calendar.scope];
}

- (NSInteger)todayName {
    return self.calendar.todayName;
}

- (NSString *)dayNameForDate:(id <JYMoodDate>)date {
    NSString *dayName = @([self.gregorian component:NSCalendarUnitDay fromDate:date.date]).stringValue;
    return dayName;
}

- (NSInteger)currentMonthName {
    return self.calendar.currentMonthName;
}

- (NSString *)monthNameForMonth:(id <JYMoodDate>)month {
    NSString *text = [self.calendar.formatter stringFromDate:month.date];
    return text;
}

- (NSString *)dayNameForMonth:(id <JYMoodDate>)month index:(NSInteger)index {
    NSUInteger daysOffset = index;
    NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:daysOffset toDate:month.date options:0];
    if ([self.gregorian isDateInToday:date]) {
        return @"今";
    } else {
        NSString *text = @([self.gregorian component:NSCalendarUnitDay fromDate:date]).stringValue;
        return text;
    }
}

- (JYMoodMonthDate *)monthDateForIndex:(NSInteger)index {
    NSNumber *key = @(index);
    id <JYMoodDate> month = self.months[key];
    if (!month) {
        NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:index toDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate].date options:0];
        month = [[JYMoodMonthDate alloc] initWithDate:date];
        NSInteger numberOfHeadPlaceholders = [self numberOfHeadPlaceholdersForMonth:month];
        NSDate *dateHead = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-numberOfHeadPlaceholders toDate:month.date options:0];
        id <JYMoodDate> monthHead = [[JYMoodMonthDate alloc] initWithDate:dateHead];
        self.months[key] = month;
        self.monthHeads[key] = monthHead;
    }
    return month;
}

- (NSInteger)numberOfRowsInMonth:(id <JYMoodDate>)month {
    if (!month) return 0;
    if (self.calendar.placeholderType == JYCalendarPlaceholderTypeFillSixRows) return 6;

    NSNumber *rowCount = self.rowCounts[month];
    if (rowCount == nil) {
        NSInteger numberOfDaysInMonth = [self.gregorian jy_numberOfDaysInMonth:month];
        rowCount = @(numberOfDaysInMonth);
        self.rowCounts[month] = rowCount;
    }
    return rowCount.integerValue;
}

- (id <JYMoodDate>)dateForIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) return nil;
    return [self dateForIndexPath:indexPath scope:self.calendar.scope];
}

#pragma mark - JYCalendarDelegate

- (void)calendar:(JYCalendar *)calendar scrollToDate:(id <JYMoodDate>)date animated:(BOOL)animated {

    NSInteger scrollOffset = [self indexPathForDate:date atMonthPosition:JYCalendarMonthPositionCurrent].section;
    if ([self.delegate respondsToSelector:@selector(calendarCalculator:setContentOffset:animated:)]) {
        [self.delegate calendarCalculator:self setContentOffset:scrollOffset animated:animated];
    }
}

@end
