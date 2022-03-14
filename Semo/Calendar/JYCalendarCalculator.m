//
//  JYCalendarCalculator.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "JYCalendarCalculator.h"
#import "NSCalendar+JYCalendarExtensions.h"

@interface JYCalendarCalculator () <JYCalendarDelegate>

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSDate *> *months;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSDate *> *monthHeads;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSDate *> *weeks;
@property (nonatomic, strong) NSMutableDictionary<NSDate *, NSNumber *> *rowCounts;

@property (nonatomic, readonly) NSCalendar *gregorian;
@property (nonatomic, readonly) NSDate *minimumDate;
@property (nonatomic, readonly) NSDate *maximumDate;

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

- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath scope:(JYCalendarScope)scope {
    if (!indexPath) return nil;
    switch (scope) {
        case JYCalendarScopeMonth: {
            NSDate *head = [self monthHeadForSection:indexPath.section];
            NSUInteger daysOffset = indexPath.item;
            NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:daysOffset toDate:head options:0];
            return date;
            break;
        }
        case JYCalendarScopeWeek: {
            NSDate *currentPage = [self weekForSection:indexPath.section];
            NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:indexPath.item toDate:currentPage options:0];
            return date;
        }
    }
    return nil;
}

- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) return nil;
    return [self dateForIndexPath:indexPath scope:self.calendar.scope];
}

- (NSIndexPath *)indexPathForDate:(NSDate *)date {
    return [self indexPathForDate:date atMonthPosition:JYCalendarMonthPositionCurrent scope:self.calendar.scope];
}

- (NSIndexPath *)indexPathForDate:(NSDate *)date scope:(JYCalendarScope)scope {
    return [self indexPathForDate:date atMonthPosition:JYCalendarMonthPositionCurrent scope:scope];
}

- (NSIndexPath *)indexPathForDate:(NSDate *)date atMonthPosition:(JYCalendarMonthPosition)position scope:(JYCalendarScope)scope {
    if (!date) return nil;
    NSInteger item = 0;
    NSInteger section = 0;
    switch (scope) {
        case JYCalendarScopeMonth: {
            section = [self.gregorian components:NSCalendarUnitMonth fromDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate] toDate:[self.gregorian jy_firstDayOfMonth:date] options:0].month;
            if (position == JYCalendarMonthPositionPrevious) {
                section++;
            } else if (position == JYCalendarMonthPositionNext) {
                section--;
            }
            NSDate *head = [self monthHeadForSection:section];
            item = [self.gregorian components:NSCalendarUnitDay fromDate:head toDate:date options:0].day;
            break;
        }
        case JYCalendarScopeWeek: {
            section = [self.gregorian components:NSCalendarUnitWeekOfYear fromDate:[self.gregorian jy_firstDayOfWeek:self.minimumDate] toDate:[self.gregorian jy_firstDayOfWeek:date] options:0].weekOfYear;
            item = (([self.gregorian component:NSCalendarUnitWeekday fromDate:date] - self.gregorian.firstWeekday) + 7) % 7;
            break;
        }
    }
    if (item < 0 || section < 0) {
        return nil;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    return indexPath;
}

- (NSIndexPath *)indexPathForDate:(NSDate *)date atMonthPosition:(JYCalendarMonthPosition)position {
    return [self indexPathForDate:date atMonthPosition:position scope:self.calendar.scope];
}

- (NSDate *)pageForSection:(NSInteger)section {
    switch (self.calendar.scope) {
        case JYCalendarScopeWeek:
            return [self.gregorian jy_middleDayOfWeek:[self weekForSection:section]];
        case JYCalendarScopeMonth:
            return [self monthForSection:section];
        default:
            break;
    }
}

- (NSDate *)monthForSection:(NSInteger)section {
    NSNumber *key = @(section);
    NSDate *month = self.months[key];
    if (!month) {
        month = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:section toDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate] options:0];
        NSInteger numberOfHeadPlaceholders = [self numberOfHeadPlaceholdersForMonth:month];
        NSDate *monthHead = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-numberOfHeadPlaceholders toDate:month options:0];
        self.months[key] = month;
        self.monthHeads[key] = monthHead;
    }
    return month;
}

