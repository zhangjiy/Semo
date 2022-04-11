//
//  JYGridView.h
//  Semo
//
//  Created by jiyang on 2022/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYGridView : UIView
@property (nonatomic, assign) CGSize gridSize;
- (void)drawGridWithVerLineCount:(NSInteger)verLineCount horLineCount:(NSInteger)horLineCount scale:(CGFloat)scale;
@end

NS_ASSUME_NONNULL_END
