//
//  JYRecordMoodManager.m
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

#import "JYRecordMoodManager.h"
#import "JYRecordMoodDisplayView.h"
#import "JYRecordMoodBottomView.h"
#import "JYPainting.h"
#import "Semo-Swift.h"
#import "JYStyleImageFactory.h"
#import "LGDrawer.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodManager () <JYRecordMoodBottomViewDelegate>
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) JYRecordMoodDisplayView *moodDisplayView;
@property (nonatomic, strong) JYPaintingView * paintingView;
@property (nonatomic, strong) JYPainting *painting;
@property (nonatomic, strong) JYRecordMoodBottomView * bottomView;
@end

@implementation JYRecordMoodManager

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
    UIImage *image = [self styleImageWithStyleType:JYMoodStyleTypePass];
    self.moodDisplayView.image = image;
}

- (UIImage *)resultMoodImage {
    CGSize size = CGSizeMake(_moodDisplayView.imageSize.width / 10.f, _moodDisplayView.imageSize.height / 10.f);
    UIImage *sealImage = [self makeImageWithView:self.moodDisplayView withSize:self.moodDisplayView.size];
    UIImage *paintImage = self.paintingView.image;
    UIImage *resultImage = [LGDrawer drawImagesWithFinishSize:size image1:sealImage image1Rect:CGRectMake(0, 0, size.width, size.height) image2:paintImage image2Rect:CGRectMake(0, 0, size.width, size.height) clear:YES];
    return resultImage;
}

- (void)initSubviews {
    [self.containerView addSubview:self.moodDisplayView];
    [self.containerView addSubview:self.paintingView];
    [self.containerView addSubview:self.bottomView];
}

- (void)layoutSubviews {
    _paintingView.top = JYCanvasTop;
    _paintingView.centerX = self.containerView.width / 2.f;
    
    _moodDisplayView.size = JYWriteDisplayViewSize;
    _moodDisplayView.top = JYCanvasTop;
    _moodDisplayView.centerX = self.containerView.width / 2.f;
    
    _bottomView.size = CGSizeMake(self.containerView.width, JYWriteBottomHeight);
    _bottomView.bottom = self.containerView.height;
    
}

- (JYPaintingView *)paintingView {
    if (!_paintingView) {
        _paintingView = [[JYPaintingView alloc] initWithFrame:CGRectMake(JYViewInset, JYCanvasTop, self.containerView.width - JYViewInset, self.containerView.width - JYViewInset)];
    }
    
    return _paintingView;
}

- (JYRecordMoodDisplayView *)moodDisplayView {
    if (!_moodDisplayView) {
        _moodDisplayView = [[JYRecordMoodDisplayView alloc] initWithFrame:CGRectZero];
    }
    
    return _moodDisplayView;
}

- (JYRecordMoodBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JYRecordMoodBottomView alloc] initWithFrame:CGRectZero];
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

#pragma -- mark -- JYRecordMoodBottomViewDelegate

- (void)RecordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectPaintingItem:(JYPaintingItem *)item {
    if (item.type == JYPaintingTypeUndo) {
        [self.paintingView undo];
    }
}

- (void)RecordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectMoodItem:(NSString *)item {
    
    self.moodDisplayView.text = item;
}

- (void)RecordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectMenuItem:(JYMenu *)item {
    if (item.type == JYPaintingTypeStyle) {
        UIImage *image = [self styleImageWithStyleType:item.styleType];
        self.moodDisplayView.image = image;
    } else if (item.type == JYPaintingTypeColor) {
        [self.paintingView changeColor:item.color];
    } else if (item.type == JYPaintingTypeSize) {
        [self.paintingView changeSize:item.lineWidth];
    } else if (item.type == JYPaintingTypePen) {
        NSInteger index = [JYStyleImageFactory indexFactoryFromPenName:item.name];
        [self.paintingView changeStyle:index];
    }
}

- (UIImage *)styleImageWithStyleType:(JYMoodStyleType)styleType {
    self.moodDisplayView.textColor = [JYStyleImageFactory textColorFactoryFromStyleType:styleType];
    CGSize size = JYWriteDisplayViewSize;
    return [JYStyleImageFactory styleImageFactoryFromStyleType:styleType size:size borderWidth:JYWriteDisplayViewSize.width / 40.f];
}

#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
