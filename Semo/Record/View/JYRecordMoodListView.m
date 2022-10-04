//
//  JYRecordMoodListView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYRecordMoodListView.h"
#import "MBSwitch.h"
#import "JYRecordMoodListCollectionViewCell.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodListView () <UICollectionViewDelegate, UICollectionViewDataSource, JYRecordMoodListCollectionViewCellDelegate>
@property (nonatomic, strong) MBSwitch * customSwitch;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation JYRecordMoodListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.index = -1;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.collectionView];
    //[self addSubview:self.customSwitch];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat itemWidth = [self itemWidth];
    _collectionView.size = CGSizeMake(self.width, itemWidth);
    _customSwitch.size = CGSizeMake(40, 40);
    _customSwitch.right = self.width - 15;
    _customSwitch.top = _collectionView.bottom;
}

- (MBSwitch *)customSwitch {
    if (!_customSwitch) {
        _customSwitch = [[MBSwitch alloc] initWithFrame:CGRectZero];
        [_customSwitch addTarget:self action:@selector(customSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _customSwitch;

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
        [_collectionView registerClass:[JYRecordMoodListCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 0);
        if (@available(iOS 11.0, *)) _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

- (void)setIndex:(NSUInteger)index {
    if (_index != index) {
        _index = index;
    }
}

- (void)customSwitchAction:(UIControl *)sender {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return RecordMoods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYRecordMoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    NSString *text = RecordMoods[indexPath.row];
    UIColor *color = MoodColors[indexPath.row];
    cell.text = text;
    cell.color = color;
    cell.isSelected = indexPath.row == self.index ? YES : NO;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [self itemWidth];
    return CGSizeMake(width, width);
}

- (CGFloat)itemWidth {
    CGFloat width = (self.width - self.collectionView.contentInset.left * 2) / (float)RecordMoods.count;
    return width;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.customSwitch.hidden = NO;
    
    self.index = indexPath.row;
    [self.collectionView reloadData];
    NSString *text = RecordMoods[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(recordMoodListView:didSelectItem:)]) {
        [self.delegate recordMoodListView:self didSelectItem:text];
    }
}

- (void)recordMoodListCollectionViewCell:(JYRecordMoodListCollectionViewCell *)cell didLongPress:(UIGestureRecognizer *)gesture {
    self.index = -1;
    [self.collectionView reloadData];
    if ([self.delegate respondsToSelector:@selector(recordMoodListView:didSelectItem:)]) {
        [self.delegate recordMoodListView:self didSelectItem:nil];
    }
}

@end
