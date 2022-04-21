//
//  JYMenuSelected.m
//  Semo
//
//  Created by jiyang on 2022/4/19.
//

#import "JYMenuLocal.h"

#define JYMenuLocalTableName @"JYMenuLocalTable"

@implementation JYMenuLocal

- (instancetype)initWithName:(NSString *)name {
    if (name.length == 0) {
        NSAssert(name,@"name不能为空!");
    }
    if ([JYMenuLocal bg_isExistForTableName:JYMenuLocalTableName]) {
        
        NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"name"),bg_sqlValue(name)];
        NSArray *arr = [JYMenuLocal bg_find:JYMenuLocalTableName where:where];
        if (arr.count > 0) {
            return arr.firstObject;
        }
    }
    if (self = [super init]) {
        _name = name;
        self.bg_tableName = JYMenuLocalTableName;
    }
    
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
    }
}

@end
