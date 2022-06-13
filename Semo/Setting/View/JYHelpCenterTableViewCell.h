//
//  JYHelpCenterTableViewCell.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JYHelpCenterModel;

@interface JYHelpCenterTableViewCell : UITableViewCell
- (void)updateViewWithModel:(JYHelpCenterModel *)model;
@end

NS_ASSUME_NONNULL_END
