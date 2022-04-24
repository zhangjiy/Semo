//
//  JYMonthMood.h
//  Semo
//
//  Created by jiyang on 2022/4/6.
//

#import <Foundation/Foundation.h>
#import "JYDayMood.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMonthMood : NSObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDictionary <NSString *, JYDayMood *> * dayMoodDict;
- (instancetype)initWithTableName:(NSString *)tableName name:(NSString *)name;
- (void)saveDayMood:(nullable JYDayMood *)value forKey:(NSString *)key;
- (void)deleteDayMoodForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
