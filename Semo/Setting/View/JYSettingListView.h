//
//  JYSettingListView.h
//  Semo
//
//  Created by jiyang on 2022/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYSettingListView, JYSettingModel;

@protocol JYSettingListViewDelegate <NSObject>
@optional
- (void)settingListView:(JYSettingListView *)listView didSelectItem:(JYSettingModel *)item;
@end

@interface JYSettingListView : UIView
@property (nonatomic, weak) id <JYSettingListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
