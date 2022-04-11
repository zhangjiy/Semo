//
//  NSCalendar+JYCalendarExtensions.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <Foundation/Foundation.h>
#import "JYMoodDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (JYCalendarExtensions)

- (nullable id <JYMoodDate>)jy_firstDayOfMonth:(id <JYMoodDate>)month;
- (nullable id <JYMoodDate>)jy_lastDayOfMonth:(id <JYMoodDate>)month;
- (nullable id <JYMoodDate>)jy_firstDayOfWeek:(id <JYMoodDate>)week;
- (nullable id <JYMoodDate>)jy_lastDayOfWeek:(id <JYMoodDate>)week;
- (nullable id <JYMoodDate>)jy_middleDayOfWeek:(id <JYMoodDate>)week;
- (NSInteger)jy_numberOfDaysInMonth:(id <JYMoodDate>)month;

@end

NS_ASSUME_NONNULL_END
