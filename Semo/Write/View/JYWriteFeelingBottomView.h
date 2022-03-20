//
//  JYWriteFeelingBottomView.h
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYWriteFeelingBottomView;

@protocol JYWriteFeelingBottomViewDelegate <NSObject>
@optional
- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectItem:(NSString *)item;
@end

@interface JYWriteFeelingBottomView : UIView
@property (nonatomic, weak) id <JYWriteFeelingBottomViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
