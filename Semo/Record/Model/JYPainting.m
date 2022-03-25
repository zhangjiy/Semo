//
//  JYPainting.m
//  Semo
//
//  Created by jiyang on 2022/3/21.
//

#import "JYPainting.h"
#import <UIKit/UIKit.h>

@implementation JYPaintingItem
@synthesize menus = _menus;

- (NSArray<JYMenu *> *)menus {
    if (!_menus) {
        NSMutableArray *tempMutableArray = [NSMutableArray array];
        if (_type == JYPaintingTypeColor) {
            NSArray *colorArray = @[[UIColor whiteColor], [UIColor blackColor], [UIColor redColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor colorWithHue:0.8 saturation:1 brightness:1 alpha:1]];
            for (int i = 0; i < colorArray.count; i ++) {
                JYMenu *menu = [[JYMenu alloc] initWithType:_type];
                menu.color = colorArray[i];
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
            NSArray *lineWidthArray = @[@"Pen", @"pencil", @"brush", @"Eraser"];
            for (int i = 0; i < lineWidthArray.count; i ++) {
                JYMenu *menu = [[JYMenu alloc] initWithType:_type];
                menu.name = lineWidthArray[i];
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
        JYPaintingItem *item0 = [[JYPaintingItem alloc] init];
        item0.type = JYPaintingTypeStyle;
        item0.title = @"0";
        [temp addObject:item0];
        JYPaintingItem *item1 = [[JYPaintingItem alloc] init];
        item1.type = JYPaintingTypeSize;
        item1.title = @"1";
        [temp addObject:item1];
        JYPaintingItem *item2 = [[JYPaintingItem alloc] init];
        item2.type = JYPaintingTypeColor;
        item2.title = @"2";
        [temp addObject:item2];
        JYPaintingItem *item3 = [[JYPaintingItem alloc] init];
        item3.type = JYPaintingTypePen;
        item3.title = @"3";
        [temp addObject:item3];
        JYPaintingItem *item4 = [[JYPaintingItem alloc] init];
        item4.type = JYPaintingTypeUndo;
        item4.title = @"4";
        [temp addObject:item4];
        _plantings = [NSArray arrayWithArray:temp];
    }
    
    return _plantings;
}

@end
