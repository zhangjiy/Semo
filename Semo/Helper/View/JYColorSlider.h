//
//  JYColorSlider.h
//  Semo
//
//  Created by jiyang on 2022/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYColorSlider : UISlider

@property (nonatomic, strong)UIColor * currentColor;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
