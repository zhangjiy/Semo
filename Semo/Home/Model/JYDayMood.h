//
//  JYDayMood.h
//  Semo
//
//  Created by jiyang on 2022/4/5.
//

#import <Foundation/Foundation.h>
#import "JYMood.h"
#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN
@class UIImage;
@interface JYDayMood : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <JYMood *> * moods;
@property (nonatomic, strong, readonly) NSArray * dayMoodAnalysis;
- (instancetype)initWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
