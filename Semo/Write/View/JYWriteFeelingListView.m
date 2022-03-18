//
//  JYWriteFeelingListView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYWriteFeelingListView.h"
#import "JYWriteFeelingListCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYWriteFeelingListView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation JYWriteFeelingListView

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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[JYWriteFeelingListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
    layout.itemSize = CGSizeMake(44, 44);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return Feelings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYWriteFeelingListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *text = Feelings[indexPath.row];
    cell.text = text;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
