//
//  JYRecordMoodListView.h
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYRecordMoodListView;

@protocol JYRecordMoodListViewDelegate <NSObject>
@optional
- (void)recordMoodListView:(JYRecordMoodListView *)listView didSelectItem:(NSString *)item;
@end

@interface JYRecordMoodListView : UIView
@property (nonatomic, weak) id <JYRecordMoodListViewDelegate> delegate;
@property (nonatomic, assign, readonly) NSUInteger  index;
@end

NS_ASSUME_NONNULL_END
