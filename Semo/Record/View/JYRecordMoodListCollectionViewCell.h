//
//  JYRecordMoodListCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import <UIKit/UIKit.h>
#import "JYRecordMood.h"

NS_ASSUME_NONNULL_BEGIN

@class JYRecordMoodListCollectionViewCell;

@protocol JYRecordMoodListCollectionViewCellDelegate <NSObject>
@optional
- (void)recordMoodListCollectionViewCell:(JYRecordMoodListCollectionViewCell *)cell didLongPress:(UIGestureRecognizer *)gesture;
@end

@interface JYRecordMoodListCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) JYRecordMood * recordMood;
@property (nonatomic, weak) id <JYRecordMoodListCollectionViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
