//
//  JYMoodDate.h
//  Semo
//
//  Created by jiyang on 2022/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JYMoodDateType) {
    JYMoodDateTypeUnknown = 0,
    JYMoodDateTypeMonth,
    JYMoodDateTypeWeek,
    JYMoodDateTypeDay
};

@class JYMoodMonthDate, JYMonthMood, JYMoodDayDate;

@protocol JYMoodDate <NSObject, NSCoding, NSCopying>
@property (nonatomic, strong, readonly) NSDate * date;
@property (nonatomic, assign, readonly) JYMoodDateType dateType;
@property (nonatomic, strong, readonly) NSString * name;
@property (nonatomic, strong) NSCalendar *gregorian;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@interface JYMoodDate : NSObject <JYMoodDate>
- (instancetype)initWithDate:(NSDate *)date;
@end

@interface JYMoodMonthDate : JYMoodDate
@property (nonatomic, strong) JYMonthMood * monthMood;
@property (nonatomic, strong, readonly) NSArray * monthMoodAnalysis;
@end

@interface JYMoodWeekDate : JYMoodDate
@end

@interface JYMoodDayDate : JYMoodDate
@end


NS_ASSUME_NONNULL_END
