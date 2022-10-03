//
//  JYRecordMoodViewController.h
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYRecordMoodViewController, JYMonthMood, JYDayMood;

@protocol JYRecordMoodViewControllerDelegate <NSObject>
@optional
- (void)recordMoodViewController:(JYRecordMoodViewController *)controller dayMood:(JYDayMood *)dayMood;
@end

@interface JYRecordMoodViewController : UIViewController
@property (nonatomic, weak) id <JYRecordMoodViewControllerDelegate> delegate;
- (instancetype)initWithDayMood:(JYDayMood *)dayMood moodText:(nullable NSString *)moodText;
@end

NS_ASSUME_NONNULL_END
