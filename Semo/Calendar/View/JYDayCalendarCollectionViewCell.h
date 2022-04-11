//
//  JYDayCalendarCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import <UIKit/UIKit.h>
#import "JYCalendarCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYDayCalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *text;
@property (nullable, nonatomic, strong) UIImage *image;
@end

NS_ASSUME_NONNULL_END
