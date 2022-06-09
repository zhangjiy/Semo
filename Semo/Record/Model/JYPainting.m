//
//  JYPainting.m
//  Semo
//
//  Created by jiyang on 2022/3/21.
//

#import "JYPainting.h"
#import "JYMenuLocal.h"

@implementation JYPaintingItem
@synthesize menus = _menus;
@synthesize menuLocal = _menuLocal;

- (instancetype)initWithType:(JYPaintingType)type {
    if (self = [super init]) {
        _type = type;
        _menuLocal = [[JYMenuLocal alloc] initWithName:[JYPaintingItem menuLocalFromType:type]];
    }
    
    return self;
}

+ (NSString *)menuLocalFromType:(JYPaintingType)type {
    NSString *name = [NSString stringWithFormat:@"%@%ld", @"Menu", (long)type];
    return name;
}

- (NSArray<JYMenu *> *)menus {
    if (!_menus) {
        NSMutableArray *tempMutableArray = [NSMutableArray array];
        
        if (_type == JYPaintingTypeStyle) {
            NSArray *styleArray = @[@(JYMoodStyleTypePass), @(JYMoodStyleTypeADR), @(JYMoodStyleTypeSell), @(JYMoodStyleTypeLove), @(JYMoodStyleTypeEllipse), @(JYMoodStyleTypeRectangle), @(JYMoodStyleTypeRhombus), @(JYMoodStyleTypeHexagon)];
            for (int i = 0; i < styleArray.count; i ++) {
                JYMenu *menu = [[JYMenu alloc] initWithType:_type];
                menu.styleType = [styleArray[i] integerValue];
                [tempMutableArray addObject:menu];
            }
        } else if (_type == JYPaintingTypeColor) {
            int colorCount = 6;
            for (int i = 0; i < colorCount; i++) {
                UIColor *color = [UIColor colorWithWhite:i/(float)(colorCount - 1) alpha:1.0];
                JYMenu *menu = [[JYMenu alloc] initWithType:_type];
                menu.color = color;
                [tempMutableArray addObject:menu];
            }
            colorCount = 16;
            for (int i = 0; i < colorCount; i++) {
                UIColor *color = [UIColor colorWithHue:i / (float)colorCount saturation:1.0 brightness:1.0 alpha:1.0];
                JYMenu *menu = [[JYMenu alloc] initWithType:_type];
                menu.color = color;
                [tempMutableArray addObject:menu];
            }
        } else if (_type == JYPaintingTypeSize) {
            NSArray *lineWidthArray = @[@(3), @(5), @(7), @(9), @(11), @(13), @(15)];
            for (int i = 0; i < lineWidthArray.count; i ++) {
                JYMenu *menu = [[JYMenu alloc] initWithType:_type];
                menu.lineWidth = [lineWidthArray[i] floatValue];
                [tempMutableArray addObject:menu];
            }
        } else if (_type == JYPaintingTypePen) {
            NSArray *penArray = @[@"Pen", @"Pencil", @"Brush", @"Grow", @"Eraser"];
            for (int i = 0; i < penArray.count; i ++) {
                JYMenu *menu = [[JYMenu alloc] initWithType:_type];
                menu.name = penArray[i];
                [tempMutableArray addObject:menu];
            }
        }
        
        _menus = [tempMutableArray copy];
    }
    
    return _menus;
}

@end

@implementation JYPainting

- (NSArray *)plantings {
    if (!_plantings) {
        NSMutableArray *temp = [NSMutableArray array];
        JYPaintingItem *item0 = [[JYPaintingItem alloc] initWithType:JYPaintingTypeStyle];
        item0.title = @"选个模板吧";
        [temp addObject:item0];
        JYPaintingItem *item1 = [[JYPaintingItem alloc] initWithType:JYPaintingTypeSize];
        item1.title = @"线条宽度";
        [temp addObject:item1];
        JYPaintingItem *item2 = [[JYPaintingItem alloc] initWithType:JYPaintingTypeColor];
        item2.title = @"线条颜色";
        [temp addObject:item2];
        JYPaintingItem *item3 = [[JYPaintingItem alloc] initWithType:JYPaintingTypePen];
        item3.title = @"画笔类型";
        [temp addObject:item3];
        JYPaintingItem *item4 = [[JYPaintingItem alloc] initWithType:JYPaintingTypeUndo];
        item4.title = @"4";
        [temp addObject:item4];
        JYPaintingItem *item5 = [[JYPaintingItem alloc] initWithType:JYPaintingTypeCustom];
        item5.title = @"自定义";
        [temp addObject:item5];
        _plantings = [NSArray arrayWithArray:temp];
        
    }
    
    return _plantings;
}

@end
