//
//  JYPopupMenuListView.m
//  Semo
//
//  Created by jiyang on 2022/3/22.
//

#import "JYPopupMenuListView.h"
#import "JYPopupMenuCollectionViewCell.h"
#import "JYPainting.h"
#import "JYPrefixHeader.h"

@interface JYPopupMenuListView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation JYPopupMenuListView

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
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

#pragma mark - Updating the View

- (void)sizeToFit
{
    CGSize size = [self sizeThatFits:CGSizeZero];
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(ScreenWidth - JYViewInset * 2, SMPaintingMenuHeight);
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


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //return self.painting.plantings.count;
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYPopupMenuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JYPopupMenuCollectionViewCell" forIndexPath:indexPath];
//    JYPaintingItem *item = self.painting.plantings[indexPath.row];
//    [cell updateViewWithModel:item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.height, self.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
