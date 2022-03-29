//
//  JYRecordFeelingsManager.m
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

#import "JYRecordFeelingsManager.h"
#import "JYSealFeelingPassView.h"
#import "JYSealFeelingADRView.h"
#import "JYSealFeelingSellView.h"
#import "JYSealFeelingLoveView.h"
#import "JYWriteFeelingBottomView.h"
#import "JYPainting.h"
#import "Semo-Swift.h"
#import "JYPrefixHeader.h"

@interface JYRecordFeelingsManager () <JYWriteFeelingBottomViewDelegate>
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) JYSealFeelingPassView * feelingPassView;
@property (nonatomic, strong) JYSealFeelingADRView * feelingARDView;
@property (nonatomic, strong) JYSealFeelingSellView *feelingSellView;
@property (nonatomic, strong) JYSealFeelingLoveView *feelingLoveView;
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
    //[self.containerView addSubview:self.feelingPassView];
    //[self.containerView addSubview:self.feelingARDView];//节省性能不一定要用懒加载
    //[self.containerView addSubview:self.feelingSellView];
    //[self.containerView addSubview:self.feelingLoveView];
    [self.containerView addSubview:self.paintingView];
    [self.containerView addSubview:self.bottomView];
}

- (void)layoutSubviews {
    
    _paintingView.top = JYCanvasTop;
    _paintingView.centerX = self.containerView.width / 2.f;
    
    _feelingPassView.top = JYCanvasTop;
    _feelingPassView.centerX = self.containerView.width / 2.f;
    
    _feelingARDView.top = JYCanvasTop;
    _feelingARDView.centerX = self.containerView.width / 2.f;
    
    _feelingSellView.top = JYCanvasTop;
    _feelingSellView.centerX = self.containerView.width / 2.f;
    
    _feelingLoveView.top = JYCanvasTop;
    _feelingLoveView.centerX = self.containerView.width / 2.f;
    
    _bottomView.size = CGSizeMake(self.containerView.width, JYWriteBottomHeight);
    _bottomView.bottom = self.containerView.height;
    
}

- (JYSealFeelingPassView *)feelingPassView {
    if (!_feelingPassView) {
        _feelingPassView = [[JYSealFeelingPassView alloc] initWithFrame:CGRectMake(JYViewInset, JYCanvasTop, self.containerView.width - JYViewInset * 2, self.containerView.width - JYViewInset * 2)];
        _feelingPassView.hidden = NO;
    }
    
    return _feelingPassView;
}

- (JYSealFeelingADRView *)feelingARDView {
    if (!_feelingARDView) {
        _feelingARDView = [[JYSealFeelingADRView alloc] initWithFrame:CGRectMake(JYViewInset, JYCanvasTop, self.containerView.width - JYViewInset * 2, self.containerView.width - JYViewInset * 2)];
        _feelingARDView.hidden = NO;
    }
    
    return _feelingARDView;
}

- (JYSealFeelingSellView *)feelingSellView {
    if (!_feelingSellView) {
        _feelingSellView = [[JYSealFeelingSellView alloc] initWithFrame:CGRectMake(JYViewInset, JYCanvasTop, self.containerView.width - JYViewInset * 2, self.containerView.width - JYViewInset * 2)];
        _feelingSellView.hidden = NO;
    }
    
    return _feelingSellView;
}

- (JYSealFeelingLoveView *)feelingLoveView {
    if (!_feelingLoveView) {
        _feelingLoveView = [[JYSealFeelingLoveView alloc] initWithFrame:CGRectMake(JYViewInset, JYCanvasTop, self.containerView.width - JYViewInset * 2, self.containerView.width - JYViewInset * 2)];
        _feelingLoveView.hidden = NO;
    }
    
    return _feelingLoveView;
}

- (JYPaintingView *)paintingView {
    if (!_paintingView) {
        _paintingView = [[JYPaintingView alloc] initWithFrame:CGRectMake(JYViewInset, JYCanvasTop, self.containerView.width - JYViewInset, self.containerView.width - JYViewInset)];
    }
    
    return _paintingView;
}

- (JYWriteFeelingBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JYWriteFeelingBottomView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor colorWithRed:223/255.f green:225/255.f blue:215/255.f alpha:1.f];
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

- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectFeelingItem:(NSString *)item {
    //self.feelingPassView.text = item;
    //self.feelingARDView.text = item;
    //self.feelingSellView.text = item;
    self.feelingLoveView.text = item;
    [self tou];
}

- (void)tou{
    
    UIImage *image = [self makeImageWithView:self.feelingSellView withSize:self.feelingSellView.size];
    
}


#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
