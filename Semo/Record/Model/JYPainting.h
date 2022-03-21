//
//  JYPainting.h
//  Semo
//
//  Created by jiyang on 2022/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JYPaintingType) {
    JYPaintingTypeStyle = 0,
    JYPaintingTypeSize,
    JYPaintingTypeColor,
    JYPaintingTypeUndo,
    JYPaintingTypeRedo,
    JYPaintingTypeClear,
};

@interface JYPaintingItem : NSObject
@property (nonatomic, assign) JYPaintingType type;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString *title;
@end

@interface JYPainting : NSObject
@property (nonatomic, strong) NSArray <JYPaintingItem *> * plantings;
@end

NS_ASSUME_NONNULL_END
