//
//  JYSettingModel.m
//  Semo
//
//  Created by jiyang on 2022/6/10.
//

#import "JYSettingModel.h"

@implementation JYSettingModel

- (instancetype)initWithType:(JYSettingItemType)type {
    if (self = [super init]) {
        _type = type;
        _backgoundColor = [UIColor whiteColor];
    }
    
    return self;
}

@end
