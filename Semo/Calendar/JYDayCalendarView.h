//
//  JYDayCalendarView.h
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import <UIKit/UIKit.h>
#import "JYCalendarCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYDayCalendarView : UIView
@property (nonatomic, strong) NSDate * month;
@property (nonatomic, strong) JYCalendarCalculator * calculator;
@end

NS_ASSUME_NONNULL_END
