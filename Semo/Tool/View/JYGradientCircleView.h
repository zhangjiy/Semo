//
//  JYGradientCircleView.h
//  Semo
//
//  Created by jiyang on 2022/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYGradientCircleView : UIView

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat margin;       //圆环距离视图边缘的距离

@property (nonatomic, assign) CGFloat startDegree;  //开始角度 (0 - 360)

@property (nonatomic, assign) CGFloat endDegree;    //结束角度 (0 - 360)

@property (nonatomic, assign) CGFloat isClockwise; //默认YES 顺时针

@property (nonatomic, assign) CGFloat progress;    //(0 - 1)

@property (nonatomic, strong) NSArray< UIColor *> *colors;    //渐变色

@end

NS_ASSUME_NONNULL_END
