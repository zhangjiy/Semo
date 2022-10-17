//
//  JYDayMood.m
//  Semo
//
//  Created by jiyang on 2022/4/5.
//

#import "JYDayMood.h"
#import "MJExtension.h"

MJSecureCodingImplementation(JYDayMood, YES)

@implementation JYDayMood

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    
    return self;
}

- (NSArray *)dayMoodAnalysis {
    NSInteger xi = 0;
    NSInteger nu = 0;
    NSInteger you = 0;
    NSInteger si = 0;
    NSInteger bei = 0;
    NSInteger kong = 0;
    NSInteger jing = 0;
    for (JYMood *mood in self.moods) {
        if (mood.type == JYMoodTypeXi) {
            xi ++;
        } else if (mood.type == JYMoodTypeNu) {
            nu ++;
        } else if (mood.type == JYMoodTypeYou) {
            you ++;
        } else if (mood.type == JYMoodTypeSi) {
            si ++;
        } else if (mood.type == JYMoodTypeBei) {
            bei ++;
        } else if (mood.type == JYMoodTypeKong) {
            kong ++;
        } else {
            jing ++;
        }
    }

    return @[@(xi), @(nu), @(you), @(si), @(bei), @(kong), @(jing)];
}

@end
