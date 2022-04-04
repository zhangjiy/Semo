//
//  JYRecordFeelingsManager.m
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

#import "JYRecordFeelingsManager.h"
#import "JYWriteFeelingDisplayView.h"
#import "JYWriteFeelingBottomView.h"
#import "JYStyleImageFactory.h"
#import "JYPainting.h"
#import "Semo-Swift.h"
#import "JYPrefixHeader.h"

@interface JYRecordFeelingsManager () <JYWriteFeelingBottomViewDelegate>
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) JYWriteFeelingDisplayView *feelingDisplayView;
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
    UIImage *image = [self styleImageWithStyleType:JYFeelingStyleTypePass];
    self.feelingDisplayView.image = image;
}

- (void)initSubviews {
    [self.containerView addSubview:self.feelingDisplayView];
    [self.containerView addSubview:self.paintingView];
    [self.containerView addSubview:self.bottomView];
}

- (void)layoutSubviews {
    _paintingView.top = JYCanvasTop;
    _paintingView.centerX = self.containerView.width / 2.f;
    
    _feelingDisplayView.size = JYWriteDisplayViewSize;
    _feelingDisplayView.top = JYCanvasTop;
    _feelingDisplayView.centerX = self.containerView.width / 2.f;
    
    _bottomView.size = CGSizeMake(self.containerView.width, JYWriteBottomHeight);
    _bottomView.bottom = self.containerView.height;
    
}

- (JYPaintingView *)paintingView {
    if (!_paintingView) {
        _paintingView = [[JYPaintingView alloc] initWithFrame:CGRectMake(JYViewInset, JYCanvasTop, self.containerView.width - JYViewInset, self.containerView.width - JYViewInset)];
    }
    
    return _paintingView;
}

- (JYWriteFeelingDisplayView *)feelingDisplayView {
    if (!_feelingDisplayView) {
        _feelingDisplayView = [[JYWriteFeelingDisplayView alloc] initWithFrame:CGRectZero];
    }
    
    return _feelingDisplayView;
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
    self.feelingDisplayView.text = item;
}

- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectMenuItem:(JYMenu *)item {
    UIImage *image = [self styleImageWithStyleType:item.styleType];
    self.feelingDisplayView.image = image;
}

- (UIImage *)styleImageWithStyleType:(JYFeelingStyleType)styleType {
    if (styleType == JYFeelingStyleTypePass) {
        self.feelingDisplayView.textColor = SMSealRedColor;
    } else if (styleType == JYFeelingStyleTypeADR) {
        self.feelingDisplayView.textColor = SMSealGreenColor;
    } else if (styleType == JYFeelingStyleTypeSell) {
        self.feelingDisplayView.textColor = SMSealRedColor;
    } else if (styleType == JYFeelingStyleTypeLove) {
        self.feelingDisplayView.textColor = SMSealBlueColor;
    } else {
        self.feelingDisplayView.textColor = [UIColor blackColor];
    }
    CGSize size = JYWriteDisplayViewSize;
    return [JYStyleImageFactory styleImageFactoryFromStyleType:styleType size:size borderWidth:JYWriteDisplayViewSize.width / 40.f];
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
