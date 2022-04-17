//
//  JYRecordPaintingListView.h
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYRecordPaintingListView, JYPainting, JYPaintingItem, JYMenu;

@protocol JYRecordPaintingListViewDelegate <NSObject>
@optional
@property (nonatomic, strong, readonly) UIView *overlayView;
- (void)recordPaintingListView:(JYRecordPaintingListView *)listView didSelectPaintingItem:(JYPaintingItem *)item;
- (void)recordPaintingListView:(JYRecordPaintingListView *)listView didSelectMenuItem:(JYMenu *)item;
@end

@interface JYRecordPaintingListView : UIView

@property (nonatomic, weak) id <JYRecordPaintingListViewDelegate> delegate;

- (void)updateViewWithModel:(JYPainting *)model;

@end

NS_ASSUME_NONNULL_END
