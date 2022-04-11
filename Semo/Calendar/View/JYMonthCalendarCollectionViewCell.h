//
//  JYMonthCalendarCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/12.
//

#import <UIKit/UIKit.h>
#import "JYCalendarCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@class JYMonthCalendarCollectionViewCell;
@protocol JYMonthCalendarCollectionViewCellDelegate <NSObject>
@optional
- (void)monthCalendarCollectionViewCell:(JYMonthCalendarCollectionViewCell *)cell didSelectItemAtIndexPath:(id <JYMoodDate>)date;
@end

@interface JYMonthCalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id <JYMonthCalendarCollectionViewCellDelegate> delegate;
- (void)updateViewWithMonth:(JYMoodMonthDate *)month calculator:(JYCalendarCalculator *)calculator;
@end

NS_ASSUME_NONNULL_END
