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

@property (nonatomic, assign) BOOL needRequestingBoundingDates;
@property (nonatomic, assign) BOOL needScrollToPage;
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
    _needRequestingBoundingDates = YES;
    _needScrollToPage = YES;
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"yyyy-MM-dd";
    _locale = [NSLocale currentLocale];
    _timeZone = [NSTimeZone defaultTimeZone];
    [self invalidateDateTools];
    
    _currentPage = MonthsAgo;
    
    NSDate *dayDate = [self.gregorian startOfDayForDate:[NSDate date]];
    _today = [[JYMoodMonthDate alloc] initWithDate:dayDate];
    _sameMonth = [self.gregorian jy_firstDayOfMonth:_today];

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
    if (_needRequestingBoundingDates) {
        _needRequestingBoundingDates = NO;
        NSDate *maxDate = _today.date;
        maxDate = [self.gregorian startOfDayForDate:maxDate];
        NSDate *minDate = [self.formatter dateFromString:[NSString stringWithFormat:@"%ld%@", OriginYear, @"-01-01"]];
        //NSDate *minDate = [self getPriousorLaterDateFromDate:maxDate withMonth:-MonthsAgo];
        minDate = [self.gregorian startOfDayForDate:minDate];
        
        NSAssert([self.gregorian compareDate:minDate toDate:maxDate toUnitGranularity:NSCalendarUnitDay] != NSOrderedDescending, @"The minimum date of calendar should be earlier than the maximum.");
        
        BOOL res = ![self.gregorian isDate:minDate inSameDayAsDate:_minimumDate.date] || ![self.gregorian isDate:maxDate inSameDayAsDate:_maximumDate.date];
        
        _minimumDate = [[JYMoodMonthDate alloc] initWithDate:minDate];
        _maximumDate = [[JYMoodMonthDate alloc] initWithDate:maxDate];
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
    _currentPage = index;
}

- (void)scrollToPageForDate:(id <JYMoodDate>)date animated:(BOOL)animated {
    if (_needScrollToPage) {
        _needScrollToPage = NO;
        if (!date) return;
        if (![self isDateInRange:date]) {
            date = [self safeDateForDate:date];
            if (!date) return;
        }
        if (!_minimumDate || !_maximumDate) {
            return;
        }
        _currentPage = [self monthFromDate:date] - 1;
        
        if ([self.delegate respondsToSelector:@selector(calendar:scrollToDate:animated:)]) {
            [self.delegate calendar:self scrollToDate:date animated:animated];
        }
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

- (NSDate*)getPriousorLaterDateFromDate:(NSDate*)date withMonth:(NSInteger)month{

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

- (NSInteger)monthFromDate:(id <JYMoodDate>)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:date.date];
    NSInteger month = [components month];
    return month;
}

@end

extern NSArray * JYYears(void) {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear= [[formatter stringFromDate:date] integerValue];
    if (currentYear < OriginYear) {
        return nil;
    }
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = OriginYear; i <= currentYear; i ++) {
        [mutableArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    return [mutableArray copy];
}

extern NSArray * JYMonths(void) {
    return @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
}
