//
//  JYMenu.h
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JYPaintingType) {
    JYPaintingTypeStyle = 0,
    JYPaintingTypeSize,
    JYPaintingTypeColor,
    JYPaintingTypeUndo,
    JYPaintingTypeRedo,
    JYPaintingTypeClear,
};

@interface JYMenu : NSObject
@property (nonatomic, assign, readonly) JYPaintingType type;
@property (nonatomic, assign) NSString  * name;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * color;
- (instancetype)initWithType:(JYPaintingType)type;
@end

NS_ASSUME_NONNULL_END