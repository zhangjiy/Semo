//
//  JYCalculator.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JYCalendarScope) {
    JYCalendarScopeMonth,
    JYCalendarScopeWeek
};

typedef NS_ENUM(NSUInteger, JYCalendarPlaceholderType) {
    JYCalendarPlaceholderTypeNone          = 0,
    JYCalendarPlaceholderTypeFillHeadTail  = 1,
    JYCalendarPlaceholderTypeFillSixRows   = 2
};

@class JYCalendar;

@protocol JYCalendarDelegate <NSObject>
@optional
- (void)calendar:(JYCalendar *)calendar scrollToDate:(NSDate *)date animated:(BOOL)animated;

@end

@interface JYCalendar : NSObject

@property (nonatomic, weak) id <JYCalendarDelegate> delegate;

@property (nonatomic, strong) NSCalendar *gregorian;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, assign) NSInteger numberOfMonths;
@property (nonatomic, assign) NSInteger numberOfWeeks;

@property (nonatomic, assign) JYCalendarScope scope;
@property (nonatomic, assign) JYCalendarPlaceholderType placeholderType;
@property (nonatomic, assign) BOOL floatingMode;

- (void)adjustMonthPosition;
@end

NS_ASSUME_NONNULL_END
