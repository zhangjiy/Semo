//
//  JYPopupMenuCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYMenu;

@interface JYPopupMenuCollectionViewCell : UICollectionViewCell
- (void)updateViewWithModel:(JYMenu *)model;
@end

NS_ASSUME_NONNULL_END
