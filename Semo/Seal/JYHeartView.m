//
//  JYHeartView.m
//  Semo
//
//  Created by jiyang on 2022/3/29.
//

#import "JYHeartView.h"

@interface JYHeartView()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation JYHeartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig{
        //默认值
    self.heartSize = 150.0;
    self.heartColor = [UIColor redColor];
    [self addSubview: self.bottomView];
    [self addSubview: self.leftView];
    [self addSubview: self.rightView];
    //提前旋转45度
    self.transform = CGAffineTransformMakeRotation(M_PI_4);
}

//去除设置背景色
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    backgroundColor = [UIColor clearColor];
    [super setBackgroundColor:backgroundColor];
}

- (void)setHeartSize:(CGFloat)heartSize{
    _heartSize = heartSize;
    CGFloat partSize = heartSize/3.0;
    self.bottomView.frame = CGRectMake(partSize, partSize, partSize*2 , partSize*2);
    self.leftView.frame = CGRectMake(0, partSize, partSize*2 , partSize*2);
    self.rightView.frame = CGRectMake(partSize, 0, partSize*2 , partSize*2);
    
    self.leftView.layer.cornerRadius = partSize;
    self.rightView.layer.cornerRadius = partSize;
}

- (void)setHeartColor:(UIColor *)heartColor{
    _heartColor = heartColor;
    self.bottomView.backgroundColor = heartColor;
    self.leftView.backgroundColor = heartColor;
    self.rightView.backgroundColor = heartColor;
}

    ///MARK:- lazy load
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}
- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_leftView];
    }
    return _leftView;
}

- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_rightView];
    }
    return _rightView;
}

@end
