//
//  JYCalendarCalculator.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JYCalendar.h"

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

@property (nonatomic, readonly) NSInteger numberOfSectionsIn;

- (void)adjustMonthPosition;

- (NSInteger)numberOfRowsInMonth:(NSDate *)month;
- (NSString *)monthTextForMonth:(NSDate *)month;
- (NSString *)dayTextForMonth:(NSDate *)month index:(NSInteger)index;

- (NSDate *)monthDateForIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
