//
//  JYDetailMoodListView.h
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import <UIKit/UIKit.h>
#import "JYDayMood.h"

NS_ASSUME_NONNULL_BEGIN

@class JYDetailMoodListView;

@protocol JYDetailMoodListViewDelegate <NSObject>
@optional
- (void)detailMoodListView:(JYDetailMoodListView *)view didSelectItem:(JYMood *)item;
@end

@interface JYDetailMoodListView : UIView
@property (nonatomic, weak) id <JYDetailMoodListViewDelegate> delegate;
@property (nonatomic, strong) JYDayMood *dayMood;
@end

NS_ASSUME_NONNULL_END
