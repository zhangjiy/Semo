//
//  JYPopupStyleMenuCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JYMenu;

@interface JYPopupStyleMenuCollectionViewCell : UICollectionViewCell
- (void)updateViewWithModel:(JYMenu *)model;
@end

NS_ASSUME_NONNULL_END
