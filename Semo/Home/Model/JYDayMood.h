//
//  JYDayMood.h
//  Semo
//
//  Created by jiyang on 2022/4/5.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN
@class UIImage;
@interface JYDayMood : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <NSData *> * moods;
- (instancetype)initWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
