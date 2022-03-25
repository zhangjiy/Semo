//
//  JYRecordFeelingsManager.m
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

#import "JYRecordFeelingsManager.h"
#import "JYSealFeelingPassView.h"
#import "JYWriteFeelingBottomView.h"
#import "JYPainting.h"
#import "Semo-Swift.h"
#import "JYPrefixHeader.h"

@interface JYRecordFeelingsManager () <JYWriteFeelingBottomViewDelegate>
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) JYSealFeelingPassView * sealFeelingPassView;
@property (nonatomic, strong) JYPaintingView * paintingView;
@property (nonatomic, strong) JYPainting *painting;
@property (nonatomic, strong) JYWriteFeelingBottomView * bottomView;
@end

@implementation JYRecordFeelingsManager

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.containerView = [[UIView alloc] initWithFrame:frame];
        [self initSubviews];
        [self initConfig];
    }
    
    return self;
}

- (void)initConfig {
    [self.bottomView updateViewWithModel:self.painting];
}

- (void)initSubviews {
    //[self.containerView addSubview:self.sealFeelingPassView];
    [self.containerView addSubview:self.paintingView];
    [self.containerView addSubview:self.bottomView];
}

- (void)layoutSubviews {
    
    
    _paintingView.size = CGSizeMake(JYCanvasWidth, JYCanvasHeight);
    _paintingView.top = JYCanvasTop;
    _paintingView.centerX = self.containerView.width / 2.f;
    
    _sealFeelingPassView.size = CGSizeMake(120, 120);
    _sealFeelingPassView.top = JYCanvasTop + _paintingView.height / 2.f;
    _sealFeelingPassView.centerX = self.containerView.width / 2.f;
    
    _bottomView.size = CGSizeMake(self.containerView.width, JYWriteBottomHeight);
    _bottomView.bottom = self.containerView.height;
    
}

- (JYSealFeelingPassView *)sealFeelingPassView {
    if (!_sealFeelingPassView) {
        _sealFeelingPassView = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        _sealFeelingPassView.hidden = NO;
    }
    
    return _sealFeelingPassView;
}

- (JYPaintingView *)paintingView {
    if (!_paintingView) {
        _paintingView = [[JYPaintingView alloc] initWithFrame:CGRectMake((self.containerView.width - 330) / 2.f, JYCanvasTop, JYCanvasWidth, JYCanvasHeight)];
    }
    
    return _paintingView;
}

- (JYWriteFeelingBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JYWriteFeelingBottomView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor colorWithRed:223/225.f green:225/225.f blue:215/225.f alpha:1.f];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (JYPainting *)painting {
    if (!_painting) {
        _painting = [[JYPainting alloc] init];
    }
    
    return _painting;
}

#pragma -- mark -- JYWriteFeelingBottomViewDelegate

- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectPaintingItem:(JYPaintingItem *)item {
    
}

@end
