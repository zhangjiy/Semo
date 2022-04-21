//
//  JYPopupSizeMenuListView.m
//  Semo
//
//  Created by jiyang on 2022/4/4.
//

#import "JYPopupSizeMenuListView.h"
#import "JYPopupSizeMenuCollectionViewCell.h"
#import "JYSizeSlider.h"
#import "JYMenuLocal.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYPopupSizeMenuListView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) JYSizeSlider * sizeSlider;
@end

@implementation JYPopupSizeMenuListView
@synthesize item = _item;
@synthesize delegate = _delegate;

+ (instancetype)itemViewWithItem:(id <JYPopupMenuListDataProtocol>)item {
    return [[self alloc] initWithItem:item];
}

- (instancetype)initWithItem:( id<JYPopupMenuListDataProtocol>)item {
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        // View settings
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        self.item = item;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [super initSubViews];
    [self addSubview:self.collectionView];
    //[self addSubview:self.sizeSlider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    _collectionView.contentInset = UIEdgeInsetsMake((self.height - SMPaintingMenuItemHeight - JYViewItemInset), JYViewItemInset, JYViewInset, JYViewItemInset);
    _sizeSlider.size = CGSizeMake(self.width - JYViewInset * 2, 30);
    _sizeSlider.left = JYViewInset;
    _sizeSlider.bottom = self.height - SMPaintingMenuItemHeight - JYViewInset;
}

- (void)setItem:(id<JYPopupMenuListDataProtocol>)item {
    [super setItem:item];
    if (_item != item) {
        _item = item;
    }
}

#pragma mark - Updating the View

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize superViewSize = [super sizeThatFits:CGSizeZero];
    
    CGFloat height = 60 + superViewSize.height;
    CGSize viewSize = CGSizeMake(SMPaintingMenuItemHeight * _item.menus.count + JYViewItemInset * 2 + JYViewItemInset * (_item.menus.count - 1), height);
    return viewSize;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[JYPopupSizeMenuCollectionViewCell class] forCellWithReuseIdentifier:@"JYPopupSizeMenuCollectionViewCell"];
        _collectionView.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = JYViewItemInset;
    layout.minimumInteritemSpacing = JYViewItemInset;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

- (JYSizeSlider *)sizeSlider {
    if (!_sizeSlider) {
        _sizeSlider = [[JYSizeSlider alloc] initWithFrame:CGRectZero];
    }
    
    return _sizeSlider;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _item.menus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYPopupSizeMenuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYPopupSizeMenuCollectionViewCell" forIndexPath:indexPath];
    JYMenu *menu = _item.menus[indexPath.row];
    [cell updateViewWithModel:menu];
    cell.isSelected = indexPath.row == self.item.menuLocal.selectedIndex ? YES : NO;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SMPaintingMenuItemHeight, SMPaintingMenuItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.item.menuLocal.selectedIndex = indexPath.row;
    [self.item.menuLocal bg_saveOrUpdate];
    JYMenu *menu = _item.menus[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(menuListView:didSelectItem:)]) {
        [self.delegate menuListView:self didSelectItem:menu];
    }
    [self.collectionView reloadData];
}

@end
