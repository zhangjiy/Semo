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

typedef NS_ENUM(NSUInteger, JYMonthCalendarJumpType) {
    JYMonthCalendarJumpTypeRecord,
    JYMonthCalendarJumpTypeDetail
};

@class JYMonthMood;
@protocol JYMonthCalendarViewManagerProtocol;

@protocol JYMonthCalendarViewDelegate <NSObject>
@optional
- (void)monthCalendarViewManager:(id <JYMonthCalendarViewManagerProtocol>)manager didSelectItemAtIndexPath:(NSString *)dayName jumpType:(JYMonthCalendarJumpType)jumpType;
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
