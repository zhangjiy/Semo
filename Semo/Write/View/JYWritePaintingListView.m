//
//  JYWritePaintingListView.m
//  Semo
//
//  Created by jiyang on 2022/3/19.
//

#import "JYWritePaintingListView.h"
#import "JYWritePaintingListCollectionViewCell.h"
#import "JYPopupMenu.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYWritePaintingListView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) JYPopupMenu *popupColorMenu;
@property (nonatomic, strong) JYPopupMenu *popupLineWidthMenu;
@property (nonatomic, strong) JYPainting *painting;
@end

@implementation JYWritePaintingListView

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
        [_collectionView registerClass:[JYWritePaintingListCollectionViewCell class] forCellWithReuseIdentifier:@"JYWritePaintingListCollectionViewCell"];
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
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.sectionInset = UIEdgeInsetsMake(0, 50, 0, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}

- (JYPopupMenu *)popupColorMenu {
    if (!_popupColorMenu) {
        _popupColorMenu = [[JYPopupMenu alloc] init];
        _popupColorMenu.height = SMPaintingMenuHeight;
        _popupColorMenu.color = SMGhostWhiteColor;
    }
    
    return _popupColorMenu;
}

- (JYPopupMenu *)popupLineWidthMenu {
    if (!_popupLineWidthMenu) {
        _popupLineWidthMenu = [[JYPopupMenu alloc] init];
        _popupLineWidthMenu.height = SMPaintingMenuHeight;
        _popupLineWidthMenu.color = SMGhostWhiteColor;
    }
    
    return _popupLineWidthMenu;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.painting.plantings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYWritePaintingListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYWritePaintingListCollectionViewCell" forIndexPath:indexPath];
    JYPaintingItem *item = self.painting.plantings[indexPath.row];
    [cell updateViewWithModel:item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.height, self.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JYPaintingItem *item = self.painting.plantings[indexPath.row];

    JYWritePaintingListCollectionViewCell * cell = (JYWritePaintingListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect rectInCollectionView =[self.collectionView convertRect:cell.frame toView:self.collectionView];
    UIView *view = self.firstAvailableWBViewController.view;
    CGRect rect = [self.collectionView convertRect:rectInCollectionView toView:view];
    if (item.type == JYPaintingTypeColor) {
        self.popupColorMenu.item = item;
        [self.popupColorMenu showInView:view targetRect:rect animated:YES];
    } else if (item.type == JYPaintingTypeSize) {
        self.popupLineWidthMenu.item = item;
        [self.popupLineWidthMenu showInView:view targetRect:rect animated:YES];
    }
    
    if ([self.delegate respondsToSelector:@selector(writePaintingListView:didSelectItem:)]) {
        [self.delegate writePaintingListView:self didSelectItem:item];
    }
}

@end

