//
//  JYRecoverTableCell.h
//  Semo
//
//  Created by jiyang on 2022/10/11.
//

#import <UIKit/UIKit.h>
#import "JYICloudFileModel.h"

NS_ASSUME_NONNULL_BEGIN

@class JYRecoverTableViewCell;
@protocol JYRecoverTableViewCellDelegate <NSObject>
@optional
- (void)recoverTableViewCell:(JYRecoverTableViewCell *)cell didSelectAction:(UIButton *)sender;
@end

@interface JYRecoverTableViewCell : UITableViewCell
@property (nonatomic, weak) id <JYRecoverTableViewCellDelegate> delegate;
@property (nonatomic, strong) JYICloudFileModel *fileModel;
@end

NS_ASSUME_NONNULL_END
