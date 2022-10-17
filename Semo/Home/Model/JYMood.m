//
//  JYMood.m
//  Semo
//
//  Created by jiyang on 2022/6/8.
//

#import "JYMood.h"
#import "MJExtension.h"

MJSecureCodingImplementation(JYMood, YES)

@implementation JYMood

- (instancetype)initWithType:(JYMoodType)type {
    if (self = [super init]) {
        self.type = type;
    }
    
    return self;
}
@end
