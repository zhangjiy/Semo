//
//  JYWriteFeelingBottomView.h
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYWriteFeelingBottomView, JYPainting, JYPaintingItem, JYMenu;

@protocol JYWriteFeelingBottomViewDelegate <NSObject>
@optional
- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectPaintingItem:(JYPaintingItem *)item;
- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectFeelingItem:(NSString *)item;
- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectMenuItem:(JYMenu *)item;
@end

@interface JYWriteFeelingBottomView : UIView
@property (nonatomic, weak) id <JYWriteFeelingBottomViewDelegate> delegate;
- (void)updateViewWithModel:(JYPainting *)model;
@end

NS_ASSUME_NONNULL_END
