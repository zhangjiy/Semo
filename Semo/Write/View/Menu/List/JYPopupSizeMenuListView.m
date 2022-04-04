//
//  JYPopupSizeMenuListView.m
//  Semo
//
//  Created by jiyang on 2022/4/4.
//

#import "JYPopupSizeMenuListView.h"
#import "JYPopupSizeMenuCollectionViewCell.h"
#import "JYSizeSlider.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYPopupSizeMenuListView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) JYSizeSlider * sizeSlider;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation JYPopupSizeMenuListView
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
    [self addSubview:self.sizeSlider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _collectionView.frame = self.bounds;
    _collectionView.contentInset = UIEdgeInsetsMake((self.height - SMPaintingMenuItemHeight - JYViewItemInset), JYViewItemInset, JYViewInset, JYViewItemInset);
    _sizeSlider.size = CGSizeMake(self.width - JYViewInset * 2, SMPaintingMenuSliderHeight);
    _sizeSlider.left = JYViewInset;
    _sizeSlider.top = SMPaintingMenuSizeSlideTop;

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
    CGSize viewSize = CGSizeMake(SMPaintingMenuItemHeight * _item.menus.count + JYViewItemInset * 2 + JYViewItemInset * (_item.menus.count - 1), SMPaintingMenuHeight);
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
    cell.isSelected = indexPath.row == self.indexPath.row ? YES : NO;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SMPaintingMenuItemHeight, SMPaintingMenuItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    [self.collectionView reloadData];
}

@end
