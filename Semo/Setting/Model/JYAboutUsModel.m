//
//  JYAboutUsModel.m
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import "JYAboutUsModel.h"

@implementation JYAboutUsModel

- (instancetype)initWithType:(JYAboutUsItemType)type {
    if (self = [super init]) {
        _type = type;
        _backgoundColor = [UIColor whiteColor];
    }
    
    return self;
}

@end
