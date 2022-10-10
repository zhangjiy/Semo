//
//  JYRecordMoodBottomView.m
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import "JYRecordMoodBottomView.h"
#import "JYRecordPaintingListView.h"
#import "JYRecordMoodListView.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodBottomView () <JYRecordMoodListViewDelegate, JYRecordPaintingListViewDelegate>
@property (nonatomic, strong) JYRecordPaintingListView *paintingListView;
@property (nonatomic, strong) JYRecordMoodListView *moodListView;
@property (nonatomic, strong) UILabel * longPressTipLabel;
@end

@implementation JYRecordMoodBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    [self addSubview:self.paintingListView];
    [self addSubview:self.moodListView];
    [self addSubview:self.longPressTipLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = (self.width - 100 - 60) / (float)Plantings.count;
    _paintingListView.size = CGSizeMake(self.width, height);
    //_paintingListView.backgroundColor = [UIColor blueColor];
    _moodListView.size = CGSizeMake(self.width, self.height - height - SafeAreaHeight);
    _moodListView.top = _paintingListView.bottom + 5;
    //_moodListView.backgroundColor = [UIColor greenColor];
    
    [_longPressTipLabel sizeToFit];
    _longPressTipLabel.right = self.width - 20;
    _longPressTipLabel.top = _moodListView.bottom + 5;
}

- (void)updateViewWithModel:(JYPainting *)model {
    [self.paintingListView updateViewWithModel:model];
}

- (JYRecordPaintingListView *)paintingListView {
    if (!_paintingListView) {
        _paintingListView = [[JYRecordPaintingListView alloc] initWithFrame:CGRectZero];
        _paintingListView.delegate = self;
    }
    
    return _paintingListView;
}

- (JYRecordMoodListView *)moodListView {
    if (!_moodListView) {
        _moodListView = [[JYRecordMoodListView alloc] initWithFrame:CGRectZero];
        _moodListView.delegate = self;
    }
    
    return _moodListView;
}

- (UILabel *)longPressTipLabel {
    if (!_longPressTipLabel) {
        _longPressTipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _longPressTipLabel.font = [UIFont systemFontOfSize:10];
        _longPressTipLabel.text = NSLocalizedString(@"长按隐藏文字", nil);
        _longPressTipLabel.textColor = [UIColor lightGrayColor];
    }
    return _longPressTipLabel;
}

- (NSInteger)index {
    return self.moodListView.index;
}

#pragma -- mark -- JYRecordPaintingListViewDelegate

- (void)recordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectPaintingItem:(JYPaintingItem *)item {
    if ([self.delegate respondsToSelector:@selector(recordMoodBottomView:didSelectPaintingItem:)]) {
        [self.delegate recordMoodBottomView:self didSelectPaintingItem:item];
    }
}

#pragma -- mark -- JYRecordMoodListViewDelegate
- (void)recordPaintingListView:(JYRecordPaintingListView *)listView didSelectPaintingItem:(JYPaintingItem *)item {
    if ([self.delegate respondsToSelector:@selector(recordMoodBottomView:didSelectMoodItem:)]) {
        [self.delegate recordMoodBottomView:self didSelectPaintingItem:item];
    }
}

- (void)recordMoodListView:(JYRecordMoodListView *)listView didSelectItem:(NSString *)item {
    if ([self.delegate respondsToSelector:@selector(recordMoodBottomView:didSelectMoodItem:)]) {
        [self.delegate recordMoodBottomView:self didSelectMoodItem:item];
    }
}

- (UIView *)overlayView {
    if ([self.delegate respondsToSelector:@selector(overlayView)]) {
        return self.delegate.overlayView;
    }
    
    return nil;
}

#pragma -- mark -- JYRecordMoodListViewDelegate

- (void)recordPaintingListView:(JYRecordPaintingListView *)listView didSelectMenuItem:(JYMenu *)item {
    if ([self.delegate respondsToSelector:@selector(recordMoodBottomView:didSelectMenuItem:)]) {
        [self.delegate recordMoodBottomView:self didSelectMenuItem:item];
    }
}

@end
