//
//  JYCalculator.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "JYCalendar.h"
#import "NSCalendar+JYCalendarExtensions.h"

@interface JYCalendar()
@property (nonatomic, strong) NSTimeZone *timeZone;

@property (nonatomic, copy) NSLocale *locale;

@property (nonatomic, strong) id <JYMoodDate> sameMonth;

@property (nonatomic, strong) id <JYMoodDate> minimumDate;
@property (nonatomic, strong) id <JYMoodDate> maximumDate;

@property (nonatomic, assign) BOOL needsRequestingBoundingDates;
@end

@implementation JYCalendar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _needsRequestingBoundingDates = YES;
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"yyyy-MM-dd";
    _locale = [NSLocale currentLocale];
    _timeZone = [NSTimeZone defaultTimeZone];
    [self invalidateDateTools];
    
    NSDate *dayDate = [self.gregorian startOfDayForDate:[NSDate date]];
    _today = [[JYMoodMonthDate alloc] initWithDate:dayDate];
    
    _currentMonth = [self.gregorian jy_firstDayOfMonth:_today];
    _sameMonth = [self.gregorian jy_firstDayOfMonth:_today];

    _minimumDate = [[JYMoodMonthDate alloc] initWithDate:[self.formatter dateFromString:@"2022-01-01"]];
    _maximumDate = [[JYMoodMonthDate alloc] initWithDate:[self.formatter dateFromString:@"2022-12-31"]];
    [self requestBoundingDatesIfNecessary];
    
}

- (void)invalidateDateTools {
    _gregorian.locale = _locale;
    _gregorian.timeZone = _timeZone;
    _formatter.calendar = _gregorian;
    _formatter.timeZone = _timeZone;
    _formatter.locale = _locale;
}

- (BOOL)requestBoundingDatesIfNecessary {
    if (_needsRequestingBoundingDates) {
        _needsRequestingBoundingDates = NO;
        self.formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *newMin = [self.formatter dateFromString:@"2022-01-01"];
        newMin = [self.gregorian startOfDayForDate:newMin];
        NSDate *newMax = [self.formatter dateFromString:@"2022-12-31"];
        newMax = [self.gregorian startOfDayForDate:newMax];
        
        NSAssert([self.gregorian compareDate:newMin toDate:newMax toUnitGranularity:NSCalendarUnitDay] != NSOrderedDescending, @"The minimum date of calendar should be earlier than the maximum.");
        
        BOOL res = ![self.gregorian isDate:newMin inSameDayAsDate:_minimumDate.date] || ![self.gregorian isDate:newMax inSameDayAsDate:_maximumDate.date];
        
        _minimumDate = [[JYMoodMonthDate alloc] initWithDate:newMin];
        _maximumDate = [[JYMoodMonthDate alloc] initWithDate:newMax];
        [self reloadDate];
        
        return res;
    }
    return NO;
}

- (void)reloadDate {
    id <JYMoodDate> firstDayOfMonth = [self.gregorian jy_firstDayOfMonth:self.minimumDate];
    _numberOfMonths = [self.gregorian components:NSCalendarUnitMonth fromDate:firstDayOfMonth.date toDate:self.maximumDate.date options:0].month+1;
}

- (void)adjustMonthPosition {
    [self requestBoundingDatesIfNecessary];
    [self scrollToPageForDate:self.sameMonth animated:NO];
}

- (void)endScroll:(NSInteger)index {
    id <JYMoodDate> minimumPage = [self.gregorian jy_firstDayOfMonth:_minimumDate];
    NSDate *targetPage = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:index toDate:minimumPage.date options:0];
    BOOL shouldTriggerPageChange = [self isDateInDifferentPage:targetPage];
    if (shouldTriggerPageChange) {
        _currentMonth = [[JYMoodMonthDate alloc] initWithDate:targetPage];
    }
}

- (void)scrollToPageForDate:(id <JYMoodDate>)date animated:(BOOL)animated {
    if (!date) return;
    if (![self isDateInRange:date]) {
        date = [self safeDateForDate:date];
        if (!date) return;
    }
    if (!_minimumDate || !_maximumDate) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(calendar:scrollToDate:animated:)]) {
        [self.delegate calendar:self scrollToDate:date animated:animated];
    }
}

- (BOOL)isDateInRange:(id <JYMoodDate>)date {
    BOOL flag = YES;
    flag &= [self.gregorian components:NSCalendarUnitDay fromDate:date.date toDate:self.minimumDate.date options:0].day <= 0;
    flag &= [self.gregorian components:NSCalendarUnitDay fromDate:date.date toDate:self.maximumDate.date options:0].day >= 0;;
    return flag;
}

- (id <JYMoodDate>)safeDateForDate:(id <JYMoodDate>)date {
    if ([self.gregorian compareDate:date.date toDate:self.minimumDate.date toUnitGranularity:NSCalendarUnitDay] == NSOrderedAscending) {
        date = self.minimumDate;
    } else if ([self.gregorian compareDate:date.date toDate:self.maximumDate.date toUnitGranularity:NSCalendarUnitDay] == NSOrderedDescending) {
        date = self.maximumDate;
    }
    return date;
}

- (BOOL)isDateInDifferentPage:(NSDate *)date {
    return ![self.gregorian isDate:date equalToDate:_currentMonth.date toUnitGranularity:NSCalendarUnitMonth];
}

@end
