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

typedef NS_ENUM(NSInteger, JYMoodStyleType) {
    JYMoodStyleTypePass = 0,
    JYMoodStyleTypeADR,
    JYMoodStyleTypeSell,
    JYMoodStyleTypeLove,
    JYMoodStyleTypeEllipse,
    JYMoodStyleTypeRectangle,
    JYMoodStyleTypeRhombus,
    JYMoodStyleTypeHexagon
};

@interface JYMenu : NSObject
@property (nonatomic, assign, readonly) JYPaintingType type;
@property (nonatomic, assign) JYMoodStyleType styleType;
@property (nonatomic, assign) NSString  * name;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) UIImage * sizeImage;
- (instancetype)initWithType:(JYPaintingType)type;
@end

NS_ASSUME_NONNULL_END
