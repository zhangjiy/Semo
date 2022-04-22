//
//  JYCalendarCalculator.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JYCalendar.h"
#import "JYMoodDate.h"

NS_ASSUME_NONNULL_BEGIN

struct JYCalendarCoordinate {
    NSInteger row;
    NSInteger column;
};
typedef struct JYCalendarCoordinate JYCalendarCoordinate;

typedef NS_ENUM(NSUInteger, JYCalendarMonthPosition) {
    JYCalendarMonthPositionPrevious,
    JYCalendarMonthPositionCurrent,
    JYCalendarMonthPositionNext,
    
    JYCalendarMonthPositionNotFound = NSNotFound
};

@class JYCalendarCalculator;

@protocol JYCalendarCalculatorDelegate <NSObject>
@optional
- (void)calendarCalculator:(JYCalendarCalculator *)calculator setContentOffset:(NSInteger)scrollOffset animated:(BOOL)animated;

@end

@interface JYCalendarCalculator : NSObject

@property (nonatomic, weak) id <JYCalendarCalculatorDelegate> delegate;

@property (nonatomic, assign, readonly) NSInteger numberOfMonths;
@property (nonatomic, strong, readonly) id <JYMoodDate> currentMonth;
@property (nonatomic, strong, readonly) id <JYMoodDate> sameMonth;
@property (nonatomic, strong, readonly) id <JYMoodDate> today;
@property (nonatomic, assign, readonly) NSInteger currentMonthName;
@property (nonatomic, assign, readonly) NSInteger sameMonthName;
@property (nonatomic, assign, readonly) NSInteger todayName;

- (void)adjustMonthPosition;

- (NSString *)yearNameForMonth:(id <JYMoodDate>)month;

- (NSInteger)numberOfRowsInMonth:(id <JYMoodDate>)month;
- (NSString *)monthNameForMonth:(id <JYMoodDate>)month;

- (NSString *)dayNameForMonth:(id <JYMoodDate>)month index:(NSInteger)index;
- (NSString *)dayNameForDate:(id <JYMoodDate>)date;

- (JYMoodMonthDate *)monthDateForIndex:(NSInteger)index;
- (id <JYMoodDate>)dayDayForIndex:(NSInteger)index;

- (BOOL)isToday:(id <JYMoodDate>)month index:(NSInteger)index;

- (void)endScroll:(NSInteger)index;

extern NSInteger JYCalendarDataIndexFromDateName(NSInteger value);

@end



NS_ASSUME_NONNULL_END
