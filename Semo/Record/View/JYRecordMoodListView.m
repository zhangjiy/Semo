//
//  JYRecordMoodListView.m
//  Semo
//
//  Created by jiyang on 2022/3/14.
//

#import "JYRecordMoodListView.h"
#import "MBSwitch.h"
#import "JYRecordMoodListCollectionViewCell.h"
#import "JYRecordMood.h"
#import "JYPrefixHeader.h"

@interface JYRecordMoodListView () <UICollectionViewDelegate, UICollectionViewDataSource, JYRecordMoodListCollectionViewCellDelegate>
@property (nonatomic, strong) MBSwitch * customSwitch;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray * recordMoods;
@end

@implementation JYRecordMoodListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.index = -1;
        self.recordMoods = JYRecordMoods();
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
        [self.collectionView reloadData];
    }
}

- (void)customSwitchAction:(UIControl *)sender {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.recordMoods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JYRecordMoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    JYRecordMood *recordMood = self.recordMoods[indexPath.row];
    recordMood.isSelected = indexPath.row == self.index ? YES : NO;
    cell.recordMood = recordMood;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [self itemWidth];
    return CGSizeMake(width, width);
}

- (CGFloat)itemWidth {
    CGFloat width = (self.width - self.collectionView.contentInset.left * 2) / (float)self.recordMoods.count;
    return width;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.customSwitch.hidden = NO;
    
    self.index = indexPath.row;
    [self.collectionView reloadData];
    JYRecordMood *recordMood = [self.recordMoods objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(recordMoodListView:didSelectItem:)]) {
        [self.delegate recordMoodListView:self didSelectItem:recordMood.text];
    }
}

- (void)recordMoodListCollectionViewCell:(JYRecordMoodListCollectionViewCell *)cell didLongPress:(UIGestureRecognizer *)gesture {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath.row == self.index) {
        JYRecordMood *recordMood = [self.recordMoods objectAtIndex:self.index];
        recordMood.hiddenText = !recordMood.hiddenText;
        [self.collectionView reloadData];
        if ([self.delegate respondsToSelector:@selector(recordMoodListView:didSelectItem:)]) {
            [self.delegate recordMoodListView:self didSelectItem:recordMood.text];
        }
    }
}

@end
