//
//  JYMood.m
//  Semo
//
//  Created by jiyang on 2022/6/8.
//

#import "JYMood.h"

@implementation JYMood
- (instancetype)initWithType:(JYMoodType)type {
    if (self = [super init]) {
        self.type = type;
    }
    
    return self;
}
@end
