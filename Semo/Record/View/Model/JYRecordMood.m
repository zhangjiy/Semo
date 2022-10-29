//
//  JYRecordMood.m
//  Semo
//
//  Created by jiyang on 2022/10/29.
//

#import "JYRecordMood.h"
#import "JYPrefixHeader.h"

@implementation JYRecordMood
- (NSString *)text {
    if (self.hiddenText) {
        return @"";
    }
    return _text;
}
@end

extern NSArray <JYRecordMood *> * JYRecordMoods(void) {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < RecordMoods.count; i ++) {
        JYRecordMood *recordMood = [[JYRecordMood alloc] init];
        recordMood.text = [RecordMoods objectAtIndex:i];
        recordMood.color = [MoodColors objectAtIndex:i];
        [array addObject:recordMood];
    }
    
    return [array copy];
}
