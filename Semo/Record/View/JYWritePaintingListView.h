//
//  JYWritePaintingListView.h
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYWritePaintingListView, JYPainting, JYPaintingItem, JYMenu;

@protocol JYWritePaintingListViewDelegate <NSObject>
@optional
- (void)writePaintingListView:(JYWritePaintingListView *)listView didSelectPaintingItem:(JYPaintingItem *)item;
- (void)writePaintingListView:(JYWritePaintingListView *)listView didSelectMenuItem:(JYMenu *)item;
@end

@interface JYWritePaintingListView : UIView

@property (nonatomic, weak) id <JYWritePaintingListViewDelegate> delegate;

- (void)updateViewWithModel:(JYPainting *)model;

@end

NS_ASSUME_NONNULL_END
