//
//  JYPainting.h
//  Semo
//
//  Created by jiyang on 2022/3/21.
//

#import <Foundation/Foundation.h>
#import "JYPopupListMenuDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class UIColor;

typedef NS_ENUM(NSInteger, JYPaintingType) {
    JYPaintingTypeStyle = 0,
    JYPaintingTypeSize,
    JYPaintingTypeColor,
    JYPaintingTypeUndo,
    JYPaintingTypeRedo,
    JYPaintingTypeClear,
};

@interface JYPaintingItem : NSObject <JYPopupListMenuDataProtocol>
@property (nonatomic, assign) JYPaintingType type;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString * title;
@end

@interface JYPainting : NSObject
@property (nonatomic, strong) NSArray <JYPaintingItem *> * plantings;
@end

NS_ASSUME_NONNULL_END
