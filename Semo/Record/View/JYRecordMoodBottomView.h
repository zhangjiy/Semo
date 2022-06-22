//
//  JYRecordMoodBottomView.h
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYRecordMoodBottomView, JYPainting, JYPaintingItem, JYMenu;

@protocol JYRecordMoodBottomViewDelegate <NSObject>
@optional
@property (nonatomic, strong, readonly) UIView *overlayView;
- (void)recordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectPaintingItem:(JYPaintingItem *)item;
- (void)recordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectMoodItem:(NSString *)item;
- (void)recordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectMenuItem:(JYMenu *)item;
@end

@interface JYRecordMoodBottomView : UIView
@property (nonatomic, weak) id <JYRecordMoodBottomViewDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger index;
- (void)updateViewWithModel:(JYPainting *)model;
@end

NS_ASSUME_NONNULL_END
