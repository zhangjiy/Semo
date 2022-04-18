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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = (self.width - 100 - 60) / (float)Plantings.count;
    _paintingListView.size = CGSizeMake(self.width, height);
    _moodListView.size = CGSizeMake(self.width, 50);
    _moodListView.bottom = self.height - SafeAreaHeight;
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

#pragma -- mark -- JYRecordPaintingListViewDelegate

- (void)RecordMoodBottomView:(JYRecordMoodBottomView *)bottomView didSelectPaintingItem:(JYPaintingItem *)item {
    if ([self.delegate respondsToSelector:@selector(RecordMoodBottomView:didSelectPaintingItem:)]) {
        [self.delegate RecordMoodBottomView:self didSelectPaintingItem:item];
    }
}

#pragma -- mark -- JYRecordMoodListViewDelegate
- (void)recordPaintingListView:(JYRecordPaintingListView *)listView didSelectPaintingItem:(JYPaintingItem *)item {
    if ([self.delegate respondsToSelector:@selector(RecordMoodBottomView:didSelectMoodItem:)]) {
        [self.delegate RecordMoodBottomView:self didSelectPaintingItem:item];
    }
}

- (void)RecordMoodListView:(JYRecordMoodListView *)listView didSelectItem:(NSString *)item {
    if ([self.delegate respondsToSelector:@selector(RecordMoodBottomView:didSelectMoodItem:)]) {
        [self.delegate RecordMoodBottomView:self didSelectMoodItem:item];
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
    if ([self.delegate respondsToSelector:@selector(RecordMoodBottomView:didSelectMenuItem:)]) {
        [self.delegate RecordMoodBottomView:self didSelectMenuItem:item];
    }
}

@end
