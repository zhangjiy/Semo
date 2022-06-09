//
//  JYMood.h
//  Semo
//
//  Created by jiyang on 2022/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JYMoodType) {
    JYMoodTypeXi,
    JYMoodTypeNu,
    JYMoodTypeYou,
    JYMoodTypeSi,
    JYMoodTypeBei,
    JYMoodTypeKong,
    JYMoodTypeJing
};

@interface JYMood : NSObject
@property (nonatomic, assign) JYMoodType type;
@property (nonatomic, strong) NSData *data;
- (instancetype)initWithType:(JYMoodType)type;
@end

NS_ASSUME_NONNULL_END
