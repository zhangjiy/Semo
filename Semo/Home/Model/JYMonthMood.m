//
//  JYMonthMood.m
//  Semo
//
//  Created by jiyang on 2022/4/6.
//

#import "JYMonthMood.h"

MJSecureCodingImplementation(JYMonthMood, YES)

@implementation JYMonthMood

- (instancetype)initWithTableName:(NSString *)tableName name:(NSString *)name {
    if (name.length == 0) {
        NSAssert(name,@"name不能为空!");
    }
    if ([JYMonthMood bg_isExistForTableName:tableName]) {
        NSString *where = [NSString stringWithFormat:@"where %@=%@", bg_sqlKey(@"name"), bg_sqlValue(name)];
        NSArray *arr = [JYMonthMood bg_find:tableName where:where];
        if (arr.count > 0) {
            return arr.firstObject;
        }
    }
    if (self = [super init]) {
        _name = name;
        self.bg_tableName = tableName;
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

- (void)deleteDayMoodForKey:(NSString *)key itemAtIndex:(NSInteger)index{
    NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] init];
    if (_dayMoodDict) {
        [tempDict addEntriesFromDictionary:_dayMoodDict];
    }
    
    JYDayMood *dayMood = [tempDict valueForKey:key];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:dayMood.moods];
    [tempArray removeObjectAtIndex:index];
    dayMood.moods = [tempArray copy];
    
    _dayMoodDict = [tempDict copy];
    [self bg_saveOrUpdate];
}

- (NSInteger)moodCount {
    NSInteger count = 0;
    for (NSString *key in self.dayMoodDict.allKeys) {
        JYDayMood *dayMood = [self.dayMoodDict valueForKey:key];
        count += dayMood.moods.count;
    }
    
    return count;
}

@end
