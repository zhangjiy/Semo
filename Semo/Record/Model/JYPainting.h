//
//  JYPainting.h
//  Semo
//
//  Created by jiyang on 2022/3/21.
//

#import <Foundation/Foundation.h>
#import "JYPopupMenuListDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class UIColor, JYMenuLocal;

@interface JYPaintingItem : NSObject <JYPopupMenuListDataProtocol>
@property (nonatomic, assign, readonly) JYPaintingType type;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString * title;
@end


@interface JYPainting : NSObject
@property (nonatomic, strong) NSArray <JYPaintingItem *> * plantings;
@end

NS_ASSUME_NONNULL_END
