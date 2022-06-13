//
//  JYAboutUsTableViewCell.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JYAboutUsModel;

@interface JYAboutUsTableViewCell : UITableViewCell
- (void)updateViewWithModel:(JYAboutUsModel *)model;
@end

NS_ASSUME_NONNULL_END
