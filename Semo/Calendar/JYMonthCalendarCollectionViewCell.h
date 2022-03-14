//
//  JYMonthCalendarCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "JYCalendarCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMonthCalendarCollectionViewCell : UICollectionViewCell
- (void)updateViewWithMonth:(NSDate *)month calculator:(JYCalendarCalculator *)calculator;
@end

NS_ASSUME_NONNULL_END
