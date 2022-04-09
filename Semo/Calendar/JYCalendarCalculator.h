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

- (instancetype)initWithCalendar:(JYCalendar *)calendar;

@property (nonatomic, weak) id <JYCalendarCalculatorDelegate> delegate;

@property (nonatomic, strong, readonly) id <JYMoodDate> currentMonth;
@property (nonatomic, assign, readonly) NSInteger currentMonthName;
@property (nonatomic, assign, readonly) NSInteger numberOfSectionsIn;
@property (nonatomic, assign, readonly) NSInteger todayName;

- (void)adjustMonthPosition;

- (NSInteger)numberOfRowsInMonth:(id <JYMoodDate>)month;
- (NSString *)monthNameForMonth:(id <JYMoodDate>)month;

- (NSString *)dayNameForMonth:(id <JYMoodDate>)month index:(NSInteger)index;
- (NSString *)dayNameForDate:(id <JYMoodDate>)date;

- (JYMoodMonthDate *)monthDateForIndex:(NSInteger)index;
- (id <JYMoodDate>)dateForIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
