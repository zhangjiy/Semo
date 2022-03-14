//
//  JYCalendarCollectionViewLayout.h
//  Semo
//
//  Created by jiyang on 2022/3/13.
//

#import <UIKit/UIKit.h>
#import "JYCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@class JYCalendarCollectionViewLayout;

@protocol JYCalendarCollectionViewLayoutDelegate <NSObject>
@optional
- (void)calendarCollectionViewDidPrepareLayout:(JYCalendarCollectionViewLayout *)layout;

@end

@interface JYCalendarCollectionViewLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id <JYCalendarCollectionViewLayoutDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
