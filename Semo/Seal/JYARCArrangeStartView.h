//
//  JYARCArrangeStartView.h
//  Deme
//
//  Created by jiyang on 2022/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYARCArrangeStartView : UIView
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSArray *stars;
- (void)drawStars;
@end

NS_ASSUME_NONNULL_END
