//
//  JYWriteFeelingListView.h
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYWriteFeelingListView;

@protocol JYWriteFeelingListViewDelegate <NSObject>
@optional
- (void)writeFeelingListView:(JYWriteFeelingListView *)listView didSelectItem:(NSString *)item;
@end

@interface JYWriteFeelingListView : UIView
@property (nonatomic, weak) id <JYWriteFeelingListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
