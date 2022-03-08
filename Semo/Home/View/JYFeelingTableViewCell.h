//
//  JYFeelingTableViewCell.h
//  Semo
//
//  Created by jiyang on 2022/3/8.
//

#import <UIKit/UIKit.h>
#import "JYFeelingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYFeelingTableViewCell : UITableViewCell
- (void)updateViewWithModel:(JYFeelingModel *)feelingModel;
@end

NS_ASSUME_NONNULL_END
