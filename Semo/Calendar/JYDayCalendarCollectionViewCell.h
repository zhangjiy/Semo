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
- (void)updateViewWithText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
