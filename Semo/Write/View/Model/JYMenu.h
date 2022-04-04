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
    JYPaintingTypeColor,
    JYPaintingTypeSize,
    JYPaintingTypePen,
    JYPaintingTypeUndo,
};

typedef NS_ENUM(NSInteger, JYFeelingStyleType) {
    JYFeelingStyleTypePass = 0,
    JYFeelingStyleTypeADR,
    JYFeelingStyleTypeSell,
    JYFeelingStyleTypeLove,
    JYFeelingStyleTypeEllipse,
    JYFeelingStyleTypeRectangle,
    JYFeelingStyleTypeRhombus,
    JYFeelingStyleTypeHexagon
};

@interface JYMenu : NSObject
@property (nonatomic, assign, readonly) JYPaintingType type;
@property (nonatomic, assign) JYFeelingStyleType styleType;
@property (nonatomic, assign) NSString  * name;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, strong) UIImage * image;
- (instancetype)initWithType:(JYPaintingType)type;
@end

NS_ASSUME_NONNULL_END
