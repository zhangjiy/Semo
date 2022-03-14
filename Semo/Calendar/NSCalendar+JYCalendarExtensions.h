//
//  NSCalendar+JYCalendarExtensions.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (JYCalendarExtensions)

- (nullable NSDate *)jy_firstDayOfMonth:(NSDate *)month;
- (nullable NSDate *)jy_lastDayOfMonth:(NSDate *)month;
- (nullable NSDate *)jy_firstDayOfWeek:(NSDate *)week;
- (nullable NSDate *)jy_lastDayOfWeek:(NSDate *)week;
- (nullable NSDate *)jy_middleDayOfWeek:(NSDate *)week;
- (NSInteger)jy_numberOfDaysInMonth:(NSDate *)month;

@end

NS_ASSUME_NONNULL_END
