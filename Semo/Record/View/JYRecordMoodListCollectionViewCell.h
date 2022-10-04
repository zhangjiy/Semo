//
//  JYRecordMoodListCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYRecordMoodListCollectionViewCell;

@protocol JYRecordMoodListCollectionViewCellDelegate <NSObject>
@optional
- (void)recordMoodListCollectionViewCell:(JYRecordMoodListCollectionViewCell *)cell didLongPress:(UIGestureRecognizer *)gesture;
@end

@interface JYRecordMoodListCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, weak) id <JYRecordMoodListCollectionViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
