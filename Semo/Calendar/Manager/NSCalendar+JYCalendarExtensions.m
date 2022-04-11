//
//  NSCalendar+JYCalendarExtensions.m
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import "NSCalendar+JYCalendarExtensions.h"
#import <objc/runtime.h>

@implementation NSCalendar (JYCalendarExtensions)

- (nullable id <JYMoodDate>)jy_firstDayOfMonth:(id <JYMoodDate>)month {
    if (!month) return nil;
    NSDateComponents *components = [self components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:month.date];
    components.day = 1;
    JYMoodMonthDate *monthDate = [[JYMoodMonthDate alloc] initWithDate:[self dateFromComponents:components]];
    return monthDate;
}

- (nullable id <JYMoodDate>)jy_lastDayOfMonth:(id <JYMoodDate>)month {
    if (!month) return nil;
    NSDateComponents *components = [self components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:month.date];
    components.month++;
    components.day = 0;
    JYMoodMonthDate *monthDate = [[JYMoodMonthDate alloc] initWithDate:[self dateFromComponents:components]];
    return monthDate;
}

- (nullable id <JYMoodDate>)jy_firstDayOfWeek:(id <JYMoodDate>)week {
    if (!week) return nil;
    NSDateComponents *weekdayComponents = [self components:NSCalendarUnitWeekday fromDate:week.date];
    NSDateComponents *components = self.jy_privateComponents;
    components.day = - (weekdayComponents.weekday - self.firstWeekday);
    components.day = (components.day-7) % 7;
    NSDate *firstDayOfWeek = [self dateByAddingComponents:components toDate:week.date options:0];
    firstDayOfWeek = [self startOfDayForDate:firstDayOfWeek];
    components.day = NSIntegerMax;
    JYMoodWeekDate *weekDate = [[JYMoodWeekDate alloc] initWithDate:firstDayOfWeek];
    return weekDate;
}

- (nullable id <JYMoodDate>)jy_lastDayOfWeek:(NSDate *)week {
    if (!week) return nil;
    NSDateComponents *weekdayComponents = [self components:NSCalendarUnitWeekday fromDate:week];
    NSDateComponents *components = self.jy_privateComponents;
    components.day = - (weekdayComponents.weekday - self.firstWeekday);
    components.day = (components.day-7) % 7 + 6;
    NSDate *lastDayOfWeek = [self dateByAddingComponents:components toDate:week options:0];
    lastDayOfWeek = [self startOfDayForDate:lastDayOfWeek];
    components.day = NSIntegerMax;
    JYMoodWeekDate *weekDate = [[JYMoodWeekDate alloc] initWithDate:lastDayOfWeek];
    return weekDate;
}

- (nullable id <JYMoodDate>)jy_middleDayOfWeek:(id <JYMoodDate>)week {
    if (!week) return nil;
    NSDateComponents *weekdayComponents = [self components:NSCalendarUnitWeekday fromDate:week.date];
    NSDateComponents *componentsToSubtract = self.jy_privateComponents;
    componentsToSubtract.day = - (weekdayComponents.weekday - self.firstWeekday) + 3;
    // Fix https://github.com/WenchaoD/FSCalendar/issues/1100 and https://github.com/WenchaoD/FSCalendar/issues/1102
    // If firstWeekday is not 1, and weekday is less than firstWeekday, the middleDayOfWeek will be the middle day of next week
    if (weekdayComponents.weekday < self.firstWeekday) {
        componentsToSubtract.day = componentsToSubtract.day - 7;
    }
    NSDate *middleDayOfWeek = [self dateByAddingComponents:componentsToSubtract toDate:week.date options:0];
    NSDateComponents *components = [self components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:middleDayOfWeek];
    middleDayOfWeek = [self dateFromComponents:components];
    componentsToSubtract.day = NSIntegerMax;
    JYMoodWeekDate *weekDate = [[JYMoodWeekDate alloc] initWithDate:middleDayOfWeek];
    return weekDate;
}

- (NSInteger)jy_numberOfDaysInMonth:(id <JYMoodDate>)month {
    if (!month) return 0;
    NSRange days = [self rangeOfUnit:NSCalendarUnitDay
                                        inUnit:NSCalendarUnitMonth
                                       forDate:month.date];
    return days.length;
}

- (NSDateComponents *)jy_privateComponents {
    NSDateComponents *components = objc_getAssociatedObject(self, _cmd);
    if (!components) {
        components = [[NSDateComponents alloc] init];
        objc_setAssociatedObject(self, _cmd, components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return components;
}

@end
