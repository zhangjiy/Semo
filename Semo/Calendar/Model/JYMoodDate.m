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
    return [NSString stringWithFormat:@"%@_%@", @"TableName", year];
}

- (JYMoodDateType)dateType {
    return JYMoodDateTypeMonth;
}

- (JYMonthMood *)monthMood {
    if (!_monthMood) {
        _monthMood = [[JYMonthMood alloc] initWithTableName:self.tableName name:self.name];
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

