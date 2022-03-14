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

@property (nullable, nonatomic, strong) NSDate *today;
@property (nonatomic, strong) NSDate *currentPage;

@property (nonatomic, readonly) NSDate *minimumDate;
@property (nonatomic, readonly) NSDate *maximumDate;

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
    //_firstWeekday = 1;
    [self invalidateDateTools];
    
    _today = [self.gregorian startOfDayForDate:[NSDate date]];
    _currentPage = [self.gregorian jy_firstDayOfMonth:_today];
    
    
    _minimumDate = [self.formatter dateFromString:@"2022-01-01"];
    _maximumDate = [self.formatter dateFromString:@"2022-12-31"];
    
    _scope = JYCalendarScopeMonth;
//    _selectedDates = [NSMutableArray arrayWithCapacity:1];
//    _visibleSectionHeaders = [NSMapTable weakToWeakObjectsMapTable];
    [self requestBoundingDatesIfNecessary];
    
}

- (void)invalidateDateTools {
    _gregorian.locale = _locale;
    _gregorian.timeZone = _timeZone;
    //_gregorian.firstWeekday = _firstWeekday;
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
        
        BOOL res = ![self.gregorian isDate:newMin inSameDayAsDate:_minimumDate] || ![self.gregorian isDate:newMax inSameDayAsDate:_maximumDate];
        _minimumDate = newMin;
        _maximumDate = newMax;
        [self reloadSections];
        
        return res;
    }
    return NO;
}

- (void)reloadSections {
    self.numberOfMonths = [self.gregorian components:NSCalendarUnitMonth fromDate:[self.gregorian jy_firstDayOfMonth:self.minimumDate] toDate:self.maximumDate options:0].month+1;
    self.numberOfWeeks = [self.gregorian components:NSCalendarUnitWeekOfYear fromDate:[self.gregorian jy_firstDayOfWeek:self.minimumDate] toDate:self.maximumDate options:0].weekOfYear+1;
    //[self clearCaches];
}

- (void)adjustMonthPosition {
    [self requestBoundingDatesIfNecessary];
    //NSDate *targetPage = self.pagingEnabled?self.currentPage:(self.currentPage?:self.selectedDate);
    [self scrollToPageForDate:self.currentPage animated:NO];
}

- (void)scrollToPageForDate:(NSDate *)date animated:(BOOL)animated {
    if (!date) return;
    if (![self isDateInRange:date]) {
        date = [self safeDateForDate:date];
        if (!date) return;
    }
    
    if (!self.floatingMode) {
//        if ([self isDateInDifferentPage:date]) {
//            [self willChangeValueForKey:@"currentPage"];
//            NSDate *lastPage = _currentPage;
//            switch (self.transitionCoordinator.representingScope) {
//                case FSCalendarScopeMonth: {
//                    _currentPage = [self.gregorian fs_firstDayOfMonth:date];
//                    break;
//                }
//                case FSCalendarScopeWeek: {
//                    _currentPage = [self.gregorian fs_firstDayOfWeek:date];
//                    break;
//                }
//            }
//            if (self.hasValidateVisibleLayout) {
//                [self.delegateProxy calendarCurrentPageDidChange:self];
//                if (_placeholderType != FSCalendarPlaceholderTypeFillSixRows && self.transitionCoordinator.state == FSCalendarTransitionStateIdle) {
//                    [self.transitionCoordinator performBoundingRectTransitionFromMonth:lastPage toMonth:_currentPage duration:0.33];
//                }
//            }
//            [self didChangeValueForKey:@"currentPage"];
//        }
        if (!_minimumDate || !_maximumDate) {
            return;
        }
        if ([self.delegate respondsToSelector:@selector(calendar:scrollToDate:animated:)]) {
            [self.delegate calendar:self scrollToDate:date animated:animated];
        }
    }
//    else {
//        [self scrollToDate:[self.gregorian fs_firstDayOfMonth:date] animated:animated];
//    }
}

- (BOOL)isDateInRange:(NSDate *)date {
    BOOL flag = YES;
    flag &= [self.gregorian components:NSCalendarUnitDay fromDate:date toDate:self.minimumDate options:0].day <= 0;
    flag &= [self.gregorian components:NSCalendarUnitDay fromDate:date toDate:self.maximumDate options:0].day >= 0;;
    return flag;
}

- (NSDate *)safeDateForDate:(NSDate *)date {
    if ([self.gregorian compareDate:date toDate:self.minimumDate toUnitGranularity:NSCalendarUnitDay] == NSOrderedAscending) {
        date = self.minimumDate;
    } else if ([self.gregorian compareDate:date toDate:self.maximumDate toUnitGranularity:NSCalendarUnitDay] == NSOrderedDescending) {
        date = self.maximumDate;
    }
    return date;
}

@end
