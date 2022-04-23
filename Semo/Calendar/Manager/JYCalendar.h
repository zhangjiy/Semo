//
//  JYCalculator.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSInteger const MonthsAgo = 11;

typedef NS_ENUM(NSUInteger, JYCalendarScope) {
    JYCalendarScopeMonth,
};

typedef NS_ENUM(NSUInteger, JYCalendarPlaceholderType) {
    JYCalendarPlaceholderTypeNone          = 0,
    JYCalendarPlaceholderTypeFillHeadTail  = 1,
    JYCalendarPlaceholderTypeFillSixRows   = 2
};

@class JYCalendar;
@protocol JYMoodDate;

@protocol JYCalendarDelegate <NSObject>
@optional
- (void)calendar:(JYCalendar *)calendar scrollToDate:(id <JYMoodDate>)date animated:(BOOL)animated;

@end

@interface JYCalendar : NSObject

@property (nonatomic, weak) id <JYCalendarDelegate> delegate;

@property (nonatomic, assign, readonly) NSInteger numberOfMonths;
@property (nonatomic, assign, readonly) NSInteger currentPage;

@property (nonatomic, strong, readonly) id <JYMoodDate> currentMonth;
@property (nonatomic, strong, readonly) id <JYMoodDate> sameMonth;
@property (nonatomic, strong, readonly) id <JYMoodDate> today;
@property (nonatomic, strong) NSCalendar *gregorian;
@property (nonatomic, strong) NSDateFormatter *formatter;

- (void)adjustMonthPosition;
- (void)endScroll:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
