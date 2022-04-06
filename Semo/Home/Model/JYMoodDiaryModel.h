//
//  JYMoodDiaryModel.h
//  Semo
//
//  Created by jiyang on 2022/4/5.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN

#define kJYMoodDiaryTableName @"JYMoodDiaryTableName"

@interface JYMoodDiaryModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <NSString *> * moods;
@end

NS_ASSUME_NONNULL_END
