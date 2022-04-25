//
//  JYDayCalendarView.h
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import <UIKit/UIKit.h>
#import "JYCalendarCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@class JYDayCalendarView;
@protocol JYDayCalendarViewDelegate <NSObject>
@optional
- (void)dayCalendarView:(JYDayCalendarView *)view didSelectedItem:(id <JYMoodDate>)date didSelectedItemAtIndex:(NSInteger)index;
- (void)dayCalendarView:(JYDayCalendarView *)view didDeletedItem:(id <JYMoodDate>)date didDeletedItemAtIndex:(NSInteger)index;
@end

@interface JYDayCalendarView : UIView
@property (nonatomic, weak) id <JYDayCalendarViewDelegate> delegate;
@property (nonatomic, strong) JYMoodMonthDate * month;
@property (nonatomic, strong) JYCalendarCalculator * calculator;
@end

NS_ASSUME_NONNULL_END
