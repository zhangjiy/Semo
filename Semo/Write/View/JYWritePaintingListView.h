//
//  JYWritePaintingListView.h
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYWritePaintingListView, JYPainting, JYPaintingItem;

@protocol JYWritePaintingListViewDelegate <NSObject>
@optional
- (void)writePaintingListView:(JYWritePaintingListView *)listView didSelectItem:(JYPaintingItem *)item;
@end

@interface JYWritePaintingListView : UIView

@property (nonatomic, weak) id <JYWritePaintingListViewDelegate> delegate;

- (void)updateViewWithModel:(JYPainting *)model;

@end

NS_ASSUME_NONNULL_END
