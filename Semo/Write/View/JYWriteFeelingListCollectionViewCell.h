//
//  JYWriteFeelingListCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYWriteFeelingListCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
