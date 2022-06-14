//
//  JYHomeTopView.h
//  Semo
//
//  Created by jiyang on 2022/4/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JYHomeTopView, JYMoodMonthDate;

@protocol JYHomeTopViewDelegate <NSObject>
@optional
@property (nonatomic, strong, readonly) UIView *overlayView;
- (void)homeTopView:(JYHomeTopView *)view rightButtonAction:(UIButton *)sender;
@end


@interface JYHomeTopView : UIView
@property (nonatomic, strong) JYMoodMonthDate *monthDate;
@property (nonatomic, weak) id <JYHomeTopViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
