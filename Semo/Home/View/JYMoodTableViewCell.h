//
//  JYMoodTableViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import <UIKit/UIKit.h>
#import "JYMoodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMoodTableViewCell : UITableViewCell
- (void)updateViewWithModel:(JYMoodModel *)moodModel;
@end

NS_ASSUME_NONNULL_END
