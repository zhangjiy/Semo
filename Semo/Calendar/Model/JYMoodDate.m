//
//  JYMoodDate.m
//  Semo
//
//  Created by jiyang on 2022/4/7.
//

#import "JYMoodDate.h"
#import "JYMonthMood.h"

@implementation JYMoodDate
@synthesize date = _date;
@synthesize name = _name;
@synthesize dateType = _dateType;
@synthesize gregorian = _gregorian;
@synthesize formatter = _formatter;

- (instancetype)initWithDate:(NSDate *)date {
    if (self = [super init]) {
        _date = date;
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"yyyy-MM-dd";
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if ([super init]) {

    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [[[self class] alloc] init];
}

@end

@implementation JYMoodMonthDate

- (NSString *)name {
    NSString *year = @([self.gregorian component:NSCalendarUnitYear fromDate:self.date]).stringValue;
    NSString *month = [self.formatter stringFromDate:self.date];
    NSString *name = [NSString stringWithFormat:@"%@_%@", year, month];
    return name;
}

- (NSString *)tableName {
    NSDate *date = [NSDate now];
    NSString *year = @([self.gregorian component:NSCalendarUnitYear fromDate:date]).stringValue;
    return year;
}

- (JYMoodDateType)dateType {
    return JYMoodDateTypeMonth;
}

- (JYMonthMood *)monthMood {
    if (![JYMonthMood bg_isExistForTableName:self.tableName]) {
        _monthMood = [[JYMonthMood alloc] initWithName:self.name];
        _monthMood.bg_tableName = self.tableName;
    }
    
    if (!_monthMood) {
        NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"name"),bg_sqlValue(self.name)];
        NSArray *arr = [JYMonthMood bg_find:self.tableName where:where];
        if (arr.count == 0) {
            _monthMood = arr.firstObject;
        } else {
            _monthMood = [[JYMonthMood alloc] initWithName:self.name];
            _monthMood.bg_tableName = self.tableName;
        }
    }
       
    return _monthMood;
}

@end


@implementation JYMoodWeekDate

- (JYMoodDateType)dateType {
    return JYMoodDateTypeDay;
}

@end

@implementation JYMoodDayDate

- (JYMoodDateType)dateType {
    return JYMoodDateTypeWeek;
}

@end

