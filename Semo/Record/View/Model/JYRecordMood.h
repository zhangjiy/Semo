//
//  JYRecordMood.h
//  Semo
//
//  Created by jiyang on 2022/10/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYRecordMood : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL hiddenText;
@property (nonatomic, assign) BOOL isSelected;

@end

extern NSArray <JYRecordMood *> * JYRecordMoods(void);

NS_ASSUME_NONNULL_END
