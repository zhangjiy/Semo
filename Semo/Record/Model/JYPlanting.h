//
//  JYPainting.h
//  Semo
//
//  Created by jiyang on 2022/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYPaintingItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL enabled;
@end

@interface JYPainting : NSObject
@property (nonatomic, strong) NSArray <JYPaintingItem *> * plantings;
@end

NS_ASSUME_NONNULL_END
