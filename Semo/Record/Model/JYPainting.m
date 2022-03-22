//
//  JYPainting.m
//  Semo
//
//  Created by jiyang on 2022/3/21.
//

#import "JYPainting.h"
#import <UIKit/UIKit.h>

@implementation JYPaintingItem
@synthesize colors = _colors;

- (NSArray<UIColor *> *)colors {
    if (!_colors) {
        if (_type == JYPaintingTypeColor) {
            _colors = @[[UIColor whiteColor],[UIColor blackColor],[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor colorWithHue:0.8 saturation:1 brightness:1 alpha:1]];
        }
    }
    
    return _colors;
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
        item3.type = JYPaintingTypeUndo;
        item3.title = @"3";
        [temp addObject:item3];
        JYPaintingItem *item4 = [[JYPaintingItem alloc] init];
        item4.type = JYPaintingTypeRedo;
        item4.title = @"4";
        [temp addObject:item4];
        _plantings = [NSArray arrayWithArray:temp];
    }
    
    return _plantings;
}

@end