- (NSDate *)monthHeadForSection:(NSInteger)section {
    NSNumber *key = @(section);
    NSDate *monthHead = self.monthHeads[key];
    if (!monthHead) {
        NSDate *month = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:section toDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate] options:0];
        NSInteger numberOfHeadPlaceholders = [self numberOfHeadPlaceholdersForMonth:month];
        monthHead = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-numberOfHeadPlaceholders toDate:month options:0];
        self.months[key] = month;
        self.monthHeads[key] = monthHead;
    }
    return monthHead;
}

- (NSDate *)weekForSection:(NSInteger)section {
    NSNumber *key = @(section);
    NSDate *week = self.weeks[key];
    if (!week) {
        week = [self.gregorian dateByAddingUnit:NSCalendarUnitWeekOfYear value:section toDate:[self.gregorian jy_firstDayOfWeek:self.minimumDate] options:0];
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

- (NSInteger)numberOfHeadPlaceholdersForMonth:(NSDate *)month {
    NSInteger currentWeekday = [self.gregorian component:NSCalendarUnitWeekday fromDate:month];
    NSInteger number = ((currentWeekday- self.gregorian.firstWeekday) + 7) % 7 ?: (7 * (!self.calendar.floatingMode&&(self.calendar.placeholderType == JYCalendarPlaceholderTypeFillSixRows)));
    return number;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (self.calendar.scope == JYCalendarScopeWeek) return 1;
    NSDate *month = [self monthForSection:section];
    return [self numberOfRowsInMonth:month];
}

- (JYCalendarMonthPosition)monthPositionForIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) return JYCalendarMonthPositionNotFound;
    if (self.calendar.scope == JYCalendarScopeWeek) {
        return JYCalendarMonthPositionCurrent;
    }
    NSDate *date = [self dateForIndexPath:indexPath];
    NSDate *page = [self pageForSection:indexPath.section];
    NSComparisonResult comparison = [self.gregorian compareDate:date toDate:page toUnitGranularity:NSCalendarUnitMonth];
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

//- (void)reloadSections {
//    self.numberOfMonths = [self.gregorian components:NSCalendarUnitMonth fromDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate] toDate:self.maximumDate options:0].month+1;
//    self.numberOfWeeks = [self.gregorian components:NSCalendarUnitWeekOfYear fromDate:[self.gregorian jy_firstDayOfWeek:self.minimumDate] toDate:self.maximumDate options:0].weekOfYear+1;
//    [self clearCaches];
//}

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

- (void)adjustMonthPosition {
    [self.calendar adjustMonthPosition];
}

- (NSString *)monthTextForMonth:(NSDate *)month {
    NSString *text = [self.calendar.formatter stringFromDate:month];
    return text;
}

- (NSString *)dayTextForMonth:(NSDate *)month index:(NSInteger)index {
    NSUInteger daysOffset = index;
    NSDate *date = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:daysOffset toDate:month options:0];
    if ([self.gregorian isDateInToday:date]) {
        return @"今";
    } else {
        NSString *text = @([self.gregorian component:NSCalendarUnitDay fromDate:date]).stringValue;
        return text;
    }
}

- (NSDate *)monthDateForIndex:(NSInteger)index {
    NSNumber *key = @(index);
    NSDate *month = self.months[key];
    if (!month) {
        month = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:index toDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate] options:0];
        NSInteger numberOfHeadPlaceholders = [self numberOfHeadPlaceholdersForMonth:month];
        NSDate *monthHead = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-numberOfHeadPlaceholders toDate:month options:0];
        self.months[key] = month;
        self.monthHeads[key] = monthHead;
    }
    return month;
}

- (NSInteger)numberOfRowsInMonth:(NSDate *)month {
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

#pragma mark - JYCalendarDelegate

- (void)calendar:(JYCalendar *)calendar scrollToDate:(NSDate *)date animated:(BOOL)animated {
    //animated &= _scrollEnabled; // No animation if _scrollEnabled == NO;

    NSInteger scrollOffset = [self indexPathForDate:date atMonthPosition:JYCalendarMonthPositionCurrent].section;
    if ([self.delegate respondsToSelector:@selector(calendarCalculator:setContentOffset:animated:)]) {
        [self.delegate calendarCalculator:self setContentOffset:scrollOffset animated:animated];
    }
}

@end
