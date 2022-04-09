//
//  JYMonthCalendarView.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "JYCalendarCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@class JYMonthMood;

@class JYMonthCalendarView;
@protocol JYMonthCalendarViewDelegate <NSObject>
@optional
- (void)monthCalendarView:(JYMonthCalendarView *)view didSelectItemAtIndexPath:(NSString *)dayName;
@end


@interface JYMonthCalendarView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, weak) id <JYMonthCalendarViewDelegate> delegate;
@property (nonatomic, strong, readonly) JYMoodMonthDate * currentMonth;
@property (nonatomic, strong, readonly) NSString * dayName;
@property (nonatomic, strong, readonly) NSString * todayName;

- (void)reloadDate;
@end

NS_ASSUME_NONNULL_END
