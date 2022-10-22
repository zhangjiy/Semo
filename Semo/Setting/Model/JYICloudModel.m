//
//  JYICloudModel.m
//  Semo
//
//  Created by jiyang on 2022/10/15.
//

#import "JYICloudModel.h"
#import "JYMonthMood.h"
#import "MJExtension.h"

MJSecureCodingImplementation(JYICloudModel, YES)

@implementation JYICloudModel

- (instancetype)init {
    if (self = [super init]) {
        _dateString = [[self class] getCurrentCompainedDateString];
    }
    
    return self;
}

+ (NSString *)getCurrentCompainedDateString {
    NSDate *localDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd+HH:mm:ss";
    NSString *timeString = [formatter stringFromDate:localDate];
    return timeString;
}

@end
