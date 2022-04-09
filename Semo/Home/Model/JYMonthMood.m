//
//  JYMonthMood.m
//  Semo
//
//  Created by jiyang on 2022/4/6.
//

#import "JYMonthMood.h"

@implementation JYMonthMood

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        if (name.length == 0) {
            NSAssert(name,@"name不能为空!");
        }
        _name = name;
    }
    
    return self;
}

- (void)saveDayMood:(nullable JYDayMood *)value forKey:(NSString *)key {
    NSMutableDictionary * temp = [[NSMutableDictionary alloc] init];
    if (_dayMoodDict) {
        [temp addEntriesFromDictionary:_dayMoodDict];
    }
    
    [temp setValue:value forKey:key];
    _dayMoodDict = [temp copy];
    
    [self bg_saveOrUpdate];
}

@end
