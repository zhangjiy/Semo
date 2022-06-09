//
//  JYRecordPaintingListView.m
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import "JYRecordPaintingListView.h"
#import "JYRecordPaintingStyleCollectionViewCell.h"
#import "JYRecordPaintingColorCollectionViewCell.h"
#import "JYRecordPaintingSizeCollectionViewCell.h"
#import "JYRecordPaintingPenCollectionViewCell.h"
#import "JYRecordPaintingUndoCollectionViewCell.h"
#import "JYRecordPaintingCustomCollectionViewCell.h"
#import "JYPopupMenu.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYRecordPaintingListView () <UICollectionViewDelegate, UICollectionViewDataSource, JYPopupMenuDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) JYPainting *painting;
@end

@implementation JYRecordPaintingListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}

- (void)updateViewWithModel:(JYPainting *)model {
    self.painting = model;
    [self.collectionView reloadData];
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[JYRecordPaintingStyleCollectionViewCell class] forCellWithReuseIdentifier:@"JYRecordPaintingStyleCollectionViewCell"];
        [_collectionView registerClass:[JYRecordPaintingColorCollectionViewCell class] forCellWithReuseIdentifier:@"JYRecordPaintingColorCollectionViewCell"];
        [_collectionView registerClass:[JYRecordPaintingSizeCollectionViewCell class] forCellWithReuseIdentifier:@"JYRecordPaintingSizeCollectionViewCell"];
        [_collectionView registerClass:[JYRecordPaintingPenCollectionViewCell class] forCellWithReuseIdentifier:@"JYRecordPaintingPenCollectionViewCell"];
        [_collectionView registerClass:[JYRecordPaintingUndoCollectionViewCell class] forCellWithReuseIdentifier:@"JYRecordPaintingUndoCollectionViewCell"];
        [_collectionView registerClass:[JYRecordPaintingCustomCollectionViewCell class] forCellWithReuseIdentifier:@"JYRecordPaintingCustomCollectionViewCell"];
        _collectionView.scrollsToTop = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 50, 0, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

#pragma -- mark - JYPopupMenuDelegate

- (void)popupMenu:(JYPopupMenu *)popupMenu didSelectItem:(JYMenu *)item {
    if ([self.delegate respondsToSelector:@selector(recordPaintingListView:didSelectMenuItem:)]) {
        [self.delegate recordPaintingListView:self didSelectMenuItem:item];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *plantings = self.painting.plantings;
    return plantings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *plantings = self.painting.plantings;
    JYPaintingItem *item = plantings[indexPath.row];
    if (item.type == JYPaintingTypeStyle) {
        JYRecordPaintingStyleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYRecordPaintingStyleCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    else if (item.type == JYPaintingTypeColor) {
        JYRecordPaintingColorCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYRecordPaintingColorCollectionViewCell" forIndexPath:indexPath];
        return cell;
    } else if (item.type == JYPaintingTypeSize) {
        JYRecordPaintingSizeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYRecordPaintingSizeCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    else if (item.type == JYPaintingTypePen) {
        JYRecordPaintingPenCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYRecordPaintingPenCollectionViewCell" forIndexPath:indexPath];
        return cell;
    } else if (item.type == JYPaintingTypeUndo) {
        JYRecordPaintingUndoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYRecordPaintingUndoCollectionViewCell" forIndexPath:indexPath];
        return cell;
    } else {
        JYRecordPaintingCustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYRecordPaintingCustomCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.height, self.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JYPaintingItem *item = self.painting.plantings[indexPath.row];

    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect rectInCollectionView = [self.collectionView convertRect:cell.frame toView:self.collectionView];
    if ([self.delegate respondsToSelector:@selector(overlayView)]) {
        UIView *view = self.delegate.overlayView;
        CGRect rect = [self.collectionView convertRect:rectInCollectionView toView:view];
        [self dismissMenu];
        JYPopupMenu *popupMenu = [[JYPopupMenu alloc] initWithItem:item];
        popupMenu.tag = 1000;
        popupMenu.item = item;
        popupMenu.delegate = self;
        popupMenu.color = SMGhostWhiteColor;
        [popupMenu showInView:view targetRect:rect animated:YES];
    }
    
    if ([self.delegate respondsToSelector:@selector(recordPaintingListView:didSelectPaintingItem:)]) {
        [self.delegate recordPaintingListView:self didSelectPaintingItem:item];
    }
}

- (void)dismissMenu {
    if ([self.delegate respondsToSelector:@selector(overlayView)]) {
        UIView *overlayView = self.delegate.overlayView;
        UIView *view = [overlayView viewWithTag:1000];
        if ([view isKindOfClass:[JYPopupMenu class]]) {
            JYPopupMenu *popupMenu = (JYPopupMenu *)view;
            [popupMenu dismissAnimated:YES];
        }
    }
}

@end

