//
//  JYAboutUsListView.h
//  Semo
//
//  Created by jiyang on 2022/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JYAboutUsListView, JYAboutUsModel;
@protocol JYAboutUsListViewDelegate <NSObject>
@optional
- (void)aboutUsListView:(JYAboutUsListView *)listView didSelectItem:(JYAboutUsModel *)item;
@end

@interface JYAboutUsListView : UIView
@property (nonatomic, weak) id <JYAboutUsListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
