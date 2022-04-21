//
//  JYMenuLocal.h
//  Semo
//
//  Created by jiyang on 2022/4/19.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMenuLocal : NSObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign) NSInteger selectedIndex;
- (instancetype)initWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
