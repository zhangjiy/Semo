//
//  JYPopupStyleMenuListView.m
//  Semo
//
//  Created by jiyang on 2022/3/27.
//

#import "JYPopupStyleMenuListView.h"
#import "JYPopupStyleMenuCollectionViewCell.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYPopupStyleMenuListView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation JYPopupStyleMenuListView
@synthesize item = _item;
@synthesize image = _image;
@synthesize delegate = _delegate;

+ (instancetype)itemViewWithItem:(id <JYPopupListMenuDataProtocol>)item {
    return [[self alloc] initWithItem:item];
}

- (instancetype)initWithItem:( id<JYPopupListMenuDataProtocol>)item {
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
    [self addSubview:self.imageView];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _collectionView.frame = self.bounds;
    _collectionView.contentInset = UIEdgeInsetsMake((self.height - SMPaintingStyleMenuItemWidth - JYViewItemInset), JYViewItemInset, JYViewInset, JYViewItemInset);
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setItem:(id<JYPopupListMenuDataProtocol>)item {
    if (_item != item) {
        _item = item;
    }
}

#pragma mark - Updating the View

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = SMPaintingStyleMenuHeight;
    CGFloat viewWidth = SMPaintingStyleMenuItemWidth * _item.menus.count + JYViewItemInset * 2 + JYViewItemInset * (_item.menus.count - 1);
    CGSize viewSize = CGSizeMake(MIN(viewWidth, ScreenWidth - JYViewItemInset * 2), height);
    return viewSize;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _imageView;
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
        [_collectionView registerClass:[JYPopupStyleMenuCollectionViewCell class] forCellWithReuseIdentifier:@"JYPopupStyleMenuCollectionViewCell"];
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

#pragma -- mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _item.menus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYPopupStyleMenuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYPopupStyleMenuCollectionViewCell" forIndexPath:indexPath];
    JYMenu *menu = _item.menus[indexPath.row];
    [cell updateViewWithModel:menu];
    cell.isSelected = indexPath.row == self.indexPath.row ? YES : NO;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SMPaintingStyleMenuItemWidth, SMPaintingStyleMenuItemWidth);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    JYMenu *menu = _item.menus[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(menuListView:didSelectItem:)]) {
        [self.delegate menuListView:self didSelectItem:menu];
    }
    [self.collectionView reloadData];
}

@end

