//
//  JYPopupMenuListView.m
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import "JYPopupColorMenuListView.h"
#import "JYPopupMenuCollectionViewCell.h"
#import "JYSizeSlider.h"
#import "XDVerticalGradientColorSlider.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYPopupColorMenuListView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) JYSizeSlider * sizeSlider;
@property (nonatomic, strong) XDVerticalGradientColorSlider * colorSlider;
@end

@implementation JYPopupColorMenuListView
@synthesize item = _item;
@synthesize image = _image;

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
    [self addSubview:self.colorSlider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _collectionView.frame = self.bounds;
    _collectionView.contentInset = UIEdgeInsetsMake((self.height - SMPaintingMenuItemHeight - JYViewItemInset), JYViewItemInset, 0, JYViewItemInset);
    _sizeSlider.size = CGSizeMake(self.width - JYViewInset * 2, SMPaintingMenuSliderHeight);
    _sizeSlider.left = JYViewInset;
    _sizeSlider.top = JYViewItemInset;
    
    _colorSlider.size = CGSizeMake(self.width - JYViewInset * 2, SMPaintingMenuSliderHeight);
    _colorSlider.left = JYViewInset;
    _colorSlider.top = JYViewInset + 10;

}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setItem:(id<JYPopupListMenuDataProtocol>)item {
    if (_item != item) {
        _item = item;
        if (item.type == JYPaintingTypeSize) {
            _sizeSlider.hidden = NO;
            _colorSlider.hidden = YES;
        } else if (item.type == JYPaintingTypeColor) {
            _colorSlider.hidden = NO;
            _sizeSlider.hidden = YES;
        } else {
            _sizeSlider.hidden = YES;
            _colorSlider.hidden = YES;
        }
    }
}

#pragma mark - Updating the View

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = SMPaintingMenuHeight;
    if (self.item.type == JYPaintingTypePen) {
        height = 60;
    }
    CGSize viewSize = CGSizeMake(SMPaintingMenuItemHeight * _item.menus.count + JYViewItemInset * 2 + JYViewItemInset * (_item.menus.count - 1), height);
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
        [_collectionView registerClass:[JYPopupMenuCollectionViewCell class] forCellWithReuseIdentifier:@"JYPopupMenuCollectionViewCell"];
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
        _sizeSlider.hidden = YES;
    }
    
    return _sizeSlider;
}

- (XDVerticalGradientColorSlider *)colorSlider {
    if (!_colorSlider) {
        _colorSlider = [XDVerticalGradientColorSlider createGradientColorSliderWithColors:nil];
        _colorSlider.hidden = YES;
        CGFloat alpha = M_PI / 2.f;
        CATransform3D trans = CATransform3DIdentity;
        _colorSlider.layer.transform = CATransform3DRotate(trans, alpha, 0, 0, 1);
        [_colorSlider setValueChangedHandler:^(UIColor *color) {
        }];
    }
    return _colorSlider;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _item.menus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYPopupMenuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYPopupMenuCollectionViewCell" forIndexPath:indexPath];
    JYMenu *menu = _item.menus[indexPath.row];
    [cell updateViewWithModel:menu];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SMPaintingMenuItemHeight, SMPaintingMenuItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
