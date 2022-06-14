//
//  JYSettingTableViewCell.h
//  Semo
//
//  Created by jiyang on 2022/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JYSettingModel;

@interface JYSettingTableViewCell : UITableViewCell
@property (nonatomic, strong) JYSettingModel *settingModel;;
@end

NS_ASSUME_NONNULL_END
