//
//  JYWriteFeelingBottomView.m
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import "JYWriteFeelingBottomView.h"
#import "JYWritePaintingListView.h"
#import "JYWriteFeelingListView.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingBottomView () <JYWriteFeelingListViewDelegate, JYWritePaintingListViewDelegate>
@property (nonatomic, strong) JYWritePaintingListView *paintingListView;
@property (nonatomic, strong) JYWriteFeelingListView *feelingListView;
@end

@implementation JYWriteFeelingBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self addSubview:self.paintingListView];
    [self addSubview:self.feelingListView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = (self.width - 100 - 60) / (float)Plantings.count;
    _paintingListView.size = CGSizeMake(self.width, height);
    _paintingListView.top = 10;
    
    _feelingListView.size = CGSizeMake(self.width, 50);
    _feelingListView.bottom = self.height - SafeAreaHeight;
}

- (void)updateViewWithModel:(JYPainting *)model {
    [self.paintingListView updateViewWithModel:model];
}

- (JYWritePaintingListView *)paintingListView {
    if (!_paintingListView) {
        _paintingListView = [[JYWritePaintingListView alloc] initWithFrame:CGRectZero];
        _paintingListView.delegate = self;
    }
    
    return _paintingListView;
}

- (JYWriteFeelingListView *)feelingListView {
    if (!_feelingListView) {
        _feelingListView = [[JYWriteFeelingListView alloc] initWithFrame:CGRectZero];
        _feelingListView.delegate = self;
    }
    
    return _feelingListView;
}

#pragma -- mark -- JYWritePaintingListViewDelegate

- (void)writeFeelingBottomView:(JYWriteFeelingBottomView *)bottomView didSelectPaintingItem:(JYPaintingItem *)item {
    if ([self.delegate respondsToSelector:@selector(writeFeelingBottomView:didSelectPaintingItem:)]) {
        [self.delegate writeFeelingBottomView:self didSelectPaintingItem:item];
    }
}

#pragma -- mark -- JYWriteFeelingListViewDelegate

- (void)writeFeelingListView:(JYWriteFeelingListView *)listView didSelectItem:(NSString *)item {
    if ([self.delegate respondsToSelector:@selector(writeFeelingBottomView:didSelectFeelingItem:)]) {
        [self.delegate writeFeelingBottomView:self didSelectFeelingItem:item];
    }
}

@end
