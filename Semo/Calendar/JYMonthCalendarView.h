//
//  JYMonthCalendarView.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "JYCalendarCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMonthCalendarView : UIView
- (instancetype)initWithFrame:(CGRect)frame calendar:(JYCalendar *)calendar;
@end

NS_ASSUME_NONNULL_END
