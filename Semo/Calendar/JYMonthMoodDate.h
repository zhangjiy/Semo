//
//  JYMonthMoodDate.h
//  Semo
//
//  Created by jiyang on 2022/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JYMoodDate <NSObject>

@end

@interface JYMonthMoodDate : NSObject

@property (nonatomic, strong, readonly) NSDate * date;

- (instancetype)initWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
