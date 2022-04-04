//
//  JYPopupPenMenuCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYMenu;

@interface JYPopupPenMenuCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) BOOL isSelected;
- (void)updateViewWithModel:(JYMenu *)model;
@end

NS_ASSUME_NONNULL_END
