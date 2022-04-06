//
//  JYWritePaintingListCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYPaintingItem;

@interface JYWritePaintingListCollectionViewCell : UICollectionViewCell
- (void)updateViewWithModel:(JYPaintingItem *)model;
@end

NS_ASSUME_NONNULL_END
