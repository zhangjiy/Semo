//
//  JYHelpCenterListView.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYHelpCenterListView, JYHelpCenterModel;

@protocol JYHelpCenterListViewDelegate <NSObject>
@optional
- (void)helpCenterListView:(JYHelpCenterListView *)listView didSelectItem:(JYHelpCenterModel *)item;
@end

@interface JYHelpCenterListView : UIView
@property (nonatomic, weak) id <JYHelpCenterListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
