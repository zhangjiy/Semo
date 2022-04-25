//
//  JYDayMoodImageCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYDayMoodImageCollectionViewCell;
@protocol JYDayMoodImageCollectionViewCellDelegate <NSObject>
@optional
- (UIView *)inView:(JYDayMoodImageCollectionViewCell *)cell;
- (void)dayMoodImageCollectionViewCell:(JYDayMoodImageCollectionViewCell *)cell didDeleteItemAtIndex:(NSInteger)deleteAtIndex;
@end

@interface JYDayMoodImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) id <JYDayMoodImageCollectionViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
