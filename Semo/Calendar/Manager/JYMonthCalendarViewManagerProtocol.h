//
//  JYMonthCalendarViewManagerProtocol.h
//  Semo
//
//  Created by jiyang on 2022/4/10.
//

#ifndef JYMonthCalendarViewManagerProtocol_h
#define JYMonthCalendarViewManagerProtocol_h

#import "JYViewProtocol.h"
#import "JYCalendarCalculator.h"

@class JYMonthMood;
@protocol JYMonthCalendarViewManagerProtocol;

@protocol JYMonthCalendarViewDelegate <NSObject>
@optional
- (void)monthCalendarViewManager:(id <JYMonthCalendarViewManagerProtocol>)manager didSelectItemAtIndexPath:(NSString *)dayName;
@end


@protocol JYMonthCalendarViewManagerProtocol <JYViewProtocol>
@optional
@property (nonatomic, weak) id <JYMonthCalendarViewDelegate> delegate;
@property (nonatomic, strong, readonly) JYMoodMonthDate * currentMonth;
@property (nonatomic, strong, readonly) NSString * dayName;
@property (nonatomic, strong, readonly) NSString * todayName;

- (void)reloadDate;
@end

#endif /* JYMonthCalendarViewManagerProtocol_h */
