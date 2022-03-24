//
//  JYMenu.m
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import "JYMenu.h"
#import "JYPainting.h"

@implementation JYMenu

- (instancetype)initWithType:(JYPaintingType)type {
    if (self = [super init]) {
        _type = type;
    }
    
    return self;
}

@end
