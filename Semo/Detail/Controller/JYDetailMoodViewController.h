//
//  JYDetailMoodViewController.h
//  Semo
//
//  Created by jiyang on 2022/4/25.
//

#import <UIKit/UIKit.h>
#import "JYDayMood.h"

NS_ASSUME_NONNULL_BEGIN

@class JYDetailMoodViewController;

@protocol JYDetailMoodViewControllerDelegate <NSObject>
@optional
- (void)detailMoodViewController:(JYDetailMoodViewController *)controller didSelectItem:(JYMood *)item;
@end

@interface JYDetailMoodViewController : UIViewController
@property (nonatomic, weak) id <JYDetailMoodViewControllerDelegate> delegate;
- (instancetype)initWithDayMood:(JYDayMood *)dayMood;
@end

NS_ASSUME_NONNULL_END
