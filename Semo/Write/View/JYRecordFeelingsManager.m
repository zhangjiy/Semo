//
//  JYRecordFeelingsManager.m
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

#import "JYRecordFeelingsManager.h"
#import "JYSealFeelingPassView.h"
#import "Semo-Swift.h"
#import "JYPrefixHeader.h"

@interface JYRecordFeelingsManager ()
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIView * hollowView;
@property (nonatomic, strong) JYSealFeelingPassView * sealFeelingPassView;
@property (nonatomic, strong) JYPaintingView * paintingView;
@end

@implementation JYRecordFeelingsManager

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.containerView = [[UIView alloc] initWithFrame:frame];
        [self initSubviews];
    }
    
    return self;
}

- (void)initConfig {
    
}

- (void)initSubviews {
    [self.containerView addSubview:self.hollowView];
    [self.containerView addSubview:self.sealFeelingPassView];
    [self.containerView addSubview:self.paintingView];
}

- (void)layoutSubviews {
    
    _hollowView.size = CGSizeMake(330, 165);
    _hollowView.top = 100;
    _hollowView.centerX = self.containerView.width / 2.f;
    
    _sealFeelingPassView.size = CGSizeMake(120, 120);
    _sealFeelingPassView.centerY = _hollowView.height / 2.f;
    _sealFeelingPassView.centerX = _hollowView.width / 2.f;
    
}

- (UIView *)hollowView {
    if (!_hollowView) {
        _hollowView = [[UIView alloc] initWithFrame:CGRectZero];
        _hollowView.backgroundColor = SMHomeBackgroudColor;
    }
    return _hollowView;
}

- (JYSealFeelingPassView *)sealFeelingPassView {
    if (!_sealFeelingPassView) {
        _sealFeelingPassView = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        _sealFeelingPassView.hidden = YES;
    }
    
    return _sealFeelingPassView;
}

- (JYPaintingView *)paintingView {
    if (!_paintingView) {
        _paintingView = [[JYPaintingView alloc] initWithFrame:self.containerView.frame];
    }
    
    return _paintingView;
}

@end
