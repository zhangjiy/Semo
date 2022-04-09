//
//  JYMoodDate.m
//  Semo
//
//  Created by jiyang on 2022/4/7.
//

#import "JYMoodDate.h"
#import "JYMonthMood.h"

@implementation JYMoodMonthDate
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
//    [aCoder encodeObject:_leftFilterPath forKey:@"_leftFilterPath"];
//    [aCoder encodeObject:_rightFilterPath forKey:@"_rightFilterPath"];
//    [aCoder encodeFloat:_leftRatio forKey:@"_leftRatio"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if ([super init]) {
//        _leftFilterPath = [aDecoder decodeObjectForKey:@"_leftFilterPath"];
//        _rightFilterPath = [aDecoder decodeObjectForKey:@"_rightFilterPath"];
//        _leftRatio = [aDecoder decodeFloatForKey:@"_leftRatio"];
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    JYMoodMonthDate *date = [[JYMoodMonthDate alloc] init];
//    filter.leftFilterPath = _leftFilterPath;
//    filter.rightFilterPath = _rightFilterPath;
//    filter.leftRatio = _leftRatio;
    return date;
}

- (NSString *)name {
    NSString *year = @([self.gregorian component:NSCalendarUnitYear fromDate:self.date]).stringValue;
    _formatter.dateFormat = @"yyyy-MM-dd";
    NSString *month = [self.formatter stringFromDate:self.date];
    NSString *name = [NSString stringWithFormat:@"%@_%@", year, month];
    return name;
}

- (JYMoodDateType)dateType {
    return JYMoodDateTypeMonth;
}

- (JYMonthMood *)monthMood {
    if (![JYMonthMood bg_isExistForTableName:kJYMonthMoodTableName]) {
        _monthMood = [[JYMonthMood alloc] initWithName:self.name];
        _monthMood.bg_tableName = kJYMonthMoodTableName;
        [_monthMood bg_save];
    }
    
    if (!_monthMood) {
        NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"name"),bg_sqlValue(self.name)];
        NSArray *arr = [JYMonthMood bg_find:kJYMonthMoodTableName where:where];
        _monthMood = arr.firstObject;
    }
       
    return _monthMood;
}

@end


@implementation JYMoodWeekDate

@synthesize date = _date;
@synthesize name = _name;
@synthesize dateType = _dateType;
@synthesize gregorian = _gregorian;
@synthesize formatter = _formatter;

- (instancetype)initWithDate:(NSDate *)date {
    if (self = [super init]) {
        _date = date;
    }
    
    return self;
}


- (void)encodeWithCoder:(nonnull NSCoder *)coder {

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if ([super init]) {

    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    JYMoodWeekDate *date = [[JYMoodWeekDate alloc] init];
    return date;
}

@end
