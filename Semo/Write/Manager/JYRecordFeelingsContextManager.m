//
//  JYRecordFeelingsContextManager.m
//  Semo
//
//  Created by jiyang on 2022/4/4.
//

#import "JYRecordFeelingsContextManager.h"

@implementation JYRecordFeelingsContextManager

+ (instancetype)shareManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc] init];
    });
    return instance;
}

@end
