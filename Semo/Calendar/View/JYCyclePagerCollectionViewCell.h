//
//  JYCyclePagerCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYCyclePagerCollectionViewCell;
@protocol JYCyclePagerCollectionViewCellDelegate <NSObject>
@optional
@property (nonatomic, assign, readonly) CGRect targetRect;
- (UIView *)inView:(JYCyclePagerCollectionViewCell *)cell;
- (void)cyclePagerCollectionViewCell:(JYCyclePagerCollectionViewCell *)cell didDeleteAction:(id)sender;
@end

@interface JYCyclePagerCollectionViewCell : UICollectionViewCell
@property (nullable, nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id <JYCyclePagerCollectionViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
