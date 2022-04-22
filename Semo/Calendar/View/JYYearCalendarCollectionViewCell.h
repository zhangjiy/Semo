//
//  JYYearCalendarCollectionViewCell.h
//  Semo
//
//  Created by jiyang on 2022/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYYearCalendarCollectionViewCell : UICollectionViewCell
- (void)updateYearText:(NSString *)yearText monthText:(NSString *)monthText;
@end

NS_ASSUME_NONNULL_END
